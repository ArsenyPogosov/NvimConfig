-- download packer if not downloaded
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

-- autoapply updates on save
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost packer_config.lua source <afile> | PackerSync
--   augroup end
-- ]])

local status, packer = pcall(require, "packer")
if not status then
	return
end

return packer.startup(function(use)

	use("wbthomason/packer.nvim")                             -- packer itself
	use("nvim-lua/plenary.nvim")                              -- common dependency
	use("famiu/nvim-reload")                                  -- reload configs
	use({"catppuccin/nvim", as = "catppuccin"})               -- catppuccin theme
	use("tpope/vim-repeat")                                   -- fixes . command for some packs
	use("tpope/vim-surround")                                 -- work with braces, qoutes and tags
	use("christoomey/vim-tmux-navigator")                     -- navigate panes using <C+[hjkl]>
	use("szw/vim-maximizer")                                  -- zoom into/out of pane
	use("inkarkat/vim-ReplaceWithRegister")                   -- gr in normal for replacing with register
	use("numToStr/Comment.nvim")                              -- comment objects using gc and gv
	use("nvim-tree/nvim-tree.lua")                            -- file explorer
	use("nvim-tree/nvim-web-devicons")                        -- icons for nvim-tree
	use("alvarosevilla95/luatab.nvim")                        -- custom tabbar render
	use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
    })                                                        -- treesitter
	use({"nvim-telescope/telescope.nvim", branch = '0.1.x'})  -- fuzzy finder
	use("L3MON4D3/LuaSnip")                                   -- snippet engine
	use("rafamadriz/friendly-snippets")                       -- snippet collection
	use("hrsh7th/nvim-cmp")                                   -- completion suggestions
	use("hrsh7th/cmp-cmdline")                                -- cmp source
	use('hrsh7th/cmp-path')                                   -- cmp source
	use("hrsh7th/cmp-buffer")                                 -- cmp source
	use("hrsh7th/cmp-nvim-lsp")                               -- cmp source
	use("hrsh7th/cmp-nvim-lua")                               -- cmp source
	use("petertriho/cmp-git")                                 -- cmp source
	use("saadparwaiz1/cmp_luasnip")                           -- cmp source
	use("williamboman/mason.nvim")                            -- external editor tooling manager (LSP, DAP, ...)
	use("williamboman/mason-lspconfig.nvim")                  -- bridge between mason and nvim-lspconfig
	use("neovim/nvim-lspconfig")                              -- LSP support
	use("VonHeikemen/lsp-zero.nvim")                          -- yet another LSP shit (keymaps?)
	use("Pocco81/auto-save.nvim")                             -- auto save
	use("akinsho/toggleterm.nvim")                            -- toggle term
	use({
		"folke/trouble.nvim",
		requires = "nvim-tree/nvim-web-devicons",
    })                                                        -- problems list
	use("norcalli/nvim-colorizer.lua")                        -- highlight color codes
	use("sbdchd/neoformat")                                   -- format code

	if packer_bootstrap then
	    require('packer').sync()
	end
end)
