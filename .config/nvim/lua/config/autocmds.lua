vim.api.nvim_set_hl(0, "Visual", { reverse = true })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})
