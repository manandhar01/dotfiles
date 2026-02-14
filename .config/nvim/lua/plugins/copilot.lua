return {
    "zbirenbaum/copilot.lua",
    -- dependencies = {
    --     "copilotlsp-nvim/copilot-lsp",
    -- },
    requires = {
        "copilotlsp-nvim/copilot-lsp",
    },
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        require("copilot").setup({
            suggestion = {
                auto_trigger = true,
            },
            -- nes = {
            --     enabled = true,
            --     keymap = {
            --         accept_and_goto = "<leader>p",
            --         accept = false,
            --         dismiss = "<Esc>",
            --     },
            -- },
        })
    end,
}
