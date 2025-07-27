-- Plugin Configuration Entry Point
-- This file imports all plugin configurations from separate files

local plugins = {}

-- Import all plugin configurations
local plugin_files = {
  "ai",      -- AI tools (ChatGPT, Claude Code, Avante, Copilot)
  "ui",      -- UI & Theme (Catppuccin, Dashboard, Statusline, Notifications)
  "editor",  -- Editor tools (File explorer, Telescope, Treesitter, LSP, Autocomplete)
  "git",     -- Git tools (vim-fugitive, gitsigns)
  "session", -- Session management
}

for _, file in ipairs(plugin_files) do
  local success, plugin_list = pcall(require, "plugins." .. file)
  if success then
    for _, plugin in ipairs(plugin_list) do
      table.insert(plugins, plugin)
    end
  else
    vim.notify("Failed to load plugin configuration: " .. file, "error")
  end
end

return plugins 