#!/usr/bin/env bash

set -e

echo "Script started"


function yesNoPrompt {
  read -p "$2" -n 1 -r
  echo    # (optional) move to a new line
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
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    # Yes
    echo "Yes"
    make clean
    make build
    make up
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
  echo "$2"
  yesNoReset
fi



  # echo "Sure ?"
  # read -p "Are you sure you want to delete world and all data from this server ? y / N" response
  # response=${response:-'n'}
  # echo $response
