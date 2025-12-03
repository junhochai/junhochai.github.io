# 🚀 GitHub Pages Deployment Guide

This guide will help you deploy the Citation Verification Tool on GitHub Pages (completely free).

---

## ✅ Step-by-Step Setup

### Step 1: Create a GitHub Repository

1. Go to [GitHub](https://github.com) and sign in
2. Click **"+" → New repository**
3. **Repository name**: `citation-verifier` (or any name you prefer)
4. **Description**: "Academic citation verification tool"
5. **Visibility**: Public (required for free GitHub Pages)
6. Click **Create repository**

---

### Step 2: Add Files to Repository

#### Option A: Upload via GitHub Web Interface (Easiest)

1. Click **"Add file → Upload files"**
2. Drag and drop these files:
   - `index.html` (from this folder)
   - `README.md` (from this folder)
3. Click **"Commit changes"**

#### Option B: Clone and Push (For Developers)

```bash
# Clone your new repository
git clone https://github.com/YOUR_USERNAME/citation-verifier.git
cd citation-verifier

# Copy files
cp index.html .
cp README.md .

# Commit and push
git add .
git commit -m "Initial commit: Citation verification tool"
git push origin main
```

---

### Step 3: Enable GitHub Pages

1. In your repository, go to **Settings** (top-right gear icon)
2. Scroll down to **Pages** (left sidebar under "Code and automation")
3. Under **Build and deployment**:
   - **Source**: Select **"Deploy from a branch"**
   - **Branch**: Select **`main`**
   - **Folder**: Keep as **`/ (root)`**
4. Click **Save**

GitHub will automatically build and deploy your site within seconds.

---

### Step 4: Access Your Tool

Your tool will be live at:

```
https://YOUR_USERNAME.github.io/citation-verifier/
```

**Example:** If your username is `jane-doe`, it will be:
```
https://jane-doe.github.io/citation-verifier/
```

---

## 🔄 Updates & Maintenance

### Update the Tool

1. Edit files locally or on GitHub
2. Commit changes:
   ```bash
   git add .
   git commit -m "Description of changes"
   git push origin main
   ```
3. Changes live within **30 seconds**

### Add a Custom Domain (Optional)

If you have your own domain:

1. Settings → Pages
2. Enter your domain under **Custom domain**
3. Update your domain's DNS settings (see [GitHub instructions](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site))

---

## 🛠️ Customization

### Change the Title

Edit `index.html`:

```html
<title>Your Custom Title</title>

<header>
    <h1>📚 Your Citation Tool Title</h1>
    <p>Your custom description</p>
</header>
```

### Modify Colors

Edit the `<style>` section in `index.html`:

```css
/* Change header gradient */
header {
    background: linear-gradient(135deg, #YOUR_COLOR1 0%, #YOUR_COLOR2 100%);
}

/* Change button colors */
.btn-primary {
    background: #YOUR_BUTTON_COLOR;
}
```

### Add Your Own Logo

In the `<header>`, replace or add:

```html
<img src="your-logo.png" alt="Logo" style="max-height: 50px; margin-bottom: 10px;">
```

Upload `your-logo.png` to your repository.

---

## ✅ Verify Deployment

### Check Status

1. Go to your repository
2. Look for a small **green checkmark** next to the latest commit (means it deployed successfully)
3. Click it to see deployment details

### Troubleshooting

**Tool not appearing?**
- Wait 30–60 seconds for build to complete
- Force refresh browser: `Ctrl+Shift+R` (Windows) or `Cmd+Shift+R` (Mac)
- Check Settings → Pages to confirm correct branch is selected

**Getting 404 error?**
- Confirm your URL is: `https://USERNAME.github.io/REPO_NAME/`
- (Many people forget the repository name at the end)

**Want to see build logs?**
- Repository → Settings → Pages
- Scroll down to see deployment history with any errors

---

## 🌐 Multiple Deployments

Want to host on multiple platforms? Choose one or more:

### GitHub Pages (Free)
```
https://YOUR_USERNAME.github.io/citation-verifier/
```
- No custom domain needed
- Built-in with GitHub
- Perfect for this tool

### Netlify (Free Alternative)

1. Sign up at [netlify.com](https://netlify.com)
2. "New site from Git" → Select your GitHub repo
3. Deploy automatically on each push
4. Custom domain supported
5. Live at: `https://your-site.netlify.app/`

### Vercel (Free Alternative)

1. Sign up at [vercel.com](https://vercel.com)
2. "Add New... → Project" → Import your GitHub repo
3. Deploy automatically
4. Live at: `https://your-project.vercel.app/`

---

## 📊 Sharing Your Tool

Once deployed, share it:

**Twitter/X:**
```
🧬 Just deployed a free citation verification tool! 
Check if your academic citations are real & accurate.
Batch verify 50-500+ citations against Crossref & OpenAlex.

👉 https://YOUR_USERNAME.github.io/citation-verifier/

#AcademicTools #Research #Citations
```

**LinkedIn:**
```
Excited to share: Citation Verification Tool

A free, open-source web app for verifying academic citations.
Built for researchers & students to check citation accuracy.

Features:
✓ Batch verification (50-500+ citations)
✓ Automatic DOI lookup
✓ CSV export
✓ No API keys needed

Try it: [your URL]

#Research #AcademicTools #OpenScience
```

**Academia.edu or ResearchGate:**
Add to your profile as a tool resource.

---

## 🔐 Security & Privacy

✅ **Why GitHub Pages is safe for this tool:**

- All processing happens in **your browser**
- No data sent to GitHub servers
- Only queries go to Crossref/OpenAlex (read-only, public APIs)
- Your citations never stored anywhere
- Your GitHub repository can be private (tool still accessible)

---

## 📈 Analytics (Optional)

Track usage by adding Google Analytics:

Edit `index.html` and add before `</head>`:

```html
<!-- Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'GA_MEASUREMENT_ID');
</script>
```

Replace `GA_MEASUREMENT_ID` with your Google Analytics ID from [analytics.google.com](https://analytics.google.com).

---

## 🎓 Next Steps

1. ✅ Deploy on GitHub Pages (this guide)
2. 📣 Share with your research community
3. 🐛 Test with various citation formats
4. 💡 Consider adding more features:
   - Retract watch integration
   - ResearchGate/ORCID lookup
   - Citation impact metrics
   - Batch DOI registration

---

## ❓ FAQ

**Q: Can I use this privately?**
A: Repository can be private, but GitHub Pages URLs are always public. If you need truly private, run locally.

**Q: How many citations can I verify at once?**
A: Tool handles 500+ easily. API rate limits may affect batches >1000.

**Q: Do I need technical skills?**
A: No! The drag-and-drop GitHub upload method requires zero coding.

**Q: Can I modify the tool?**
A: Yes! Fork the repository and customize freely (CSS colors, text, features).

**Q: Is there a cost?**
A: Completely free with GitHub. GitHub Pages has no usage fees.

---

## 🚀 You're Done!

Your Citation Verification Tool is now live! 

**Next:** Share the link with colleagues and students. Enjoy! 📚✨

---

**Need help?**
- GitHub Pages Issues: https://docs.github.com/en/pages
- Tool Questions: Check the main README.md
- Report a Bug: Open an issue in your repository