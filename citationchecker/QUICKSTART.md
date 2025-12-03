# Quick-Start Checklist

Use this checklist to deploy the Citation Verification Tool in under 5 minutes.

## ⏱️ 5-Minute Setup

- [ ] **Create GitHub Repository** (1 min)
  - [ ] Go to https://github.com/new
  - [ ] Name: `citation-verifier`
  - [ ] Make it Public
  - [ ] Create

- [ ] **Upload Files** (1 min)
  - [ ] Click "Add file → Upload files"
  - [ ] Upload `index.html`
  - [ ] Upload `README.md`
  - [ ] Commit changes

- [ ] **Enable GitHub Pages** (1 min)
  - [ ] Settings → Pages
  - [ ] Source: Deploy from branch → main
  - [ ] Save

- [ ] **Verify Deployment** (1 min)
  - [ ] Wait 30 seconds
  - [ ] Visit: `https://YOUR_USERNAME.github.io/citation-verifier/`
  - [ ] Test with sample citations

- [ ] **Share** (1 min)
  - [ ] Copy URL to clipboard
  - [ ] Share with colleagues

---

## 📋 Full Checklist

### Preparation
- [ ] Have a GitHub account (free at https://github.com)
- [ ] Downloaded/copied `index.html` and `README.md`
- [ ] Know your GitHub username

### Repository Creation
- [ ] Created new repository
- [ ] Set to Public
- [ ] Added description

### File Upload
- [ ] Uploaded `index.html` (main tool)
- [ ] Uploaded `README.md` (documentation)
- [ ] Added `.gitignore` (optional but recommended)
- [ ] Committed changes

### GitHub Pages Configuration
- [ ] Settings → Pages is open
- [ ] Build and deployment source set to "Deploy from a branch"
- [ ] Branch set to `main`
- [ ] Folder set to `/ (root)`
- [ ] Saved changes

### Testing
- [ ] Site is live (green checkmark visible)
- [ ] URL is accessible (no 404 error)
- [ ] Tool loads completely (no console errors)
- [ ] Sample citations parse correctly
- [ ] API queries work (get results back)
- [ ] CSV export works
- [ ] Responsive on mobile

### Sharing & Promotion
- [ ] Shared URL with team
- [ ] Added to research group resources
- [ ] Updated course materials (if applicable)
- [ ] Documented on README

### Optional Enhancements
- [ ] Customized header title and description
- [ ] Changed color scheme
- [ ] Added custom domain
- [ ] Set up Google Analytics
- [ ] Added logo or branding

---

## 🔧 Troubleshooting Quick Reference

### "Site not showing up"
- ✅ Check Settings → Pages shows green checkmark
- ✅ Refresh page (Ctrl+Shift+R)
- ✅ Wait 60 seconds for build
- ✅ Check correct URL: `https://USERNAME.github.io/citation-verifier/`

### "Getting 404 error"
- ✅ Verify `index.html` was uploaded to root of repo
- ✅ Confirm branch is `main` (not `master`)
- ✅ Check repository name in URL

### "Tool loads but doesn't work"
- ✅ Open browser console (F12)
- ✅ Check for JavaScript errors
- ✅ Ensure internet connection
- ✅ Try different browser
- ✅ Clear browser cache

### "Results don't appear"
- ✅ Check if citations are formatted correctly
- ✅ Try "Load Example" first
- ✅ Ensure you have internet connection
- ✅ Check API rate limits (rare)

---

## 🎓 First-Time Tips

1. **Test Locally First** (Optional)
   ```bash
   # Open directly in browser
   open index.html
   
   # Or run simple server
   python -m http.server 8000
   # Visit http://localhost:8000
   ```

2. **Verify Before Sharing**
   - Test with 3-5 sample citations
   - Check all buttons work
   - Try CSV export
   - Test on mobile phone

3. **Customize Branding** (10 min)
   - Edit title in `index.html`
   - Change colors if desired
   - Add institution name
   - Update footer text

4. **Monitor Usage**
   - Check GitHub traffic (Insights → Traffic)
   - Add Google Analytics for detailed stats
   - Track feedback from users

---

## ✅ Success Indicators

✓ Tool is live when you see:
- Green checkmark on latest commit
- No errors in browser console
- Sample citations return results
- CSV export works

---

## 📚 Documentation

After deploying, share these links:

**For Users:**
- Main tool: `https://YOUR_USERNAME.github.io/citation-verifier/`
- How to use: `README.md` in the repo (displayed on GitHub)

**For Developers:**
- Deployment guide: `DEPLOY.md` (this file)
- Technical details: See `README.md`

---

## 🚀 Next Milestones

After successful deployment:

**Week 1:** Get feedback from initial users
**Week 2:** Make bug fixes based on feedback
**Week 3:** Consider adding features (retract watch, impact metrics)
**Month 1:** Promote to wider research community

---

## 📞 Getting Help

- **GitHub Pages Help:** https://docs.github.com/en/pages
- **API Documentation:** 
  - Crossref: https://www.crossref.org/documentation/
  - OpenAlex: https://docs.openalex.org/
- **General Questions:** Open an issue in your repository

---

**You've got this! 🎉 Deploy and start verifying citations!**