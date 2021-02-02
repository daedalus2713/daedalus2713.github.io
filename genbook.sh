#!/bin/bash

mkdir src;
rsync -av --progress . ./src --exclude=docs/ --exclude=src/ --exclude=.gitignore --exclude=.git --exclude=genbook.sh --exclude=book.toml;
sed -i "s/##/#/" src/SUMMARY.md
mdbook build;
cp -r .gitbook/ docs/
rm -r src/;
# mdbook serve;
