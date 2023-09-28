-- tree sync
require("user.tree").enable_tree_focus_sync()

-- vim.opt.termguicolors = true

-- indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.smarttab = true
vim.opt.autoindent = true
-- line wrapping
vim.opt.wrap = false

-- line numbers
vim.opt.relativenumber = true
vim.opt.number = true

-- enable 26 colors
vim.opt.termguicolors = true

-- use "+ for y, p, etc.
vim.opt.clipboard:append("unnamedplus")

-- split windows
vim.opt.splitright = true
vim.opt.splitbelow = true

-- no timeout for keystrokes
vim.opt.timeout = false
vim.opt.ttimeout = false

-- always show tabline
vim.opt.showtabline = 2

-- completion suggestions
vim.opt.completeopt=menu,menuone,noselect

vim.opt.scrolloff = 2

-- highlight current line
vim.opt.cursorline = true

-- auto update file
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})

-- normal mod with russian keyboard
vim.opt.langmap="ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"
