local ts_utils = require "nvim-treesitter.ts_utils"
local M = {}

function P(table)
	print(vim.inspect(table))
	return table
end

local get_root = function(bufnr)
	local parser = vim.treesitter.get_parser(bufnr, "rust", {})
	local tree = parser:parse()[1]
	return tree:root()
end

M.menem = function()
	local node = ts_utils.get_node_at_cursor()
	if node == nil then
		error("no hay nodo pa")
	end

	-- help tsnode
	local bufnr = vim.api.nvim_get_current_buf()
	ts_utils.update_selection(bufnr, node)

	local root = get_root(bufnr)
	local query = vim.treesitter.parse_query("python", "(identifier) @id")

	for id, node in query:iter_captures(root, bufnr, 0, -1) do
		-- local range = { node:range() }

		print(vim.treesitter.get_node_text(node, bufnr))

		-- if node.captures ~= nil then
			-- print(node)
		-- end
	end

	-- print(vim.inspect(node:field("name")))
	-- local tabla = node:field('identifier')
	-- print(vim.inspect(tabla))

	-- print(vim.inspect(ts_utils.get_named_children(node)))
	-- print(ts_utils.get_named_children(node)[1])

end

return M
