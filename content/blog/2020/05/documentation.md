---
title: "Documentation"
date: 2020-05-10T20:13:38Z
summary: "It is a fact that individual contributors to a codebase will come and go. Establishing good documentation practices is essential to enable an effective organisational memory."
tags: ["dev", "documentation", "work"]
---
{{< quote text="Accurate information is a key part of motivation." author="Mary Ann Allison" >}}

I'd like to introduce Nev's corollaries to [Arnold's Laws of Documentation](https://threes.com/arnolds-laws-of-documentation/):

- The only thing worse than no documentation is outdated and misleading documentation
- The closer that documentation is to the thing that it is documenting, the easier it is to find
- The easier that the documentation is to find, the more likely it is to be kept up to date

Documentation is not just commenting your code or adding a sparse README file and leaving it at that. Ideally, you'd [write code that doesn't need commenting](https://blog.codinghorror.com/coding-without-comments/) anyway.

Like a well-crafted commit message or pull request, good documentation is more about the _why_ rather than the _what_. With enough time, _what_ is happening can always be extracted from the code. It is impossible to infer what the developer's intentions, constraints and considerations were at the time of implementation.

You can write the best project documentation around but it's pointless if nobody knows where it is. Don't bury it in a wiki -- those notorious informational dumping grounds. The extra maintenance effort involved usually means that they are seldom properly curated.

Instead, keep it in the repository, with the code to which it is pertaining; it is something that should evolve with the codebase.

Document the project overview and high level architecture, security aspects, local development and testing processes, deployment practices, and runbooks for any common procedures.

For recording significant choices, consider adopting [Architectural Decision Records](https://adr.github.io/) and link to these in your code where appropriate.

Organisation-wide concerns that are applicable across projects -- like branching models and merge strategies -- are less likely to change all that frequently and _are_ more suited for keeping in a wiki or other document management solution. Finer detailed, individual feature requirements with well-defined user stories and acceptance criteria should be the responsibility of individual tickets in your project tracking system.

Once you've gone to the trouble of putting these things in place, don't throw it all away by allowing the documentation to get stale. Don't approve any pull requests that haven't addressed any required updates to the documentation as a result of changes to the code.

Doing all of this will ease the onboarding of new developers, facilitate embedded knowledge and make information quicker to reference as the need arises.
