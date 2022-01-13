# PETIFICATION develop logs

## How to write
### Make diary file
You can automatically create folder & md file by `new.sh`
```
./new.sh [name]
```
example:
```
./new.sh HaeramKim
```
### Write metadata
Before writing diary, You have to write metadata for the diary first. Please follow the example below to know how to write it.
```
---
title: "My first diary"
date: "2022-01-05"
tags:
- "HaeramKim"
---
```
Please use `title` of metadata instead of `#` of markdown. And also, write your name in `tags` to identify the author. But when you use `new.sh` to make diary file, metadata form will automatically generated and all you have to do is fill out the empty form. If you want to add more tags, type your own tags below your name in similar form.
### Upload post
Uploading post is very simple. Just typing a command below and your post will automatically added, commited and pushed to main branch, and also, it will automatically deployed.
```
./post.sh
```

## Author
1. Hyejong Kang
2. Dukho Choi
3. Seonghan Kim
4. Haeram Kim
