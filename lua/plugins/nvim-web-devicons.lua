return {
	"nvim-tree/nvim-web-devicons",
	config = function()
		local nwd = require("nvim-web-devicons")
		nwd.setup({
			-- same as `override` but specifically for overrides by extension
			override_by_extension = {
				["toml"] = {
					icon = "󰰦",
					color = "#ffffff",
					cterm_color = "231",
				},
			},
		})
	end,
}
