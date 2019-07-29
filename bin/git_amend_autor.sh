#!/bin/bash
# Amend last git commit with current git autor

git commit --amend --author "`git config user.name` <`git config user.email`>"

