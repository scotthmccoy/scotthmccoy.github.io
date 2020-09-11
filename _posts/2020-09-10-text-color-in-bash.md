---
layout: post
title: Text Color in Bash
date: 2020-09-10 17:32 -0700
---


```
function green {
    tput setaf 2
    echo $1
    tput init
}

function red {
    tput setaf 1
    echo $1
    tput init
}
```