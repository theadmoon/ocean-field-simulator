#!/bin/bash
# === Ocean Field Simulator : Deploy ===

echo "== Starting SSH agent and adding keys... =="
eval $(ssh-agent -s)
ssh-add ~/.ssh/github_key
ssh-add ~/.ssh/developer1_fullkey

echo "== Checking GitHub connection... =="
ssh -T github || { echo "GitHub auth failed"; exit 1; }

echo "== Checking Production server connection... =="
ssh prod "echo prod ok" || { echo "Prod server auth failed"; exit 1; }

echo "== Creating commit =="
git add -A
git commit -m "Auto deploy $(date '+%Y.%m.%d_%H%M')"

echo "== Pushing commit & tags to GitHub... =="
git push github main || { echo "GitHub push failed"; exit 1; }

echo "== Deploying to Production... =="
rsync -avz --delete ./ prod:/var/www/ocean2joy.com

echo "== Deploy finished successfully =="
