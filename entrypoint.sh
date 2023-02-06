#!/bin/bash

# Set up auth if required
if [[ $3 ]]; then
  location="--server=$3"
  if [[ $4 && $5 ]]; then
      location="$location --user=$4:$5"
  fi
else
  location="--local"
fi

/app/kestra "$2" validate "$1" $location