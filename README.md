# 😅 oops.nvim

<div align="center">
    <img alt="Neovim" src="https://img.shields.io/badge/Neovim-000?style=for-the-badge&logo=neovim&logoColor=A6E3A1&color=1E1E2E">
    <img alt="Repo size" src="https://img.shields.io/github/languages/code-size/OXY2DEV/oops.nvim?style=for-the-badge&logo=data%3Aimage%2Fsvg%2Bxml%3Bbase64%2CPHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCA0NDggNTEyIj48IS0tIUZvbnQgQXdlc29tZSBGcmVlIDYuNy4yIGJ5IEBmb250YXdlc29tZSAtIGh0dHBzOi8vZm9udGF3ZXNvbWUuY29tIExpY2Vuc2UgLSBodHRwczovL2ZvbnRhd2Vzb21lLmNvbS9saWNlbnNlL2ZyZWUgQ29weXJpZ2h0IDIwMjUgRm9udGljb25zLCBJbmMuLS0%2BPHBhdGggc3Ryb2tlPSIjQ0JBNkY3IiBmaWxsPSIjQ0JBNkY3IiBkPSJNOTYgMEM0MyAwIDAgNDMgMCA5NkwwIDQxNmMwIDUzIDQzIDk2IDk2IDk2bDI4OCAwIDMyIDBjMTcuNyAwIDMyLTE0LjMgMzItMzJzLTE0LjMtMzItMzItMzJsMC02NGMxNy43IDAgMzItMTQuMyAzMi0zMmwwLTMyMGMwLTE3LjctMTQuMy0zMi0zMi0zMkwzODQgMCA5NiAwem0wIDM4NGwyNTYgMCAwIDY0TDk2IDQ0OGMtMTcuNyAwLTMyLTE0LjMtMzItMzJzMTQuMy0zMiAzMi0zMnptMzItMjQwYzAtOC44IDcuMi0xNiAxNi0xNmwxOTIgMGM4LjggMCAxNiA3LjIgMTYgMTZzLTcuMiAxNi0xNiAxNmwtMTkyIDBjLTguOCAwLTE2LTcuMi0xNi0xNnptMTYgNDhsMTkyIDBjOC44IDAgMTYgNy4yIDE2IDE2cy03LjIgMTYtMTYgMTZsLTE5MiAwYy04LjggMC0xNi03LjItMTYtMTZzNy4yLTE2IDE2LTE2eiIvPjwvc3ZnPg%3D%3D&logoColor=CBA6F7&labelColor=1e1e2e&color=B4BEFE">
    <img alt="GitHub Release" src="https://img.shields.io/github/v/release/OXY2DEV/oops.nvim?include_prereleases&sort=semver&display_name=release&style=for-the-badge&logo=data%3Aimage%2Fsvg%2Bxml%3Bbase64%2CPHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCA1MTIgNTEyIj48IS0tIUZvbnQgQXdlc29tZSBGcmVlIDYuNy4yIGJ5IEBmb250YXdlc29tZSAtIGh0dHBzOi8vZm9udGF3ZXNvbWUuY29tIExpY2Vuc2UgLSBodHRwczovL2ZvbnRhd2Vzb21lLmNvbS9saWNlbnNlL2ZyZWUgQ29weXJpZ2h0IDIwMjUgRm9udGljb25zLCBJbmMuLS0%2BPHBhdGggZmlsbD0iI0Y1RTBEQyIgc3Ryb2tlPSIjRjVFMERDIiBkPSJNMzQ1IDM5LjFMNDcyLjggMTY4LjRjNTIuNCA1MyA1Mi40IDEzOC4yIDAgMTkxLjJMMzYwLjggNDcyLjljLTkuMyA5LjQtMjQuNSA5LjUtMzMuOSAuMnMtOS41LTI0LjUtLjItMzMuOUw0MzguNiAzMjUuOWMzMy45LTM0LjMgMzMuOS04OS40IDAtMTIzLjdMMzEwLjkgNzIuOWMtOS4zLTkuNC05LjItMjQuNiAuMi0zMy45czI0LjYtOS4yIDMzLjkgLjJ6TTAgMjI5LjVMMCA4MEMwIDUzLjUgMjEuNSAzMiA0OCAzMmwxNDkuNSAwYzE3IDAgMzMuMyA2LjcgNDUuMyAxOC43bDE2OCAxNjhjMjUgMjUgMjUgNjUuNSAwIDkwLjVMMjc3LjMgNDQyLjdjLTI1IDI1LTY1LjUgMjUtOTAuNSAwbC0xNjgtMTY4QzYuNyAyNjIuNyAwIDI0Ni41IDAgMjI5LjV6TTE0NCAxNDRhMzIgMzIgMCAxIDAgLTY0IDAgMzIgMzIgMCAxIDAgNjQgMHoiLz48L3N2Zz4%3D&labelColor=1E1E2E&color=45475A">
