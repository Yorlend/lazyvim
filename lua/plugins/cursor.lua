return {
	"sphamba/smear-cursor.nvim",
	enabled = not vim.g.neovide,
	opts = {
		cursor_color = "#ebbcba", -- Rose Pine rose
		transparent_bg_fallback_color = "#191724", -- Rose Pine base
		stiffness = 0.78,
		trailing_stiffness = 0.6,
		damping = 0.95,
		gradient_exponent = 1.8,
		smear_insert_mode = false,
	},
}
