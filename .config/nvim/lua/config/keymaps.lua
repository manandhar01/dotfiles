function ToggleWrap()
	if vim.wo.wrap then
		vim.wo.wrap = false
		print("Text wrapping disabled")
	else
		vim.wo.wrap = true
		print("Text wrapping enabled")
	end
end

function ToggleIgnoreCase()
	local ignorecase = vim.o.ignorecase

	if ignorecase then
		vim.o.ignorecase = false
		vim.o.smartcase = false
		print("Search is now case sensitive")
	else
		vim.o.ignorecase = true
		vim.o.smartcase = true
		print("Search is now case insensitive")
	end
end

vim.api.nvim_set_keymap("n", "<leader>tw", "<Cmd>lua ToggleWrap()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ic", "<Cmd>lua ToggleIgnoreCase()<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>w", ":w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>q", ":bd<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>y", ':let @+ = @"<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>h", ":nohlsearch<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "h", "h:nohlsearch<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "j:nohlsearch<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "k", "k:nohlsearch<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "l", "l:nohlsearch<CR>", { noremap = true, silent = true })
