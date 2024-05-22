# Log Parser

- [Log Parser](#log-parser)
  - [Description](#description)
    - [How to use](#how-to-use)
      - [Arguments](#arguments)
    - [To be fixed](#to-be-fixed)
    - [What the result looks like](#what-the-result-looks-like)

## Description
This bash script parses git logs in order to create a _changelog.md_ file. Each commit message that contains the keyword _fix_ will be considered a fix, each message that contains the keyword _feat_ will be considered a feature.

### How to use
Currently, to execute the script, you need to move it on the root of your project and execute `./log-parser.sh` script. In future will be possible to execute it as a cli tool without the necessity to move the script itself.

#### Arguments
- `--since`: optional argument, supports a date as value in format `yyyy-MM-dd`, sets the starting point of logs to be parsed. When not set, `2005-01-01` is considered the starting point.

### To be fixed
- [X] Requires `git remote update` to be executed before changelog generated, could be executed at start
- [ ] Make it executable from everywhere, and downlodable

### What the result looks like
This project respects the [conventional commit](https://www.conventionalcommits.org/en/v1.0.0/) and the git history is mantained as much clean is possible. You can check the generated changelog [here](changelogger_changelog.md).
