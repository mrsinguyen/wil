#!/bin/sh

if [[ $(git status -s) ]]
then
    echo "Please commit any pending changes."
    exit 1;
fi

echo "Deleting old publication"
rm -rf public
mkdir public
git worktree prune
rm -rf .git/worktrees/public/

echo "Checking out gh-pages branch into public"
git worktree add -B gh-pages public origin/gh-pages

echo "Removing existing files"
rm -rf public/*

echo "Generating static site"
hugo --theme=hugo-dusk

echo "Updating gh-pages branch"
cd public
echo "wil.tiensi.me" >> CNAME
git add --all
git commit -m "Deploying to gh-pages"
git push
