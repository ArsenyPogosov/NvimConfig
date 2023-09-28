local setup, nvimtree = pcall(require, "luatab")
if not setup then
	return
end

nvimtree.setup{
    separator = function() return '' end,

	modified = function(bufnr)
		return vim.fn.getbufvar(bufnr, '&modified') == 1 and ' +' or ''
	end,

	cell = function(index)
		local M = require("luatab").helpers

		local tabpage = require("user.utils").get_tab_id(index)
		local isSelected = vim.fn.tabpagenr() == index
		local result = (isSelected and '%#TabLineSel#' or '%#TabLine#') .. '%' .. index .. 'T' .. ' '
		local wins = require("user.utils").get_user_windows(tabpage)
		for i, j in pairs(wins) do
			local bufnr = vim.fn.winbufnr(j)
			result = result ..
				-- M.devicon(bufnr, isSelected) ..
				M.title(bufnr) ..
				-- M.modified(bufnr) ..
				(i ~= #wins and ', ' or '')
		end

		return result .. ' ' ..
			'%T' ..
			M.separator(index)
	end
}

local utils = require('user.tree')

Final_tabline = function()
	local greeter = utils.is_tree_visible() and "[storage]:" or ""
	local indent = math.max(#greeter, utils.get_tree_size())
	return
		'%#NvimTreeNormal#' ..
		greeter ..
		string.rep(" ", indent - #greeter) ..
		nvimtree.helpers.tabline()
end

vim.opt.tabline = '%!v:lua.Final_tabline()'
