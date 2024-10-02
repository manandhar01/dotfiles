return {
	"mfussenegger/nvim-lint",
	config = function()
		require("lint").linters_by_ft = {
			markdown = { "vale" },
			typescript = { "eslint" },
			javascript = { "eslint" },
			lua = { "luacheck" },
			sh = { "shellcheck" },
			bash = { "shellcheck" },
			ruby = { "ruby" },
			python = { "pylint" },
			rust = { "clippy" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
