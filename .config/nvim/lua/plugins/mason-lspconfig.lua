return {
    "mason-org/mason-lspconfig.nvim",
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "bashls",
                "css_variables",
                "cssls",
                "lua_ls",
                "ts_ls",
                -- "texlab",
                -- "gopls",
                -- "rust_analyzer",
            },
            automatic_enable = {
                exclude = {
                    "rust_analyzer",
                },
            },
            automatic_installation = true,
        })
    end,
}
