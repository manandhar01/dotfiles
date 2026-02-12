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

vim.keymap.set("n", "gg", "gg0", opts)
vim.keymap.set("n", "G", "G$", opts)
vim.keymap.set("v", "gg", "gg0", opts)
vim.keymap.set("v", "G", "G$", opts)

vim.keymap.set("n", "<leader>tw", "<Cmd>lua ToggleWrap()<CR>", opts)
vim.keymap.set("n", "<leader>ic", "<Cmd>lua ToggleIgnoreCase()<CR>", opts)

vim.keymap.set("n", "<leader>w", ":wa<CR>", opts)
vim.keymap.set("n", "<leader>y", ':let @+ = @"<CR>', opts)

vim.keymap.set("n", "<Esc>", "<Cmd>noh<CR>", opts)

vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

vim.keymap.set("n", "<C-a>", "<cmd>CodeCompanionActions<cr>", opts)
vim.keymap.set("v", "<C-a>", "<cmd>CodeCompanionActions<cr>", opts)
vim.keymap.set("n", "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", opts)
vim.keymap.set("v", "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", opts)
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", opts)
vim.cmd([[cab cc CodeCompanion]])

vim.keymap.set("n", "<leader>ai", ":lua require('copilot.suggestion').toggle_auto_trigger()<cr>", opts)

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<leader>q", function()
    local cur = vim.api.nvim_get_current_buf()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and buf ~= cur then
            vim.api.nvim_buf_delete(buf, {})
        end
    end
end, { desc = "Close all but current buffer" })
