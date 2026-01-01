return {
    "olimorris/codecompanion.nvim",
    version = "^18.0.0",
    opts = {},
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "zbirenbaum/copilot.lua",
    },
    config = function()
        require("codecompanion").setup({
            adapters = {
                copilot = {},
                openai = {
                    api_key = function()
                        return os.getenv("OPENAI_API_KEY")
                    end,
                },
            },
            strategies = {
                chat = { adapter = "copilot" },
                inline = { adapter = "copilot" },
            },
        })
    end,
}
