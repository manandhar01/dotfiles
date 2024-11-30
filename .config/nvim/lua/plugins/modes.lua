return {
	"mvllow/modes.nvim",
	event = "VimEnter",
	config = function()
		require("modes").setup({
			colors = {
				copy = "#f5c359",
				delete = "#c75c6a",
				insert = "#78ccc5",
				visual = "#fbf1c7",
			},
			line_opacity = 0.3,
			set_cursor = true,
			set_cursorline = true,
			set_number = true,
			ignore_filetypes = { "NvimTree", "TelescopePrompt" },
		})
	end,
}
