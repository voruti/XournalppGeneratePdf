#!/bin/bash

DARK_GRAY='\033[1;30m'
LIGHT_BLUE='\033[1;34m'
ORANGE='\033[0;33m'
RESET='\033[0m'

if [ $# -ne 1 ]; then
  echo "Error: Exactly one parameter is required."
  exit 1
fi
if ! [[ -d "$1" || (-f "$1" && "$1" == *.xopp) ]]; then
  echo "Error: Parameter must be a directory or a Xournalpp file."
  exit 1
fi

if [ -d "$1" ]; then
  # echo "$1 is directory"

  # for file in "$1"/.* "$1"/*; do # include dot files
  for file in "$1"/*; do
    if [[ -d "$file" || (-f "$file" && "$file" == *.xopp) ]]; then
      "$(realpath "$0")" "$file"
    fi
  done
else
  # echo "$1 is Xournalpp file"
  generatedPath="${1%.*}.generated.pdf"

  if [ -f "$generatedPath" ]; then
    # echo "removing generated PDF file $generatedPath"
    # read -p "execute?"
    rm -v "$generatedPath" || exit 1
  else
    echo -e "${DARK_GRAY}[DEBUG] generated PDF file $generatedPath does not exist${RESET}"
  fi

  # echo "generating PDF export for $1"
  # read -p "execute?"
  xournalpp -p "$generatedPath" "$1" &
  wait $!

  if [[ $? -eq 0 && -f "$generatedPath" ]]; then
    echo -e "${LIGHT_BLUE}[INFO] successfully generated PDF export as $generatedPath${RESET}"
  else
    echo -e "${ORANGE}[WARN] failed to generate PDF export for $1${RESET}"
    exit 1
  fi
fi
