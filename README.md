# Log Parser

- [Log Parser](#log-parser)
  - [Description](#description)
    - [Usage](#usage)
    - [Missing](#missing)
    - [What the result looks like](#what-the-result-looks-like)

## Description
This bash script parses git logs in order to create a _changelog.md_ file. Each commit message that contains the keyword _fix_ will be considered a fix, each message that contains the keyword _feat_ will be considered a feature.

### Usage
Usage: ./log-parser.sh [--since <date> | --latest] [--help]

- `--since`: optional argument, supports a date as value in format `yyyy-MM-dd`, sets the starting point of logs to be parsed. When not set, `2005-01-01` is considered the starting point.
- `--latest`: Generate changelog for commits executed in the latest software version. When used, `--since` is ignored.
- `--help`: Show a simple manual that describe the usage.

### Missing
- [X] Requires `git remote update` to be executed before changelog generated, could be executed at start
- [ ] Make it executable from everywhere, and downlodable
- [X] Add argument to handle versions
- [ ] Handle long commit messages
- [X] Add --help
- [ ] Add --rich to handle long commits messages as summary of a specific feature/bug
- [ ] Organize code in multiple files

### What the result looks like
This project respects the [conventional commit](https://www.conventionalcommits.org/en/v1.0.0/) and the git history is mantained as much clean is possible. You can check the generated changelog [here](changelogger_changelog.md).
