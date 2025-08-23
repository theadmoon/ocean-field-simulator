# Ocean2Joy Deployment Guide

This project uses **deploy.sh** to automate deployment.

## 🚀 Usage

1. Open **Git Bash** in the root of the project.
2. Make sure you are on the `main` branch:

   ```bash
   git checkout main
   git pull origin main
   ```

3. Run the deployment script:

   ```bash
   ./deploy.sh
   ```

## 📦 What it does

- If `package.json` exists → runs `npm install && npm run build`
- Clears and recreates `docs/`
- Copies build output (`dist/` or `build/`) into `docs/`
- If no build folder → copies `index.html`, `src/`, `assets/` and other project files into `docs/`
- Commits changes and pushes to GitHub

## 🌐 Result

GitHub Pages serves the site from `docs/` on the `main` branch.

URL: `https://<username>.github.io/<repo>/`

