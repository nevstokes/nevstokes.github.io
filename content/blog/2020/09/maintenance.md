---
title: "Maintenance"
date: 2020-09-05T14:10:13Z
summary: "The software project lifecycle doesn't usually end with delivery. If it's not looked after properly, a project can often still cause you pain way beyond this stage."
tags: ["dev", "documentation", "security", "work"]
---
{{< quote text="Another flaw in human character is that everybody wants to build and nobody wants to do maintenance." author="Kurt Vonnegut" >}}

We all start out with good intentions but these often fall by the wayside as the competing priorities of feature delivery come to the fore.

Refactoring, bug fixes, planned deprecations and defined upgrade paths are a discussion for another day.

Currently, one of the biggest security issues developers face is outdated third-party dependencies. Staying on top of these can be a Sisyphean task. GitHub's [Dependabot](https://github.blog/2020-06-01-keep-all-your-packages-up-to-date-with-dependabot/) is a fantastic step forward but you can also use an audit step in your pipelines and git hooks; don't commit -- or deploy -- anything known to be insecure.

Using <nobr>`npm audit`</nobr> or Python's [Safety](https://pypi.org/project/safety/) project can protect you from rolling out a release with known vulnerabilities to production but having these block your build can be problematic if there isn't a fix available.

I only recently discovered the <nobr>[`npm-audit-resolver`](https://www.npmjs.com/package/npm-audit-resolver)</nobr> package that is designed to address this situation. This delegates to <nobr>`npm audit fix`</nobr> to mitigate any issues that have an available update but, when this isn't the case, links you through to more information to help understand what the vulnerability actully is and lets you defer the resolution for a period of time. This allows you to still perform deploys while the upstream maintainer works on a fix for the issue.

The tool comes in two parts. One to use during development -- <nobr>`resolve-audit`</nobr> -- to resolve security issues and generate a <nobr>`audit-resolve.json`</nobr> file which should be committed as a decision log. This file is then used by the second command -- <nobr>`check-audit`</nobr> -- in the CI pipeline to enforce the expiration on any exceptions.

These dependency updates can -- and should -- be automated. To help faciliate this, it's important to also have robust automated testing in place in your pipelines that can give you confidence that these updates don't result in any unintended consequences.

However, not everything can be covered by automation. For example, is the project documentation still up to date? Check it over -- regularly. You can at least automate reminders about the management of these review tasks by creating recurring events in your team calendar and setting an alert to raise them in the relevant stand ups to ensure that they get actioned. Once completed, update a review log in the project repository accordingly with any resulting findings recorded, along with the date for when the next review is scheduled.
