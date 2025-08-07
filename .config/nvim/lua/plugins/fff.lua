return {
    "dmtrKovalenko/fff.nvim",
    build = "cargo build --release",
    opts = {},
    keys = {
        {
            "<leader>ff", -- try it if you didn't it is a banger keybinding for a picker
            function()
                require("fff").find_in_git_root() -- or find_in_git_root() if you only want git files
            end,
            desc = "Open file picker",
        },
    },
}
