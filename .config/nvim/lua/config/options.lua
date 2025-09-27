vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.inccommand = "split"
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 10
vim.opt.syntax = "enable"
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.termguicolors = true
vim.opt.mousemoveevent = true
vim.opt.swapfile = false
vim.opt.title = true
vim.opt.titlelen = 0
vim.opt.titlestring = "nvim %{expand('%:p')}"
vim.wo.wrap = false
vim.g.vimtex_view_method = "zathura"
-- vim.g.vimtex_view_general_viewer = "evince"
-- vim.g.vimtex_view_general_options = "@pdf"
-- vim.g.vimtex_format_enabled = 1
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "vimtex#fold#level(v:lnum)"
vim.opt.foldtext = "vimtex#fold#text()"
vim.opt.foldlevel = 10
vim.opt.foldenable = false
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })

vim.api.nvim_set_hl(0, "Search", { bg = "#665c54", fg = "#cccccc", bold = true })
vim.api.nvim_set_hl(0, "IncSearch", { bg = "#8ec07c", fg = "#000000", bold = true })
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#32302f" })
vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#3c3836" })
vim.api.nvim_set_hl(0, "CursorLineNr", { bold = true })
vim.api.nvim_set_hl(0, "Visual", { bg = "#213842", fg = "NONE" })
vim.api.nvim_set_hl(0, "Cursor", { fg = "NONE", bg = "#83a598" })

vim.diagnostic.config({
    virtual_text = false,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN] = "⚑",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
    },
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "always",
        -- header = "",
        -- prefix = "",
        focusable = false,
        -- max_width = 60,
        close_events = {
            "BufLeave",
            "BufHidden",
            "InsertEnter",
            "CursorMoved",
            "CursorMovedI",
            "InsertCharPre",
            "LspAttach",
            "LspDetach",
            "WinLeave",
        },
    },
})

vim.schedule(function()
    vim.opt.clipboard = "unnamedplus"
end)

vim.g.rustaceanvim = {
    server = {
        default_settings = {
            ["rust-analyzer"] = {
                diagnostics = {
                    disabled = { "unlinked-file" },
                },
            },
        },
    },
}
