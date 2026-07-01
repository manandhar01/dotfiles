return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            bash = { "shellcheck" },
            go = { "golangcilint" },
            javascript = { "eslint_d" },
            lua = { "luacheck" },
            markdown = { "vale" },
            python = { "pylint" },
            ruby = { "rubocop" },
            sh = { "shellcheck" },
            typescript = { "eslint_d" },
        }

        -- Run only the linters whose executable is installed, so a missing
        -- linter doesn't raise ENOENT on every read/save until it's installed.
        local function lint_if_available()
            local names = lint.linters_by_ft[vim.bo.filetype] or {}
            local runnable = {}
            for _, name in ipairs(names) do
                local linter = lint.linters[name]
                local cmd = linter and linter.cmd
                if type(cmd) == "function" then
                    local ok, resolved = pcall(cmd)
                    cmd = ok and resolved or nil
                end
                if cmd and vim.fn.executable(cmd) == 1 then
                    table.insert(runnable, name)
                end
            end
            if #runnable > 0 then
                lint.try_lint(runnable)
            end
        end

        vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
            callback = lint_if_available,
        })

        -- Lint the buffer that triggered this plugin to load.
        lint_if_available()
    end,
}
