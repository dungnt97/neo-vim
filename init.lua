-- ===== PERFORMANCE OPTIMIZATIONS =====
vim.loader.enable() -- Enable Lua module caching for faster startup
vim.g.loaded_netrw = 1 -- Disable netrw
vim.g.loaded_netrwPlugin = 1

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then  
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- ===== BASIC SETTINGS =====
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamed,unnamedplus"

-- Disable mouse scrolling for dashboard
vim.api.nvim_create_autocmd("FileType", {
  pattern = "alpha",
  callback = function()
    vim.opt_local.mouse = ""
    vim.opt_local.scrolloff = 0
    vim.opt_local.sidescrolloff = 0
  end
})

-- Disable optional providers to avoid health check warnings
vim.g.loaded_node_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.smoothscroll = true
vim.opt.laststatus = 3

-- ===== PLUGIN SETUP =====
require("lazy").setup({
  -- Performance settings
  performance = {
    cache = { enabled = true },
    reset_packpath = true,
    rtp = {
      disabled_plugins = {
        "gzip", "matchit", "matchparen", "netrwPlugin", "tarPlugin", "tohtml", "tutor", "zipPlugin"
      },
    },
  },
  
  -- Import all plugin configurations
  spec = require("plugins"),
})

-- ===== LOAD MODULES =====
-- Load TokenOptimizer
TokenOptimizer = require("token_optimizer")

-- Load keymaps
require("keymaps").setup()

-- Load dashboards
local dashboards = require("dashboards")

-- ===== DASHBOARD KEYMAPS =====
vim.keymap.set("n", "<leader>?", dashboards.show_help, { desc = "Show keymaps help" })
vim.keymap.set("n", "<leader>ai", dashboards.show_ai_dashboard, { desc = "Show AI tools dashboard" })
vim.keymap.set("n", "<leader>cost", dashboards.show_cost_info, { desc = "Show cost optimization info" })
vim.keymap.set("n", "<leader>setup", dashboards.show_setup_guide, { desc = "Show setup guide" })
vim.keymap.set("n", "<leader>theme", dashboards.show_theme_info, { desc = "Show theme information" })
vim.keymap.set("n", "<leader>tree", dashboards.show_neotree_help, { desc = "Show Neo-tree keymaps" })
vim.keymap.set("n", "<leader>window", dashboards.show_window_help, { desc = "Show window navigation guide" })
vim.keymap.set("n", "<leader>features", dashboards.show_features_info, { desc = "Show enhanced features info" })
vim.keymap.set("n", "<leader>health", dashboards.show_health_check, { desc = "AI tools health check" })

-- ===== AUTOCMDS (OPTIMIZED) =====
local augroup = vim.api.nvim_create_augroup("OptimizedConfig", { clear = true })

-- Auto format on save (essential files only) - LSP fallback
vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  pattern = { "*.lua", "*.py", "*.js", "*.jsx", "*.ts", "*.tsx", "*.json" },
  callback = function()
    if vim.bo.modified then 
      pcall(function() vim.lsp.buf.format({ timeout_ms = 1000 }) end)
    end
  end,
})

-- Auto save on focus lost
vim.api.nvim_create_autocmd("FocusLost", {
  group = augroup,
  pattern = "*",
  callback = function()
    if vim.bo.modified and not vim.bo.readonly then 
      pcall(function() vim.cmd("silent! write") end)
    end
  end,
})

-- Force syntax highlighting
vim.api.nvim_create_autocmd("BufEnter", {
  group = augroup,
  pattern = "*",
  callback = function()
    if vim.bo.filetype ~= "" then
      -- Force syntax highlighting
      vim.cmd("syntax on")
      -- Force treesitter highlighting
      pcall(function()
        require("nvim-treesitter.highlight").attach(0, vim.bo.filetype)
      end)
    end
  end,
})

-- ===== STARTUP NOTIFICATION =====
vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup,
  callback = function()
    vim.defer_fn(function()
      vim.schedule(function()
        vim.api.nvim_notify("⚡ DUNGNT's Ultimate Neovim Ready! (Claude 4 + Catppuccin)", vim.log.levels.INFO, { 
          title = "🚀 AI-Powered System Ready",
          timeout = 2000,
          position = "bottom_right"
        })
      end)
      
      -- Check Snacks UI handlers
      vim.defer_fn(function()
        if vim.ui.input and vim.ui.select then
          vim.notify("✅ Snacks UI handlers configured successfully", "info", { 
            timeout = 1000,
            position = "bottom_right"
          })
        else
          vim.notify("⚠️ Snacks UI handlers not configured - some features may not work", "warn", { 
            timeout = 2000,
            position = "bottom_right"
          })
        end
      end, 500)
      
      -- Check if Claude CLI is available
      vim.defer_fn(function()
        if vim.fn.executable('claude') == 0 then
          vim.notify("⚠️  Claude CLI not found. Run <leader>setup for installation guide.", "warn", {
            title = "Setup Required",
            timeout = 4000,
            position = "bottom_right"
          })
        end
      end, 1000)
    end, 100)
  end,
  once = true
})

print("🔥 Claude 4 Edition Neovim with Catppuccin theme setup complete! Ready for ultimate AI coding!") 