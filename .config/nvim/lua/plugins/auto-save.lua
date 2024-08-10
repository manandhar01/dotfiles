return {
	"okuuva/auto-save.nvim",
	config = function()
		require("auto-save").setup({
			execution_message = {
				enabled = false,
			},
			debounce_delay = 60000,
		})
	end,
}
