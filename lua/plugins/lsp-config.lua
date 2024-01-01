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
	terraform = {
		lsp = "terraformls",
	},
	shell = {
		lsp = "bashls",
		formatter = "shfmt",
		diagnostics = "shellcheck",
	},
}

local function extractValues(serverNames, key)
	local lspArr = {}
	for _, server in pairs(serverNames) do
		if server.lsp then
			table.insert(lspArr, server[key])
		end
	end
	return lspArr
end

local function mergeTables(a, b)
	for _, v in ipairs(b) do
		table.insert(a, v)
	end
end

local lspServers = extractValues(servers, "lsp")
local lspFormatters = extractValues(servers, "formatter")
local lspDiagnostics = extractValues(servers, "diagnostics")

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
		config = function()
			local packages = {}
			mergeTables(packages, lspFormatters)
			mergeTables(packages, lspDiagnostics)
			require("mason-null-ls").setup({ ensure_installed = packages })
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			local formatSources = {}
			for _, name in ipairs(lspFormatters) do
				local formatter = null_ls.builtins.formatting[name]
				if name == "shfmt" then
					table.insert(
						formatSources,
						formatter.with({
							filetypes = { "sh", "zsh" }, -- Replace with actual args
						})
					)
				elseif name == "" then
					table.insert(formatSources, formatter.with({ filetypes = { "sh", "zsh" } }))
				elseif formatter then
					table.insert(formatSources, formatter)
				else
					print("Formatter not found: " .. name)
				end
			end
			local diagnosticsSources = {}
			for _, name in ipairs(lspDiagnostics) do
				local diagnostics = null_ls.builtins.diagnostics[name]
				if name == "shellcheck" then
					table.insert(
						formatSources,
						diagnostics.with({
							filetypes = { "sh", "zsh" }, -- Replace with actual args
						})
					)
				elseif name == "" then
					table.insert(formatSources, diagnostics.with({ filetypes = { "sh", "zsh" } }))
				elseif diagnostics then
					table.insert(formatSources, diagnostics)
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
