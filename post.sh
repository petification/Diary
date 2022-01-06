#!/bin/bash

git pull origin gh-pages
npm run deploy
git pull origin main
git add .
git commit -m "I post it!"
