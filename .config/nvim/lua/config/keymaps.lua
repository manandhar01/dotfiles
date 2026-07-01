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

-- opts plus a which-key description
local function d(desc)
    return vim.tbl_extend("force", opts, { desc = desc })
end

vim.keymap.set("n", "<leader>tw", "<Cmd>lua ToggleWrap()<CR>", d("Toggle text wrapping"))
vim.keymap.set("n", "<leader>ic", "<Cmd>lua ToggleIgnoreCase()<CR>", d("Toggle ignorecase/smartcase"))

vim.keymap.set("n", "<leader>w", ":wa<CR>", d("Save all buffers"))
vim.keymap.set("n", "<leader>y", ':let @+ = @"<CR>', d("Copy last yank to system clipboard"))

vim.keymap.set("n", "<Esc>", "<Cmd>noh<CR>", d("Clear search highlight"))

vim.keymap.set("n", "<C-h>", "<C-w>h", d("Go to left window"))
vim.keymap.set("n", "<C-j>", "<C-w>j", d("Go to lower window"))
vim.keymap.set("n", "<C-k>", "<C-w>k", d("Go to upper window"))
vim.keymap.set("n", "<C-l>", "<C-w>l", d("Go to right window"))

vim.keymap.set("n", "<C-a>", "<cmd>CodeCompanionActions<cr>", d("CodeCompanion actions"))
vim.keymap.set("v", "<C-a>", "<cmd>CodeCompanionActions<cr>", d("CodeCompanion actions"))
vim.keymap.set("n", "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", d("Toggle CodeCompanion chat"))
vim.keymap.set("v", "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", d("Toggle CodeCompanion chat"))
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", d("Add selection to CodeCompanion chat"))
vim.cmd([[cab cc CodeCompanion]])

vim.keymap.set("n", "<leader>ai", ":lua require('copilot.suggestion').toggle_auto_trigger()<cr>", d("Toggle Copilot auto-trigger"))

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<leader>q", function()
    local cur = vim.api.nvim_get_current_buf()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(buf) and buf ~= cur then
            vim.api.nvim_buf_delete(buf, {})
        end
    end
end, { desc = "Close all but current buffer" })
