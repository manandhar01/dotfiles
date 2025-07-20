return {
    "mvllow/modes.nvim",
    config = function()
        require("modes").setup({
            colors = {
                copy = "#f5c359",
                delete = "#f87a53",
                insert = "#78acc5",
                visual = "#ffffff",
            },
            line_opacity = 0.25,
            set_cursor = false,
            set_cursorline = false,
            set_number = true,
            ignore = { "NvimTree", "TelescopePrompt" },
        })
    end,
}
