local snip_status_ok, ls = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

local fmt = require("luasnip.extras.fmt").fmt

ls.config.set_config {
	history = true,
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true,
	store_selection_keys = '<c-s>',
}

require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.fn.stdpath "config" .. "/snippets" })

-- ls.add_snippets("lua", {
-- 	s("mbappe", {
-- 		c(1, {
-- 			t("campeon 2018"),
-- 			t("subcampeon 2022"),
-- 		}),
-- 		i(2),
-- 	}),
-- 	s("menem",
-- 	fmt([[jjaj {} noooo {} {}]], {
-- 		i(1, "a"),
-- 		i(2, "a"),
-- 		i(3, "a"),
-- 	}
-- 	)),
-- 	s({trig="%d", regTrig= true}, {t("warewor")}),
-- 	s({trig="pito(:?%d)", regTrig= true, hidden=true}, {t("warewor")}),
-- }, {
-- 	key = "lua",
-- })

-- vim.keymap.set({ "i", "s" }, "<c-j>", function()
-- 	ls.expand_or_jump()
-- 	if ls.expand_or_jumpable() then
-- 		ls.expand_or_jump()
-- 	end
-- end, { silent = true })
--
-- vim.keymap.set({ "i", "s" }, "<c-k>", function()
-- 	if ls.jumpable(-1) then
-- 		ls.jump(-1)
-- 	end
-- end, { silent = true })
--

vim.keymap.set({ "i", "s" }, "<C-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)
-- vim.keymap.set({ "i", "s" }, "<C-h>", function()
-- 	if ls.choice_active() then
-- 		ls.change_choice(-1)
-- 	end
-- end)
