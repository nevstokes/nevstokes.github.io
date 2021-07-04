---
title: "Think of Your Environment"
date: 2020-07-08T20:42:16Z
summary: "No, I'm not talking about green issues here, but rather the variable context to which an operating system's shell is exposed."
tags: ["containers", "dev"]
---
{{< quote text="Knowing is not understanding. There is a great difference between knowing and understanding: you can know a lot about something and not really understand it." author="Charles F. Kettering" >}}

A dotenv file such as `.env` can be handy for local development. It is a substitute for a real environment in which the application will actually be operating; they should never really be used in a production environment.

## Environments and dotenv files

As per best practice as described in Heroku's [12 Factor App](https://12factor.net/config) methodology, only runtime configuration parameters that differ per-environment should be included in a dotenv file; it shouldn't be polluted with values that are intended for the build or deployment processes.

Before the days of the Cloud, containers and ephemeral infrastructure, heavy-duty configuration management tools would take care of setting up the production environments if you were lucky. This made things tricky to manage for local development, unless you had the luxury of working on a single project or were using virtual machines. These VMs were slow and cumbersome so devs started using these dotenv files to easily isolate and manage these variables.

Libraries are commonly used to parse these dotenv files and make the variables in them available via the environment for languages to use, such as those for [PHP](https://packagist.org/packages/symfony/dotenv), [Node.js](https://www.npmjs.com/package/dotenv) or [Python](https://pypi.org/project/python-dotenv/).

We've moved on a lot in the last decade but the use of dotenv files still persists. The reasoning behind them sometimes gets lost, which means we run the risk of descending into dogmatic cargo culting. They are a workaround, not the actual way to achieve the original goal of the seperation of code and config.

Indeed, to achieve this seperation of concerns, a dotenv file should never be checked into source control. Instead, templated versions -- such as `.env.dist` or `.env.local` -- which don't include sensitive information are committed instead. Sharing and populating the actual values is an extra step to be built in to the development process -- not to mention the work involved in keeping these details up to date.

Some get around this by committing encrypted verions of dotenv files, maybe employing the `git smudge` and `git clean` filters to handle this work transparently. Others rely on manual processes or scripted solutions to get the same effect.

## envfiles

Similar to a dotenv file but for a different context. Used to pass variables from the existing environment to a container or set new ones.

docker-compose automatically use .env

## Alternatives

direnv -- requires installation (https://direnv.net/) rather than a library -- can be coupled with encryption such as ssh-vault so that the variables can be safely shared. Sets up a per-project environment.

All that being said, the use of environment variables in this way would ideally be limited -- if used at all. Any process running will have access; real risk of credential leakage.
Instead, if at all possible, template out configuration files with values from a secure storage solution with granular access levels and audited leased access.
