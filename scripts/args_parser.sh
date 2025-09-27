#!/bin/bash

if [[ $# -lt 2 ]]; then
    echo "Usage: $0 VERSION MODE [-s NEW_SUFFIX]"
    return 1
fi

export current_version="$1"
export increase_version_mode="$2"
shift
shift

new_suffix=""
remove_suffix=0
while [[ $# -gt 0 ]]; do
    case "$1" in
        -s)
            if [[ $remove_suffix -eq 1 ]]; then
                echo "Error: -s and -r cannot be used together"
                exit 1
            fi
            shift
            if [[ -z "$1" || "$1" == "-"* ]]; then
                echo "Error: -s requires a value"
                exit 1
            fi
            new_suffix="$1"
            ;;
        -r)
            if [[ -n "$new_suffix" ]]; then
                echo "Error: -s and -r cannot be used together"
                exit 1
            fi
            remove_suffix=1
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
    shift
done


export new_suffix
export remove_suffix

