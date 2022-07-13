#!/bin/bash

function run {

    if [ -n '$1' ]then;
    build
    fi
    echo 'running'
    cargo run
}

function build {
    echo 'building'
    cargo build --release
}

echo "currently in $pwd"
set -e

local_branch=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)
remote_branch=$(git rev-parse --abbrev-ref --symbolic-full-name @{u})
remote=$(git config branch.$local_branch.remote)

echo "Fetching from $remote..."
git fetch $remote

if git merge-base --is-ancestor $remote_branch HEAD; then
    echo 'Already up-to-date'
    run
    exit 0
fi

if git merge-base --is-ancestor HEAD $remote_branch; then
    echo 'Fast-forward possible. Merging...'
    git merge --ff-only --stat $remote_branch
else
    echo 'Fast-forward not possible. Rebasing...'
    git rebase --preserve-merges --stat $remote_branch
fi

tools/launcher.sh -b

exit 0