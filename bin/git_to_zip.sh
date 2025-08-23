#!/bin/bash

# Get current branch name and sanitize it
branch=$(git rev-parse --abbrev-ref HEAD)
(
    cd "$(git rev-parse --show-toplevel)" || exit 1
    zip -r "${branch}.zip" . -x "*.git*"
)