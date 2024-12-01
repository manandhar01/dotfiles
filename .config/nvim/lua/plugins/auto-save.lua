return {
    "okuuva/auto-save.nvim",
    config = function()
        require("auto-save").setup({
            trigger_events = {
                immediate_save = { "BufLeave" },
                defer_save = { "InsertLeave", "TextChanged", "FocusLost" },
                cancel_deferred_save = { "InsertEnter" },
            },
            debounce_delay = 60000,
        })
    end,
}
