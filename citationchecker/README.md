# 📚 Citation Verification Tool

A **browser-based tool** for verifying academic citations against Crossref and OpenAlex databases. No installation required—runs entirely in your browser.

## ✨ Features

- **Multi-format support**: APA, MLA, Chicago, raw references
- **Dual API verification**: Crossref (primary) + OpenAlex (fallback)
- **Batch processing**: Verify 50–500+ citations at once
- **Intelligent parsing**: Automatically extracts titles, authors, years, DOIs
- **Confidence scoring**: 0–100% match confidence
- **Mismatch detection**: Title, author, year discrepancies flagged
- **CSV export**: Download results for further analysis
- **No API keys required**: Uses public, free APIs
- **Privacy-first**: All processing happens locally in your browser

---

## 🚀 Quick Start

### Option 1: GitHub Pages (Recommended)

1. **Fork or clone this repository** to your GitHub account
2. **Enable GitHub Pages**:
   - Settings → Pages → Source → Deploy from branch: `main`
3. **Access at**: `https://yourusername.github.io/citation-verifier/`

### Option 2: Local File

Simply open `index.html` in any modern browser:
```bash
# On macOS
open index.html

# On Linux
firefox index.html

# On Windows
start index.html
```

### Option 3: Local Web Server (Recommended for Development)

```bash
# Using Python 3
python -m http.server 8000

# Using Node.js
npx http-server

# Using Live Server (VS Code extension)
# Just click "Go Live"
```

Then visit `http://localhost:8000` in your browser.

---

## 📖 How to Use

### 1. **Paste Citations**
Copy-paste your citations into the text area, one per line:

```
Smith, J., & Jones, A. (2020). A study on language development. Journal of Psychology, 45(3), 123-145.
Chen, L., Lee, M., & Park, S. (2019). Language acquisition in multilingual children. Developmental Psychology, 55(2), 234-256.
Brown, R., & Davis, K. (2018). Parental responsiveness and child outcomes. Early Childhood Research Quarterly, 42, 156-169. DOI: 10.1016/j.ecresq.2017.09.002
```

### 2. **Click "Verify Citations"**
The tool will:
- Parse each citation
- Extract title, authors, year, DOI
- Query Crossref and OpenAlex APIs
- Compare results and flag mismatches

### 3. **Review Results**
Results include:
- **Status**: Verified ✓ | Warning ⚠ | Not Found ✗
- **Confidence**: 0–100% match score
- **Database metadata**: Title, authors, year, journal, DOI
- **Issues flagged**: Title mismatch, author mismatch, year mismatch

### 4. **Export to CSV**
Click "Export to CSV" to download results for:
- Spreadsheet analysis
- Documentation
- Batch processing

---

## 🔍 Understanding the Results

### Status Indicators

| Status | Meaning | Action |
|--------|---------|--------|
| **✓ Verified** | Citation found in database, all metadata matches | No action needed |
| **⚠ Warning** | Citation found but with minor discrepancies | Review title/author/year |
| **✗ Not Found** | Citation not in Crossref or OpenAlex | May be non-standard or fabricated |

### Confidence Score

- **90–100%**: Highly confident match
- **70–89%**: Likely match with minor title variations
- **50–69%**: Possible match, needs review
- **<50%**: Low confidence, likely not found or significant mismatch

### Common Issues

| Issue | Explanation |
|-------|-------------|
| Title mismatch (60% similar) | Your title differs significantly from database; may be typo or subtitle missing |
| Year mismatch (cited: 2020, actual: 2019) | Citation year is wrong; check arXiv preprint vs. published date |
| Author mismatch | First author name doesn't match; verify correct paper |
| Citation not found | Paper doesn't exist in database; check DOI or search manually |

---

## 📊 Supported Citation Formats

The tool accepts citations in any of these formats:

### APA Format
```
Smith, J., & Jones, A. (2020). A study on language development. 
Journal of Psychology, 45(3), 123-145. https://doi.org/10.1037/xxx
```

### MLA Format
```
Smith, John, and Anne Jones. "A Study on Language Development." 
Journal of Psychology, vol. 45, no. 3, 2020, pp. 123-145.
```

### Chicago Format
```
Smith, John, and Anne Jones. "A Study on Language Development." 
Journal of Psychology 45, no. 3 (2020): 123-145. 
https://doi.org/10.1037/xxx
```

### Raw Reference
```
Language development in early childhood. Smith & Jones. 2020.
```

---

## 🔐 Privacy & Data

✅ **All verification happens in your browser**
- No data sent to external servers
- No accounts or login required
- No tracking or analytics
- Browser history stored locally

⚠️ **API Calls**
- Queries to Crossref and OpenAlex APIs are read-only
- Your email is included (good API etiquette per their documentation)
- Rate limits: ~100 requests/5 minutes per API

