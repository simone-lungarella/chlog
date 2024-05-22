#!/bin/bash

# Default values
since="2005-01-01"

# Parse optional arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --since)
            if [[ -n $2 && $2 != -* ]]; then
                since=$2
                shift 2
            else
                echo "Option --since requires an argument."
                exit 1
            fi
            ;;
        -*)
            echo "Invalid option: $1"
            exit 1
            ;;
        *)
            echo "Invalid argument: $1"
            exit 1
            ;;
    esac
done

# Get basename
repository_name=$(basename `git rev-parse --show-toplevel`)
file_suffix="_changelog.md"
file_name="$repository_name$file_suffix"
repository_version=$(git describe --tags --abbrev=0)

# Setting up file title
echo "# $repository_name $repository_version

All notable changes to this project will be documented in this file.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and this project adheres to [Semantic Versioning](https://semver.org/).
" > "$file_name"

echo "## Change Log
Showing changes from $since
" >> "$file_name"

features=$(git --no-pager log --oneline --format='%s' --since="$since" | grep 'feat')

echo "### Features
$features" | sed -e 's/feat[ure]\?!\?\((.*)\)\? \?:/-/g' | uniq >> "$file_name"

bugfixes=$(git --no-pager log --oneline --format='%s' --since="$since" | grep 'fix')

echo "
### Bugfixes
$bugfixes" | sed -e 's/\(fix\|refactor\)!\?\((.*)\)\? \?:/-/g' | uniq >> "$file_name"
