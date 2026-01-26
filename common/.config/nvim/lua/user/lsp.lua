require("mason").setup()

require("mason-lspconfig").setup {
	ensure_installed = {
		"lua_ls", "rust_analyzer", "pyright", "ts_ls", "eslint", "cssls",
		"html", "gopls", "graphql", "bashls"
	},
}

local opts = { noremap = true, silent = true }
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local lsp_keymaps = function(bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)

	vim.api.nvim_create_user_command("Format", function()
		vim.lsp.buf.format()
	end, {})
end

local on_attach = function(client, bufnr)
	lsp_keymaps(bufnr)
end

-- Configure servers using vim.lsp.config() function syntax
vim.lsp.config('rust_analyzer', {
	on_attach = on_attach,
	settings = {
		["rust-analyzer"] = {
			imports = {
				granularity = {
					group = "crate",
				},
				prefix = "self",
			},
			cargo = {
				buildScripts = {
					enable = true,
				},
			},
			procMacro = {
				enable = true,
			},
		},
	},
})

vim.lsp.config('lua_ls', {
	on_attach = on_attach,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

vim.lsp.config('pyright', {
	on_attach = on_attach,
	settings = {
		pyright = {
			autoImportCompletion = true,
			useLibraryCodeForTypes = true,
		},
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = 'openFilesOnly',
				useLibraryCodeForTypes = true,
				typeCheckingMode = 'off',
			},
		},
	},
})

local cssls_capabilities = vim.lsp.protocol.make_client_capabilities()
cssls_capabilities.textDocument.completion.completionItem.snippetSupport = true

vim.lsp.config('cssls', {
	on_attach = on_attach,
	capabilities = cssls_capabilities,
})

vim.lsp.config('clangd', {
	on_attach = on_attach,
	cmd = { "clangd", "--offset-encoding=utf-16" },
})

vim.lsp.config('ts_ls', {
	on_attach = on_attach,
	settings = {
		typescript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
		javascript = {
			inlayHints = {
				includeInlayParameterNameHints = "all",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
	},
})

-- Default config for all servers
vim.lsp.config('*', {
	on_attach = on_attach,
})

-- Enable all the servers
vim.lsp.enable({
	'rust_analyzer',
	'lua_ls',
	'pyright',
	'ts_ls',
	'eslint',
	'cssls',
	'html',
	'gopls',
	'graphql',
	'bashls',
	'clangd',
})
