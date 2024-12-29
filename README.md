# Advent of Code 2024 in Lua :santa: :christmas_tree:

This repository is incomplete, since I was trying to do 2024 in Janet. I'm only doing some days in Lua, either for fun or because I hit a roadblock in Janet.

## Quickstart

For Fish shell.

```shell
$ set -g day "d19"; fd -e lua -e txt --no-ignore | entr -c -s "lua $day/main.lua < $day/in.txt"
```

## Progress (1/25)

|     | Lua    | Time    |
| --- | ------ | ------- |
| 1   | :zzz:  |
| 2   | :bell: | 16m 25s |
| 3   | :zzz:  |
| 5   | :zzz:  |
| 6   | :zzz:  |
| 7   | :zzz:  |
| 8   | :zzz:  |
| 9   | :zzz:  |
| 10  | :zzz:  |
| 11  | :zzz:  |
| 12  | :zzz:  |
| 13  | :zzz:  |
| 14  | :zzz:  |
| 15  | :zzz:  |
| 16  | :zzz:  |
| 17  | :zzz:  |
| 18  | :zzz:  |
| 19  | :zzz:  |
| 20  | :zzz:  |
| 21  | :zzz:  |
| 22  | :zzz:  |
| 23  | :zzz:  |
| 24  | :zzz:  |
| 25  | :zzz:  |

## Make Reddit Code Snippet

For longer code snippets, use https://topaz.github.io/paste/. If it's short enough, do this:

```
$ cat code | sed 's/^/    /' | xsel -b
$ cat code | sed 's/^/    /' | pbcopy
```

## Reddit Comment Template

```text
[LANGUAGE: Lua]

60 lines of code according to `tokei` when formatted with `stylua`.

- [GitHub Repository](https://github.com/cideM/aoc2024-lua)
- [Topaz Paste]()
```

## Disable Copilot

Add `set exrc` to your Neovim configuration, then `echo 'let g:copilot_enabled=v:false' > .nvimrc`, open the file and `:trust` it.
