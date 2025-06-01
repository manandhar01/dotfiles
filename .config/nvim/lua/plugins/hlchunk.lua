return {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("hlchunk").setup({
            chunk = {
                enable = true,
                chars = {
                    horizontal_line = "─",
                    vertical_line = "│",
                    left_top = "╭",
                    left_bottom = "╰",
                    -- right_arrow = ">",
                    right_arrow = "─",
                },
                duration = 100,
                delay = 0,
            },
            indent = {
                enable = true,
                chars = { "┆" },
            },
            line_num = {
                enable = true,
                style = "#806d9c",
            },
        })
    end,
}
