# How to Upload Files to GitHub Repository

## 🔍 If you can't see "Add file" button:

### Method 1: Create a file first (Recommended)
1. On your GitHub repository page, look for the text that says:
   - **"Get started by creating a new file or uploading an existing file"**
2. Click on **"creating a new file"** link
3. This will open the file editor
4. Now you'll see "Add file" dropdown in the top right
5. Click **"Add file" → "Upload files"**
6. Drag and drop all your website files

### Method 2: Use the "uploading an existing file" link
1. On the repository page, find the text:
   - **"uploading an existing file"** (it's a clickable link)
2. Click on that link
3. This will take you to the upload page
4. Drag and drop all files

### Method 3: Use Git Commands (Easiest if you have Git installed)

Open PowerShell in your website folder and run:

```powershell
cd Desktop\website

git init
git add .
git commit -m "Initial commit - Add website files"
git branch -M main
git remote add origin https://github.com/devixsolutions12/Adult-Play.git
git push -u origin main
```

### Method 4: Create README first
1. Click the **"README"** link on the repository page
2. Add some text (like "# Adult Play Website")
3. Click "Commit new file"
4. Now the "Add file" button should appear in the top right

---

## 📁 What to Upload

Upload ALL these files and folders:
- ✅ index.html
- ✅ styles.css
- ✅ script.js
- ✅ vercel.json
- ✅ package.json
- ✅ .gitignore
- ✅ README.md
- ✅ images/ (entire folder)
- ✅ apk/ (entire folder)

---

## 🚀 After Uploading to GitHub

Then go to Vercel:
1. Visit https://vercel.com
2. Click "Add New Project"
3. Import from GitHub: `devixsolutions12/Adult-Play`
4. Deploy!

