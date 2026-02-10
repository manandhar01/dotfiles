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

local diagnostic_float_group = vim.api.nvim_create_augroup("LspDiagnosticsFloat", { clear = true })

vim.api.nvim_create_autocmd("CursorHold", {
    group = diagnostic_float_group,
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end,
    desc = "Show diagnostic float on cursor hold",
})

-- organize typescript imports
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
    callback = function(args)
        local bufnr = args.buf
        local params = {
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(bufnr) },
        }

        local clients = vim.lsp.get_clients({ bufnr = bufnr })
        for _, client in ipairs(clients) do
            if client.name == "ts_ls" then
                local view = vim.fn.winsaveview()
                vim.lsp.buf_request_sync(bufnr, "workspace/executeCommand", params, 1000)
                vim.fn.winrestview(view)
                break
            end
        end

        require("conform").format({ bufnr = bufnr })
    end,
    desc = "Organize imports and format before save",
})

-- treesitter
vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local buf = args.buf
        local ft = vim.bo[buf].filetype

        if ft == "" or vim.bo[buf].buftype ~= "" then
            return
        end

        local ok, lang = pcall(vim.treesitter.language.get_lang, ft)
        if not ok or not lang then
            return
        end

        local ok_parser = pcall(vim.treesitter.get_parser, buf, lang)
        if not ok_parser then
            return
        end

        vim.treesitter.start(buf)
    end,
})
