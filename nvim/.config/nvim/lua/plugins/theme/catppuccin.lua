return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			-- transparent_background = true,
			auto_integrations = true,
			dim_inactive = {
				enabled = true, -- dims the background color of inactive window
				percentage = 0.15, -- percentage of the shade to apply to the inactive window
			},
			custom_highlights = function(colors)
				return {
					CursorLine = { underline = true },
					CursorLineNr = { underline = true },
				}
			end
		})
		vim.cmd.colorscheme "catppuccin-mocha"
	end,
}
