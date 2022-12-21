local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

-- -- load my personal vscode-style snippets
require("luasnip/loaders/from_vscode").lazy_load({
	paths = vim.fn.stdpath "config" .. "/snippets",
})

luasnip.config.set_config {
	history = true,
	updateevents = "TextChanged,TextChangedI",
	enable_autosnippets = true
}

-- jump forward in snippet
vim.keymap.set({ "i", "s" }, "<c-j>", function()
	if luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	end
end, { silent = true })

-- jump backwards in snippet
vim.keymap.set({ "i", "s" }, "<c-k>", function()
	if luasnip.jumpable(-1) then
		luasnip.jump(-1)
	end
end, { silent = true })

-- choices in snippets
vim.keymap.set("i", "<c-l>", function()
	if luasnip.choice_active() then
		luasnip.change_choice(1)
	end
end)


-- "body": [
-- 	 "Mejor presidente de la historia:",
--	 "${1|menem,de la rua|}"
-- ],
-- Voy switcheando entre las opciones con <c-l>
