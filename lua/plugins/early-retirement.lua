return {
	"chrisgrieser/nvim-early-retirement",
	event = "VeryLazy",
	config = function()
		require("early-retirement").setup({
			retirementAgeMins = 15,
		})
	end,
}