</div>



https://github.com/user-attachments/assets/d6b00d77-7442-4ab3-a77e-235234610a01




Attempts to fix typos in the last run command.

## 📖 Table of contents

- [✨ Features](#-features)
- [📚 Requirements](#-requirements)
- [📐 Installation](#-installation)
- [🧭 Configuration](#-configuration)

- [🎇 Commands](#-commands)
- [💡 Rules](#-rules)

## ✨ Features

+ Tiny. ~ 100 lines of code.
+ Fully customisable, allows customizing every rule.
+ Out-of-box support for common typos.

## 📚 Requirement

- `histget()` function.

## 📐 Installation

### 🧩 Vim-plug

Add this to your plugin list.

```vim
Plug "OXY2DEV/oops.nvim"
```

### 💤 Lazy.nvim

```lua
-- For `plugins/oops.lua` users.
return {
    "OXY2DEV/oops.nvim",
    lazy = false
};
```

```lua
-- For `plugins.lua` users.
{
    "OXY2DEV/oops.nvim",
    lazy = false
},
```

### 🦠 Mini.deps

```lua
local MiniDeps = require("mini.deps");

MiniDeps.add({
    source = "OXY2DEV/oops.nvim"
});
```

### 🌒 Rocks.nvim

>[!WARNING]
> `luarocks package` may sometimes be a bit behind `main`.

```vim
:Rocks install oops.nvim
```

### 📥 GitHub release

Tagged releases can be found in the [release page](https://github.com/OXY2DEV/oops.nvim/releases).

>[!NOTE]
> `Github releases` may sometimes be slightly behind `main`.

## 🧭 Configuration

Configuration table structure is given below,

```lua
--- Command types.
---@alias oops_kind
---| "cmd"
---| "search_up"
---| "search_down"
---| "expr"
---| "input"

--- Oops rule.
---@class oops_rule
---
--- Condition to trigger this rule.
---@field condition fun(kind: oops_kind, command: string): boolean
---
--- Resulting fixed command.
---@field fix fun(kind: oops_kind, command: string): (oops_kind, string)

----------------------------------------------------------------------

--- Configuration table for `oops.nvim`
---@class oops.config
---
--- Apply fix without confirmation?
---@field force? boolean
---
--- Command kinds to ignore.
---@field ignore_kinds? oops_kind[]
---
--- Rules.
---@field rules table<string, oops_rule>
oops.config = {
    force = false,
    ignore_kinds = { "input", "expr" },

    rules = {
        q_quote = {
            condition = function (prompt, command)
                if prompt ~= "cmd" then return; end

                return string.match(command, "^q[`'\"]") ~= nil;
            end,

            fix = function (prompt, command)
                return prompt, string.gsub(command, "^q[`'\"]", "q")
            end
        },

        -- ... Other rules
    }
};
```

## 🎇 Commands

Oops comes with the `:Oops` command. It will try to fix whatever cmd was run last that isn't `:Oops`.

```txt
USAGE,
    :Oops

    :Oops [Kind]

    :Oops [Kind] [force]

EXAMPLE,
    :Oops cmd true
```

Different command kinds are given below,


| Kind        | Description  |
|-------------|--------------|
| cmd         | Command(`:`) |
| search_up   | Search(`/`)  |
| search_down | Search(`?`)  |
| expr        | Search(`=`)  |


## 💡 Rules

Out of the box, oops comes with the following rules,

- `caps_locked`
  Fixes typos like `:W`, `:Q`, `:Wq` and other variations.

- `q_quote`
  Fixes `:q'`, `:q"`.

- `reverses_wq`
  Fixes `:qw`.

- `accidental_bash`
  Fixes `:!w`, `:!q`, `:!e` etc.

- `set_with_S`
  Fixes `:Set`.

- `lua_with_b`
  Fixes `:luabcommand`(becomes `:lua commands`).

- `moh`
  Fixes `:moh`(becomes `:noh`).

- `sub_wo_slash`
  Fixes `:sfoo/bar`(becomes `:s/foo/bar`).

- `vsub_wo_slash`
  Fixes `:'<,'>sfoo/bar`(becomes `:'<,'>s/foo/bar`).

