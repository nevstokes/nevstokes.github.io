---
title: "Recorded History"
date: 2020-09-05T14:10:13Z
summary: "I was first introduced to version control systems twenty years ago, first with CVS and then SVN. These days, like most others, I'm using Git. Over the years, various models and strategies have emerged for VCS best practice."
tags: ["work"]
---
{{< quote text="Any code of your own that you haven't looked at for six or more months might as well have been written by someone else." author="Eagleson's Law" >}}

The BitKeeper / SourcePuller feud spawned the development of Git in 2005. The concept of distributed source control had been around for a while but Linus Torvalds had unique insights on how to implement a system to improve on the designs of some of the earlier systems.

Audit of who did what when. signed commit - git blame somebody else


## Repository Workflows

Distributed architecture enables many modes.
https://git-scm.com/about/distributed

## Branching Models

It took five years of everyone experimenting with Git for anything approaching a good workflow to emerge. For a while, everyone got excited about git-flow. GitHub flow, Git V

Like most things, there's not a one-size-fits-all solution. Understand your processes and requirements.


https://barro.github.io/2016/02/a-succesful-git-branching-model-considered-harmful/
https://mergebase.com/doing-git-wrong/2018/06/04/git-v-an-optimal-git-branching-model/
https://docs.microsoft.com/en-us/azure/devops/learn/devops-at-microsoft/release-flow

With the rise of CI / CD practices, more and more are gravitating towards a trunk-based development process to shorten their feedback loops.

## Commits

- Create atomic commits and enable rerere
- Write well-crafted commit messages

An atomic commit is the smallest individual changeset that will not break the build; it is not the entire feature in a single commit. A feature implementation will consist of many atomic commits; you may have changes grouped across business logic, configuration, documentation and the presentation layer. Having these changes as reductive as possible will make things easy for you to rollback changes as and when necessary but will also simplify the steps needed by git itself when it comes to combine your work into another branch. There will be far fewer conflicts.

Using new syntaxt switch - checkout


project>feature $ git fetch
project>feature $ git rebase origin/main
project>feature $ git switch main
project>main $ git merge feature --no-ff



https://github.com/k88hudson/git-flight-rules




Atomic commit:
Branch from master - known to work
Do the work, single commit - doesn't work
Where did the error creep in?
To me, seems a not very useful practice to encourage.

*alternatively*
Atomic commit is the smallest iteration on the feature
Multiple commits deliver the feature
When it doesn't work, use git bisect to pinpoint where the error crept in


## Merge Strategies

Tell a story of the life of your project.

Merge commit rather than squashing.

Yes you migt say, even if you squash your commits the work will still be available in the reflog but *only until you tidy up*. Pruning old branches is just good housekeeping.

Prefering a particular practice on the basis of subjective aesthetics at the expense of discarding information isn't the best trade-off in my opinion.

- Regularly rebase from upstream main onto feature branch, you may get conflicts but easier to resolve rather than bigger issues later
- Perform an interactive rebase to tidy commits before pushing
- Merge commit feature branch onto main in order to preserve history


Top tip: turn on rerere - this will record the resolution of any merge conflicts so that they can be automaticaly re-applied should the same signature be encountered again in some future operation.


## Config

global ignore

Template - main branch

- git push --force-with-lease
https://blog.developer.atlassian.com/force-with-lease/

- git pull --ff-only
https://mergebase.com/doing-git-wrong/2018/03/07/fun-with-git-pull-rebase/

- git merge --no-ff
https://linuxhint.com/git_merge_noff_option/
helps create a more readable history. It allows you to put tags that clearly shows where the merges occurred. It can save you time and effort during debugging.



- https://gist.github.com/SethRobertson/1540906/68feeabfe906ec1eb893e4fa45f402795ed6e62c
- https://chris.beams.io/posts/git-commit/
