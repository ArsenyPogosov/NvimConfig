local toggleterm = require("toggleterm")

toggleterm.setup({
	size = function(term)
		if term.direction == "horizontal" then
			return 10
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		else
			return 20
		end
	end,
	highlights = {
		Normal = {
			guibg = "#181825",
		}
	},
	open_mapping = [[<c- >]],
	hide_numbers = true,
	shade_terminals = false,
	direction = "float",
});
