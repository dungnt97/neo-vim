-- Main plugins configuration file
-- This file imports and combines all plugin modules

local plugins = {}

-- Import all plugin modules
local plugin_modules = {
  "ai",
  "editor", 
  "git",
  "session",
  "ui"
}

-- Combine all plugin configurations
for _, module_name in ipairs(plugin_modules) do
  local success, module_plugins = pcall(require, "plugins." .. module_name)
  if success then
    -- If the module returns a table, extend the plugins table
    if type(module_plugins) == "table" then
      for _, plugin in ipairs(module_plugins) do
        table.insert(plugins, plugin)
      end
    end
  else
    vim.notify("Failed to load plugin module: " .. module_name, "error", {
      position = "bottom_right"
    })
  end
end

return plugins 