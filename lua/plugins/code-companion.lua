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
				anthropic = function()
					return require("codecompanion.adapters").extend("anthropic", {
						env = {
							api_key = "cmd:cat " .. home .. "/anthropic_api_key.txt",
						},
					})
				end,
			},
			strategies = {
				chat = "anthropic",
				inline = "anthropic",
				tool = "anthropic",
			},
		})
	end,
}
