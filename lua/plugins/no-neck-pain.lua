return {
	"shortcuts/no-neck-pain.nvim",
	config = function()
		require("no-neck-pain").setup({
			buffers = {
				right = {
					enabled = false,
				},
			},
		})
	end,
}
