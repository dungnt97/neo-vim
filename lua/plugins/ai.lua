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
          model = "gpt-4o-mini", -- Use GPT-4o-mini (latest and cost-effective)
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
          model = "gpt-4o-mini", -- Use GPT-4o-mini for editing too
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
          border = { style = "rounded", text = { top = " ChatGPT (GPT-4o-mini) " } },
        },
        popup_input = {
          prompt = "  ",
          submit = "<C-Enter>",
        },
      })
    end
  },

  -- Claude Code (coder/claudecode.nvim - OPTIMIZED CONFIGURATION)
  {
    "coder/claudecode.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    -- Removed build = "make" to avoid nix dependency issues
    dependencies = { "folke/snacks.nvim" },
    opts = {
      -- Server Configuration
      port_range = { min = 10000, max = 65535 },
      auto_start = true,
      log_level = "info",
      terminal_cmd = nil, -- Use default "claude" command

      -- Selection Tracking
      track_selection = true,
      visual_demotion_delay_ms = 50,

      -- Terminal Configuration
      terminal = {
        split_side = "right",
        split_width_percentage = 0.30,
        provider = "snacks", -- Use snacks.nvim provider
        auto_close = true,
        snacks_win_opts = {
          position = "right",
          width = 0.28,
          height = 1,
          border = "rounded",
          wo = {
            winhighlight = "Normal:Normal,NormalNC:Normal,NormalFloat:Normal,FloatBorder:FloatBorder,WinBar:Normal,WinBarNC:Normal",
          },
        },
      },

      -- Diff Integration
      diff_opts = {
        auto_close_on_accept = true,
        vertical_split = true,
        open_in_current_tab = true,
      },

      -- Token tracking integration for Claude Code
      on_response = function(response)
        if TokenOptimizer and response and response.usage then
          TokenOptimizer.track_usage(
            response.usage.input_tokens or 0,
            response.usage.output_tokens or 0,
            "claude_sonnet"
          )
        end
      end,
    },
    keys = {
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      { "<leader>at", "<cmd>ClaudeCodeTreeAdd<cr>", desc = "Add file to Claude" },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
      -- Image paste support
      { "<D-v>", "<cmd>ClaudeCodePasteImage<cr>", desc = "Paste image to Claude", mode = { "n", "i" } },
    },
  },

  -- Snacks.nvim (Required for Claude Code)
  {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- Suppress Snacks warnings temporarily
      local old_notify = vim.notify
      vim.notify = function(msg, level, opts)
        if type(msg) == "string" and (msg:match("Snacks") or msg:match("dashboard")) then
          return
        end
        old_notify(msg, level, opts)
      end

      require("snacks").setup({
        -- Terminal configuration for Claude Code compatibility
        terminal = {
          split_side = "right",
          split_width_percentage = 0.30,
          auto_close = true,
        },
        -- Enable image features for supported terminals
        image = { 
          enabled = true,
          fallback_to_text = true,
          magick_command = "magick",
          -- Enable clipboard image support
          clipboard = true,
          -- Enable drag and drop
          drag_and_drop = true,
        },
        -- Enable only essential features
        bigfile = { enabled = true },
        notifier = { enabled = true },
        quickfile = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true },
        input = { enabled = true },
        picker = { enabled = true },
        dashboard = { enabled = false },
        explorer = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        -- Window handling optimized for Claude Code
        win = {
          backdrop = false,
        },
      })

      -- Restore original notify
      vim.notify = old_notify

      -- Set up Snacks UI handlers with defer to ensure plugin is loaded
      vim.defer_fn(function()
        local snacks = require("snacks")
        if snacks and snacks.input and snacks.picker then
          vim.ui.input = snacks.input.input
          vim.ui.select = snacks.picker.select
        end
      end, 100)

      -- Additional token tracking for Claude Code via autocmd (only if response has usage data)
      vim.api.nvim_create_autocmd("User", {
        pattern = "ClaudeCodeResponse",
        callback = function()
          -- Only track if response contains actual usage data
          -- This prevents false tracking
        end
      })
    end
  },

  -- Avante.nvim (UPDATED to Claude 4 Sonnet)
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false,
    -- Removed build = "make" to avoid nix dependency issues
    keys = {
      { "<leader>av", function() require("avante.api").ask() end, desc = "Avante: ask", mode = { "n", "v" } },
      { "<leader>ave", function() require("avante.api").edit() end, desc = "Avante: edit", mode = { "n", "v" } },
      { "<leader>avr", function() require("avante.api").refresh() end, desc = "Avante: refresh", mode = "v" },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
          latex = {
            enabled = false,
          },
        },
        ft = { "markdown", "Avante" },
      },
    },
    opts = {
      provider = "openai",
      auto_suggestions_provider = "openai",
      providers = {
        openai = {
          endpoint = "https://api.openai.com/v1",
          model = "gpt-4o-mini", -- hoặc "gpt-4o"
          extra_request_body = {
            temperature = 0.3,
            max_tokens = 2000,
          },
          extra_headers = {
            ["Authorization"] = "Bearer " .. os.getenv("OPENAI_API_KEY"),
          },
          on_response = function(response)
            if TokenOptimizer and response.usage then
              TokenOptimizer.track_usage(
                response.usage.prompt_tokens or 0,
                response.usage.completion_tokens or 0,
                "gpt4o"
              )
            end
          end,
        },
      },
      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
      },
      mappings = {
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
          insert = "<C-s>",
        },
      },
      hints = { enabled = false },
      windows = {
        position = "right",
        wrap = true,
        width = 30,
        sidebar_header = {
          align = "center",
          rounded = true,
        },
      },
      highlights = {
        diff = {
          current = "DiffText",
          incoming = "DiffAdd",
        },
      },
      diff = {
        autojump = true,
        list_opener = "copen",
      },
    },
  },

  -- GitHub Copilot (Simple setup)
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
      vim.g.copilot_tab_fallback = ""
      
      -- Token tracking for Copilot
      vim.api.nvim_create_autocmd("User", {
        pattern = "CopilotSuggestion",
        callback = function()
          if TokenOptimizer then
            local estimated_tokens = 50
            TokenOptimizer.track_usage(0, estimated_tokens, "copilot")
          end
        end
      })
    end
  },

  -- Copilot.lua (Alternative Copilot implementation)
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = false,
        },
        suggestion = {
          enabled = false,
        },
        filetypes = {
          markdown = true,
          help = true,
        },
      })
      
      -- Token tracking for Copilot.lua
      vim.api.nvim_create_autocmd("User", {
        pattern = "CopilotSuggestion",
        callback = function()
          if TokenOptimizer then
            local estimated_tokens = 50
            TokenOptimizer.track_usage(0, estimated_tokens, "copilot")
          end
        end
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
