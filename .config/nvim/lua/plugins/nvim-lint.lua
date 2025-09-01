return {
    "mfussenegger/nvim-lint",
    config = function()
        require("lint").linters_by_ft = {
            bash = { "shellcheck" },
            -- go = { "golangcilint" },
            javascript = { "eslint_d" },
            -- lua = { "luacheck" },
            markdown = { "vale" },
            python = { "pylint" },
            -- ruby = { "rubocop" },
            sh = { "shellcheck" },
            typescript = { "eslint_d" },
            xml = { "sonarlintlanguageserver" },
        }

        -- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        -- 	callback = function()
        -- 		require("lint").try_lint()
        -- 	end,
        -- })
    end,
}
