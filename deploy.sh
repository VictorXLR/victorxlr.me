#!/bin/sh

# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Build the project.
yarn build # if using a theme, replace with `hugo -t <YOURTHEME>`

# Go To Public folder
cd pages

#custom domain
echo victorxlr.me > CNAME
# Add changes to git.
git init
git config core.autocrlf true
git add -A

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "deploy $msg"

# Push source and build repos.

git push -f git@github.com:VictorXLR/victorxlr.github.io.git master

cd - 

printf "\033[0;32mDeleting Build Directory...\033[0m\n"

rm -rf pages

# Add changes to git.
git config core.autocrlf true
git add -A 
msg="saving site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "deploy $msg"
git push -f git@github.com:VictorXLR/victorxlr.github.io.git source
