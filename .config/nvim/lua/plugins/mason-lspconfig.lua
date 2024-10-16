return {
	"williamboman/mason-lspconfig.nvim",
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"bashls",
				"css_variables",
				"cssls",
				"lua_ls",
				"ts_ls",
				"texlab",
				"gopls",
			},
			automatic_installation = true,
		})
	end,
}
