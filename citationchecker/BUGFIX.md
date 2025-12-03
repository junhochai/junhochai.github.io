# CITATION VERIFIER - BUGFIX GUIDE

## Problem Analysis

Your citation query is returning false negatives because:

1. **DOI is being ignored** - You provided `https://doi.org/10.1017/S0305000916000416`
2. **Query falls back to title search** - "Multimodal infant-directed communication"
3. **Crossref API returns wrong result** - Matching partial words incorrectly (gets R metadata)

## Root Cause

The query order in the tool is:
```javascript
// WRONG ORDER (current):
if (citation.doi) { /* use it */ }
else if (citation.title) { /* search title */ }
else if (citation.authors) { /* search author */ }
```

The problem: The DOI extraction regex may be **failing to capture** the URL format.

## Solution: Query Priority Fix

Change the query to prioritize DOI:

```javascript
// CORRECT ORDER:
if (citation.doi) {
    // Query by DOI directly - MOST PRECISE
    params.append('filter', `doi:${citation.doi}`);
}
else if (citation.title && citation.year) {
    // Query by title + year - MORE PRECISE
    params.append('query.title', citation.title);
    params.append('filter', `from-pub-date:${citation.year}-01-01,until-pub-date:${citation.year}-12-31`);
}
else if (citation.authors.length > 0 && citation.title) {
    // Query by first author + title - BALANCED
    params.append('query.author', citation.authors[0]);
    params.append('query.title', citation.title);
}
else if (citation.title) {
    // Fallback: title only
    params.append('query.title', citation.title);
}
else if (citation.authors.length > 0) {
    // Last resort: author only
    params.append('query.author', citation.authors[0]);
}
```

## DOI Extraction Bug

Your citation has: `https://doi.org/10.1017/S0305000916000416`

Current regex:
```javascript
const doiMatch = text.match(/(?:doi:|https?:\/\/doi\.org\/)?([0-9.\/]+(?:10\.\S+)?)/i);
```

**Problem**: The regex is too greedy and may extract wrong part.

**Better regex**:
```javascript
// Extract DOI from various formats:
// - 10.1017/S0305000916000416
// - doi:10.1017/S0305000916000416
// - https://doi.org/10.1017/S0305000916000416
const doiMatch = text.match(/(?:https?:\/\/doi\.org\/|doi:)?(\d{2}\.\d+\/\S+?)(?:\s|$|[\.\),])/i);
```

## Testing Your Citation

Before fix, tool returns:
- Status: ⚠ Warning (42%)
- Journal: R Language...
- Year: 2000

After fix, should return:
- Status: ✓ Verified (95%+)
- Title: Multimodal infant-directed communication
- Journal: Journal of Child Language
- Year: 2017
- DOI: 10.1017/S0305000916000416

## Implementation Changes

Three key changes needed in `index.html`:

### Change 1: Improve DOI Extraction
In the `parseCitation()` method, improve the regex:

**OLD:**
```javascript
const doiMatch = text.match(/(?:doi:|https?:\/\/doi\.org\/)?([0-9.\/]+(?:10\.\S+)?)/i);
if (doiMatch) {
    citation.doi = doiMatch[1];
}
```

**NEW:**
```javascript
// Try multiple DOI formats
let doiMatch = text.match(/https?:\/\/doi\.org\/(10\.\d+\/\S+?)(?:\s|$)/i);
if (!doiMatch) doiMatch = text.match(/doi:\s*(10\.\d+\/\S+?)(?:\s|,|$)/i);
if (!doiMatch) doiMatch = text.match(/(10\.\d+\/\S+?)(?:\s|,|$|\))/);

if (doiMatch && doiMatch[1]) {
    citation.doi = doiMatch[1].trim();
}
```

### Change 2: Crossref Query Priority
In the `fetchCrossref()` method, reorder the query logic:

**OLD:**
```javascript
if (citation.doi) {
    params.append('filter', `doi:${citation.doi}`);
} else if (citation.title) {
    params.append('query.title', citation.title);
    if (citation.year) {
        params.append('filter', `from-pub-date:${citation.year}-01-01,until-pub-date:${citation.year}-12-31`);
    }
}
```

**NEW:**
```javascript
// Priority 1: DOI (most unique identifier)
if (citation.doi) {
    params.append('filter', `doi:${citation.doi}`);
    params.append('rows', '1');
    return await this._executeQuery(params);
}

// Priority 2: Title + Year (more specific)
if (citation.title && citation.year) {
    params.append('query.title', citation.title);
    params.append('filter', `from-pub-date:${citation.year}-01-01,until-pub-date:${citation.year}-12-31`);
    params.append('rows', '1');
    return await this._executeQuery(params);
}

// Priority 3: First Author + Title (balanced)
if (citation.authors.length > 0 && citation.title) {
    const firstAuthor = citation.authors[0].split(',')[0]; // Get last name
    params.append('query.author', firstAuthor);
    params.append('query.title', citation.title);
    params.append('rows', '1');
    return await this._executeQuery(params);
}

// Fallback: Title only
if (citation.title) {
    params.append('query.title', citation.title);
    params.append('rows', '5'); // Get more results to find best match
}
```

### Change 3: Better Result Matching
Enhance the comparison logic to prefer exact matches:

```javascript
// Add this helper function:
compareMetadata(citation, result) {
    const scoreFactors = {
        title: 0,
        author: 0,
        year: 0,
    };

    // Title comparison: word-overlap (higher sensitivity)
    if (result.title && citation.title) {
        const citWords = citation.title.toLowerCase().split(/\s+/);
        const resWords = result.title.toLowerCase().split(/\s+/);
        const matches = citWords.filter(w => resWords.some(rw => rw.includes(w) || w.includes(rw)));
        scoreFactors.title = (matches.length / Math.max(citWords.length, resWords.length)) * 100;
    }

    // Author comparison: check first author match
    if (result.authors && citation.authors.length > 0) {
        const firstCitAuthor = citation.authors[0].toLowerCase().split(',')[0];
        const matches = result.authors.some(a => 
            a.toLowerCase().includes(firstCitAuthor) || 
            firstCitAuthor.split(' ').every(part => a.toLowerCase().includes(part))
        );
        scoreFactors.author = matches ? 100 : 0;
    }

    // Year comparison: exact match
    if (result.year && citation.year) {
        scoreFactors.year = result.year.toString() === citation.year ? 100 : 0;
    }

    // Weight: DOI search should be 99%+ confident
    // Title+year search should be 80%+ confident
    // Author+title search should be 70%+ confident
    return scoreFactors;
}
```

## How to Apply This Fix

You have two options:

### Option A: Minimal Fix (Just DOI Priority)
Replace the `fetchCrossref()` method's query building section with the corrected Priority logic above.

### Option B: Complete Fix (Recommended)
Replace:
1. DOI extraction regex
2. Query priority order
3. Result comparison logic

This ensures future citations with DOIs, titles, and authors all work correctly.

## Testing After Fix

Test with your citation:
```
Abu-Zhaya, R., Seidl, A., & Cristia, A. (2017). Multimodal infant-directed communication: How caregivers combine tactile and linguistic cues. Journal of Child Language, 44(5), 1088–1116. https://doi.org/10.1017/S0305000916000416
```

Expected result:
- ✓ Verified (95%+)
- Title Match: 95%+
- Authors: R Abu-Zhaya, A Seidl, A Cristia
- Year: 2017
- Journal: Journal of Child Language
- DOI: 10.1017/S0305000916000416