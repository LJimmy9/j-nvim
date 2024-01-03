print("keybinds loaded")
-- GENERAL
Keymap("n", "H", "Hzz")
Keymap("n", "L", "Lzz")
Keymap("n", "<leader>so", function()
	RunCommands({ "w", "so" })
end)
Keymap("n", "<leader>er", ":NvimTreeToggle<CR>")
Keymap({ "n", "v" }, "<leader>nh", ":nohl<CR>")
Keymap("n", "<leader>lr", ":LspRestart<CR>")
Keymap("n", "<leader>qq", ":q<CR>")
Keymap("n", "<leader>vs", ":vs<CR>")
Keymap("n", "<leader>vv", ":tab split<CR>")
Keymap("n", "<leader>w", "<C-w>")

Keymap("v", "J", ":m '>1<CR>gv=gv")
Keymap("v", "K", ":m '<-2<CR>gv=gv")
Keymap({ "n", "v" }, "<leader>d", [["_d]])

Keymap("n", "<leader>gd", function()
	RunCommands({ ":normal *", ":nohl" })
	RunCommands({ ":normal zz" })
end)

Keymap("n", "<leader>ss", function()
	vim.lsp.buf.format()
	RunCommands({ "w" })
end)
-- GENERAL

-- Open command list
Keymap("n", "<leader>cl", ":<C-f>")

Keymap("i", "<C-l>", "<Right>")
Keymap("i", "<C-h>", "<Left>")

Keymap("v", "<leader>cw", ":s///g<Left><Left><Left>")

Keymap("n", "<leader>cd", ":cd %:p:h <CR>")
-- Open command list

-- LSP
Keymap("n", "gh", vim.diagnostic.open_float)
Keymap("n", "K", vim.lsp.buf.hover)
Keymap("n", "gd", vim.lsp.buf.definition)
Keymap("n", "<leader>ca", vim.lsp.buf.code_action)
Keymap("n", "<leader>rn", vim.lsp.buf.rename)
Keymap("n", "<leader>gr", "<cmd>Telescope lsp_references<CR>")
-- LSP

-- TELESCOPE
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>fj", function()
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		previewer = false,
	}))
end)
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fs", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

vim.keymap.set("n", "<leader>ft", function()
	RunCommands({ "TodoTelescope" })
end)
-- TELESCOPE

-- TOGGLE TERM
Keymap("t", "<esc>", [[<C-\><C-n>]])
Keymap("n", "<leader>1", ":ToggleTerm1<CR>")
Keymap("n", "<leader>2", ":ToggleTerm2<CR>")
Keymap("n", "<leader>tt", ":ToggleTermToggleAll")
-- TOGGLE TERM

--  TODO
Keymap("n", "]t", function()
	require("todo-comments").jump_next()
end, { desc = "Next todo comment" })
Keymap("n", "<leader>ft", function()
	RunCommands({ "TodoTelescope" })
end)

Keymap("n", "[t", function()
	require("todo-comments").jump_prev()
end, { desc = "Previous todo comment" })
--  TODO

-- LUASNIP
Keymap({ "n", "v" }, "<leader>le", require("luasnip.loaders").edit_snippet_files)
Keymap({ "n", "v" }, "<leader>ls", "<cmd>source ~/.config/nvim/lua/plugins/luasnip.lua<CR>")
-- LUASNIP

Keymap("n", "<Esc>[17;5u", "<Nop>", { noremap = true, silent = true })

function _G.send_line_to_terminal()
	local line = vim.fn.getline(".")
	-- Replace single quotes with double quotes
	line = line:gsub("'", '"')
	-- Use double quotes for the cmd part
	local cmd = "TermExec cmd='" .. line .. "'"

	vim.cmd(cmd)
end

vim.api.nvim_create_user_command("SendLineToTerminal", send_line_to_terminal, {})

Keymap("n", "<leader>sl", ":SendLineToTerminal<CR>", { noremap = true, silent = true })
