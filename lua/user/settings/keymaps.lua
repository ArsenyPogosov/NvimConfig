vim.g.mapleader = " "

vim.keymap.set("n", "<leader>q", ":qa<CR>")                     -- close all
vim.keymap.set("n", "<leader>Q", ":qa!<CR>")                    -- close all no unsave change

vim.keymap.set("n", "<leader>r", ":Reload<CR>")                 -- reload config

vim.keymap.set("n", "<leader>nh", ":nohl<CR>")                  -- clear search highlights

-- split windows control
vim.keymap.set("n", "<leader>sv", ":vnew<CR>")                  -- vertical split
vim.keymap.set("n", "<leader>sh", ":new<CR>")                   -- horizontal split
vim.keymap.set("n", "<leader>sn", function()
	vim.cmd(":wincmd w")
	if #(require("user.utils").get_user_windows()) ~= 0 then
		while not require("user.utils").is_user_window(vim.api.nvim_get_current_win()) do
			vim.cmd(":wincmd w")
		end
	end
end)                                                            -- next window
vim.keymap.set("n", "<leader>sp", function()
	vim.cmd(":wincmd W")
	if #(require("user.utils").get_user_windows()) ~= 0 then
		while not require("user.utils").is_user_window(vim.api.nvim_get_current_win()) do
			vim.cmd(":wincmd W")
		end
	end
end)                                                            -- prev window
vim.keymap.set("n", "<leader>se", "<C-w>=")                     -- equalize sizes
vim.keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")       -- zoom into/out of current window
vim.keymap.set("n", "<leader>sx", ":bd<CR>")                    -- close current window

-- tab control
vim.keymap.set("n", "<leader>tn", ":tabn<CR>")                  -- next tab
vim.keymap.set("n", "<leader>tp", ":tabp<CR>")                  -- prev tab
for i=1,9 do
	vim.keymap.set("n", "<leader>t"..i, ":"..i.."tabn<CR>")     -- tab i
end
vim.keymap.set("n", "<leader>th", ":tabm -1<CR>")               -- move tab to the left
vim.keymap.set("n", "<leader>tl", ":tabm +1<CR>")               -- move tab to the right
vim.keymap.set("n", "<leader>to", ":tabnew<CR>")                -- open new tab
vim.keymap.set("n", "<leader>tx", ":tabclose<CR>")              -- close current tab
vim.keymap.set("n", "<leader>tX", ":tabonly<CR>")               -- close all but current tab
vim.keymap.set("n", "<leader>tt", ":tabs<CR>")                  -- content of the tabs

-- nvim-tree
local tree = require("user.tree")
vim.keymap.set("n", "<leader>e", function()
	if tree.is_tree_focused() then
		vim.cmd(":wincmd p")
	else
		if not tree.is_tree_visible() then
			tree.open_all_trees()
		end
		tree.focus_on_tree_all()
	end
end)                                                            -- focus on explorer window
vim.keymap.set("n", "<leader>te", function()
	if tree.is_tree_visible() then
		tree.close_all_trees()
	else
		tree.open_all_trees()
	end
end)                                                            -- open/close explorer window

-- nvim-tree pane focused only
local nvim_tree = {
    -- { key = { "<CR>", "o", "<2-LeftMouse>" }, action = "tabnew" },
	{ key = "<C-v>",                          action = "vsplit" },
    { key = "<C-x>",                          action = "split" },
    { key = "<C-t>",                          action = "tabnew" },
}

-- telescope
local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope.find_files)         -- find files
vim.keymap.set("n", "<leader>ft", telescope.live_grep)          -- find text with grep
vim.keymap.set("n", "<leader>fb", telescope.buffers)            -- find buffer
vim.keymap.set("n", "<leader>fgc", telescope.git_commits)       -- find commits
vim.keymap.set("n", "<leader>fgC", telescope.git_bcommits)      -- find commits changing the current buffer
vim.keymap.set("n", "<leader>fgf", telescope.git_files)         -- find git files
vim.keymap.set("n", "<leader>fgs", telescope.git_status)        -- find changed file
vim.keymap.set("n", "<leader>fgb", telescope.git_branches)      -- find commits
vim.keymap.set("n", "<leader>fgS", telescope.git_status)        -- find git stash

vim.keymap.set("n", "<leader>td",
	"<cmd>TroubleToggle document_diagnostics<cr>")              -- toggle diagnostics for current file
vim.keymap.set("n", "<leader>tD",
	"<cmd>TroubleToggle workspace_diagnostics<cr>")             -- toggle diagnostics for whole project

vim.keymap.set("n", "<leader>l", ":Neoformat<CR>")              -- format code

return {
	nvim_tree = nvim_tree
}
