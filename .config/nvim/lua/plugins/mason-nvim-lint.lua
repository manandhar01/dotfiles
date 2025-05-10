return {
    "rshkarin/mason-nvim-lint",
    dependencies = { "mason-org/mason.nvim", "mfussenegger/nvim-lint" },
    config = function()
        require("mason-nvim-lint").setup()
    end,
}
