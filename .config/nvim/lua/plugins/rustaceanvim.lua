return {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    init = function()
        -- rustaceanvim reads its config from vim.g.rustaceanvim, which must be
        -- set before the plugin loads.
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
    end,
}
