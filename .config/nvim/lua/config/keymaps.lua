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

local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<leader>tw", "<Cmd>lua ToggleWrap()<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>ic", "<Cmd>lua ToggleIgnoreCase()<CR>", opts)

vim.api.nvim_set_keymap("n", "<leader>w", ":wa<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>q", ":%bd|e#<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>y", ':let @+ = @"<CR>', opts)

vim.api.nvim_set_keymap("n", "<Esc>", "<Cmd>noh<CR>", opts)

vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", opts)
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", opts)
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", opts)
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", opts)

vim.api.nvim_set_keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
