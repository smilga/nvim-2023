return {
	"catgoose/vue-goto-definition.nvim",
	ft = "vue",
	config = function()
		require("vue-goto-definition").setup()
	end,
}
