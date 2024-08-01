return { 
	'nvim-treesitter/nvim-treesitter',
	config = function()

		local treesitter = require("nvim-treesitter.configs").setup(
		{
			highlight = { enable = true },
			indent = { enable = true }
		}
		)
	end
}
