# Log Parser

- [Log Parser](#log-parser)
  - [Description](#description)
    - [How it works](#how-it-works)
    - [What the result looks like](#what-the-result-looks-like)

## Description
This bash script parse git logs in order to create a _changelog.md_ file. Each commit message that contains the keyword _fix_ will be considered a fix, each message that contains the keyword _feat_ will be considered a feature.

### How it works
The first step retrieves information about the repository using the command: 

`basename git rev-parse --show-toplevel`

With this information a _changelog_repo-name.md_ file will be created.

The following step will retrieve each _feature_ commit to create the feature section of the changelog

`git --no-pager log --oneline --format='%s' --since='2024-01-01' | grep 'feat'`

The following step will retrieve each _fix_ commit to create the bugfix section of the changelog

`git --no-pager log --oneline --format='%s' --since='2024-01-01' | grep 'fix'`

### What the result looks like

```md
# changelogger

## Features
- Added bash script to generate changelog
- Added readme.md

## Bugfixes
- Improved readme content
```