require("mason").setup()

require("mason-lspconfig").setup {
	ensure_installed = { "lua_ls", "rust_analyzer", "pyright", "ts_ls", "eslint", "cssls", "tailwindcss", "html", "htmx", "gopls", "graphql", "clangd", "bashls" },
}

local opts = { noremap = true, silent = true }
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']g', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local lsp_keymaps = function(bufnr)
	-- Enable completion triggered by <c-x><c-o>
	-- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
	local bufopts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)

	-- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	-- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	-- vim.keymap.set('n', '<space>wl', function()
	--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, bufopts)

	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)

	-- vim.keymap.set('n', '<space>F', function() vim.lsp.buf.format { async = true } end, bufopts)

	vim.api.nvim_create_user_command("Format", function()
		vim.lsp.buf.format()
	end, {})
end

local on_attach = function(client, bufnr)
	lsp_keymaps(bufnr)
end

require("mason-lspconfig").setup_handlers {
	function(server_name)
		require("lspconfig")[server_name].setup {
			on_attach = on_attach,
		}
	end,

	["rust_analyzer"] = function()
		require('lspconfig').rust_analyzer.setup({
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
						enable = true
					},
				}
			}
		})
	end,

	["lua_ls"] = function()
		require('lspconfig').lua_ls.setup {
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					}
				}
			}
		}
	end,

	["pyright"] = function()
		require('lspconfig').pyright.setup {
			on_attach = on_attach,
			settings = {
				pyright = {
					autoImportCompletion = true,
					useLibraryCodeForTypes = true
				},
				python = {
					analysis = {
						autoSearchPaths = true,
						diagnosticMode = 'openFilesOnly',
						useLibraryCodeForTypes = true,
						typeCheckingMode = 'off'
					}
				}
			}
		}
	end,

	["cssls"] = function()
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true
		require('lspconfig').cssls.setup {
			capabilities = capabilities,
			on_attach = on_attach,
		}
	end,

	["clangd"] = function()
		require('lspconfig').clangd.setup {
			on_attach = on_attach,
			cmd = { "clangd", "--offset-encoding=utf-16" },
		}
	end,
}
