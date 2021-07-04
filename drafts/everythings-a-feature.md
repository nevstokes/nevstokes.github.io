---
title: "Everything's a Feature"
date: 2020-09-05T14:10:13Z
summary: ""
tags: ["dev"]
---
{{< quote text="" author="" >}}

feat: A new feature
fix: A bug fix
Breaking change - that you have to type as part of the commit message

The Angular convention additions
https://github.com/angular/angular/blob/22b96b9/CONTRIBUTING.md#type

x build: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
x ci: Changes to our CI configuration files and scripts (example scopes: Travis, Circle, BrowserStack, SauceLabs)
x docs: Documentation only changes
x perf: A code change that improves performance
x refactor: A code change that neither fixes a bug nor adds a feature
x style: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
x test: Adding missing tests or correcting existing tests

"chore" is the last resort, it doesn't tell me anything - the "misc", or "general". A chore is something nondescript that is done begrudingly. "doc" and "test" - like security (which apparently doesn't merit a mention), do this with the feature itself. "Performance" is also a feature, as others (have)https://blog.codinghorror.com/performance-is-a-feature/ (said)[https://blog.gradle.org/performance-is-a-feature]

how the project is built and deployed arguably should be your first feature. Establish a path to production early, walking skeleton.

An excuse for being lazy with commit messages.

"refactor" fixes something, maybe not a bug in functionality, but in code design or ci/cd implementation.

Bumping your dependencies - a fix for something that's outdated or insecure.

"style" should be automated by your linter to adhere to your coding standards either directly in your IDE or with a preventative git hook that won't allow commits that are in violation.

Which leaves us with: everything is a feature or a fix. If you're making small, atomic commits then you're not going to have a 1:1 of the feature or fix item on your backlog. Why bother? Write good commit messages, use "feature" or "fix" as part of your branch name where you'll commit all of the changes to deliver a changeset that will satisfy the acceptance criteria.
