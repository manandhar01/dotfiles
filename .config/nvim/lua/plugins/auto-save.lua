return {
	"okuuva/auto-save.nvim",
	config = function()
		require("auto-save").setup({
			execution_message = {
				enabled = false,
			},
		})
	end,
}
