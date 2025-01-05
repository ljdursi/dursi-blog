---
title: Buy and Lease, not Cloud vs On-Prem
summary: "It's well past time to move past 2012-era 'cloud vs on-prem' arguments"
tags: [strategy]
---

(Note: This post is adapted from [#130](https://www.researchcomputingteams.org/newsletter_issues/0130) of the [Research Computing Teams Newsletter](https://www.researchcomputingteams.org))

I'd like us to move past the "cloud-vs-on-prem" debate.  Right now, AWS or GCP will deliver their cloud hardware into your data centres to run there, if you want.  Various commercial software can be subscribed to to manage infrastructure control.  Hardware can be leased, bought, sold back.  If your data centre is a co-lo, so the premises aren’t yours, is it really on premises?  And…

There’s a whole spectrum of options available today, and our community is still debating “on-prem vs cloud” like it’s 2012.  It would do us and our researchers well to have more sophisticated discussions.  The question isn’t “on-prem vs cloud”, it’s what should be bought outright and what should be leased for a given workload mix.

Here are some real options for moderately-sized teams charged with delivering the capabilities of a system to users right now:

- Buy the hardware outright, install all open-source software,
- Buy the hardware outright, install a lot of “rented” commercial software (or commercial support of open source software)
- Buy some hardware outright and install something like Azure Stack, renting a lot of the infrastructure software and control plane
- Lease the hardware, with any of the software options above
- Host any of the hardware options above in a datacenter you own, “renting” the data centre operations staff’s time (cooling, power, internet, physical security..)
- Any of the hardware above in a leased space where you control and have to manage the utilities, renting the same staff time
- Any of the hardware above in an an institutional or commercially-managed space where you are now “renting” the space and their data centre operations staff
- Rent medium-term reserved hardware at a cloud provider, combining data centre ops, some systems ops, and the hardware for moderate periods of time
- Mix of the above plus short-term “renting” of on-demand or shorter-term contract nodes/services
- All short-term
- “Hybrid”, which just means a mix of any two or more of any of the combinations above

It’s not “A vs B” any more, and it hasn’t been for ages.  We have a widely diverse research community with its huge range of use cases to support, and we need to think in more sophisticated ways than obsolescent binaries.

(And **here’s** a controversial take:  You know who in our institutions are *really, really* smart about leasing versus buying for big capital needs?  Who have taken, like, whole postsecondary courses on the topic?  The folks in the finance department).
