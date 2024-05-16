return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim", -- Optional
		{
			"stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
			opts = {},
		},
	},
	config = function()
		local home = vim.fn.expand("$HOME")
		require("codecompanion").setup({
			adapters = {
				openai = require("codecompanion.adapters").use("openai", {
					env = {
						api_key = "cmd:cat " .. home .. "/open_api_key.txt",
					},
				}),
				strategies = {
					chat = "openai",
					inline = "openai",
				},
			},
		})
	end,
}
