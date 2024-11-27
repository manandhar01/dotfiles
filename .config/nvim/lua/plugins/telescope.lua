return {
	"nvim-telescope/telescope.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	config = function()
		local builtin = require("telescope.builtin")
		local actions = require("telescope.actions")
		local action_layout = require("telescope.actions.layout")

		require("telescope").setup({
			defaults = {
				mappings = {
					n = {
						["<M-p>"] = action_layout.toggle_preview,
						["<C-s>"] = actions.cycle_previewers_next,
						["<C-a>"] = actions.cycle_previewers_prev,
					},
					i = {
						["<esc>"] = actions.close,
						["<C-u>"] = false,
						["<M-p>"] = action_layout.toggle_preview,
						["<C-s>"] = actions.cycle_previewers_next,
						["<C-a>"] = actions.cycle_previewers_prev,
					},
				},
			},

			pickers = {
				find_files = {
					file_ignore_patterns = { "%.git/", "node_modules/" },
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
				},
				live_grep = {
					file_ignore_patterns = { "%.git/", "node_modules/" },
					additional_args = function()
						return { "--hidden" }
					end,
				},
			},
		})

		vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
	end,
}
