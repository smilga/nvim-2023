return {
	"gbprod/nord.nvim",
	name = "nord",
	lazy = false,
	priority = 1000,
	config = function()
		require("nord").setup({
			transparent = false,
			diff = { mode = "fg" },
			on_highlights = function(highlights, colors)
				colors.polar_night.origin = "#2E3440"
				highlights["Normal"] = {
					bg = "#21252e",
				}
				highlights["SignColumn"] = {
					bg = "#21252e",
				}
				highlights["TelescopeBorder"] = {
					bg = "#21252e",
				}
				highlights["NormalFloat"] = {
					bg = "#21252e",
				}
				highlights["FloatBorder"] = {
					bg = "#21252e",
				}
			end,
		})
	end,
}
