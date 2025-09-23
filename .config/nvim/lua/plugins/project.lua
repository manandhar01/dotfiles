return {
    "DrKJeff16/project.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    opts = {
        show_hidden = true,
    },
    cond = vim.fn.has("nvim-0.11") == 1,
}
