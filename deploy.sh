#!/bin/bash
echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Update post from til repository.
# git submodule update --remote

# Build the project.
hugo -t github-style-plus

# Go to public folder, submodule commit
cd public
# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin gh-pages

# Come back up to the project root
cd ..

# Commit and push to main branch
git add .

msg="rebuilding site `date`"
if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

git push origin main