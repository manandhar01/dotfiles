return {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
        vim.g.gruvbox_material_background = "hard"
        vim.g.gruvbox_material_better_performance = 1
        vim.g.gruvbox_material_enable_italic = 1
        vim.g.gruvbox_material_transparent_background = 2
        vim.g.gruvbox_material_sign_column_background = "grey"
        vim.g.gruvbox_material_current_word = "grey background"
    end,
}
