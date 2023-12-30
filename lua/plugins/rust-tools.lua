return {
	"simrat39/rust-tools.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		"nvim-lua/plenary.nvim",
		"mfussenegger/nvim-dap",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		require("rust-tools").setup({
			server = {
				on_attach = function(_, bufnr)
					print("attaching")
				end,
				capabilities = capabilities,
			},
		})
	end,
}
