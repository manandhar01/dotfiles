return {
    "zbirenbaum/copilot.lua",
    requires = {
        "copilotlsp-nvim/copilot-lsp",
    },
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        require("copilot").setup({
            suggestion = { enabled = false },
            panel = { enabled = false },
        })
    end,
}
