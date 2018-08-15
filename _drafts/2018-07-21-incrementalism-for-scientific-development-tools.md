---
title:  "The Killer Feature for Scientific Development Frameworks: An Incremental Path To Maturity"
tags: ['hpc']
---

### The Stages of Research Software Development

Research software development covers a lot of ground &mdash; it's the development of software for research,
and research is a broad endevour that covers a lot of use cases.

The part of research software development that I spend the most time thinking about is the part that 
_is a research effort itself_; the creation of new simulation methods, new data analysis techniques,
new ways to combining different sorts of approaches.  Like any new tools, this work
can enable people to ask entirely new questions, or answer old questions in new ways, pushing
scholarship forward along previously unexplored paths.

But for new methods to live up to their potential and have that impact, they have to be developed
and disseminated.  As a community, we're still developing the training and tool chains that 
make this routine; without them, there are still too many bottlenecks in the method development
pipline that mean good ideas for new tools get delayed, sometimes indefintely, before adoption.

Computational tools for science and scholarship go through stages of development like any experimental technique:

1.  **Will this even work?**  Testing the core ideas out, usually interactively
2.  **Will this answer my question?**  Developing a very early prototype on your own data set/conditions
3.  **Is this an interesting question to others?**  Sharing a more robust prototype with friendly collaborators who think it might be useful
4.  **Becoming Research Infrastructure** The robust, usable, automatable tool becomes something strangers start to use routinely in their own research

These steps can be thought of as a sort of internal-to-the-research-endevour version of 
the [Technology Readiness Levels](https://en.wikipedia.org/wiki/Technology_readiness_level) 
that are used to describe the maturity of technologies and tools, now often used when talkingj
about commercialization.

Not every idea has to go through all four stages to be successful; sometimes a tool will be a 'one-off'
or nearly so, used for one or two projects and never again.  This isn't at all a bad thing, 
if it serves its one purpose well.  

But each transition between stages represents a potential barrier for ideas becoming new tools,
a jump in level of development skills and effort required.  Every tool that stalls at between 
stages there isn't training or tooling to allow incremental progress along the pipeline is a tool that
is unnecessarily lost to researchers who might have made use of it.

### Training Research Software Developers at all Stages

The set of techniques that people generally mean when they talk about 
&ldquo;Software Engineering&rdquo; is most useful at step 4 &mdash; they largely assume that 
there already exists a well-posed problem and an understood, implementable solution.
It was understood fairly early that this was quite different from scientific software development
(although perhaps too much was concluded from this, as science spent decades largely 
ignoring progress in programming techniques tools used in other fields).

Realizing that something somewhat different was needed, in the late 90s 
[Software Carpentry](https://software-carpentry.org), and later [The Carpentries](https://carpentries.org),
started teaching more research trainees enough modern programming skills to ask their own 
questions &mdash; to navigate the biggest transition from nothing to stage 1, when existing tools
won't work for their questions; and to get started on the journey of the next transition, to
stage 2, building an entire early prototype.  That training may or may not get students
all the way to the end of stage 2, with issues like speed or advanced functionality remaining,
but those issues will vary from research project to research project, and the goal is to
get the students to the point where they can learn additional material themselves.

There still isn't a lot of training for researchers to make the next big jump, from
prototype-for-self to tool-some-others-can-use.  However, authors are beginning to write
resources for students wanting to learn how to proceed[^1] [^2] [^3].

The second-biggest transition in that list, that from 3 to 4, is the one I spend the least
time worrying about.  It's at that stage that existing software engineering teaching, tooling,
and resources become the most helpful.  And while the effort to learn those techniques
and apply them can be significant, at this point the ideas and the tool have proven themselves
useful enough that it is much easier to find the time, people, adn resources to complete a 
&ldquo;research infrastructure&rdquo;-grade implementation.

Of course, once the set of ideas is implemented as research infrastructure, it's
much harder for most practicing researchers to get under the hood and start 
tinkering with by making changes or incorporating additional ideas.  And so the cycle starts again.

### The Best Scientific Development Frameworks will Allow an Incremental Path Towards Maturity

While the research computing community has made great progress in creating development training
specific to their needs, there's been much less success with programming languages, tools, or
frameworks which reflect the path of research programs.

Arguably the best programming language for science, and certainly one of the most successful, 
has been a general purpose programming language, Python.  I think the reasons for this include
the relatively smooth path scientific software development can take towards maturity in the
Python ecosystem:

* One can easily and rapidly test out ideas at the REPL and in a notebook.
* The large standard library and even larger ecosystem lets you quickly implement a lot of functionality
* Compared to languages more commonly used earlier like C and FORTRAN, the exception system lets
you implement a number of things and still undertand what's happening before you have to start
implementing boilerplate error handling, making it something that can be added incrementally at later stages.
* Tools like [Numba](http://numba.pydata.org), [PyPy](https://www.pypy.org), or venerable [Cython](http://cython.org) allow incremental (but often substantial) performance improvement for many kinds of computation
* Tools like [Dask](https://www.pypy.org) offer an incremental path to scale
* Great tooling exists, including [VSCode](https://code.visualstudio.com) which makes much IDE functionality available for free

Meanwhile, other frameworks, aimed more directly at solving needs particular to research or branches of research,
have struggled.  Much of this, of course, has to do with the simple math of adoption; but most have not
made much effort to make tools which ease the development of increasingly mature research software.

To their credit, the [Julia](https://julialang.org) community understands some of this, but they are focussed
on a narrow piece of the issue; the need for a framework for incremental adoption becomes &ldquo;one language
for everything&rdquo; with tools like Numba or PyPy as, essentially, cheating; and the only 
maturity metric focussed on is performance, which can certainly be helpful but is by no means the primary
development problem of most researchers. Having said that, most other programming languages aimed for
scientific communities have not made nearly as much progress on key usability issues for researchers.
I'll certainly be watching the progress of their 1.x releases with some interest.


[^1]: [_Ten simple rules for making research software more robust_, Taschuk &amp; Wilson](http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1005412)
[^2]: [_Ten Simple Rules for Developing Usable Software in Computational Biology_, List, Ebert, &amp; Albrecht](http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1005265)
[^3]: [_Testing and Continuous Integration with Python_, Huff](http://katyhuff.github.io/python-testing)