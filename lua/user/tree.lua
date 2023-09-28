local M = {}

local utils = require("user.utils")

function M.get_tree_window(tabpage)
	tabpage = tabpage or vim.api.nvim_get_current_tabpage()

	local winnr = require("nvim-tree.view").get_winnr(tabpage)
	if winnr and vim.api.nvim_win_is_valid(winnr) then
		return winnr
	end
end

function M.is_tree_visible(tabpage)
	if M.get_tree_window(tabpage) then
		return true
	end
	return false
end

function M.get_tree_size(tabpage)
	tabpage = tabpage or vim.api.nvim_get_current_tabpage()
	return M.is_tree_visible(tabpage) and require("nvim-tree.view").View.width or 0
end

function M.is_tree_focused(tabpage)
	tabpage = tabpage or vim.api.nvim_get_current_tabpage()
	local window = utils.get_focused_window(tabpage)
	return window and window == M.get_tree_window(tabpage)
end

function M.focus_on_tree()
	local window = M.get_tree_window()
	if window then
		vim.fn.win_gotoid(window)
		-- require("nvim-tree.view").focus(window, true)
	end
end

function M.focus_on_tree_all()
	local current_tab = vim.fn.tabpagenr()
	vim.cmd(":tabdo lua require(\"user.tree\").focus_on_tree()")
	vim.cmd(":tabnext " .. current_tab)
end

function M.lose_focus()
	if M.is_tree_focused() then
		vim.cmd(":wincmd p")
	end
end

function M.lose_focus_all()
	local current_tab = vim.fn.tabpagenr()
	vim.cmd(":tabdo lua require(\"user.tree\").lose_focus()")
	vim.cmd(":tabnext " .. current_tab)
end

function M.open_all_trees()
	local current_tab = vim.fn.tabpagenr()
	local n = utils.get_tab_count()
	for i = 1, n do
		vim.cmd(":noautocmd tabnext " .. i)
		if not M.is_tree_visible() then
			vim.cmd(":noautocmd NvimTreeOpen")
		end
		vim.cmd(":noautocmd wincmd p")
	end
	vim.cmd(":noautocmd tabnext " .. current_tab)
end

function M.close_all_trees()
	local current_tab = vim.fn.tabpagenr()
	local n = utils.get_tab_count()
	for i = 1, n do
		vim.cmd(":noautocmd tabnext " .. i)
		if M.is_tree_visible() then
			vim.cmd(":noautocmd NvimTreeClose")
		end
	end
	vim.cmd(":noautocmd tabnext " .. current_tab)
end

function M.enable_tree_focus_sync()
	local function sync(force)
		if M.is_tree_visible() or force then
			if M.is_tree_focused() then
				M.open_all_trees()                  -- cause they are created lazily by plugin
				M.focus_on_tree_all()
			else
				M.lose_focus_all()
			end
		end
	end

	vim.api.nvim_create_autocmd('WinEnter', {
		pattern = '*',
		callback = sync
	})
	local events = require("nvim-tree.events")
	events.subscribe(events.Event.TreeOpen, function() sync(true) end)
end

return M
