#!/bin/sh
printf '\033c\033]0;%s\a' Spirémon
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Spiremon.exe.x86_64" "$@"
