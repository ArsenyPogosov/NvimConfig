local M = {}

function M.get_tab_position(tabpage)
	local tabpage = tabpage or vim.api.nvim_get_current_tabpage()
	local positions = vim.api.nvim_list_tabpages()
	for i, j in ipairs(positions) do
		if j == tabpage then
			return i
		end
	end
	return 0
end

function M.get_tab_id(position)
	local positions = vim.api.nvim_list_tabpages()
	return positions[position]
end

function M.get_tab_count()
	return #vim.api.nvim_list_tabpages()
end

function M.get_focused_window(tabpage)
	local tabpage = tabpage or vim.api.nvim_get_current_tabpage()
	local pos = M.get_tab_position(tabpage)
	return vim.fn.win_getid(vim.fn.tabpagewinnr(pos), pos)
end

function M.get_windows(tabpage)
	local tabpage = tabpage or vim.api.nvim_get_current_tabpage()
	return vim.api.nvim_tabpage_list_wins(tabpage)
end

function M.is_user_window(window)
	local tab = vim.api.nvim_win_get_tabpage(window)
	local buf = vim.api.nvim_win_get_buf(window)

	if window == require("user.tree").get_tree_window(tab) then
		return false
	end
	if vim.api.nvim_win_get_config(window).relative ~= '' then        -- window is floating
		return false
	end
	if vim.api.nvim_buf_get_option(buf, "filetype") == "Trouble" then
		return false
	end

	return true
end

function M.get_user_windows(tabpage)
	local tabpage = tabpage or vim.api.nvim_get_current_tabpage()

	local result = {}
	for _, i in pairs(M.get_windows(tabpage)) do
		if M.is_user_window(i) then
			table.insert(result, i)
		end
	end

	return result
end

return M
