#! /usr/bin/sh

git add .
git commit -m "Updated: `date +'%Y-%m-%d %H:%M:%S'`"
git push origin main
../venv_m3den_github_io/bin/python -m mkdocs gh-deploy