---

## 🛠️ Technical Details

### Technologies Used

- **Frontend**: Vanilla HTML5, CSS3, JavaScript (no frameworks)
- **APIs**: 
  - [Crossref REST API](https://www.crossref.org/documentation/retrieve-metadata/rest-api/) (176M+ records)
  - [OpenAlex API](https://docs.openalex.org/) (hundreds of millions of records)
- **Parsing**: Custom regex-based citation parser
- **Similarity**: Word-overlap matching (Levenshtein-inspired)

### How It Works

1. **Citation Parser**
   - Extracts title using quote detection and sentence patterns
   - Finds year using regex (YYYY in parentheses or standalone)
   - Parses author names using common academic patterns
   - Extracts DOI if provided

2. **Crossref Query**
   - Primary search method (most comprehensive)
   - Searches by title, DOI, or author
   - Filters by publication year if provided

3. **OpenAlex Fallback**
   - Used if Crossref doesn't find a match
   - Broader coverage of preprints and open-access

4. **Result Comparison**
   - Compares database metadata against parsed citation
   - Calculates title similarity (word-overlap %)
   - Flags year/author discrepancies
   - Computes confidence score

5. **Export**
   - Results formatted as CSV
   - All fields included for further analysis

---

## ⚠️ Limitations

1. **Parsing accuracy**: Complex citations may not parse perfectly
   - Workaround: Ensure each citation includes at least title + year

2. **Database coverage**: 
   - Crossref: Primarily journal articles and books
   - OpenAlex: Includes preprints but less comprehensive for books
   - Workaround: Some books/gray literature won't be found

3. **Incomplete citations**: 
   - Missing title or year significantly reduces match quality
   - Workaround: Add more details if possible

4. **Rate limits**: 
   - API rate limits may throttle very large batches (1000+)
   - Workaround: Process in batches of 500

5. **Formatting variations**: 
   - Titles with special characters may not match perfectly
   - Workaround: Tool uses fuzzy matching to compensate

---

## 💡 Tips for Best Results

1. **Include DOI when available**
   - Significantly improves match accuracy
   - Example: `DOI: 10.1037/000000`

2. **Use complete titles**
   - Avoid abbreviations or partial titles
   - Include subtitles if available

3. **Include publication year**
   - Helps distinguish multiple papers by same author
   - Format: `(2020)` or `2020`

4. **Format: One citation per line**
   - Tool processes line by line
   - Empty lines are skipped

5. **For ambiguous citations**
   - Use "Load Example" to see proper format
   - Copy-paste from Google Scholar for best results

---

## 🐛 Troubleshooting

### "Nothing happens when I click Verify"
- Check browser console (F12 → Console) for errors
- Ensure you have an internet connection (APIs are cloud-based)
- Try refreshing the page

### "Citation not found but I know it exists"
- Try adding more details (title, authors, year)
- Check the DOI in [doi.org](https://www.doi.org/)
- Some books/dissertations may not be in Crossref

### "Title mismatch but it's the same paper"
- Crossref may have slightly different title formatting
- Common causes: capitalization, subtitles, special characters
- If confidence >70%, likely the same paper

### "Export to CSV doesn't work"
- Some browsers have restrictions; try another browser
- Ensure pop-ups aren't blocked

---

## 🔗 Resources

- **Crossref API Docs**: https://www.crossref.org/documentation/retrieve-metadata/rest-api/
- **OpenAlex Docs**: https://docs.openalex.org/
- **Citation Formats Guide**: https://www.scribbr.com/citation/
- **Digital Object Identifier (DOI) Help**: https://www.doi.org/

---

## 📄 License

This tool is open source and provided as-is for educational and research purposes.

---

## 🤝 Contributing

Found a bug? Have a feature request? Feel free to:
1. Open an issue
2. Submit a pull request
3. Contact the maintainer

---

## 📧 Support

For questions or feedback:
- Open an issue on GitHub
- Check existing issues for similar problems
- Include browser type and sample citations

---

## 🎓 Cite This Tool

If you use this tool in your research, please cite it as:

**APA Format:**
```
Citation Verification Tool. (2024). Browser-based academic citation verification 
using Crossref and OpenAlex APIs. Retrieved from 
https://github.com/[username]/citation-verifier/
```

**BibTeX:**
```bibtex
@software{citation_verifier_2024,
  title={Citation Verification Tool},
  author={Your Name},
  year={2024},
  url={https://github.com/[username]/citation-verifier/}
}
```

---

## 🌟 Acknowledgments

- **Crossref** for comprehensive journal metadata
- **OpenAlex** for open-access citation data
- **Academic research community** for citation standards

---

**Last updated**: December 2024
**Version**: 1.0.0