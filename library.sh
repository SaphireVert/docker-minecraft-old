#!/usr/bin/env bash

echo "Script started"
echo "$1"

if [[ "$1" == "script" ]]
then
  echo "Perfect !"
fi

if [[ "$1" == "yesNoPrompt" ]]
then
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
fi

  # echo "Sure ?"
  # read -p "Are you sure you want to delete world and all data from this server ? y / N" response
  # response=${response:-'n'}
  # echo $response
