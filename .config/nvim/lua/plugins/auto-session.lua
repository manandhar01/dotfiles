return {
    "rmagatti/auto-session",
    lazy = false,
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {
        enabled = true,
        auto_save = true,
        auto_restore = true,
        auto_create = true,
        suppressed_dirs = { "~/", "~/Downloads", "/" },
    },
}
