return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim", config = true },
        "williamboman/mason-lspconfig.nvim",
        { "j-hui/fidget.nvim", opts = {} },
    },

    config = function()
        local lspconfig = require("lspconfig")

        local function organize_imports()
            local params = {
                command = "_typescript.organizeImports",
                arguments = { vim.api.nvim_buf_get_name(0) },
                title = "",
            }
            vim.lsp.buf.execute_command(params)
        end

        lspconfig.ts_ls.setup({
            init_options = {
                preferences = {
                    importModuleSpecifierPreference = "relative",
                    importModuleSpecifierEnding = "minimal",
                },
            },

            capabilities = require("cmp_nvim_lsp").default_capabilities(),

            commands = {
                OrganizeImports = {
                    organize_imports,
                    description = "Organize Imports",
                },
            },
        })

        lspconfig.lua_ls.setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })

        lspconfig.bashls.setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })

        lspconfig.css_variables.setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })

        lspconfig.cssls.setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })

        lspconfig.texlab.setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })

        lspconfig.gopls.setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
            callback = function(event)
                local map = function(keys, func, desc, mode)
                    mode = mode or "n"
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
                map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                map("K", vim.lsp.buf.hover, "")

                map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
                map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
                map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
                map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

                -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                -- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                -- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                -- vim.keymap.set('n', '<space>wl', function()
                --     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                -- end, opts)
                -- vim.keymap.set('n', '<space>f', function()
                --     vim.lsp.buf.format { async = true }
                -- end, opts)
            end,
        })
    end,
}
