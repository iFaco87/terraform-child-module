#!/bin/bash
set -x

for DIR in $(find ./* -maxdepth 1 -type d | egrep -v "^(./tools|./templates|./.git)" | egrep -v "examples$"); do
  terraform-docs -c .terraform-docs.yml $DIR
done
