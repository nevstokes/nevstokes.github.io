---
title: "My Descent into Shell"
date: 2020-06-18T19:41:55Z
summary: "For my first lightning talk, I dived into the history of Unix to find the starting point from which modern shells emerged."
tags: ["dev", "unix", "bash"]
---
{{< quote text="Computers in the future may weigh no more than 1.5 tons." author="<cite>Popular Mechanics</cite>, 1949" >}}

I only have vague memories of the discussions at univeristy around the choice of shell. I was new to Unix operating systems and largely just followed the advice of others who knew more about that kind of thing. Frankly I had too many other things on which to focus. I've picked stuff up over the years but never really took a deep-dive into the whys and wherefores until relatively recently.

Before considering the shell though, we need an operating system with which to interact. To do that, we need to go back in time several decades to the 1950s. It was the days of mainframes and the famous engineering labs of Xerox, Bell, General Electric and MIT. Some of the names active in these pioneering times have become well known -- even to those outwith the sphere of computer science -- others, not so much.

At the time, mainframes worked via batch processing. It often took a day from submitting changed code to getting the results back. As an alternative to the batch processing model of working, the concept of time sharing was proposed in 1954 by John Backus in an MIT Summer Session.

> "By time sharing, a big computer could be used as several small ones."

It was a concept ahead of the capabilities of the room-sized computers of the day. It was only five years later when Christopher Strachey presented his paper _Time Sharing in Large Fast Computers_ at a <acronym title="United Nations Educational, Scientific and Cultural Organisation">UNESCO</acronym> conference in Paris that the idea started to take hold. On returning to MIT from the conference, John McCarthy wrote a memo which led to a working committee being established to develop time sharing.

Fast forward a couple of years to the early ‘60s and work was underway on the Experimental Time-Sharing System at MIT, mainly demonstrated by Fernando J. Corbató.

Another couple of years pass and the Compatible Time-Sharing System (CTSS) had evolved from the earlier work. The command-line interfaces of these operating system were resident monitor programs and could not be easily replaced.

Enter Frenchman Louis Pouzin who, while working at MIT, developed the RUNCOM (Run Command) tool for executing command scripts with argument substitution. RUNCOM is where we get the "rc" suffix convention for configuration files such as `.vimrc` to this day.

It was Pouzin who coined the term "shell" to describe the technique of using commands like a programming language, outside of the operating system kernel. After Strachey visited MIT, Pouzin wrote a paper describing how to implement the idea in Multics (Multiplexed Information and Computing Service) -- another early time-sharing operating system, the following year.

Pouzin returned to France in 1965 and, among other things, invented the datagram and designed an early packet switching communications research network -- CYCLADES -- which influenced Robert Kahn and Vint Cerf in their development of TCP/IP protocols.

Meanwhile, another MIT staffer, Glenda Schroeder, implemented Pouzin's ideas in the first command-line user interface shell for Multics.

This was the predecessor to the Unix shell as we know it.
