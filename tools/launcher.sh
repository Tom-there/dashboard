#!/bin/bash

var = 0

function run {
     if $var > 0; then
        echo now building
         cargo build --release
     fi
     echo 'running'
     target/release/dashboard

    cargo build --release

    
}

function fetchGit {
    local_branch=$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)
    remote_branch=$(git rev-parse --abbrev-ref --symbolic-full-name @{u})
    remote=$(git config branch.$local_branch.remote)

    echo "Fetching from $remote..."
    git fetch $remote > /dev/null

    if git merge-base --is-ancestor $remote_branch HEAD; then
        echo 'Already up-to-date'
        run
        exit 0
    fi

    if git merge-base --is-ancestor HEAD $remote_branch; then
        echo 'Fast-forward possible. Merging...'
        git merge --ff-only --stat $remote_branch  > /dev/null
    else
        echo 'Fast-forward not possible. Rebasing...'
        git rebase --preserve-merges --stat $remote_branch > /dev/null
    fi
    $var = 1
}

echo "currently in $(pwd)"
set -e

fetchGit

exit 0