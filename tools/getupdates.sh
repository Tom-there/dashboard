#!/bin/bash
pwd
if [[ 'git status --procelain --untracked-files=no' ]]
then
  echo changes upstream
else	
  echo no changes upstream
fi
