local function open_link_as_md()
  local line = vim.fn.getline(".")
  local file_path = line:match("%[.-%]%((.-)%)")
  if not file_path then
    return
  end

  -- Check if it's a URL
  if file_path:match("^https?://") or file_path:match("^www%.") then
    -- Open in the default browser
    vim.fn.jobstart({ "xdg-open", file_path }, { detach = true })
    return
  end

  -- Otherwise treat it as a local markdown file
  local current_dir = vim.fn.expand("%:h")
  local full_path = current_dir .. "/" .. file_path .. ".md"
  if vim.fn.filereadable(full_path) == 1 then
    vim.cmd("edit " .. full_path)
  else
    vim.cmd("edit " .. full_path)
    -- or show an error instead:
    -- vim.api.nvim_err_writeln("File does not exist: " .. full_path)
  end
end


local function go_up_and_open_parent()
	local current_path = vim.fn.expand("%:p")
	local parent_dir = vim.fn.fnamemodify(current_path, ":h")
	local parent_name = vim.fn.fnamemodify(parent_dir, ":t"):lower()

	local grandparent_dir = vim.fn.fnamemodify(parent_dir, ":h")
	local grandparent_name = vim.fn.fnamemodify(grandparent_dir, ":t"):lower()
	local ext = vim.fn.expand("%:e")

	local parent_file = parent_dir .. "/" .. parent_name .. "." .. ext
	local grandparent_file = grandparent_dir .. "/" .. grandparent_name .. "." .. ext
	local index_file = grandparent_dir .. "/index." .. ext

	if vim.fn.filereadable(parent_file) == 1 and parent_file ~= current_path then
		vim.cmd("edit " .. parent_file)
	elseif vim.fn.filereadable(grandparent_file) == 1 then
		vim.cmd("edit " .. grandparent_file)
	elseif vim.fn.filereadable(index_file) == 1 then
		vim.cmd("edit " .. index_file)
	else
		vim.api.nvim_err_writeln("Neither " .. grandparent_file .. " nor index file exists.")
	end
end

local function goto_next_markdown_link()
	local cur_line = vim.fn.line(".")
	local total_lines = vim.fn.line("$")

	for lnum = cur_line + 1, total_lines do
		local line = vim.fn.getline(lnum)
		local col = line:find("%[.-%]%(")
		if col then
			vim.fn.cursor(lnum, col)
			return
		end
	end
	vim.api.nvim_echo({ { "No next link found", "WarningMsg" } }, false, {})
end

local function goto_prev_markdown_link()
	local cur_line = vim.fn.line(".")

	for lnum = cur_line - 1, 1, -1 do
		local line = vim.fn.getline(lnum)
		local col = line:find("%[.-%]%(")
		if col then
			vim.fn.cursor(lnum, col)
			return
		end
	end
	vim.api.nvim_echo({ { "No previous link found", "WarningMsg" } }, false, {})
end

local function file_to_html()
	vim.cmd("silent !" .. vim.fn.expand("~/wiki/md_to_html") .. " %:p")

	local source_dir = vim.fn.expand("~/wiki/markdown/")
	local path = vim.fn.expand("%:p")

	local relative_path = path:gsub("^" .. vim.pesc(source_dir), "")
	local html_path = relative_path:gsub("%.md$", ".html")
	local url = "http://localhost:4040/" .. html_path

	vim.fn.jobstart({ "chromium", url }, { detach = true })
end

vim.keymap.set('n', '<CR>', open_link_as_md, { noremap = true, silent = true })
vim.keymap.set("n", "<BS>", go_up_and_open_parent, { buffer = true, silent = true })
vim.keymap.set("n", "<Tab>", goto_next_markdown_link, { buffer = true, silent = true })
vim.keymap.set("n", "<S-Tab>", goto_prev_markdown_link, { buffer = true, silent = true })
vim.keymap.set("n", "<f4>", file_to_html, { buffer = true, silent = true })

-- vim.cmd([[
-- 	augroup Markdown
-- 	  autocmd!
-- 	  autocmd BufWritePost *.md silent !~/wiki/md_to_html %:p
-- 	augroup END
-- ]])
