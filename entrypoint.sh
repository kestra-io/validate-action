#!/bin/bash

# Set up auth if required
if [[ $3 ]]; then
  location="--server=$3"
  if [[ $4 && $5 ]]; then
      server="$server --user=$5:$6"
  fi
else
  location="--local"
fi

/app/kestra "$2" validate "$1" $location