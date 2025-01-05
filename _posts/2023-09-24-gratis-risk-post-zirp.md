---
title: "Gratis Offering, Risk, and our Post-ZIRP environment"
summary: "We have to do risk management for the gratis offerings we rely on"
tags: [strategy]
---

(Note: This post is adapted from [#170](https://www.researchcomputingteams.org/newsletter_issues/0170) of the [Research Computing Teams Newsletter](https://www.researchcomputingteams.org))

It’s fantastic today that there’s so many free (gratis) tiers of service and packages of software, open source or otherwise, that we can use as the foundations for the computing, software, or data services we offer to our research communities.

It really is! I feel that viscerally, because when I was coming of age in this community, proprietary and only barely interoperable OSes, compilers, libraries, resource managers, data platforms… were the norm, not the exception.

So I’ve never taken those free offerings for granted. It’s a fantastic development that I’m constantly conscious of.
In some cases, it’s a vibrant distributed community that makes these offerings possible, with each contributor putting in largely volunteer effort off the sides of their desk, each person part of a massive international collaboration made possible by nearly ubiquitous internet access.

There are real downsides to putting so much responsibility on the shoulders of unpaid volunteer labour — maintainer and contributor burnout being a big one — but there are communities and packages where it works well and empirically appears sustainable.

In other cases, it’s a clear business decision, with a company freely offering a software package or service (often with some open source), with paid services or support built atop. The idea here is to fund the development of the open software or services (and then some) with paid offerings.

Either way, these offerings are great boons for those of us supporting research with computing, software, or data services.

But people’s time is (rightly) valuable and one way or another needs to be compensated. Similarly, equipment takes both money both for the equipment itself and for paying the people who operate it.

These are facts that we’re exceedingly aware of within our own teams, but too often forget when it comes to external offerings.

From the second tech boom (post the pets.com bubble) and then during years of low interest rates, money had been pretty easy to come by for tech companies. That’s meant that companies (or more properly their investors) could be pretty ok with high customer acquisition costs, like generous free tiers or open source software offerings; it meant that companies didn’t mind paying for some of their people to do open source development if it helped with recruiting; and it meant that other companies could be pretty ok paying for paid tiers of offerings even if they didn’t need it, “just in case”.

But now things have changed.

We’ve seen this with last year’s seemingly endless rounds of layoffs in tech companies, but it started before then. Docker no longer storing unused images indefinitely for free ([#37](https://www.researchcomputingteams.org/newsletter_issues/0037)) and then charging for Docker Desktop ([#90](https://www.researchcomputingteams.org/newsletter_issues/0090)); Heroku discontinuing their free tier; a number of CI/CD offerings chopping their free tier limits way back; GitLab said (and then partly walked back) that they were going to expire dormant repos; Google messed around with free Suite/Workspace plans; and of course we remember Binder’s struggles. Lots of small but key software packages have been archived, or are simply no longer being updated. This has been building for some time.

And while I was on summer hiatus, the latest RedHat licensing brouhaha erupted.

That Red Hat has put another bump in the path of generating free versions their distribution has a lot of people talking, because it directly impacts our systems and plans.

(A lot of that talking went along the lines of “IBM/RedHat is shooting themselves in the foot in the RCD community with this move”. My siblings in Science — why would a software or services company spend five seconds thinking about a market whose primary defining characteristic is a passionate refusal to spend money on software or services?)

There’s been very little discussion I’ve seen about anything closer to home, where we have much better knowledge and (more importantly) the very real ability to change things.

Crucially, only once or twice have I heard (and exclusively in private), “We had that risk logged; we already had some plans in place”.

In the RCT newsletter (as well as over at [Manager, PhD](https://www.managerphd.com)) I talk about risk registers and risk management principally in the context of projects. But it matters for operations, too. We’re entrusted to provide foundational resources and expertise for researchers who need data, computing, and software development. It’s our responsibility to be aware of, and consistently revisit plans for, events that could risk our ability to deliver those resources or expertise.

Given that since the late 90s, free (both *libre* and *gratis*) offerings have been so much the norm that its understandable that we’ve grown to take them for granted and not view them as risky (though maybe less understandable is surprise about this particular case, after all of the discussion when CentOS transitioned to CentOS stream so recently.)

But it’s always been true that depending on some other group to provide something to you for free has some degree of risk associated with it, which must be managed.

And yes, it is undoubtedly true that paid offerings sometimes also get cancelled without replacement unexpectedly. This has happened to me in both my professional and private life, and I have been Greatly Displeased each time.  But we are professionals, and colleagues. Let’s not pretend to each other that this happens at remotely the same rate or with the same consequences with which free offerings disappear or fade away.

People who don’t want to think about this stuff will doubtlessly uncharitably summarize what I’m writing here as “He says we should all be paying for everything or we deserve what we get”. That is emphatically **not** what I’m saying.

Given what we do and the constraints under which we do it, yes we should continue to take advantage of free offerings and free software! It would be ridiculous not to.

The evolving environment *does* mean that we should be very conscious when we adopt such offerings in foundational ways, and make sure we have plans and alternatives should the offerings change. It also means we should revisit these plans and mitigations periodically and update when necessary.  Mitigations could mean having backup plans including ideas for transitions; it could mean contributing to the free offering in some way (bug reports, PRs, etc.) so as to be seen to be a valuable member of the community.

Regardless of how we address it: as people with significant responsibility entrusted to us, responsibility that affects researchers’ ability to advance science and scholarship, it’s important for us to be aware of the shifting risk landscape around us.

We should be alive to and monitoring the risks of crucial dependencies in the services and resources we offer. That’s true whether it’s crucial team members leaving, the terms of a free tier being drastically altered, funders changing their compliance requirements, or anything else.

The fact those risks exist doesn’t mean we don’t hire great people, or never use free tiers of anything, nor take money from inconstant funders (which is all of them).

It just means we don’t take them for granted.

RCD shares academia’s greatest weakness — refusing to acknowledge that people’s time matters and has value, even our own.

That can lead to taking contributions from within our community, and from external organizations, as a given and as something that we’re entitled to.

The recent RedHat issues, when combined with other recent changes to our environment, will be well worth it if it reminds us that this isn’t the case, and that the responsibility entrusted to us requires a level of clear-headedness and professionalism around the value of things we rely on, dependencies, risks, and mitigations.
