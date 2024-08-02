return {
	"akinsho/toggleterm.nvim",
	config = function()
		require("toggleterm").setup({
			size = 70,
			open_mapping = [[<c-\>]],
			hide_numbers = true,
			shading_factor = 2,
			direction = "vertical",
		})

		vim.api.nvim_set_keymap("n", "<leader>tt", "<Cmd>ToggleTerm<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("t", "<leader>tt", "<C-\\><C-n><Cmd>ToggleTerm<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap(
			"n",
			"<leader>tf",
			"<Cmd>ToggleTerm direction=float<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>th",
			"<Cmd>ToggleTerm direction=horizontal<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>tv",
			"<Cmd>ToggleTerm direction=vertical<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
	end,
}
