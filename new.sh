#!/bin/bash

name=$1
now=$(date +'%Y-%m-%d')

mkdir ./content/posts/$name$now
cat > ./content/posts/$name$now/index.md <<EOF
---
title: ""
date: "$now"
tags:
- "$name"
---
EOF
