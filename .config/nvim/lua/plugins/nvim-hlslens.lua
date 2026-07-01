return {
    "kevinhwang91/nvim-hlslens",
    event = "VeryLazy",
    config = function()
        require("hlslens").setup()

        local function kopts(desc)
            return { noremap = true, silent = true, desc = desc }
        end

        vim.keymap.set(
            "n",
            "n",
            [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
            kopts("Next search result (hlslens)")
        )
        vim.keymap.set(
            "n",
            "N",
            [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
            kopts("Previous search result (hlslens)")
        )
        vim.keymap.set("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], kopts("Search word under cursor (hlslens)"))
        vim.keymap.set("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], kopts("Search word under cursor backward (hlslens)"))
        vim.keymap.set("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts("Search partial word under cursor (hlslens)"))
        vim.keymap.set("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts("Search partial word backward (hlslens)"))
    end,
}
