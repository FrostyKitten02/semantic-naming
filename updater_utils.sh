#!/bin/bash

version_regex='^([1-9][0-9]*)\.([0-9]+)\.([0-9]+)(-[^ ]+)?$'

increase_version() {
   local current_version="$1"
   local mode="$2"
   local MAJOR MINOR PATCH SUFFIX
   read MAJOR MINOR PATCH SUFFIX <<< "$(parse_version "$current_version")"
   local new_version=""
   case "$mode" in
        "MAJOR")
        echo "Increasing MAJOR version"
	((MAJOR++))
        ;;
        "MINOR")
        echo "Increasing MINOR version"
	((MINOR++))
	;;
        "PATCH")
        echo "Increasing PATCH version"
	((PATCH++))
	;;
    esac

    local new_version=$(build_version "$MAJOR" "$MINOR" "$PATCH" "$SUFFIX")
    echo "$new_version"
}


parse_version() {
    local version="$1"
    if [[ $version =~ $version_regex ]]; then
        # Echo groups separated by space
        echo "${BASH_REMATCH[1]} ${BASH_REMATCH[2]} ${BASH_REMATCH[3]} ${BASH_REMATCH[4]}"
        return 0
    else
        return 1
    fi
}

build_version() {
    local MAJOR="$1"
    local MINOR="$2"
    local PATCH="$3"
    local SUFFIX="$4"

    echo "$MAJOR.$MINOR.$PATCH$SUFFIX"
}
