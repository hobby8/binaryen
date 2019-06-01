#!/bin/bash
set -o errexit
CLANG_DIR=$(dirname $(dirname $(which clang-tidy)))
CLANG_TIDY_DIFF=$CLANG_DIR/share/clang/clang-tidy-diff.py
TIDY_MSG=$(git diff -U0 master/... | $CLANG_TIDY_DIFF -quiet -p1 2> /dev/null)
if [ -n "$TIDY_MSG" -a "$TIDY_MSG" != "No relevant changes found." ]
then
  echo "Fix clang-tidy errors before committing!"
  echo
  # Run clang-tidy once again to show the error
  git diff -U0 master/... | $CLANG_TIDY_DIFF -quiet -p1 2> /dev/null
  exit 1
fi
