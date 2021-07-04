---
title: "Confessions of a Bashist"
date: 2020-06-27T18:08:51Z
summary: "I prefer some things to be done a certain way but my reasons are seldom irrational -- usually there's at least some logic involved somewhere."
tags: ["dev", "bash"]
---
{{< quote text="If I had an argument with a player we would sit down for twenty minutes, talk about it and then decide I was right." author="Brian Clough" >}}

Developers who get upset at non-Pythonic code are commonly referred to as "Pythonistas". Similarly, I've decided that I'm a radical bashist; it irks me to see things done contrary to the general Unix philosophy.

> Write programs that "Do One Thing and Do It Well". Write programs to work together. Write programs to handle text streams, because that is a universal interface.

Ken Lochner came up with the concept of "communication files" in the Dartmouth Time Sharing System. While independently developed, this was very similar to the slightly later Unix pipe that Doug McIllroy and Ken Thompson created for Version 3 Unix.

At the fundamental level, a pipeline is a mechanism for inter-process communication using message passing. In other words, the glue that connects different commands -- taking the output from one and treating it as the input for the next.

Unix systems are characterized by this modular design. I see it as analogous to functional composition or fluent interfaces and method chaining -- even, dare I say it, microservices. I'm not sure how many people really truly appreciate the beauty and genius in the design of things like `awk` and `sed` and the underlying principles of this method of implementation.

This is stuff from 40-50 years ago. Meanwhile, I'm wondering what the JavaScript framework _de jour_ is going to be next month.

Some view a pipelined chain of commands as "complex" and "unreadabe" when in reality what they actually have is a sequence of pure simplicity.

A large part of the problem is that not everyone knows what these commands do -- or that some of the more arcane ones even exist.

I guess if you haven't got to grips with the fundamental concept of connected text streams then it probably is more obvious and readable with explicit control structures as that's the way it'd be done in most scripting languages.

Direct implementations of paradigms from other languages aren't necessarily a bad thing. Yes, `bash` has conditional and looping constructs but we don't always need to use them. In fact, I'd argue that they should be avoided wherever possible.

As someone once said, Think Different.
