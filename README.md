# 😅 oops.nvim

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

