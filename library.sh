#!/usr/bin/env bash

set -e

# echo $2

function yesNoPrompt {
  read -p "$2" -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    # Yes
    echo "Yes"
  else
    # No
    echo "No"
  fi
}

function yesNoReset {
  read -p "$2" -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    # Yes
    echo "Yes"
    sudo rm -rf data/* # make clean
    make build
    make up
  else
    # No
    echo "No"
  fi
}

function yesNoClear {
  read -p "$2" -n 1 -r
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    # Yes
    echo "Yes"
    sudo rm -rf data/* # make clean
  else
    # No
    echo "No"
  fi
}

if [[ "$1" == "script" ]]
then
  echo "Perfect !"
fi

if [[ "$1" == "yesNoReset" ]]
then
  yesNoReset $1 "$2"
fi

if [[ "$1" == "yesNoClear" ]]
then
  yesNoClear $1 "$2"
fi
