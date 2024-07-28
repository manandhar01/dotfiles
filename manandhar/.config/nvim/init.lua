vim.cmd('source ~/.config/nvim/plugins.vim')

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.syntax = 'enable'
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.signcolumn = 'yes'
vim.opt.cursorline = true
vim.opt.cursorcolumn = true

vim.opt.formatoptions:remove({ 'c', 'r', 'o' })

function toggleRelativeNumber()
    if vim.wo.relativenumber then
        vim.wo.relativenumber = false
    else
        vim.wo.relativenumber = true
    end
end

vim.api.nvim_set_keymap('n', '<leader>n', ':lua toggleRelativeNumber()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })


-- ####### GRUVBOX MATERIAL START #######
vim.g.gruvbox_material_background = 'hard'
vim.g.gruvbox_material_disable_italic_comment = 0
vim.g.gruvbox_material_enable_italic = 1
vim.g.gruvbox_material_sign_column_background = 'grey'
vim.g.gruvbox_material_spell_foreground = 'colored'

vim.cmd([[colorscheme gruvbox-material]])
-- ####### GRUVBOX MATERIAL END #######


-- ####### AIRLINE START #######
vim.g.airline_powerline_fonts = 1
vim.g.airline_theme = 'gruvbox_material'

vim.g['airline#extensions#tabline#enabled'] = 1
vim.g['airline#extensions#tabline#show_tabs'] = 0
vim.g['airline#extensions#tabline#show_buffers'] = 0
vim.g['airline#extensions#tabline#show_tab_type'] = 1
vim.g['airline#extensions#fugitiveline#enabled'] = 1
-- ####### AIRLINE END #######


-- ####### NVIM-TREE START #######
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
    auto_reload_on_write = true,
    diagnostics = {
        enable = true,
        show_on_dirs = true,
    },
    filters = {
        dotfiles = false,
        custom = { "^.git$" },
    },
    git = {
        enable = true,
        ignore = false,
    },
    renderer = {
        group_empty = true,
        highlight_opened_files = "all",
        icons = {
            webdev_colors = true,
            git_placement = "before",
            show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
            },
        },
    },
    sort = {
        sorter = "case_sensitive",
    },
    update_cwd = true,
    update_focused_file = {
        enable = true,
        update_cwd = true,
    },
    view = {
        width = 30,
        side = 'left',
    },
})

vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>r', ':NvimTreeRefresh<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>f', ':NvimTreeFindFile<CR>', { noremap = true, silent = true })
-- ####### NVIM-TREE END #######


-- ####### NVIM TREESITTER START #######
require('nvim-treesitter.configs').setup({
    highlight = { enable = true },
    indent = { enable = true }
})
-- ####### NVIM TREESITTER END #######


-- ####### BLANKLINE START #######
local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require('ibl.hooks')

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require('ibl').setup({
    indent = { highlight = highlight },
})
-- ####### BLANKLINE START #######


-- ####### NVIM AUTOPAIRS START #######
require('nvim-autopairs').setup()
-- ####### NVIM AUTOPAIRS END #######


-- ####### TELESCOPE START #######
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local action_layout = require('telescope.actions.layout')

require('telescope').setup({
    defaults = {
        mappings = {
            n = {
                ["<M-p>"] = action_layout.toggle_preview,
                ["<C-s>"] = actions.cycle_previewers_next,
                ["<C-a>"] = actions.cycle_previewers_prev,
            },
            i = {
                ["<esc>"] = actions.close,
                ["<C-u>"] = false,
                ["<M-p>"] = action_layout.toggle_preview,
                ["<C-s>"] = actions.cycle_previewers_next,
                ["<C-a>"] = actions.cycle_previewers_prev,
            },
        },
    },

    pickers = {
        find_files = {
            file_ignore_patterns = { '%.git/', 'node_modules/' },
            find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        live_grep = {
            additional_args = function(opts)
                return { "--hidden" }
            end,
        },
    },
})


vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
-- ####### TELESCOPE END #######


-- ####### AUTO SESSION START #######
require('auto-session').setup()
-- ####### AUTO SESSION END #######


-- ####### DASHBOARD NVIM START #######
require('dashboard').setup()
-- ####### DASHBOARD NVIM START #######


-- ####### GITSIGNS START #######
require('gitsigns').setup()
-- ####### GITSIGNS END #######
