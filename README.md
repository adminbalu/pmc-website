# PMC Hotel Project Management System

A comprehensive project management tool for hotel construction projects with task tracking, meeting minutes, workflow visualization, and user management.

## 🚀 Quick Start

### Prerequisites
- Node.js 18+ (optional, for local development)
- Git
- GitHub account
- Netlify account (free tier works)

---

## 📋 Table of Contents

1. [Initial Setup](#initial-setup)
2. [GitHub Repository Setup](#github-repository-setup)
3. [Netlify Hosting Setup](#netlify-hosting-setup)
4. [Environment Variables](#environment-variables)
5. [Deployment](#deployment)
6. [Rollback](#rollback)
7. [Development Workflow](#development-workflow)
8. [Troubleshooting](#troubleshooting)

---

## 🔧 Initial Setup

### Step 1: Initialize Git (if not already done)

```bash
# Navigate to project directory
cd /path/to/project1

# Initialize git repository
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: PMC website setup"
```

### Step 2: Create GitHub Account (if you don't have one)

1. Go to [GitHub.com](https://github.com)
2. Click "Sign up"
3. Choose a username, email, and password
4. Verify your email address
5. Complete the setup wizard

---

## 📦 GitHub Repository Setup

### Step 1: Create New Repository on GitHub

1. Log in to GitHub
2. Click the **"+"** icon in the top right → **"New repository"**
3. Repository name: `pmc-website` (or your preferred name)
4. Description: "PMC Hotel Project Management System"
5. Visibility: Choose **Private** (recommended) or **Public**
6. **DO NOT** initialize with README, .gitignore, or license (we already have these)
7. Click **"Create repository"**

### Step 2: Connect Local Repository to GitHub

```bash
# Add GitHub repository as remote (replace YOUR_USERNAME with your GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/pmc-website.git

# Rename default branch to main (if needed)
git branch -M main

# Push code to GitHub
git push -u origin main
```

### Step 3: Create Develop Branch

```bash
# Create and switch to develop branch
git checkout -b develop

# Push develop branch to GitHub
git push -u origin develop
```

---

## 🌐 Netlify Hosting Setup

### Step 1: Create Netlify Account

1. Go to [Netlify.com](https://www.netlify.com)
2. Click **"Sign up"**
3. Choose **"Sign up with GitHub"** (recommended for easier integration)
4. Authorize Netlify to access your GitHub account

### Step 2: Create Testing Site

1. In Netlify dashboard, click **"Add new site"** → **"Import an existing project"**
2. Choose **"Deploy with GitHub"**
3. Select your `pmc-website` repository
4. Configure:
   - **Branch to deploy**: `develop`
   - **Build command**: (leave empty - static site)
   - **Publish directory**: `.` (current directory)
5. Click **"Deploy site"**
6. Note the **Site ID** (found in Site settings → General → Site details)
7. Note the **Site URL** (your testing URL, e.g., `https://pmc-testing.netlify.app`)

### Step 3: Create Production Site

1. Click **"Add new site"** again
2. Choose **"Deploy with GitHub"**
3. Select the same `pmc-website` repository
4. Configure:
   - **Branch to deploy**: `main`
   - **Build command**: (leave empty)
   - **Publish directory**: `.`
5. Click **"Deploy site"**
6. Note the **Site ID** for production
7. Note the **Production URL** (e.g., `https://pmc-production.netlify.app`)

### Step 4: Get Netlify Auth Token

1. In Netlify, click your profile icon (top right)
2. Go to **"User settings"** → **"Applications"**
3. Click **"New access token"**
4. Name it: `GitHub Actions Deploy`
5. Click **"Generate token"**
6. **Copy the token immediately** (you won't see it again!)

---

## 🔐 Environment Variables & GitHub Secrets

### Step 1: Add Secrets to GitHub

1. Go to your GitHub repository
2. Click **"Settings"** → **"Secrets and variables"** → **"Actions"**
3. Click **"New repository secret"**
4. Add these secrets:

   **Secret 1:**
   - Name: `NETLIFY_AUTH_TOKEN`
   - Value: (paste your Netlify auth token)

   **Secret 2:**
   - Name: `NETLIFY_SITE_ID_TESTING`
   - Value: (paste testing site ID from Netlify)

   **Secret 3:**
   - Name: `NETLIFY_SITE_ID_PRODUCTION`
   - Value: (paste production site ID from Netlify)

   **Secret 4:**
   - Name: `NETLIFY_TESTING_URL`
   - Value: (your testing URL, e.g., `https://pmc-testing.netlify.app`)

   **Secret 5:**
   - Name: `NETLIFY_PRODUCTION_URL`
   - Value: (your production URL, e.g., `https://pmc-production.netlify.app`)

### Step 2: Configure Environment Variables (Optional)

For this static site, environment variables are optional. If you need them in the future:

1. Create `.env.testing` file (for testing environment)
2. Create `.env.production` file (for production environment)
3. Add variables as needed
4. **Never commit these files** (they're in `.gitignore`)

---

## 🚀 Deployment

### Automatic Deployment (Recommended)

**The system is now set up for automatic deployment!**

- **Push to `develop` branch** → Automatically deploys to Testing
- **Push to `main` branch** → Automatically deploys to Production

```bash
# Deploy to testing
git checkout develop
git add .
git commit -m "Your changes"
git push origin develop
# ✅ Automatically deploys to testing URL

# Deploy to production
git checkout main
git merge develop  # or create a PR
git push origin main
# ✅ Automatically deploys to production URL
```

### Manual Deployment (Alternative)

If you need to deploy manually:

```bash
# Install Netlify CLI (first time only)
npm install -g netlify-cli

# Login to Netlify
netlify login

# Deploy to testing
npm run deploy:test

# Deploy to production
npm run deploy:prod
```

---

## 🔄 Rollback

### Method 1: Git Revert (Recommended)

```bash
# Find the commit hash you want to revert to
git log --oneline

# Revert to a specific commit
git revert <commit-hash>

# Push the revert
git push origin main  # or develop
# ✅ Automatically redeploys with previous version
```

### Method 2: Netlify Dashboard

1. Go to Netlify dashboard
2. Select your site
3. Go to **"Deploys"** tab
4. Find the deployment you want to restore
5. Click **"..."** → **"Publish deploy"**

### Method 3: Quick Rollback Script

```bash
# Rollback to previous commit
git revert HEAD
git push origin main
```

---

## 🔀 Development Workflow

### Standard Workflow

```bash
# 1. Start on develop branch
git checkout develop

# 2. Create feature branch
git checkout -b feature/your-feature-name

# 3. Make changes and commit
git add .
git commit -m "Add new feature"

# 4. Push feature branch
git push origin feature/your-feature-name

# 5. Merge to develop (deploys to testing)
git checkout develop
git merge feature/your-feature-name
git push origin develop

# 6. After testing, merge to main (deploys to production)
git checkout main
git merge develop
git push origin main
```

### Using Pull Requests (Recommended)

1. Push feature branch to GitHub
2. Create Pull Request on GitHub
3. Review changes
4. Merge PR to `develop` (auto-deploys to testing)
5. After testing, create PR from `develop` to `main`
6. Merge PR to `main` (auto-deploys to production)

---

## 📁 Project Structure

```
project1/
├── .github/
│   └── workflows/
│       ├── deploy-testing.yml      # Testing deployment workflow
│       └── deploy-production.yml   # Production deployment workflow
├── .gitignore                      # Files to exclude from git
├── .env.example                    # Example environment variables
├── netlify.toml                    # Netlify configuration
├── package.json                    # Project dependencies
├── README.md                       # This file
└── index.html                      # Main application file
```

---

## ✅ Verification Checklist

After setup, verify everything works:

- [ ] Git repository initialized
- [ ] GitHub repository created and connected
- [ ] `develop` and `main` branches exist
- [ ] Netlify account created
- [ ] Testing site created and linked to `develop` branch
- [ ] Production site created and linked to `main` branch
- [ ] GitHub Secrets configured
- [ ] Push to `develop` triggers testing deployment
- [ ] Push to `main` triggers production deployment
- [ ] Both sites are accessible via their URLs

---

## 🐛 Troubleshooting

### Issue: GitHub Actions not running

**Solution:**
1. Check if workflows are enabled: Settings → Actions → General
2. Verify secrets are correctly set
3. Check Actions tab for error messages

### Issue: Deployment fails

**Solution:**
1. Check Netlify deployment logs
2. Verify Site IDs in GitHub Secrets
3. Ensure Netlify Auth Token is valid
4. Check branch names match (develop/main)

### Issue: Changes not appearing

**Solution:**
1. Wait 1-2 minutes for deployment to complete
2. Hard refresh browser (Ctrl+Shift+R or Cmd+Shift+R)
3. Check Netlify deploy logs
4. Verify correct branch was pushed

### Issue: Can't find Site ID

**Solution:**
1. Go to Netlify dashboard
2. Select your site
3. Site settings → General → Site details
4. Site ID is shown at the top

---

## 🔒 Security Best Practices

1. ✅ Never commit `.env` files
2. ✅ Use GitHub Secrets for sensitive data
3. ✅ Keep Netlify Auth Token secure
4. ✅ Use Private repositories for sensitive projects
5. ✅ Regularly update dependencies
6. ✅ Review deployments before merging to main

---

## 📞 Support

If you encounter issues:

1. Check GitHub Actions logs
2. Check Netlify deployment logs
3. Review this README
4. Check Netlify documentation: https://docs.netlify.com
5. Check GitHub Actions documentation: https://docs.github.com/en/actions

---

## 🎉 Success!

Your CI/CD pipeline is now set up! Every push automatically deploys your website.

**Testing URL:** Deploys from `develop` branch  
**Production URL:** Deploys from `main` branch

Happy deploying! 🚀
