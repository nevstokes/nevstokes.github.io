---
title: "Out With the Old"
date: 2020-06-28T17:07:31Z
summary: "They say that you should never reinvent the wheel. But what if you could make the wheels better?"
tags: ["dev", "bash"]
---
{{< quote text="It is only by trying new things that we can hope to create products that are original." author="Ed Catmull" >}}

After previously banging the drum for utility tools that have stood the test of time, I'll admit to using some newfangled alteratives.

There's an emerging trend of reimplementing well-known terminal commands in modern languages such as Rust. Some are faster, easier to use or provide more information whereas others just look fancy. What can I say? I guess I'm shallow.

## ls > k
> https://github.com/supercrabtree/k

`k` adds git status, file size and age indication to directory listings. I keep meaning to explore [exa](https://the.exa.website/) for similar features.

## cat > bat
> https://github.com/sharkdp/bat

Line numbering and syntax highlighting of files, right on the command line.

## man > tldr
> https://tldr.sh/

Scrolling through the `man` pages of a command to check flags and options can be a frustrating experience when all you want to see is a quick overview of common use cases.

## grep > ripgrep
> https://github.com/BurntSushi/ripgrep

Like the [Silver Surfer](https://github.com/ggreer/the_silver_searcher), this is a faster alternative for regular `grep`.

## top > htop
> https://hisham.hm/htop/

Process listing with colours and nice looking CPU bar charts.

## curl > axel
> https://github.com/axel-download-accelerator/axel

`axel` is an accelerator that tries to speed up downloads by using multiple connections and load balancing requests across servers.
