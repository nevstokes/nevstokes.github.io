---
title: "Shellology"
date: 2020-06-23T10:37:28Z
summary: "As a follow up to my previous Unix archaeology, I traced the evolution of shell development across the decades."
tags: ["dev", "unix", "bash"]
---
{{< quote text="The best way to predict the future is to create it." author="Alan Kay" >}}

In my [previous post](/blog/my-descent-into-shell/) I talked about the development of operating systems, which was necessary before discussing the shells that run on top. I'm only really going to cover the timeline of the main shell variants here, leaving the more esoteric ones aside.

We'd got to Multics, which was apparently an unwieldy behemoth and a pain with which to work. Engineers gradually left the project, with Bell Labs pulling out completely in 1969 just as the initial release was made. That said, the latest release of Multics -- albeit for a simulator -- was just three years ago. That's half a century of development, which is an achievement in itself. I can't think of many things from today -- if any -- that will still be actively maintained in another 50 years time.

Ken Thompson, Dennis Ritchie, Douglas McIllroy and Joe Ossana were among the last to leave the Multics project. They saw enough promise to reimplement the concepts in a new, simpler project -- the Uniplexed Information and Computing Service, or UNICS (to be prounounced "eunuchs"). It was Brian Kernighan who suggested the name. Nobody can remember the reasons behind the final Unix spelling.

Like the others, Ken Thompson disliked Multics, referring to it as "close to unusable". That said, he thought well enough of the shell to use it as inspiration for the Thompson shell, simply named `sh` -- introduced in the first version of Unix in 1971.

It's safe to say that the Thompson shell had some faults. John Mashey moved things forward with the PWB / Mashey shell for Version 5 Unix in 1975 and introduced some control constructs along with the use of the `$` symbol for variables. These features were some of the ideas that would make it into later shells.

Ken Thompson took a sabbatical from Bell Labs and went to Berkeley as a visiting professor, where he introduced Version 6 Unix. This inspired the graduate student Bill Joy who wrote the C shell -- or `csh` -- in 1978, adding it to the second iteration of the Berkeley Software Distribution (BSD) a year later. This shell was based on the C langauge and added features like the history mechanism, aliases and job control. Unfortunately there were still plenty of bugs and other shortcomings.

Also released in 1979 was the Bourne shell, which had been built from scratch by Stephen Bourne over the previous few years. It made an appearance in Version 7 Unix, using algol-like control structures and giving us the environment variable mechanism -- developed with input from John Mashey and Dennis Ritchie.

Moving on to 1983, Carnegie Mellon's Ken Greer evolved the C shell into `tcsh`, fixing a lot of the bugs, adding filename and command completion along with command line editing concepts from TENEX OS (hence the "t"). If you think you're using `csh` these days, you're probably actually being symlinked to `tcsh`.

That same year, David Korn at Bell Labs releaseed his KornShell -- `ksh` -- which became the original basis of the <acronym title="Institute of Electrical and Electronics Engineers">IEEE</acronym> <acronym title="Portable Operating System Interface">POSIX</acronym>.2 standard in a move to improve interoperability between operating systems. It was backward-compatible with the Bourne shell and included many features of the C shell which was popular with fellow users at Bell Labs. The fly in the ointment came with AT&T who wanted to monetize `ksh` and charge users for the shell.

In 1989 Brian Fox -- as part of the Gnu Project -- announced the "Bourne again shell" -- `bash` -- which was a superset of the original Bourne shell, adding in features from both `csh` and `ksh`. It was intended to be POSIX-compliant but with extensions -- or bashisms. It became the default shell for most Linux distributions.

As seems to be the standard in terms of timings, 1989 also saw another shell, this time from Kenneth Almquist. True to form, it was eponymous. `ash` was a BSD clone of the Bourne shell, created in order to circumvent certain copyright issues. This is in use today on some BSD descendants and in low-memory situations such as embedded Linux systems. It has been included with BusyBox, used in distributions like Alpine Linux and Linux-based router firmware, along with an even smaller shell called `hush`.

It came as a bit of a surprise to learn that the `zsh` shell that I use every day is actually 30 years old. It was created by Paul Falstad while at Princeton and is a rare occurrence of someone naming the shell they created after somebody else. Falstead thought that the login id of teaching assistant (and future Yale professor) Zhong Shao would make a good name for a shell. It extended the Bourne shell and also implemented features of `bash`, `ksh` and `tcsh`.

Herbert Xu ported `ash` from NetBSD to Debian in 1997 and, in 2002, this port was renamed to `dash` -- the Debian Almquist shell. It became the default shell in Ubuntu 6.10 and Debian Squeeze.

In recent years, there has been renewed focus on people's choice of shell with an increasing number of articles written. Frameworks such as Robby Russell's [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) are simplifying the process of creating efficient working environments for modern development.

I'll be writing about my own configuration soon.
