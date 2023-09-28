local status, catppuccin = pcall(require, "catppuccin")
if not status then
	return
end

catppuccin.setup({
	integrations = {
		nvimtree = true,
        telescope = true,
		cmp = true,
		treesitter = true,
	},
})
