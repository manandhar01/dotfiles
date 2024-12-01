return {
    "nvim-treesitter/nvim-treesitter",
    config = function()
        require("nvim-treesitter.configs").setup({
            highlight = { enable = true, disable = { "latex" } },
            indent = { enable = true },
        })
    end,
}
