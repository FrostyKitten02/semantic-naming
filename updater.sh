#!/bin/bash
utils_file=./updater_utils.sh
source "$utils_file"

version_file=./version
current_version=$(cat "$version_file")

echo "Current version: $current_version"

read MAJOR MINOR PATCH SUFFIX <<< "$(parse_version "$current_version")"
echo "MAJOR: $MAJOR, MINOR: $MINOR, PATCH: $PATCH, SUFFIX: $SUFFIX"

increase_version_mode="$1"
if [[ $increase_version_mode != "MAJOR" && $increase_version_mode != "MINOR" && $increase_version_mode != "PATCH" ]]; then
    echo "Error: wrong mode $increase_version_mode passed valid modes: MAJOR, MINOR, PATCH"
    exit 1
fi

increase_version $current_version $increase_version_mode
