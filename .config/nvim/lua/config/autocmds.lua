vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt.formatoptions:remove({ "c", "r", "o" })
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
})

local function get_project_root()
    local cwd = vim.fn.getcwd()
    local max_depth = 100
    local depth = 0

    while cwd ~= "/" and depth < max_depth do
        if vim.fn.isdirectory(cwd .. "/.git") == 1 then
            return vim.fn.fnamemodify(cwd, ":t")
        end
        cwd = vim.fn.fnamemodify(cwd, ":h")
        depth = depth + 1
    end
    return vim.fn.expand("%:p")
end

vim.api.nvim_create_autocmd({ "VimEnter" }, {
    pattern = "*",
    callback = function()
        vim.opt.titlestring = "nvim " .. get_project_root()
    end,
})

vim.api.nvim_create_augroup("LspDiagnosticsFloat", { clear = true })

vim.api.nvim_create_autocmd("CursorHold", {
    group = "LspDiagnosticsFloat",
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end,
})

-- organize typescript imports
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
    callback = function()
        local params = {
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(0) },
            title = "",
        }

        local clients = vim.lsp.get_active_clients({ bufnr = 0 })
        for _, client in ipairs(clients) do
            if client.name == "ts_ls" then
                vim.lsp.buf.execute_command(params)
                break
            end
        end
    end,
    desc = "Organize imports on save",
})
