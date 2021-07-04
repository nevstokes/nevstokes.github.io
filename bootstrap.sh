#!/usr/bin/env bash

sudo apt update && sudo apt upgrade -y
sudo apt install software-properties-common

# Get up-to-date versions of ansible and git
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-add-repository -y ppa:git-core/ppa
sudo apt update

sudo apt install -y ansible git

# Pull down personal configuration
git clone git@github.com:nevstokes/ansible-setup.git

# Set up all the things
ansible-playbook ansible-setup/playbook.yml --ask-become-pass

# Remap caps lock to control, retaining caps lock functionality via both shift keys
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps','shift:both_capslock_cancel']"
