# Get basename
repository_name=$(basename `git rev-parse --show-toplevel`)
file_suffix="_changelog.md"
file_name="$repository_name$file_suffix"

# Setting up file title
echo "# $repository_name
" > "$file_name"

# features=$(git --no-pager log --oneline --format='%s' --since='2024-01-01' | grep 'feat')
features=$(git --no-pager log --oneline --format='%s' | grep 'feat')

# Writing up the changelog file
echo "## Features
$features" | sed -e 's/feat[ure]\?!\?\((.*)\)\? \?:/-/g' | uniq >> "$file_name"

bugfixes=$(git --no-pager log --oneline --format='%s' --since='2024-01-01' | grep 'fix')

# Writing up the changelog file
echo "
## Bugfixes
$bugfixes" | sed -e 's/\(fix\|refactor\)!\?\((.*)\)\? \?:/-/g' | uniq >> "$file_name"
