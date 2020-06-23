#!/usr/bin/env bash

echo "Script started"
echo "$1"


function yesNoPrompt {
  read -p "$3" -n 1 -r
  echo    # (optional) move to a new line
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    # Yes
    echo "Yes"
    $("$2")
  else
    # No
    echo "No"
  fi
}

function makeReset {
  echo "reset en cours"
  # make clean
  # make build
  # make up
}

$("$2")

if [[ "$1" == "script" ]]
then
  echo "Perfect !"
fi

if [[ "$1" == "yesNoPrompt" ]]
then
  yesNoPrompt $2
fi



  # echo "Sure ?"
  # read -p "Are you sure you want to delete world and all data from this server ? y / N" response
  # response=${response:-'n'}
  # echo $response
