vim.api.nvim_create_user_command("Oops", function (data)
	require("oops").fix();
end, {})
