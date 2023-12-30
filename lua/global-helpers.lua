function LoadAll(modulePath)
  local config_path = vim.fn.stdpath("config") .. "/lua/" .. modulePath
  for _, file in ipairs(vim.fn.readdir(config_path, [[v:val =~ '\.lua$']])) do
    if file ~= "init.lua" then
      local path = modulePath .. "." .. file:gsub("%.lua$", "")
      require(path)
    end
  end
end

Keymap = vim.keymap.set

-- Takes in strings corresponding to vim commands
function RunCommands(commands)
  for _i, s in ipairs(commands) do
    vim.cmd(s)
  end
end

function ExtractValues(dict)
  local values = {}
  for _, value in pairs(dict) do
    table.insert(values, value)
  end
  return values
end
