# Deployment Guide - Quick Reference

## 🚀 Quick Deploy Commands

```bash
# Deploy to Testing
git checkout develop
git add .
git commit -m "Your message"
git push origin develop

# Deploy to Production
git checkout main
git merge develop
git push origin main
```

## 📋 Pre-Deployment Checklist

- [ ] Code tested locally
- [ ] All changes committed
- [ ] Correct branch checked out
- [ ] No console errors
- [ ] Features tested

## 🔄 Rollback Commands

```bash
# Quick rollback
git revert HEAD
git push origin main

# Rollback to specific commit
git log --oneline  # Find commit hash
git revert <commit-hash>
git push origin main
```

## 🌐 URLs

- **Testing:** [Your Testing URL]
- **Production:** [Your Production URL]

## ⚠️ Important Notes

- Always test on `develop` before deploying to `main`
- Never push directly to `main` without testing
- Use pull requests for code review
- Keep secrets secure and never commit them

