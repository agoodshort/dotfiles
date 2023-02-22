#!/bin/bash

output=""
status=$(chezmoi status)
sourceStatus=$(echo "$status" | cut -c 2)
destinationStatus=$(echo "$status" | cut -c 1)

# [[ $status == *'M'* ]] && output="${output}M"
# [[ $status == *'A'* ]] && output="${output}A"
# [[ $status == *'D'* ]] && output="${output}D"

# source
[[ $(echo $sourceStatus | wc -l) > 0 ]] && output="${output}⇣"

# modified
[[ ($sourceStatus == *'M'*) || ($destinationStatus == *'M'*) ]] && output="${output}!"

# deleted
[[ ($sourceStatus == *'D'*) || ($destinationStatus == *'D'*) ]] && output="${output}✘"

# review scenarios based on https://starship.rs/config/#git-status

echo $output
