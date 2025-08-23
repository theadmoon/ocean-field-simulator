#!/bin/bash
set -e
MSG=${1:-"Update: auto-deploy"}
git add .
git commit -m "$MSG" || echo "No changes to commit"
git push origin main
echo "✅ Deploy complete!"
