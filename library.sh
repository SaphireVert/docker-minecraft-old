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
    return 1
  else
    # No
    echo "No"
    return 0
  fi
}

function yesNoReset {
  value=$(yesNoPrompt)
  echo "jsfih"
  echo "$value"
  if [[ $value == 1 ]]
  then
    make clean
    make build
    make up
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
