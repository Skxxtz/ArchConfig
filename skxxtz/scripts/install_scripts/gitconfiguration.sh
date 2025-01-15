#!/bin/bash
git config --global user.name "Sebastian Kootz"
git config --global user.email "skxxtz@gmail.com"

git config --global credential.helper store

git config --global init.defaultBranch main

git config --global push.default simple

git config --global core.editor "nvim"
git config --global color.ui auto

# Alias configurations
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch

git config --global --list

