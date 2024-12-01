return {
    "zapling/mason-conform.nvim",
    dependencies = { "williamboman/mason.nvim", "stevearc/conform.nvim" },
    config = function()
        require("mason-conform").setup({
            -- ignore_install = {'some_formatter'}
        })
    end,
}
