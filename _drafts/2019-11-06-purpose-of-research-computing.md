---
tags: ['hpc', 'cloud', 'canada']
title:  "The Purpose of Research Computing is the Research, not the Computing"
---
<blockquote class="twitter-tweet"><p lang="en" dir="ltr">Any research computing centre where technical decisions don’t start and end with the questions “what do researchers say” and “is this the best way we can help research” is running computers as a hobby, not as a service.</p>&mdash; Jonathan Dursi (@ljdursi) <a href="https://twitter.com/ljdursi/status/1180123733538856960?ref_src=twsrc%5Etfw">October 4, 2019</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

Absolutely everyone in research computing will agree that supporting
research is their centre’s highest goal.  And they’re not lying,
but at many centres I’ve visited, they aren’t really correct, either.

The day-to-day work in such a centre, naturally enough, is all about
technical operations - keeping the computers running, updating
software, making sure `/scratch` has enough space free, answering
emails.  And of course, it has to be.  But without internal champions
actively and continually turning the focus back to the _purpose_
of those activities - the research outcomes that those activities
are meant to support - the internal, technical, activities _become_
the purpose of the centre.

Pretty quickly, you end up with centres that are ranking their
performance quarter to quarter with cluster utilization numbers,
or having all researcher interactions occurring via “tickets” and
measuring volume and mean-time-to-closure of those tickets (because
shorter conversations with researchers are better, right?)  And
once that’s happened, it becomes very hard to change; bytes and
flops and closure rates have become the reason for coming to work.
It’s baked into the reporting, the funding, the staff’s annual
performance review.  Sure, many of these same centres do collect
and in some way report publications, but if publication rates
resulting from work with the centre are down 5% last year because
two productive groups need new capabilities but the centre has
decided to grow current capability, no one is getting an uncomfortable
call from the boss at these centres.  Ticket closure rates going
down 5% though… maybe you’re getting a call.

It doesn’t take very long to spot centres like this, even from the
outside.  On their websites, most prominently of all, are the
statistics that their biggest cluster premiered at position X on
the Top 500, it has such-and-such much disk space, umpty-ump GPUs,
and even more CPUs.  There are elaborate multi-stage sign-up
procedures which make the centre’s own reporting easy but getting
a graduate student started on the cluster tedious.  Their website
will show a couple of dated research success stories, but if a
researcher is visiting the website for the first time and wants to
know basic facts relevant to them, things like “What is a list of
services that the centre offers”, “Can you help my grad student do
X and if so how long would it take”,  “What is current wait times
for resources/for software installation”, the researcher is out of
luck - they’re just directed to a “contact us” email address (which,
of course, feeds into a ticket tracker).

(Have you ever visited a restaurant webpage and needed like 4 or 5
clicks to get to the menu and their hours?  If the restaurant took
the menu off the website entirely and you instead had to file a
ticket so you could ask specifically if they made spaghetti carbonara,
that’s what most research computing centre websites are like for
researchers).

The thing is, using metrics like utilization, tickets, storage and
the like to measure how much research support is happening is
madness, and we all know it’s madness.  You can goose utilization
numbers by letting researchers run jobs inefficiently, by prioritizing
job size distributions that may or may not represent researcher
needs, or by having staff do a lot of benchmarks “just to make
everything’s still good”.  You can keep ticket closure rates up by
having something that should be clarified or automated or fixed and
instead leaving it vague or manual or broken so that there’s a
stream of tickets coming in that are easily closed; or by irrelevantly
dicing what could be a long, productive discussion with a researcher
into a series of shorter “tickets”.

It’s madness because neither utilization, nor ticket closure rates,
nor storage use, nor even training course enrolment are valuable
to research _in and of themselves_.  They are *inputs* to the process
of supporting research via computing; not the purpose, not the
desired outcomes.  Being guided by metrics of those inputs and just
hoping that as long as those numbers stay good the best possible
science outcomes will just happen of their own accord is an abdication
of responsibility, and a squandering of scarce research-support
resources.

And it’s worse than that, of course.  Even a focus on inputs, if
it was being honest, would focus on _all_ the inputs, and certainly
the most valuable and hardest-to-replace inputs - the technical
staff.   What’s the “utilization” of the staff?  What fraction of
that Ph.D. chemist’s time over there is spent actually enabling
research projects, versus updating software packages or responding
to “why is my job still in the queue” tickets?  How much time does
our data centre monitoring expert spend swapping memory and cables?
Is that up this quarter, or down; and if it’s down, why?  What
fraction of the expertise of the support staff is being used?  What
is the meaningful contribution rate?

The reason that those staff input metrics aren’t being measured and
others are is simple, and clarifying.  The hardware inputs aren’t
being used as metrics due to a (false) belief that they are meaningful
in and of themselves, nor because of an (incorrect) understanding
that they are they can be taken in a principled way as a proxy for
the desired research outcomes.  They’re used because they’re easy
to gather.  And they’re comfortable to use because they don’t really
require centre managers to make any hard choices.

