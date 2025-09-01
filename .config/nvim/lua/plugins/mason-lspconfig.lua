return {
    "mason-org/mason-lspconfig.nvim",
    config = function()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "bashls",
                "css_variables",
                "cssls",
                -- "gopls",
                "lemminx",
                "lua_ls",
                -- "rust_analyzer",
                -- "texlab",
                "ts_ls",
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
