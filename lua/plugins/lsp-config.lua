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
    -- lsp = "bashls",
    formatter = "shfmt",
    -- diagnostics = "shellcheck",
  },
  docker = {
    lsp = "dockerls",
  },
  toml = {
    lsp = "taplo",
  },
  c = {
    lsp = "clangd",
    formatter = "clang-format",
    null_ls_formatter = "clang_format",
  },
  c_make = {
    lsp = "cmake",
    formatter = "cmakelang",
    null_ls_formatter = "cmake_format",
  },
  html = {
    lsp = "html",
  },
  unocss = {
    lsp = "unocss",
    filetypes = { 'rust', 'html', 'css' },
    root_dir = function(fname)
      return require 'lspconfig.util'.root_pattern('unocss.config.js', 'uno.config.js')(fname)
    end
  },
  htmx = {
    lsp = "htmx",
    filetypes = { 'rust', 'html' }
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
            root_dir = (servers[server] or {}).root_dir
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
      for _, name in ipairs(nullLsFormatters) do
        local builtin_name = name
        local formatter = null_ls.builtins.formatting[builtin_name]
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
      for _, name in ipairs(lspDiagnostics) do
        local builtin_name = name
        local diagnostics = null_ls.builtins.diagnostics[builtin_name]
        if name == "shellcheck" then
          table.insert(
            formatSources,
            diagnostics.with({
              filetypes = { "sh", "zsh" }, -- Replace with actual args
            })
          )
          -- elseif name == "" then
          -- 	table.insert(formatSources, diagnostics.with({ filetypes = { "sh", "zsh" } }))
        elseif diagnostics then
          table.insert(formatSources, diagnostics)
        else
          print("Formatter not found: " .. builtin_name)
        end
      end
      null_ls.setup({
        sources = formatSources,
      })
    end,
  },
}
