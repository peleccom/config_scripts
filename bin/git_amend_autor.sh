#!/bin/bash

# Amend author of the last commit
git commit --amend --author="$(git config user.name) <$(git config user.email)>" --no-edit