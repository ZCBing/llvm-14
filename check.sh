#!/bin/bash

RESULT=`git diff -U0 --no-color --relative HEAD^ | clang/tools/clang-format/clang-format-diff.py -p1`
if [ -z "$RESULT" ]; then
  echo "check clang format successful!"
else
  echo "$RESULT"
  echo "check clang format fail! You can run the following command to fix it"
  echo "git diff -U0 --no-color --relative HEAD^ | clang/tools/clang-format/clang-format-diff.py -p1 -i"
  exit 1
fi
