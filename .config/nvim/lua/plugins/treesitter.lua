return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- The `main` branch dropped the old `require("nvim-treesitter.configs").setup()`
    -- API, so parsers are installed and started manually below. Load eagerly so the
    -- FileType autocmds are registered before the first buffer's FileType fires.
    lazy = false,
    branch = "main",
    opts = {
        ensure_installed = {
            "bash",
            "c",
            "cpp",
            "css",
            "diff",
            "go",
            "html",
            "javascript",
            "json",
            "json5",
            "latex",
            "lua",
            "luadoc",
            "markdown",
            "markdown_inline",
            "python",
            "query",
            "ruby",
            "rust",
            "scss",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
        },
    },
    config = function(_, opts)
        -- Install the configured parsers and start treesitter for their filetypes.
        if opts.ensure_installed and #opts.ensure_installed > 0 then
            require("nvim-treesitter").install(opts.ensure_installed)

            for _, parser in ipairs(opts.ensure_installed) do
                vim.treesitter.language.register(parser, parser)

                vim.api.nvim_create_autocmd("FileType", {
                    pattern = parser,
                    callback = function(event)
                        pcall(vim.treesitter.start, event.buf, parser)
                    end,
                })
            end
        end

        -- Fallback: auto-install and start a parser for any other filetype opened.
        vim.api.nvim_create_autocmd("BufReadPost", {
            callback = function(event)
                local bufnr = event.buf
                local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
                if filetype == "" then
                    return
                end

                -- Already handled by the ensure_installed loop above.
                if vim.tbl_contains(opts.ensure_installed, filetype) then
                    return
                end

                local parser_name = vim.treesitter.language.get_lang(filetype)
                if not parser_name then
                    return
                end

                -- Only proceed if this is a parser nvim-treesitter knows how to install.
                local parsers = require("nvim-treesitter.parsers")
                if not parsers[parser_name] then
                    return
                end

                if not pcall(vim.treesitter.get_parser, bufnr, parser_name) then
                    require("nvim-treesitter").install({ parser_name }):wait(30000)
                end

                if pcall(vim.treesitter.get_parser, bufnr, parser_name) then
                    pcall(vim.treesitter.start, bufnr, parser_name)
                end
            end,
        })
    end,
}
