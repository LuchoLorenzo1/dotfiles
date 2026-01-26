vim.opt.expandtab = true

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.cindent = false

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.indentkeys:remove("0#")
    vim.opt_local.indentkeys:remove("<:>")
  end,
})
