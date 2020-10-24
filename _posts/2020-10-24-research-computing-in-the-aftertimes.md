---
title:  "What will Post-Pandemic Academic Research Computing Look Like?"
subtitle:  "For research computing teams, and for their managers, the coming years will be treacherous"
tags: ['management', 'funding']
---

We're nowhere near the endgame yet.  But even now in the middle of the COVID-19 times it is not too soon to think about what research computing will look like when the threat of infection by SARS-CoV-2 no longer shapes our work lives.  While the future looks good for research computing team individual contributors who are willing to learn on the fly, the coming years
will be treacherous for teams as organizations, and their managers.

## What hath 2020 brought

There's a few pretty unambiguous "inputs" from 2020 that will have consequences for years to come:

### Institutional and governmental coffers are depleted

Entire sectors of the economy are in bad shape.  Institutional budgets have suffered across the board.  There have been large unforeseen costs for dealing with the pandemic, while normal operating costs haven't gone down much except in tiny budget lines like travel.

At Universities, international student tuitions have dropped less than expected, but there are well-founded worries that they will continue dropping and not bounce back.   In a lot of jurisdictions,  dollops of one-off support for educational institution came from governments.  Those governments will be tightening their budget as soon as they can, and reducing rather than increasing payouts over the course of many years to claw their way back to budget balance.

### Clients are now used to research computing teams being distant

We've all been working from home over the course of months.  A lot of previously unquestioned assumptions about how important it is to have certain groups or equipment "here" with the research groups so that they could be accessible are now known to be mistaken.  Researchers, VPRs, and funders are seeing that virtual teams for research computing can support research perfectly well with some controls in place.  Yes, it's handy to sit down beside someone to get things sorted sometimes but we've learned we can do pretty well without that.

### Primacy of health research

Life sciences has been an increasingly important part of research computing since quantitative molecular methods took off, and even more since the human genome project's completion.  During the pandemic, centres have dramatically shifted towards prioritizing various kinds of health research workloads, which in turn has boosted capacity (and expectations) of lots of health related research groups and their funders.

### Importance of data and data sharing better understood

With most of the world daily monitoring case counts, "excess deaths", case fatality rate vs infection fatality rate and the like, the importance of clean, high-quality data has never been more widely understood.  And the limits of what "AI" or advanced analysis techniques can do with poor quality data is very clear.

And as data's importance becomes clearer the importance of pooling data has never been more obvious, even in disciplines typically very reluctant to do so (sometimes for good reasons, sometimes not).  That's very unlikely to rapidly change back.

### The best research computing teams have learned to communicate a lot better

The research computing and data teams that have come through this pretty well and with satisfied clients have really had to up their games in communications - internally and externally, synchronous and asynchronous.  Many of these teams already had experience sucessfully working with distributed collaborators and partners, and built on those strengths.

But not all research computing and data teams have come through this experience with satisfied client researchers.

## Consequences: 2021 and beyond

None of the changes I've described above are particularly subtle or ambiguous, and I think the short-term consequences are almost as clear.  Some short and mid-term consequences will be, roughly in order of certainty:

### Research computing teams are never going back to 100% work-from-office

This one is so obvious it hardly needs to be said, but let's say it.  Space on University campuses has always been tight, and 2020 has shown us that research computing teams don't need to be on campus.  While each team will have to figure out its own approach - fully distributed, rotating with hot-desking, hybrid - we're never going back to routinely being all together on campus.

### Research budgets are mostly going to shrink, except in health

Governments worldwide will start trying to get their finances back into balance after the huge COVID-19 expenditures and shrunken tax revenues of 2020 and early(?) 2021.  While research budgets probably won't be drastically cut, they certainly won't grow.

On the other hand, even once the pandemic is well and truly over, funding for health and health research will be extremely popular, voters will be wary of another pandemic, and COVID-19 long-term effects will still need to be studied and monitored.  Health and health research will have an even larger claim to priority over stagnant research funding than before, and institutions will be eager to support such efforts.

### Research support budgets are going to shrink

With research budgets flat and institutions facing declining government funding and possibly international enrolments, there is going to be pressure to make cuts wherever possible.  "Overheads" for the basic missions of teaching and research are going to be under increasing scrutiny.

