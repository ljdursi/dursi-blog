---
title: When Research Infrastructure Is and Isn't Maintained
summary: The value of maintained research infastructure compounds over time.  Unmaintained infrastructure collapses
image: assets/imgs/arecibo-collapsed.jpg
tags: ['funding']
---

(Note: This post is adapted from [#53](https://www.researchcomputingteams.org/newsletter_issues/0053) of the [Research Computing Teams Newsletter](https://www.researchcomputingteams.org))

There were two big stories in the news this week (as I write this, at the end of 2020) about what's possible with sustained research infrastructure funding and what happens when research infrastructure isn't sustained.

In the first, you've probably read about AlphaFold, Google Brain's efforts to bring deep learning to protein folding. [It did very well](https://www.the-scientist.com/news-opinion/deepmind-ai-speeds-up-the-time-to-determine-proteins-structures-68221) in the 14th annual Critical Assessment of (protein) Structure Prediction (CASP) contest. Predictably but unfortunately, Google's press releases wildly overhyped the results - "Protein Folding Solved".

Most proteins fold very robustly in the chaotic environment of the cell, and so it's expected that there should be complex features that predict how the proteins folded configurations look. We still don't know anything about the model AlphaFold used - other than it did very well on these 100 proteins - or how it was trained. There are a lot of questions of how it will work with more poorly behaved proteins - a wrong confident prediction could be much worse than no prediction. But it did get very good results, and with a very small amount of computational time to actually make the predictions. That raises a lot of hope for the scope of near-term future advances.

But as [Aled Edwards points out on twitter](https://twitter.com/aledmedwards/status/1333754396530847745), the real story here is one of long term, multi-decadal, investment in research infrastructure including research data infrastructure by the structural biology community. The [protein data bank](https://www.wwpdb.org) was set up 50 years ago (!!); and a culture of data sharing of these laboriously solved protein structures was set up, with a norm of contributing to (and helping curate) the data bank. That databank has been continuously curated and maintained, new techniques developed, eventually leading to the massive database now on which methods can be trained and results compared.

It's the sustained funding and support - monetarily but also in terms of aligning research incentives like credit - which built the PDB. The other big story we heard this week tells us that you can't just fund a piece of infrastructure, walk away, and expect the result to be self-sustaining. On December 1st, the iconic [Arecibo Radio Telescope in Puerto Rico collapsed](https://www.the-scientist.com/news-opinion/famous-arecibo-radio-telescope-in-puerto-rico-collapses-68219). The telescope was considered important enough to keep running - there was no move to decommission it until late November - but not important enough to keep funding the maintenance to keep it functioning.

![Overhead image of a broken Arecibo Telescope](/assets/imgs/arecibo-collapsed.jpg)

Digital research infrastructure - software, data resources, computing systems - fall apart at least as quickly without ongoing funded effort to maintain them.  It's not about whether these digital pieces of infrastructure are "sustainable"; it's whether or not they are _sustained_. Too many critical pieces of our digital research infrastructure are not being sustained.
