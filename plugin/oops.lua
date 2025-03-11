vim.g.__last_cmdtype = "cmd";

vim.api.nvim_create_user_command("Oops", function (data)
	require("oops").fix(vim.g.__last_cmdtype);
end, {})

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

