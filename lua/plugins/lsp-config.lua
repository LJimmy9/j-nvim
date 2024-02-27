local servers = {
	lua = {
		lsp = "lua_ls",
		formatter = "stylua",
		filetypes = "lua",
	},
	ts = {
		lsp = "tsserver",
		formatter = "prettier",
	},
	go = {
		lsp = "gopls",
	},
	toml = {
		lsp = "taplo",
	},
	html = {
		lsp = "html",
	},
	-- htmx = {
	-- 	lsp = "htmx",
	-- 	filetypes = { "html" },
	-- },
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
local nullLsFormatters = extractValues(servers, "null_ls_formatter")
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
			capabilities.textDocument.foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			}
			for _, server in ipairs(lspServers) do
				if lspconfig[server] then
					lspconfig[server].setup({
						capabilities = capabilities,
						filetypes = (servers[server] or {}).filetypes,
						root_dir = (servers[server] or {}).root_dir,
					})
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

			for _key, values in pairs(servers) do
				if values.null_ls_formatter then
					local builtin_name = values.null_ls_formatter
					local formatter = null_ls.builtins.formatting[builtin_name]

					if values.filetypes then
						local custom_file_types = values.filetypes
						table.insert(formatSources, formatter.with({ filetypes = custom_file_types }))
					else
						table.insert(formatSources, formatter)
					end
				elseif values.formatter then
					local formatter_name = values.formatter
					local null_formatter = null_ls.builtins.formatting[formatter_name]
					table.insert(formatSources, null_formatter)
				end
			end
			null_ls.setup({
				sources = formatSources,
			})
		end,
	},
}
