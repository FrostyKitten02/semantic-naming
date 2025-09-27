#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
utils_file="$SCRIPT_DIR/updater_utils.sh"

# shellcheck source=./updater_utils.sh
source "$utils_file"

# shellcheck source=./args_parser.sh
source "$SCRIPT_DIR/args_parser.sh" "$@" || exit 1

check_version_mode "$increase_version_mode" || exit 1
increase_version "$current_version" "$increase_version_mode" "$remove_suffix" "$new_suffix" || exit 1
