local oops = {};

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

	rules = require("oops.rules")
};

--- Gets prompt character.
---@param kind oops_kind
---@return ":" | "?" | "/" | "="
oops.__get_prompt = function (kind)
	---|fS

	if kind == "cmd" then
		return ":";
	elseif kind == "search_down" then
		return "?";
	elseif kind == "search_up" then
		return "/";
	elseif kind == "expr" then
		return "=";
	else
		return ":";
	end

	---|fE
end

--- Can a command be fixed?
---@param kind oops_kind
---@param cmd string
---@return string | nil
---@return table | nil
oops.__can_fix = function (kind, cmd)
	---|fS

	local keys = vim.tbl_keys(oops.config.rules);
	table.sort(keys);

	for _, key in ipairs(keys) do
		local rule = oops.config.rules[key] or {};
		local _, condition = pcall(rule.condition, kind, cmd);

		if condition == true then
			return key, rule;
		end
	end

	---|fE
end

--- Runs given fix.
---@param old_prompt ":" | "?" | "/" | "="
---@param old_command string
---@param new_prompt ":" | "?" | "/" | "="
---@param new_command string
---@param force boolean
oops.__run = function (old_prompt, old_command, new_prompt, new_command, force)
	---|fS

	if force == true then
		vim.api.nvim_exec2(new_prompt .. new_command, {});
		return;
	end

	vim.ui.select({ "Y", "N" }, {
		prompt = "Run Fixup command?",
		default = "Y",

		format_item = function (item)
			if item == "Y" then
				return string.format("Run fixup(%s%s -> %s%s)", old_prompt, old_command, new_prompt, new_command);
			else
				return "Do nothing."
			end
		end
	}, function (result)
		if result ~= "Y" then
			return;
		else
			vim.api.nvim_exec2(new_prompt .. new_command, {});
		end
	end);

	---|fE
end

--- Gets the last **non-Oops** command.
---@param kind oops_kind
---@return string
oops.__last_command = function (kind)
	---|fS

	local last_command;
	local index = -1;

	while last_command == nil or string.match(last_command, "^Oops") do
		if kind == "search_down" or kind == "search_up" then
			last_command = vim.fn.histget("search", index);
		else
			last_command = vim.fn.histget(kind, index);
		end

		index = index - 1;
	end

	return last_command;

	---|fE
end

--- Fixes the last run command.
--- NOTE: Ignores `Oops z`.
---
---@param kind oops_kind
---@param force boolean
oops.fix = function (kind, force)
	---|fS

	kind = kind or vim.g.__last_cmdtype or "cmd";
	force = force or oops.config.force or false;

	if oops.config.ignore_kinds and vim.list_contains(oops.config.ignore_kinds, kind) then
		return;
	end

	local last_command = oops.__last_command(kind);

	if last_command == "" then
		return;
	else
		local name, rule = oops.__can_fix(kind, last_command);

		if name == nil then
			return;
		end

		local can_fix, new_prompt, new_command = pcall(
			rule.fix,

			oops.__get_prompt(kind),
			last_command
		);

		if can_fix == true then
			oops.__run(
				oops.__get_prompt(kind),
				last_command,

				new_prompt,
				new_command,

				force
			);
		else
			vim.api.nvim_echo({
				{ "󰘳 Oops.nvim", "DiagosticVirtTextOk" },
				{ ": Failed to run rule " .. name, "Comment" }
			});
		end
	end

	---|fE
end

--- Setup function for `oops`.
---@param user_config oops.config
oops.setup = function (user_config)
	if type(user_config) == "table" then
		oops.config = vim.tbl_deep_extend("force", oops.config, user_config);
	end
end

return oops;
