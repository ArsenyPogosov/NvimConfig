local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup()

require("mason-lspconfig").setup_handlers {
	function (server_name) -- default handler
		require("lspconfig")[server_name].setup({})
	end,

	["lua_ls"] = function ()
		require("lspconfig")["lua_ls"].setup({
			settings = {
				Lua = {
					diagnostics = {
						globals = {'vim'},
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					telemetry = {
						enable = false,
					},
				},
			},
		})
	end,
}
