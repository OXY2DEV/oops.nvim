local oops = {};

---@class oops.config
---
oops.config = {
	force = false,
	ignore_types = { "input", "expr" },

	rules = require("oops.rules")
};

oops.__get_prompt = function (kind)
	if kind == "cmd" then
		return ":";
	elseif kind == "search_down" then
		return "?";
	elseif kind == "search_up" then
		return "?";
	elseif kind == "expr" then
		return "=";
	elseif kind == "input" then
		return "@";
	end
end

oops.__can_fix = function (kind, cmd)
	local keys = vim.tbl_keys(oops.config.rules);
	table.sort(keys);

	for _, key in ipairs(keys) do
		local rule = oops.config.rules[key] or {};
		local _, condition = pcall(rule.condition, kind, cmd);

		if condition == true then
			return key, rule;
		end
	end
end

oops.__run = function (old_prompt, old_command, new_prompt, new_command, force)
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
	end)
end

oops.fix = function (kind, force)
	kind = kind or vim.g.__last_cmdtype or "cmd";
	force = force or oops.config.force or false;

	if oops.config.ignore_types and vim.list_contains(oops.config.ignore_types, kind) then
		return;
	end

	local last_command;

	if kind == "search_down" or kind == "search_up" then
		last_command = vim.fn.histget("search", -1);
	else
		last_command = vim.fn.histget(kind, -1);
	end

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
			})
		end
	end
end

--- Setup function for `oops`.
---@param user_config oops.config
oops.setup = function (user_config)
	if type(user_config) == "table" then
		oops.config = vim.tbl_deep_extend("force", oops.config, user_config);
	end
end

return oops;