Any research computing team that can't communicate very clearly its value to VPRs and university administration in terms of research dollars and other outcomes the administration cares about is going to be facing a lot of very uncomfortable questions.  Any cuts to research support services that won't result in months and months worth of  of angry phone calls are going to look pretty attractive to administrations trying to figure out what to cut without firing faculty or teaching staff.

### Research computing teams will consolidate

VPRs have long eyed various kinds of core facilities and wondered if they could be contracted out[^1].  A year from now, with VPRs earnestly looking for budget cuts, researchers increasingly comfortable with getting research computing support over Zoom and Miro, an increased emphasis on data-sharing and thus remote data infrastructures, and some research computing teams better able to communicate their value than others, there will be consolidation and sorting of researching data computing teams.

Very small groups - a couple of specialists embedded in a large (especially health-related) research group, or a handful of research computing experts in a large corporate IT shop - are likely safe as long as they support research that continues to be funded as they're too small a target to be worth cutting.   But medium-sized centres with vague goals and priorities who can't communicate the value they bring are going to be called upon to justify their existence.

As this shakes out, funding will favour small, hyper-specialized teams who deeply understand some segment of local needs, and large regional centres with diversified funding sources, excellent communications, and clear goals and priorities that enter contracts with other institutions and groups.

There isn't going to be a dramatic "big bang" of closures, dissolutions, or mergers. Instead, straitened circumstances and very broad acceptance of virtual research support and data infrastructure will accelerate trends that have already been visible.  And it's going to be lead by individual contributors who are about to realize their employment options have significantly increased.

### More adoption of industry best practices for running computer systems

Research software quality takes a lot of of (unjustified) guff, but the truth is that with version control, unit tests, CI/CD, and packaging, research software development is _much_ closer to industry best practices than research computing systems operations is.

With health data applications becoming increasingly important, that will have to change.  Privacy restrictions around PHI will require better controls, documentation, and processes, including security incident reporting.  Emphasis on data sharing and availability will push teams towards higher availability SLAs, which will push towards on-calls and practices like, if not chaos-engineering, at least routine testing of failures as with ["disasterpiece theatre"](https://slack.engineering/disasterpiece-theater-slacks-process-for-approachable-chaos-engineering/).

### Portfolios of research computing systems are going to be rebalanced away from "big metal"

As with research computing teams, this isn't going to be a big bang or a sudden pivot, but an acceleration of trends already in place.

With greater emphasis on data and health applications, very large-scale physical science simulations (my own background) will be an even smaller, while still important, use case for research computing.  With greater emphasis on remote data infrastructures, remote teams, and data sharing, commercial cloud adoption in research computing will continue to grow.  On-premises infrastructure is going to continue to tilt away from being able to support small numbers of large simulations towards architectures which can provide more flexibility for a wider range of computing and data applications.

## What does it mean for us?

Like the mainstreaming of telemedicine, many of the consequences of the pandemic will just be pushing forward something that was always going to happen eventually but had lacked an impetus until now.  And for many (most?) research computing team individual contributors, things will look pretty good - work-from-home will open up more job opportunities, even if the portfolio of projects they support starts looking different.

But for research computing teams as organizations, and for their managers, the coming years will be treacherous.  If the research computing team supporting University research groups doesn't have to be on campus any more, why do they have to be University employees at all?  If a neighbouring centre has better-run systems with better availability and already handle PHI, why not just use them for research software development support too?

It is not too early to start upping your game when it comes to the adminstration, your researchers, and your team members.  For the administratio, you're going to have to ensure that you can justify every budget item in terms the administration recognize and value, and that you have clear and focussed goals and priorities. For researchers, you can start making sure that your systems, processes, and practices are as high-quality and researcher-focussed and -friendly as possible.  For your team members, if you're not regularly communicating with them to make sure they're happy in their current roles and with their career development, this is the time to start.

---

[^1]: See for instance table 2 of [Carter _et al_.](https://www.srainternational.org/blogs/srai-jra1/2019/12/09/operational-fiscal-management-of-core-facilities), where VPRs 2:1 would prefer service contracts for HPC centres over in-house options (of an admittedly small sample).
