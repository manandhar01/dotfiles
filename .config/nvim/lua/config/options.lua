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

vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatBorder", { bg = "none" })

vim.fn.sign_define("DiagnosticSignError", { text = "✘", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "⚑", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
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
