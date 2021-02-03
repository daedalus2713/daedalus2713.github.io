#!/bin/bash

mkdir src;
rsync -av --progress . ./src --exclude=docs/ --exclude=src/ --exclude=.gitignore --exclude=.git --exclude=genbook.sh --exclude=book.toml --exclude=.github;
sed -i "s/##/#/" src/SUMMARY.md;
mdbook build;
for filename in $(find src -type f -name '*.md' -follow -print)
do
    sed -i "s/.gitbook/..\/.gitbook/" $filename;
done;
cp -r .gitbook/ docs/;
rm -r src/;
#mdbook serve;
