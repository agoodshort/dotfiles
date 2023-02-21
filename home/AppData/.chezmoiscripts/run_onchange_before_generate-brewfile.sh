#!/bin/bash

[[ -z $HOMEBREW_BUNDLE_FILE ]] && brew bundle dump --force --describe
