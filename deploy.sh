#! /usr/bin/sh

git add .
git commit -m "Updated: `date +'%Y-%m-%d %H:%M:%S'`"
git push origin main
./venv/bin/python -m mkdocs gh-deploy