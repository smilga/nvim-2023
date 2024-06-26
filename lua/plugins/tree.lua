return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	tag = "nightly",
	config = function()
		require("nvim-tree").setup({
			git = {
				enable = true,
				ignore = false,
				timeout = 500,
			},
		})
	end,
}
