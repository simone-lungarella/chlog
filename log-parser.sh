#!/bin/bash

usage() {
    echo "Usage: $0 [--since <date> | --latest] [--help]"
    echo
    echo "Options:"
    echo "  --since <date>   Specify the start date for the changelog (default: 2005-01-01)."
    echo "  --latest         Generate changelog for commits executed in the latest software version. When used, --since is ignored."
    echo "  --help           Show this help message and exit."
    exit 0
}

# Default values
SINCE="2005-01-01"
LATEST=false

# Parse optional arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        --since)
            if [[ -n $2 && $2 != -* ]]; then
                SINCE=$2
                shift 2
            else
                echo "Option --since requires an argument."
                exit 1
            fi
            ;;
        --latest)
            LATEST=true
            shift
            ;;
        --help)
            usage
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

# Updating project
git remote update

# Get basename
repository_name=$(basename `git rev-parse --show-toplevel`)
file_suffix="_changelog.md"
file_name="$repository_name$file_suffix"
repository_version=$(git describe --tags --abbrev=0)
latest_version_creation=$(git for-each-ref --sort=-creatordate --format '%(creatordate)' refs/tags | head -n 1)

# Setting up file title
echo "# $repository_name $repository_version
All notable changes to this project will be documented in this file. The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and this project adheres to [Semantic Versioning](https://semver.org/).
" > "$file_name"

if [[ "$LATEST" == true ]]; then
    SINCE=$latest_version_creation
fi

if [ "$LATEST" = true ]; then
echo "## Change Log
Showing changes made in $repository_version
" >> "$file_name"
else
echo "## Change Log
Showing changes from $SINCE
" >> "$file_name"
fi

all_messages=$(git --no-pager log --oneline --format='%B' --since="$SINCE")
features=$(echo "$all_messages" | grep 'feat')

echo "### Features
$features" | sed -e 's/feat[ure]\?!\?\((.*)\)\? \?:/-/g' | uniq >> "$file_name"

bugfixes=$(echo "$all_messages" | grep 'fix')

echo "
### Bugfixes
$bugfixes" | sed -e 's/\(fix\|refactor\)!\?\((.*)\)\? \?:/-/g' | uniq >> "$file_name"