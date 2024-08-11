return {
	"okuuva/auto-save.nvim",
	config = function()
		require("auto-save").setup({
			execution_message = {
				enabled = false,
			},
			trigger_events = {
				immediate_save = { "BufLeave" },
				defer_save = { "InsertLeave", "TextChanged", "FocusLost" },
				cancel_defered_save = { "InsertEnter" },
			},
			debounce_delay = 60000,
		})
	end,
}
