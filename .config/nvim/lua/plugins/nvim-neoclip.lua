return {
    "AckslD/nvim-neoclip.lua",
    dependencies = {
        { "kkharji/sqlite.lua", module = "sqlite" },
        { "nvim-telescope/telescope.nvim" },
        { "nvim-telescope/telescope-fzf-native.nvim" },
    },
    config = function()
        require("neoclip").setup({
            enable_persistent_history = true,
        })

        vim.api.nvim_set_keymap("n", "<leader>p", "<cmd>Telescope neoclip<CR>", { noremap = true, silent = true })
    end,
}
