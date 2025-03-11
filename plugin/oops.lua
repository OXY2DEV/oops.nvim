vim.g.__last_cmdtype = "cmd";

vim.api.nvim_create_user_command("Oops", function (data)
	---@type string
	local args = data.fargs;
	local force = false;

	if args[2] == "true" then
		force = true;
	end

	require("oops").fix(
		args[1] or vim.g.__last_cmdtype,
		force
	);
end, {
	nargs = "*",
	complete = function (arg_lead, cmdline, cursor_pos)
		local before = string.sub(cmdline, 0, cursor_pos);
		local tokens = vim.split(
			before,
			" ",
			{ trimempty = true }
		);

		if #tokens == 1 then
			return { "cmd", "search_up", "search_down", "expr" };
		elseif #tokens == 2 and string.match(before, "%S$") then
			local _c = {};

			for _, key in ipairs({ "cmd", "search_up", "search_down", "expr" }) do
				if string.match(key, arg_lead) then
					table.insert(_c, key);
				end
			end

			table.sort(_c);
			return _c;
		elseif #tokens == 2 and string.match(before, "%s$") then
			return { "true", "false" };
		elseif #tokens == 3 and string.match(before, "%S$") then
			local _c = {};

			for _, key in ipairs({ "true", "false" }) do
				if string.match(key, arg_lead) then
					table.insert(_c, key);
				end
			end

			table.sort(_c);
			return _c;
		end
	end
})

vim.api.nvim_create_autocmd("CmdlineEnter", {
	callback = function (event)
		local cmd = event.match;

		if cmd == ":" then
			vim.g.__last_cmdtype = "cmd";
		elseif cmd == "?" then
			vim.g.__last_cmdtype = "search_down";
		elseif cmd == "/" then
			vim.g.__last_cmdtype = "search_up";
		elseif cmd == "=" then
			vim.g.__last_cmdtype = "expr";
		elseif cmd == "@" then
			vim.g.__last_cmdtype = "input";
		end
	end
})

