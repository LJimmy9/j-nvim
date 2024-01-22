require("nvim-dap-virtual-text").setup()
require("dapui").setup()

local dap, dapui = require("dap"), require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

vim.keymap.set("n", "<leader>br", ':DapToggleBreakpoint<CR>')
vim.keymap.set("n", "<leader>bt", ':DapUiToggle<CR>')
vim.keymap.set("n", "<leader>bd", ':RustLsp debuggables<CR>')
vim.keymap.set("n", "<leader>bl", ':RustLsp debuggables last<CR>')
vim.keymap.set("n", "<leader>bx", ':DapTerminate<CR>')
vim.keymap.set("n", "<leader>bo", ':DapStepOver<CR>')
