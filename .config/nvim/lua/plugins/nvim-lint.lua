return {
    "mfussenegger/nvim-lint",
    config = function()
        require("lint").linters_by_ft = {
            markdown = { "vale" },
            typescript = { "eslint_d" },
            javascript = { "eslint_d" },
            lua = { "luacheck" },
            sh = { "shellcheck" },
            bash = { "shellcheck" },
            ruby = { "rubocop" },
            python = { "pylint" },
            go = { "golangcilint" },
        }

        -- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        -- 	callback = function()
        -- 		require("lint").try_lint()
        -- 	end,
        -- })
    end,
}
