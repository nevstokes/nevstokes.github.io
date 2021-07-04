---
title: "A Right Set Up"
date: 2020-07-04T11:24:38Z
summary: There's a popular IT anology of treating servers as cattle rather than pets. Logically, does it then follow that my laptop is a cow?
---
{{< quote text="Give me six hours to chop down a tree and I will spend the first four sharpening the axe." author="Abraham Lincoln"  >}}

I first became aware of the idea of provisioning a developer's own machine with GitHub's [Boxen](https://github.blog/2013-02-15-introducing-boxen/) project. This was a [Puppet](https://puppet.com)-based system that aimed to "automate the pain out of your development environment" and allow new starts to be contributing as soon as possible.

GitHub also host a guide on maintaining your [dotfiles](https://dotfiles.github.io/). Most developers are aware of the jarring experience of working on a strange machine without their custom command aliases and shortcuts available. Whether that is a brand new laptop or one that has had to be restored from a backup, removing the cognitive friction and working with the comfort of the familiar will always result in increased productivity.

Some would describe this kind of thing as being the very epitome of Parkinson's Law of Triviality -- or [bikeshedding](https://effectiviology.com/bikeshedding-law-of-triviality/) as it's sometimes known.

Over the years, I've spent a fair amount of accumulated time in getting my development environment to a place where I can work efficiently while being simultaneously aesthetically pleasing -- which, I understand, is all a subjective view. Others may have very well have different ideas and preferences. I've taken inspiration from elsewhere; hopefully this post will prove to be useful to someone else in return.

The most important thing that I've learnt is to _always_ make configuration updates or install a new utility via code and then to commit those changes to version control immediately rather than doing things manually and promising myself that I'll remember to bring the git repo into line at some point later on.

## Bootstrapping

To initially set up a machine, I use `curl` to download a `bash` script from an easy-to-remember URL. This performs a system update then installs [Ansible](https://www.ansible.com) and `git` via the package manager. I'm using Ubuntu so for me that is `apt` but that could equally be `yum`, `dnf`, [Homebrew](https://brew.sh) or [Chocolatey](https://chocolatey.org) depending on your OS.

Once those two dependencies are ready, the script uses them to clone my setup repository and then runs the playbook in it to install and configure everything. This isn't quite an idempotent process due to the update and upgrade step but Ansible is declarative insofar as I have a known desired state which means that this bootstrap script can safely be rerun as and when required.

## Shell

I use vanilla `zsh` without a framework such as [Oh My Zsh](https://ohmyz.sh/) or [Prezto](https://github.com/sorin-ionescu/prezto).

## Theme

My theme is a customised [Powerlevel 10k](https://github.com/romkatv/powerlevel10k) - it's one better.

To match the editor pane in my IDE, I use a Powerline-patched variant of Source Code Pro that has additional glyphs -- [Sauce Code Pro Nerd Font](https://www.nerdfonts.com/font-downloads).

My command line prompt includes the current AWS profile, VPN status, write permissions and directory path, `git` branch and status.

## Plugins

While I don't use a framework, I do use [Antibody](https://getantibody.github.io/) to manage shell plugins.

My current list of plugins is as follows:

- aperezdc/zsh-fzy
- romkatv/powerlevel10k
- supercrabtree/k
- zsh-users/zsh-autosuggestions
- zsh-users/zsh-completions
- zsh-users/zsh-history-substring-search
- zsh-users/zsh-syntax-highlighting

## Tab completion

I have tab completion enabled for `docker`, <nobr>`docker-compose`</nobr>, `git` and <nobr>`aws-cli`</nobr>. These let me automatically fill in subcommands, container and branch names without having to remember them or type them out in full.

Additionally, I've written some custom completions for switching AWS profiles and listing EC2 instance ids in order to open connections using the AWS [Session Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/session-manager.html).

## Aliases

To drastically reduce the amount of typing that we have to do, it's not uncommon for developers to have a collection of abbreviating aliases for their most frequently used commands.

I employ a simple initialism mnemonic to help me easily remember these shortcuts. For example:

- <code><nobr>docker-compose</nobr> exec</code> becomes `dce`
- `docker run --rm -it` is just `dr`
- and `git add --patch` simplifies to `gap`.

## Configuration dotfiles

My dotfiles are kept in a seperate repository as they're not dependent on a provisioning solution or a particular OS. Once cloned, I use [`stow`](https://www.gnu.org/software/stow/manual/stow.html) to create symbolic links for the actual files in my user home directory.

I keep copies of my API keys and tokens in a file in this repo as well, encrypted using [SSH Vault](https://ssh-vault.com/) and the keys that [GitHub exposes](https://changelog.com/posts/github-exposes-public-ssh-keys-for-its-users) for everyone. My `~/.profile` then includes the decrypted version to make them available as environment variables -- hence not being in `~/.zshrc` as they're not related to my choice of shell.

## Utilities

There's a few things that I remove and a good deal more that I add -- not least some of the [new shiny](/blog/2020-06-28-out-with-the-old/) that I've written about before. I'm increasingly using a containerised toolchain but I'll still need to install some packages locally, such as [`direnv`](https://direnv.net/), [`tlp`](https://linrunner.de/tlp/), [`tmux`](https://github.com/tmux/tmux/wiki) and container tools like [Skopeo](https://github.com/containers/skopeo).
