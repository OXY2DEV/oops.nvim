local oops = {};

---@class oops.config
---
oops.config = {
	force = false,
	rules = {
		W_to_w = {
			condition = function (cmd)
				return string.match(cmd, "^W") ~= nil;
			end,

			fix = function ()
				return "w";
			end
		},
		Q_to_q = {
			condition = function (cmd)
				return string.match(cmd, "^Q") ~= nil;
			end,

			fix = function ()
				return "q";
			end
		},
	}
};

oops.__can_fix = function (cmd)
	for name, rule in pairs(oops.config.rules) do
		local _, condition = pcall(rule.condition, cmd);

		if condition == true then
			return name, rule;
		end
	end
end

oops.__run = function (mode, before, cmd)
	local prompt = "";

	if mode == "cmd" then
		prompt = ":";
	elseif mode == "search" then
		prompt = "/";
	elseif mode == "expr" then
		prompt = "=";
	end

	vim.ui.select({ "Y", "N" }, {
		prompt = "Run Fixup command?",
		default = "y",

		format_item = function (item)
			if item == "Y" then
				return string.format("Run fixup(%s%s -> %s%s)", prompt, before, prompt, cmd);
			else
				return "Do nothing."
			end
		end
	}, function (result)
		if result ~= "Y" then
			return;
		else
			vim.api.nvim_exec2(prompt .. cmd, {});
		end
	end)
end

oops.fix = function (mode)
	mode = mode or "cmd";
	local last_command = vim.fn.histget(mode, -1);

	if last_command == "" then
		--- No last command!
		return;
	end

	local name, rule = oops.__can_fix(last_command or "");

	if name == nil then
		return;
	end

	local can_fix, fixed = pcall(rule.fix, last_command);

	if can_fix == true and type(fixed) == "string" then
		oops.__run(mode, last_command, fixed);
	else
		vim.api.nvim_echo({
			{ "󰘳 Oops.nvim", "DiagosticVirtTextOk" },
			{ ": Failed to run rule " .. name, "Comment" }
		})
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
