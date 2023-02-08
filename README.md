# openrndr-vscode

vscode tasks.json, shell-script for [OPERNDR](https://openrndr.org/)<br/>

## how to use

- update `build.gradle.kts` file in `openrndr-template`location as described [here](https://github.com/openrndr/openrndr-template/pull/34/commits/8eee8a13f10dc2ae38f9d2ce6853a175b9636340)
- put shell script into cloned [openrndr-template](https://github.com/openrndr/openrndr-template) location
- open with vscode
- open command palette and type `task: Run Task` -> `OPENRNDR RUN`

## note

- shell script will update sourcecode if it's location is not `/src/main/kotlin/` under template-repository. so if you move file location, remove first line 'package \*'

## recommentation extension

- [Kotlin](https://marketplace.visualstudio.com/items?itemName=fwcd.kotlin) - support kotlin lanuage server

## tested

- linux, mac tested
