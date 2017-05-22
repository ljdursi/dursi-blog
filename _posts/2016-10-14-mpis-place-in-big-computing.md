---
title:  "MPI's Place in Big Computing"
tags: ['MPI', 'presentation']
---

The organizers of [EuroMPI 2016](http://www.eurompi2016.ed.ac.uk) were kind enough to invite me to give a keynote and participate in a panel at their meeting, which was held at the end of September in beautiful Edinburgh.  The event was terrific, with lots of very interesting work going on in MPI implementations and with MPI.

The topic of my talk was &ldquo;MPI's Place in Big Computing&rdquo;; the materials from the talk can be found [on github](http://github.com/ljdursi/EuroMPI2016). The talk, as you might expect, included discussion of high-productivity big data frameworks, but also &mdash; and missing from the discussion in my &ldquo;HPC is dying&rdquo; blog post &mdash; the &ldquo;data layer&rdquo; frameworks that underpin them.

I think a lot of people have taken, quite reasonably, my that blog post to suggest that [Spark](http://spark.apache.org) for example is a competitor to MPI; the point I wanted to make is a little more nuanced that that.

I'm actually skeptical of Spark's utility for (_e.g._) large-scale simulations. However attractive the model is from a variety of points of view, absent some huge breakthrough I don't think that functional models with immutable data can support the performance, memory requirements, or performance predictability we require.  (But who knows; maybe that'll be one of the compromises we find we have to make on the road to exascale).

But whatever you might think of Spark's efficacy for your particular use case,

* A lot of people manifestly find it to be extremely useful for _their_ use case; and
* Performance is quite important to those communities.

So given that, why isn't Spark built atop of MPI for network communications?  And why isn't [TensorFlow](http://tensorflow.org), or [Dask](http://dask.pydata.org), or [SeaStar](http://www.seastar-project.org)?  

The past five years have seen a huge number of high-productivity tools for large-scale number crunching gain extremely rapid adoption.  Even if you don't like those particular tools for your problems, surely you'd like for there to exist some tools like that for the traditional HPC community; why do other communications frameworks support this flourishing ecosystem of platforms, and MPI doesn't?

There's another argument there, too - simply from a self-preservation point of view, it would be in MPI's interest to be adopted by a high-profile big data platform to ensure continued success and support.  But none are; why?  It's not because the developers of Spark or at Google are just too dumb to figure out MPI's syntax.

Going through what does get used for these packages and what doesn't &mdash; which is what I do in this talk &mdash; I think the issues become fairly clear.  MPI wants to be both a low-level communications framework and a higher-level programming model, and ends up tripping over it's own feet trying to dance both dances.  As a communications &ldquo;data plane&rdquo; it imposes too many high-level decisions on applications &mdash; no fault tolerance, restrictive communications semantics (in-order and arrival guarantees), and provides too few services (_e.g._ a performant active message/RPC layer).  And as a high-level programming model it is too low level and is missing different services (communications-aware scheduling came up in several guises at the meeting).

I don't think that's insurmountable; I think inside MPI implementations there is a performant, network-agnostic low-level communications layer trying to get out.  Exposing more MPI runtime services is a move in the right direction.  I was surprised at how open the meeting participants were to making judicious changes &mdash; even perhaps breaking some backwards compatability &mdash; in the right directions.  

Thanks again to the organizers for extending the opportunity to participate; it was great.

My slides can be seen below or on [github](http://ljdursi.github.io/EuroMPI2016/#1), where [the complete materials can be found](http://github.com/ljdursi/EuroMPI2016).

<iframe src="http://ljdursi.github.io/EuroMPI2016" width="595" height="500" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" style="border:1px solid #CCC; border-width:1px; margin-bottom:5px; max-width: 100%;" allowfullscreen> </iframe>
