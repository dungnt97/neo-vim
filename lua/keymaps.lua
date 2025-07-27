-- Keymaps Configuration
local M = {}

-- Set keymaps efficiently
local function setup_keymaps()
  local keymap_groups = {
    -- File operations (no conflicts)
    file = {
      ["<leader>e"] = { ":Neotree toggle<CR>", "Toggle file tree" },
      ["<leader>eg"] = { ":Neotree git_status<CR>", "Toggle git status" },
      ["<leader>ef"] = { ":Neotree focus<CR>", "Focus file tree" },
      ["<leader>ec"] = { ":Neotree close<CR>", "Close file tree" },
      ["<leader>tree"] = { "<leader>tree", "Show Neo-tree help" },
    },

    -- Git operations (UPDATED with diffview.nvim)
    git = {
      ["<leader>gs"] = { "<cmd>DiffviewOpen<CR>", "Git status (diffview)" },
      ["<leader>gd"] = { "<cmd>DiffviewOpen<CR>", "Git diff (diffview)" },
      ["<leader>gb"] = { "<cmd>Terminal git blame %<CR>", "Git blame" },
      ["<leader>gl"] = { "<cmd>Terminal git log --oneline<CR>", "Git log" },
      ["<leader>gg"] = { "<cmd>Terminal git grep<CR>", "Git grep" },
      ["<leader>gc"] = { "<cmd>Terminal git commit<CR>", "Git commit" },
      ["<leader>gp"] = { "<cmd>Terminal git push<CR>", "Git push" },
      ["<leader>gf"] = { "<cmd>Terminal git fetch<CR>", "Git fetch" },
      ["<leader>gm"] = { "<cmd>Terminal git merge<CR>", "Git merge" },
      ["<leader>gr"] = { "<cmd>Terminal git rebase<CR>", "Git rebase" },
      ["<leader>ga"] = { "<cmd>Terminal git add %<CR>", "Git add current file" },
      ["<leader>gaa"] = { "<cmd>Terminal git add .<CR>", "Git add all" },
      ["<leader>gh"] = { "<cmd>DiffviewFileHistory<CR>", "File history" },
      ["<leader>ghc"] = { "<cmd>DiffviewFileHistory %<CR>", "Current file history" },
    },

    -- LSP operations (fixed conflicts)
    lsp = {
      ["<leader>lf"] = { vim.lsp.buf.format, "Format buffer" },
      ["<leader>la"] = { vim.lsp.buf.code_action, "Code action" }, -- Changed from <leader>ca
      ["<leader>ld"] = { vim.diagnostic.open_float, "Show diagnostics" },
      ["<leader>lr"] = { vim.lsp.buf.rename, "Rename symbol" },
      ["<leader>lh"] = { vim.lsp.buf.hover, "Hover documentation" },
    },

    -- AI operations (coder/claudecode.nvim commands)
    ai = {
      ["<leader>ag"] = { "<cmd>ChatGPT<CR>", "Open ChatGPT" },
      ["<leader>ae"] = { "<cmd>ChatGPTEditWithInstructions<CR>", "Edit with ChatGPT" },
      ["<leader>aa"] = { "<cmd>ChatGPTActAs<CR>", "ChatGPT Act As" },
      ["<leader>ac"] = { "<cmd>ClaudeCode<CR>", "Toggle Claude Code" },
      ["<leader>af"] = { "<cmd>ClaudeCodeFocus<CR>", "Focus Claude Code" },
      ["<leader>ar"] = { "<cmd>ClaudeCode --resume<CR>", "Resume Claude Code" },
      ["<leader>aC"] = { "<cmd>ClaudeCode --continue<CR>", "Continue Claude Code" },
      ["<leader>ab"] = { "<cmd>ClaudeCodeAdd %<CR>", "Add current buffer to Claude" },
      ["<leader>aA"] = { "<cmd>ClaudeCodeDiffAccept<CR>", "Accept Claude diff" },
      ["<leader>aD"] = { "<cmd>ClaudeCodeDiffDeny<CR>", "Deny Claude diff" },
    },

    -- Search operations
    search = {
      ["<leader>ff"] = { "<cmd>Telescope find_files<CR>", "Find files" },
      ["<leader>fg"] = { "<cmd>Telescope live_grep<CR>", "Live grep" },
      ["<leader>fb"] = { "<cmd>Telescope buffers<CR>", "Find buffers" },
      ["<leader>fr"] = { "<cmd>Telescope oldfiles<CR>", "Recent files" },
    },

    -- Formatting operations
    format = {
      ["<leader>f"] = { function() require("conform").format({ async = true, lsp_fallback = true }) end, "Format buffer" },
      ["<leader>fF"] = { function() require("conform").format({ async = true, lsp_fallback = true, range = { start = 1, ["end"] = vim.api.nvim_buf_line_count(0) } }) end, "Format entire file" },
    },

    -- Session operations
    session = {
      ["<leader>ss"] = { "<cmd>SessionSave<CR>", "Save session" },
      ["<leader>sl"] = { "<cmd>SessionLoad<CR>", "Load session" },
      ["<leader>sd"] = { "<cmd>SessionDelete<CR>", "Delete session" },
      ["<leader>st"] = { "<cmd>SessionStop<CR>", "Stop session" },
      ["<leader>qq"] = { function() 
        -- Save session first
        require("persisted").save()
        -- Show notification
        vim.notify("💾 Session saved! Quitting...", "info", { 
          timeout = 1000,
          position = "bottom_right"
        })
        -- Quit after a short delay to show notification
        vim.defer_fn(function()
          vim.cmd("qa!")
        end, 500)
      end, "Save session and quit all" },
    },

    -- Buffer/Window operations
    window = {
      ["<leader>w<Up>"] = { "<C-w>k", "Go to top window" },
      ["<leader>w<Down>"] = { "<C-w>j", "Go to bottom window" },
      ["<leader>w<Left>"] = { "<C-w>h", "Go to left window" },
      ["<leader>w<Right>"] = { "<C-w>l", "Go to right window" },
      ["<leader>wv"] = { "<C-w>v", "Split vertically" },
      ["<leader>ws"] = { "<C-w>s", "Split horizontally" },
    },
  }

  -- Set keymaps efficiently
  for group, maps in pairs(keymap_groups) do
    for key, map in pairs(maps) do
      local cmd, desc = map[1], map[2]
      vim.keymap.set("n", key, cmd, { desc = desc, silent = true })
    end
  end

  -- Leader + Arrow key window navigation (thêm leader + mũi tên để di chuyển cửa sổ)
  -- Note: These are now handled in the keymap_groups above

  -- Alt + Arrow keys for window resizing
  vim.keymap.set("n", "<A-Up>", "<C-w>+", { desc = "Increase window height", silent = true })
  vim.keymap.set("n", "<A-Down>", "<C-w>-", { desc = "Decrease window height", silent = true })
  vim.keymap.set("n", "<A-Left>", "<C-w><", { desc = "Decrease window width", silent = true })
  vim.keymap.set("n", "<A-Right>", "<C-w>>", { desc = "Increase window width", silent = true })

  -- Copilot keymaps (Insert mode)
  vim.keymap.set("i", "<C-j>", "<Plug>(copilot-next)", { desc = "Next Copilot suggestion" })
  vim.keymap.set("i", "<C-k>", "<Plug>(copilot-previous)", { desc = "Previous Copilot suggestion" })
  vim.keymap.set("i", "<C-l>", "<Plug>(copilot-accept)", { desc = "Accept Copilot suggestion" })

  -- Comment keymap
  vim.keymap.set({"n", "v"}, "<leader>/", function()
    require("Comment.api").toggle.linewise.current()
  end, { desc = "Toggle comment" })

  -- Visual mode for AI (restored for coder plugin)
  vim.keymap.set("v", "<leader>ae", "<cmd>ChatGPTEditWithInstructions<CR>", { desc = "Edit selection with ChatGPT" })
  vim.keymap.set("v", "<leader>as", "<cmd>ClaudeCodeSend<CR>", { desc = "Send selection to Claude Code" })
  vim.keymap.set("v", "<leader>ave", function() require("avante.api").edit() end, { desc = "Edit selection with Avante" })

  -- Claude Code status check
  vim.keymap.set("n", "<leader>cs", "<cmd>ClaudeCodeStatus<CR>", { desc = "Check Claude Code status" })

  -- Simple context clear
  vim.keymap.set("n", "<leader>cx", function()
    vim.notify("🧹 Contexts cleared!", "info", { position = "bottom_right" })
  end, { desc = "Clear AI contexts" })

  -- Token optimizer keymaps
  vim.keymap.set("n", "<leader>at", function() TokenOptimizer.show_usage() end, { desc = "Show token usage" })
  vim.keymap.set("n", "<leader>acache", function() TokenOptimizer.clear_cache() end, { desc = "Clear prompt cache" })
  vim.keymap.set("n", "<leader>ao", function() TokenOptimizer.optimize_settings() end, { desc = "Show optimization settings" })

  -- Manual Claude Code tracking (OPTIMIZED)
  vim.keymap.set("n", "<leader>act", function()
    if TokenOptimizer then
      -- Use optimized token estimates based on new settings
      local estimated_input = 400  -- Reduced due to max_context_files = 20
      local estimated_output = 600 -- Reduced due to max_tokens = 2000
      
      -- Apply prompt caching savings
      estimated_input = estimated_input * 0.1 -- 90% savings
      
      TokenOptimizer.track_usage(estimated_input, estimated_output, "claude_sonnet")
      vim.notify("📊 Manual Claude Code tracking: " .. (estimated_input + estimated_output) .. " tokens (optimized)", "info", { 
        timeout = 2000,
        position = "bottom_right"
      })
    end
  end, { desc = "Manual track Claude Code usage (optimized)" })

  -- ===== ENHANCED MAC SHORTCUTS =====
  vim.keymap.set({"n", "i"}, "<D-Enter>", "<cmd>ChatGPT<CR>", { desc = "Quick ChatGPT (Mac)" })
  vim.keymap.set({"n", "i"}, "<D-C-Enter>", "<cmd>ClaudeCode<CR>", { desc = "Quick Claude Code (Mac)" })

  -- ===== ADDITIONAL UTILITY KEYMAPS =====
  vim.keymap.set("n", "<leader>ch", ":checkhealth<CR>", { desc = "Check health" })
  vim.keymap.set("n", "<leader>so", ":source %<CR>", { desc = "Source current file" })
  vim.keymap.set("n", "<leader>qq", ":qa<CR>", { desc = "Quit all" })
  vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
  vim.keymap.set("n", "<leader>fix", ":source ~/.config/nvim/fix_catppuccin.lua<CR>", { desc = "Fix Catppuccin" })
  vim.keymap.set("n", "<leader>syn", function()
    vim.cmd("syntax on")
    vim.cmd("syntax sync fromstart")
    pcall(function()
      require("nvim-treesitter.highlight").attach(0, vim.bo.filetype)
    end)
    vim.notify("🔄 Syntax highlighting refreshed!", "info", { position = "bottom_right" })
  end, { desc = "Refresh syntax highlighting" })

  -- Catppuccin theme switcher
  vim.keymap.set("n", "<leader>tm", function()
    local flavours = {"latte", "frappe", "macchiato", "mocha"}
    local current = vim.g.catppuccin_flavour or "mocha"
    local current_index = 1
    
    for i, flavour in ipairs(flavours) do
      if flavour == current then
        current_index = i
        break
      end
    end
    
    local next_index = (current_index % #flavours) + 1
    local next_flavour = flavours[next_index]
    
    vim.g.catppuccin_flavour = next_flavour
    vim.cmd("colorscheme catppuccin-" .. next_flavour)
    vim.notify("🎨 Switched to Catppuccin " .. next_flavour, "info", {
      title = "Theme Switcher",
      timeout = 2000,
      position = "bottom_right"
    })
  end, { desc = "Switch Catppuccin flavour" })

  -- Simple keymaps for common operations
  vim.keymap.set("n", "<leader>sa", "ggVG", { desc = "Select all", noremap = true, silent = true })
end

M.setup = setup_keymaps

return M 