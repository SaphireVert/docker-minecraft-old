#!/usr/bin/env bash

set -e

# echo $2

function yesNoPrompt {
  read -p "$2" -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    # Yes
    tmpVar="Yes"
  else
    # No
    tmpVar="No"
  fi
}

function yesNoReset {
  yesNoPrompt $1 "$2"
  echo $tmpVar
  if [[ "$tmpVar" == "Yes" ]]
    then
      echo "Reseting servers..."
      sudo rm -rf data/*
      make build
      make up
    else
      echo "Aborted"
  fi
}

function yesNoClear {
  yesNoPrompt $1 "$2"
  if [[ "$tmpVar" == "Yes" ]]
    then
      echo "Clearing data..."
      sudo rm -rf data/*
    else
      echo "Aborted"
  fi
}



if [[ "$1" == "yesNoReset" ]]
  then
    yesNoReset $1 "$2"
fi

if [[ "$1" == "yesNoClear" ]]
  then
    yesNoClear $1 "$2"
fi
