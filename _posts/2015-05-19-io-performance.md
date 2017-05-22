---
title:  "On Random vs. Streaming I/O Performance; Or seek(), and You Shall Find --- Eventually."
tags: ['bioinformatics', 'performance', 'IO']
---

At the [Simpson Lab blog](http://simpsonlab.github.io/blog/), I've written a post
[on streaming vs random access I/O performance](http://simpsonlab.github.io/2015/05/19/io-performance/),
an important topic in bioinformatics. Using a very simple problem (randomly choosing lines in a 
non-indexed text file) I give a quick overview of the file system stack and what it means for
streaming performance, and reservoir sampling for uniform random online sampling.
