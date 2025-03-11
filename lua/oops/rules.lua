--- Rules for oops.nvim
local rules = {}

--- :W → :w, :Q → :q, :Wq → :wq
rules.caps_locked = {
	condition = function (prompt, command)
		if prompt ~= "cmd" then return; end

		local patterns = {
			"^W", "^Q", "^E",
			"^[wW][qQ]", "^[qQ][aA]",

			"^[wW][qQ][aA]", "^[wW][qQ][aA][lL][lL]"
		}

		for _, pattern in ipairs(patterns) do
			if string.match(command, pattern) then
				return true;
			end
		end

		return false;
	end,

	fix = function (prompt, command)
		return prompt, string.gsub(command, "^%w+", string.lower);
	end
};

--- :q' → :q, :q` → :q
rules.q_quote = {
	condition = function (prompt, command)
		if prompt ~= "cmd" then return; end

		return string.match(command, "^q[`'\"]") ~= nil;
	end,

	fix = function (prompt, command)
		return prompt, string.gsub(command, "^q[`'\"]", "q")
	end
};

--- :qw → :wq
rules.reversed_wq = {
	condition = function (prompt, command)
		if prompt ~= "cmd" then return; end

		return string.match(command, "^[qQ][wW]") ~= nil;
	end,

	fix = function (prompt, command)
		return prompt, string.gsub(command, "^[qQ][wW]", "wq")
	end
};

--- :!q → :q!
rules.accidental_bash = {
	condition = function (prompt, command)
		if prompt ~= "cmd" then return; end

		return string.match(command, "^![wWqQeE]+") ~= nil;
	end,

	fix = function (prompt, command)
		local removed_excl = string.gsub(command, "^!", "");

		return prompt, string.gsub(removed_excl, "^[wWqQeE]+", function (val)
			return string.lower(val) .. "!";
		end);
	end
};

--- :Set opt → :set opt
rules.set_with_S = {
	condition = function (prompt, command)
		if prompt ~= "cmd" then return; end

		return string.match(command, "^Set") ~= nil;
	end,

	fix = function (prompt, command)
		return prompt, string.gsub(command, "^Set%w*", string.lower);
	end
};

--- :luabprint("hi") → :lua print("hi")
rules.lua_with_b = {
	condition = function (prompt, command)
		if prompt ~= "cmd" then return; end

		return string.match(command, "^luab") ~= nil;
	end,

	fix = function (prompt, command)
		return prompt, string.gsub(command, "^luab", "lua");
	end
};

----------------------------------------------------------------------

--- :moh → :noh
rules.moh = {
	condition = function (prompt, command)
		if prompt ~= "cmd" then return; end

		return string.match(command, "^moh") ~= nil;
	end,

	fix = function (prompt, command)
		return prompt, string.gsub(command, "^m", "n");
	end
};

--- :sfoo/bar → :s/foo/bar
rules.sub_wo_slash = {
	condition = function (prompt, command)
		if prompt ~= "cmd" then return; end

		return string.match(command, "^s[^/]") ~= nil;
	end,

	fix = function (prompt, command)
		return prompt, string.gsub(command, "^s", "s/");
	end
};

--- :'<,'>sfoo/bar → :'<,'>s/foo/bar
rules.vsub_wo_slash = {
	condition = function (prompt, command)
		if prompt ~= "cmd" then return; end

		return string.match(command, "'<,'>^s[^/]") ~= nil;
	end,

	fix = function (prompt, command)
		return prompt, string.gsub(command, "'<,'>^s[^/]", "s/");
	end
};

return rules;
