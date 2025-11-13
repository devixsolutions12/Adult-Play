# How to Upload Website to GitHub & Deploy to Vercel

## 📤 Method 1: Upload via GitHub Web Interface

1. **Go to your repository:**
   - https://github.com/devixsolutions12/Adult-Play

2. **Click "uploading an existing file"** (or click "Add file" → "Upload files")

3. **Drag and drop ALL files from your Desktop/website folder:**
   - `index.html`
   - `styles.css`
   - `script.js`
   - `vercel.json`
   - `package.json`
   - `.gitignore`
   - `README.md`
   - `images/` folder (with logo)
   - `apk/` folder (with APK file)

4. **Scroll down and click "Commit changes"**

5. **After uploading, go to Vercel:**
   - Visit https://vercel.com
   - Click "Add New Project"
   - Import your GitHub repository `devixsolutions12/Adult-Play`
   - Vercel will auto-detect and deploy!

---

## 💻 Method 2: Upload via Git Commands

Open PowerShell or Git Bash in your website folder and run:

```bash
cd Desktop/website

# Initialize git (if not already)
git init

# Add all files
git add .

# Commit
git commit -m "Add website files"

# Add your GitHub repository as remote
git remote add origin https://github.com/devixsolutions12/Adult-Play.git

# Push to GitHub
git branch -M main
git push -u origin main
```

---

## 🚀 Method 3: Direct Upload to Vercel (No GitHub)

1. **Go to Vercel:**
   - Visit https://vercel.com
   - Sign up/Login

2. **Click "Add New Project"**

3. **Drag and drop your entire `website` folder from Desktop**

4. **Click "Deploy"**

That's it! Your website will be live in seconds.

---

## 📍 Your Website Folder Location

**Desktop:** `C:\Users\mgas8\OneDrive\Desktop\website`

Make sure this folder contains:
- ✅ All HTML, CSS, JS files
- ✅ `vercel.json` configuration
- ✅ `package.json`
- ✅ `images/` folder with logo
- ✅ `apk/` folder with APK file

---

## ⚠️ Important Notes

1. **APK File:** Make sure `Adult Play.apk` is in the `apk/` folder before uploading
2. **File Size:** Vercel supports files up to 100MB
3. **Custom Domain:** You can add a custom domain in Vercel dashboard after deployment

---

## 🎯 Recommended: GitHub + Vercel

**Best approach:**
1. Upload to GitHub (Method 1 or 2)
2. Connect GitHub to Vercel
3. Auto-deploy on every push!

This way you have version control and automatic deployments.

