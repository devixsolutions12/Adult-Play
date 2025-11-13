# Adult Play Download Website

A simple, professional website for downloading the Adult Play Android APK.

## 📁 Folder Structure

```
website/
├── index.html          # Main HTML page
├── styles.css          # Styling
├── script.js           # JavaScript functionality
├── apk/                # APK file folder
│   └── Adult Play.apk  # Place your APK file here
└── README.md           # This file
```

## 🚀 Setup Instructions

1. **Place the APK file:**
   - Copy your `Adult Play.apk` file to the `apk/` folder
   - Ensure the file is named exactly: `Adult Play.apk`

2. **Deploy the website:**
   - Upload all files in the `website/` folder to your web server
   - Ensure the folder structure is maintained
   - The `apk/` folder should be accessible via the web

## 🌐 Deployment Options

### Option 1: Static Hosting (Recommended)
- **Netlify**: Drag and drop the `website/` folder
- **Vercel**: Connect your repository and deploy
- **GitHub Pages**: Push to a repository and enable Pages
- **Firebase Hosting**: Use Firebase CLI to deploy

### Option 2: Traditional Web Server
- Upload files via FTP/SFTP to your web hosting
- Ensure proper file permissions (644 for files, 755 for folders)

### Option 3: Local Testing
- Use a local server like Python's `http.server`:
  ```bash
  cd website
  python -m http.server 8000
  ```
- Or use Node.js `http-server`:
  ```bash
  npx http-server website -p 8000
  ```

## 📝 Customization

### Change App Information
Edit `index.html` to update:
- App name and version
- Description text
- Features
- System requirements

### Change Colors
Edit `styles.css` and modify the CSS variables in `:root`:
```css
--primary-color: #6366f1;
--secondary-color: #8b5cf6;
```

### Change APK File Name
1. Rename the file in the `apk/` folder
2. Update the download link in `index.html`:
   ```html
   <a href="apk/YourNewName.apk" download="YourNewName.apk">
   ```

## 🔒 Security Notes

- The website is static and doesn't require server-side processing
- Ensure your web server allows direct file downloads
- Consider adding HTTPS for secure downloads
- You may want to add download analytics or rate limiting

## 📱 Mobile Responsive

The website is fully responsive and works on:
- Desktop computers
- Tablets
- Mobile phones

## ✨ Features

- Modern, professional design
- Responsive layout
- Smooth animations
- Download button with loading state
- App information and features
- Installation instructions
- System requirements

## 🐛 Troubleshooting

**APK file not downloading:**
- Check that the file exists in `apk/Adult Play.apk`
- Verify file permissions (should be readable)
- Check browser console for errors

**Styling not loading:**
- Ensure `styles.css` is in the same folder as `index.html`
- Check file paths are correct
- Clear browser cache

**JavaScript not working:**
- Ensure `script.js` is in the same folder as `index.html`
- Check browser console for errors
- Verify JavaScript is enabled in browser

## 📄 License

All rights reserved. © 2024 Adult Play

