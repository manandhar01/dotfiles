vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':bd<CR>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>h', ':nohlsearch<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'h', 'h:nohlsearch<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', 'j:nohlsearch<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'k:nohlsearch<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'l', 'l:nohlsearch<CR>', { noremap = true, silent = true })
