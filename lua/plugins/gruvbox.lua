return {
	"morhetz/gruvbox",
	config = function()
		vim.cmd.colorscheme("gruvbox")
		vim.g.background = "dark"
		vim.g.gruvbox_contrast_light = "hard"
	end,
}
