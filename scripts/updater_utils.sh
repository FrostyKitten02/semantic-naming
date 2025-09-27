#!/bin/bash

version_regex='^([1-9][0-9]*)\.([0-9]+)\.([0-9]+)(-([^ ]+))?$'

#Modes
mode_increase_major="MAJOR"
mode_increase_minor="MINOR"
mode_increase_patch="PATCH"
mode_suffix_change="SUFFIX"

check_version_mode() {
  local mode="$1"
  if [[ $mode != "$mode_increase_major" && $mode != "$mode_increase_minor" && $mode != "$mode_increase_patch" && $mode != "$mode_suffix_change" ]]; then
      echo "Error: wrong mode $mode passed valid modes: $mode_increase_major, $mode_increase_minor, $mode_increase_patch, $mode_suffix_change"
      return 1
  fi
  return 0
}

increase_version() {
   local current_version="$1"
   local mode="$2"
   local remove_suffix="$3"
   local new_suffix="$4"
   local MAJOR MINOR PATCH SUFFIX
   read -r MAJOR MINOR PATCH SUFFIX <<< "$(parse_version "$current_version")"

   if [[ $mode == "$mode_increase_major" ]]; then
       ((MAJOR++))
       MINOR=0
       PATCH=0
   elif [[ $mode == "$mode_increase_minor" ]]; then
       ((MINOR++))
       PATCH=0
   elif [[ $mode == "$mode_increase_patch" ]]; then
       ((PATCH++))
   fi

   if [[ -n $new_suffix ]]; then
      SUFFIX=$new_suffix
   elif [[ $remove_suffix -eq 1 ]]; then
      SUFFIX=""
   fi


   local new_version
   new_version=$(build_version "$MAJOR" "$MINOR" "$PATCH" "$SUFFIX")
   printf "%s" "$new_version"
}


parse_version() {
    local version="$1"
    if [[ $version =~ $version_regex ]]; then
        # Echo groups separated by space
        echo "${BASH_REMATCH[1]} ${BASH_REMATCH[2]} ${BASH_REMATCH[3]} ${BASH_REMATCH[5]}"
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

    if [[ -n $SUFFIX ]]; then
      SUFFIX="-$SUFFIX"
    fi
    echo "$MAJOR.$MINOR.$PATCH$SUFFIX"
}