Focussing on the inputs instead of the outputs - or even better,
outcomes - isn’t only a research computing thing, of course.  It’s
an absolutely classic mistake in a lot of sectors; a google search
for [focus on outcomes, not
inputs](https://www.google.com/search?q=focus+on+outcomes%2C+not+inputs&oq=focus+on+outcomes%2C+not+inputs)
returns 139 million results.

There are two prototypical reasons why it happens.  If I were feeling
in a twitter-ranty mood again, I might be tempted to draw the analogy
to the first case - lack of competition, due to private- or
public-sector monopolies, reducing the urgency of focusing on
customer’s needs.  You see this in internal departments of large
organizations, where the “customer base” is locked in, or in other
places where there’s no real competition (Hello most departments
of motor vehicles, or cable companies, or Google Mail support!).
These departments end up developing a relentless internal focus,
having cryptic and opaque internal decision-making processes seemingly
unrelated to what their clients actually want, and famously make
clients jump through hoops to get their needs met.  This isn’t
caused by malevolence, or even indifference; it couldn’t be for it
to be so widespread.  It’s just that, absent any real driver to
focus on *customer* outcomes, it is almost impossible to drive
internal priorities towards anything other than internal efficiencies.
Those few companies in this situation that _do_ manage to maintain
a focus on client outcomes are doing so by constantly expending
almost heroic levels of unseen effort inside the organization.

But I don't actually think that’s what driving some research computing
centres inputs focus when it comes to operations and technical
decision making.  I think it comes almost from the other direction,
the other classic case; that of small nonprofits, typically enormously
concerned with their clients, who focus first on a very basic need
and then don’t know how to generalize beyond that as they grow.

Imagine a small nonprofit, passionately committed to helping people,
that gets its start meeting a very basic need - let’s say they’re
providing before-school breakfasts to children in or near poverty.
At that level, the activity _is_ the outcome; they can count the
number of breakfasts served, try to get better at serving breakfasts
with a given amount of donations, work on raising money to fund
more breakfasts, maybe expand to different schools or supplying a
wider range of breakfasts to be inclusive of students with particular
dietary needs.  They are _super_ committed to their clients.

But as that nonprofit starts expanding, it becomes clear their
client base needs a wider range of services.  It starts partnering
with food banks, to help fight student hunger at home; its staff
participate in some after-school tutoring programs.  But it has no
way to prioritize these activities.  Is it a hunger-fighting
nonprofit?  Is it a help-underprivledged-students-succeed-at-school
nonprofit?  If they could double the tutoring efforts at the cost
of slowing the growth of the breakfast program next year, is that
the right thing to do, or not?  How would they know?

This is a terrifying transition for a nonprofit to go through.
Before, it knew exactly what it was doing, and had very clear metrics
for success.  In this intermediate stage, it probably has some
earmarked resources to participate in the tutoring and foodbanks,
and it touts that work, but it doesn’t know how to do anything but
report on school breakfasts.  To go beyond this means making choices
about what it will prioritize - and more scarily, what it will _not_
prioritize - and working on program evaluation plans for the much
more ambitious but more ambiguous goals of “fighting hunger” or
“helping students succeed at school”.   Many nonprofits never make
that transition.  Some stay small and focussed, which works well
but limits their impact; many stay in limbo in that uncomfortable
intermediate state until they are overtaken by events or other
organizations.

At most research computing centres, I think the story is more like
that of the nonprofit.  Except let’s be honest, while providing
breakfasts is inherently meaningful and has very few organizations
willing to do it, providing cycles and storage isn’t, and has many
alternate providers.

But going beyond meeting the basic needs of providing research
computing cycles and storage, which was a much greater need in the
90s than it is today, is genuinely hard.  It’s very labour intensive -
it requires going out to the entire research community you aim
to support, including those who you’ve never had a working relationship
with, and understanding needs.  It’s very uncomfortable - you have
to then prioritize those needs based on their value to the larger
enterprise and to where you can make the most difference, and that
means having awkward conversations bout *not* prioritizing other
needs.  And it’s incredibly uncertain - it means going from evaluations
based on numbers on a dashboard that are largely under your control,
to unfamiliar qualitative evaluations and doing the hard work of
trying to measure research outcomes.

So I get it that asking what the right next thing to do to help
research isn’t easy.  It absolutely isn’t.  A centre that hasn’t
been thinking this way for a while will have some low-hanging fruit
that can be picked to start, but after that there will be  multiple
ways for a centre to be supporting research, and no clear answer
which is the “best”.   Making those choices will require knowing
the strengths of the centre and knowing where those strengths are
needed in the research community it serves — and not all research
needs are the same!  But _those_ are questions that teams leaders
need to be wrestling with; after those, the question of whether to
buy more storage or more big-memory nodes becomes simple or neither
and instead investing in more expertise, becomes simple.

The alternative, just running a set of computers for the same
friendly user group of people year after year, isn’t research
support; it’s a hobby.
