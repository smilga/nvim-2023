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
				anthropic = require("codecompanion.adapters").use("anthropic", {
					env = {
						api_key = "cmd:cat " .. home .. "/anthropic_api_key.txt",
					},
					schema = {
						model = {
							default = "claude-3-5-sonnet-20240620",
						},
					},
				}),
			},
			strategies = {
				chat = "anthropic",
				inline = "anthropic",
				tool = "anthropic",
			},
		})
	end,
}
