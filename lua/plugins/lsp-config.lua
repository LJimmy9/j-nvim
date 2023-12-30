local servers = {
	lua = {
		lsp = "lua_ls",
		formatter = "stylua",
	},
	ts = {
		lsp = "tsserver",
		formatter = "prettier",
	},
	go = {
		lsp = "gopls",
	},
}

local function extractLspValues(serverNames)
	local lspArr = {}
	for _, server in pairs(serverNames) do
		if server.lsp then
			table.insert(lspArr, server.lsp)
		end
	end
	return lspArr
end

local function extractFormatterValues(serverNames)
	local formatterArr = {}
	for _, server in pairs(serverNames) do
		if server.formatter then
			table.insert(formatterArr, server.formatter)
		end
	end
	return formatterArr
end

local lspServers = extractLspValues(servers)
local lspFormatters = extractFormatterValues(servers)

return {
	{
		"williamboman/mason.nvim",
		config = {},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = lspServers,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			for _, server in ipairs(lspServers) do
				if lspconfig[server] then
					lspconfig[server].setup({ capabilities = capabilities })
				else
					print("LSP configuration for " .. server .. " not found.")
				end
			end
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		config = { ensure_installed = lspFormatters },
	},
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			local formatSources = {}
			for _, name in ipairs(lspFormatters) do
				local formatter = null_ls.builtins.formatting[name]
				if formatter then
					table.insert(formatSources, formatter)
				else
					print("Formatter not found: " .. name)
				end
			end
			null_ls.setup({
				sources = formatSources,
			})
		end,
	},
}
