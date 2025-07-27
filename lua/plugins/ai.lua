-- AI Tools Configuration
return {
  -- ChatGPT.nvim (Working configuration)
  {
    "jackMort/ChatGPT.nvim",
    cmd = { "ChatGPT", "ChatGPTEditWithInstructions", "ChatGPTActAs" },
    keys = {
      { "<leader>ag", "<cmd>ChatGPT<CR>", desc = "Open ChatGPT" },
      { "<leader>ae", "<cmd>ChatGPTEditWithInstructions<CR>", desc = "Edit with ChatGPT", mode = {"n", "v"} },
      { "<D-Enter>", "<cmd>ChatGPT<CR>", desc = "Open ChatGPT (Mac)" },
    },
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    config = function()
      require("chatgpt").setup({
        api_key_cmd = "echo $OPENAI_API_KEY",
        openai_params = {
          model = "gpt-4", -- Use GPT-4 (cheaper than GPT-4 Turbo)
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 1500, -- Reduced from 4096 to save costs
          temperature = 0.3, -- Lower temperature for more consistent responses
          top_p = 1,
          n = 1,
        },
        -- Token tracking integration
        on_response = function(response)
          if TokenOptimizer and response.usage then
            TokenOptimizer.track_usage(
              response.usage.prompt_tokens or 0,
              response.usage.completion_tokens or 0,
              "gpt4"
            )
          end
        end,
        openai_edit_params = {
          model = "gpt-4",
          temperature = 0.2, -- Even lower for editing tasks
          top_p = 1,
          n = 1,
          max_tokens = 1000, -- Reduced for editing tasks
        },
        -- Token tracking for edit operations
        on_edit_response = function(response)
          if TokenOptimizer and response.usage then
            TokenOptimizer.track_usage(
              response.usage.prompt_tokens or 0,
              response.usage.completion_tokens or 0,
              "gpt4"
            )
          end
        end,
        chat = {
          max_line_length = 80, -- Shorter lines to reduce token usage
          keymaps = {
            close = { "<C-c>" },
            yank_last = "<C-y>",
            yank_last_code = "<C-k>",
            scroll_up = "<C-u>",
            scroll_down = "<C-d>",
            new_session = "<C-n>",
            cycle_windows = "<Tab>",
            select_session = "<C-s>",
            rename_session = "r",
            delete_session = "d",
            submit = "<C-Enter>",
          },
        },
        popup_layout = {
          default = "center",
          center = {
            width = "70%", -- Reduced from 80% to save screen space
            height = "70%", -- Reduced from 80%
          },
        },
        popup_window = {
          border = { style = "rounded", text = { top = " ChatGPT (Cost Optimized) " } },
        },
        popup_input = {
          prompt = "  ",
          submit = "<C-Enter>",
        },
      })
    end
  },

  -- Claude Code (coder/claudecode.nvim - SIMPLIFIED VERSION)
  {
    "coder/claudecode.nvim",
    cmd = { "ClaudeCode", "ClaudeCodeFocus", "ClaudeCodeAdd", "ClaudeCodeSend", "ClaudeCodeDiffAccept", "ClaudeCodeDiffDeny" },
    dependencies = { "folke/snacks.nvim" },
    config = function()
      require("claudecode").setup({
        -- Basic Configuration
        port_range = { min = 10000, max = 65535 },
        auto_start = true,
        log_level = "info",
        
        -- 🎯 COST OPTIMIZATION SETTINGS (Added)
        -- Model Configuration
        model = "claude-sonnet-4-20250514", -- Use Claude 4 Sonnet (cheaper than Opus)
        
        -- Token Limits
        max_tokens = 2000, -- Reduced for cost optimization
        
        -- Temperature Settings
        temperature = 0.3, -- Lower temperature for consistency
        
        -- Prompt Caching (90% savings)
        enable_prompt_caching = true, -- Enable prompt caching for 90% savings
        
        -- Auto Suggestions (Cost Saving)
        auto_suggestions = false, -- Disable auto suggestions to save cost
        
        -- Context Management
        max_context_files = 20, -- Limit context files to save tokens
        auto_clear_context = true, -- Auto clear context to prevent accumulation
        
        -- Response Optimization
        max_line_length = 80, -- Shorter lines to reduce token usage
        compact_responses = true, -- Use compact response format
        
        -- UI Optimization
        show_hints = false, -- Disable hints to save tokens
        show_usage_stats = true, -- Show token usage in UI
        
        -- Performance Settings
        lazy_loading = true, -- Enable lazy loading for faster startup
        cache_responses = true, -- Cache responses to reduce API calls
        
        -- Terminal Configuration
        terminal = {
          split_side = "right",
          split_width_percentage = 0.30,
          provider = "snacks",
          auto_close = true,
        },
        
        -- Diff Integration
        diff_opts = {
          auto_close_on_accept = true,
          vertical_split = true,
          open_in_current_tab = true,
        },
      })
      
      -- Optimized token tracking with prompt caching
      local function track_claude_usage()
        if TokenOptimizer then
          -- Use optimized token estimates based on new settings
          local estimated_input = 400  -- Reduced due to max_context_files = 20
          local estimated_output = 600 -- Reduced due to max_tokens = 2000
          
          -- Apply prompt caching savings if enabled
          if true then -- enable_prompt_caching = true
            estimated_input = estimated_input * 0.1 -- 90% savings
          end
          
          TokenOptimizer.track_usage(estimated_input, estimated_output, "claude_sonnet")
          vim.notify("📊 Claude Code usage tracked: " .. (estimated_input + estimated_output) .. " tokens (optimized)", "info", { 
            timeout = 2000,
            position = "bottom_right"
          })
        end
      end
      
      -- Hook into Claude Code events
      vim.api.nvim_create_autocmd("User", {
        pattern = "ClaudeCodeStarted",
        callback = function()
          vim.notify("⚡ Claude Code started!", "info", { 
          timeout = 2000,
          position = "bottom_right"
        })
        end
      })
      
      vim.api.nvim_create_autocmd("User", {
        pattern = "ClaudeCodeResponse",
        callback = track_claude_usage
      })
    end,
  },

  -- Snacks.nvim (Required for Claude Code - OPTIMIZED)
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000, -- Fixed: Increased priority to 1000
    config = function()
      require("snacks").setup({
        -- Terminal configuration for Claude Code compatibility
        terminal = {
          split_side = "right",
          split_width_percentage = 0.30,
          auto_close = true,
        },
        -- Enable image features for supported terminals
        image = { 
          enabled = true, -- Enable image features for kitty/wezterm
          fallback_to_text = true, -- Fallback to text if not supported
          -- Use magick instead of deprecated convert command
          magick_command = "magick",
        },
        -- Enable only essential features
        bigfile = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        input = { enabled = true }, -- Enable input functionality
        picker = { enabled = true }, -- Enable picker functionality
        dashboard = { enabled = false }, -- Disable dashboard to avoid setup errors
        explorer = { enabled = true }, -- Enable explorer
        scope = { enabled = true }, -- Enable scope
        scroll = { enabled = true }, -- Enable scroll
        -- Window handling optimized for Claude Code
        win = {
          backdrop = false,
          keys = { q = "close" },
        },
      })
      
      -- Set up Snacks UI handlers with defer to ensure plugin is loaded
      vim.defer_fn(function()
        local snacks = require("snacks")
        if snacks and snacks.input and snacks.picker then
          vim.ui.input = snacks.input.input
          vim.ui.select = snacks.picker.select
        end
        

      end, 100)
    end
  },

  -- Avante.nvim (UPDATED to Claude 4 Sonnet)
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Never set this to "*" 
    build = "make", -- Use 'make' as per official docs
    keys = {
      { "<leader>av", function() require("avante.api").ask() end, desc = "Avante: ask", mode = { "n", "v" } },
      { "<leader>ave", function() require("avante.api").edit() end, desc = "Avante: edit", mode = { "n", "v" } },
      { "<leader>avr", function() require("avante.api").refresh() end, desc = "Avante: refresh", mode = "v" },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
              -- nvim-web-devicons is configured separately in ui.lua
        -- copilot.lua is configured separately
      {
        -- support for image pasting (FIXED)
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings with terminal compatibility
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true (FIXED)
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
          -- Disable LaTeX rendering if not available
          latex = {
            enabled = false, -- Disable LaTeX to avoid missing tectonic/pdflatex errors
          },
        },
        ft = { "markdown", "Avante" },
      },
    },
    opts = {
      ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
      provider = "claude", -- Use Claude as main provider
      auto_suggestions_provider = "claude", -- Use Claude for auto suggestions
      providers = {
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-sonnet-4-20250514", -- 🔥 CLAUDE 4 SONNET (Latest)
          extra_request_body = {
            temperature = 0.3, -- Lower temperature for more consistent responses
            max_tokens = 2000, -- Reduced for cost optimization
          },
          extra_headers = {
            ["anthropic-version"] = "2023-06-01",
            ["anthropic-beta"] = "prompt-caching-2024-07-31", -- Enable prompt caching for 90% savings
          },
          -- Token tracking integration
          on_response = function(response)
            if TokenOptimizer and response.usage then
              TokenOptimizer.track_usage(
                response.usage.input_tokens or 0,
                response.usage.output_tokens or 0,
                "claude_sonnet"
              )
            end
          end,
        },
      },
      behaviour = {
        auto_suggestions = false, -- Disable auto suggestions to save cost
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false, -- Disable to avoid accidental usage
      },
      mappings = {
        --- @class AvanteConflictMappings
        diff = {
          ours = "co",
          theirs = "ct",
          all_theirs = "ca",
          both = "cb",
          cursor = "cc",
          next = "]x",
          prev = "[x",
        },
        suggestion = {
          accept = "<M-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
        jump = {
          next = "]]",
          prev = "[[",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>", -- Changed to avoid accidental submissions
        },
      },
      hints = { enabled = false }, -- Disable hints to save tokens
      windows = {
        position = "right", -- "right", "left", "top", "bottom"
        wrap = true, -- similar to vim.o.wrap
        width = 30, -- default % based on available width
        sidebar_header = {
          align = "center", -- left, center, right for title
          rounded = true,
        },
      },
      highlights = {
        diff = {
          current = "DiffText",
          incoming = "DiffAdd",
        },
      },
      --- @class AvanteConflictUserConfig
      diff = {
        autojump = true,
        ---@type string | fun(): string
        list_opener = "copen",
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- build = "make BUILD_FROM_SOURCE=true",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  },

  -- GitHub Copilot (Simple setup)
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
    end
  },

  -- Copilot.lua (Alternative Copilot implementation)
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = false, -- Disable panel to avoid conflicts with copilot.vim
        },
        suggestion = {
          enabled = false, -- Disable suggestions to avoid conflicts with copilot.vim
        },
        filetypes = {
          markdown = true,
          help = true,
        },
      })
    end,
  },

  -- Dressing.nvim (UI enhancements)
  {
    "stevearc/dressing.nvim",
    lazy = false,
    config = function()
      require("dressing").setup({
        input = {
          enabled = true,
          default_prompt = "Input:",
          trim_prompt = true,
          title_pos = "left",
          relative = "cursor",
          prefer_width = 40,
          width = nil,
          max_width = { 140, 0.9 },
          min_width = { 20, 0.2 },
          buf_options = {},
          win_options = {
            winblend = 10,
            wrap = false,
            list = true,
            listchars = "precedes:…,extends:…",
            sidescrolloff = 0,
          },
          mappings = {
            n = {
              ["<CR>"] = "Confirm",
              ["<C-c>"] = "Cancel",
              ["<C-]>"] = "Show Help",
            },
            i = {
              ["<C-c>"] = "Cancel",
              ["<CR>"] = "Confirm",
              ["<C-]>"] = "Show Help",
            },
          },
        },
        select = {
          enabled = true,
          backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
          trim_prompt = true,
          telescope = nil,
          fzf = {
            window = {
              width = 0.5,
              height = 0.4,
            },
          },
          fzf_lua = {
            winopts = {
              width = 0.5,
              height = 0.4,
            },
          },
          nui = {
            position = "50%",
            size = nil,
            relative = "editor",
            border = {
              style = "rounded",
            },
            max_width = 80,
            max_height = 40,
          },
          builtin = {
            relative = "editor",
            border = "rounded",
            max_width = { 140, 0.8 },
            max_height = { 25, 0.8 },
            min_width = { 40, 0.2 },
            min_height = { 10, 0.2 },
            width = nil,
            height = nil,
            row = nil,
            col = nil,
            title = nil,
            title_pos = "center",
          },
        },
      })
    end,
  },
} 