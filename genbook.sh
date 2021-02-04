#!/bin/bash

mkdir _book;
cp -rlf docs/* _book;
rm -rf docs;
gitbook build;
shopt -s dotglob;
mkdir docs;
cp -rlf _book/* docs;
rm -rf _book;
touch ./docs/.nojekyll;