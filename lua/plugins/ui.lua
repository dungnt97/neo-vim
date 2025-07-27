-- UI Plugins Configuration
return {
  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = false,
    config = function()
      require("nvim-web-devicons").setup({
        default = true,
        strict = true,
        override = {
          git = {
            icon = " ",
            color = "#f14c28",
            name = "Git",
          },
        },
        color_icons = true,
        default_set = true,
      })
    end,
  },

  -- UI & Theme - Catppuccin (Beautiful & Customizable)
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false,
        show_end_of_buffer = false,
        term_colors = true,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        no_italic = false,
        no_bold = false,
        no_underline = false,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = { "bold" },
          keywords = { "bold" },
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = { "bold" },
          operators = {},
        },
        color_overrides = {
          mocha = {
            base = "#000000", -- Pure black background
            mantle = "#0a0a0a", -- Slightly lighter black
            crust = "#1a1a1a", -- Dark gray
            text = "#cdd6f4", -- Light text
            subtext0 = "#a6adc8",
            subtext1 = "#bac2de",
            overlay0 = "#6c7086",
            overlay1 = "#7f849c",
            overlay2 = "#9399b2",
            surface0 = "#313244",
            surface1 = "#45475a",
            surface2 = "#585b70",
            blue = "#89b4fa",
            lavender = "#b4befe",
            sapphire = "#74c7ec",
            sky = "#89dceb",
            teal = "#94e2d5",
            green = "#a6e3a1",
            yellow = "#f9e2af",
            peach = "#fab387",
            maroon = "#eba0ac",
            red = "#f38ba8",
            mauve = "#cba6f7",
            pink = "#f5c2e7",
            flamingo = "#f2cdcd",
            rosewater = "#f5e0dc",
          },
        },
        custom_highlights = {
          -- Custom highlights for better UI
          Normal = { bg = "#000000" },
          NormalFloat = { bg = "#0a0a0a" },
          FloatBorder = { fg = "#89b4fa" },
          LineNr = { fg = "#6c7086" },
          CursorLineNr = { fg = "#89b4fa", bold = true },
          Visual = { bg = "#313244" },
          Search = { fg = "#f9e2af", bg = "#313244" },
          IncSearch = { fg = "#000000", bg = "#f9e2af" },
          -- Dashboard customizations
          AlphaHeader = { fg = "#89b4fa", bold = true },
          AlphaButtons = { fg = "#cba6f7", bold = true },
          AlphaFooter = { fg = "#74c7ec", italic = true },
          AlphaShortcut = { fg = "#f38ba8", bold = true },
          -- LSP customizations
          DiagnosticError = { fg = "#f38ba8" },
          DiagnosticWarn = { fg = "#f9e2af" },
          DiagnosticInfo = { fg = "#89b4fa" },
          DiagnosticHint = { fg = "#a6e3a1" },
        },
        default_integrations = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = true,
          neotree = true,
          telescope = true,
          which_key = true,
          indent_blankline = true,
          bufferline = true,
          alpha = true,
          mason = true,
          noice = true,
          illuminate = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
          mini = {
            enabled = true,
            indentscope_color = "#89b4fa",
          },
        },
      })
      vim.cmd("colorscheme catppuccin")
    end
  },

  -- ULTIMATE COOL DASHBOARD (Original Beautiful Version)
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    priority = 1000,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      
      -- EPIC HEADER without border
      local header_lines = {
        "",
        "",
        "",
        "",
        "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
        "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
        "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
        "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
        "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
        "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
        "",
        "         ⚡ DUNGNT's ULTIMATE WORKSPACE ⚡",
        "        🚀 Where Code Meets Innovation! 🚀",
        "        🎨 Catppuccin Mocha Theme Active 🎨",
        "",
        "",
        "",
      }
      
      dashboard.section.header.val = header_lines
      
      -- COOL BUTTONS with center padding
      dashboard.section.buttons.val = {
        dashboard.button("e", "📁  New File", ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", "🔍  Find File", ":Telescope find_files <CR>"),
        dashboard.button("r", "📚  Recent Files", ":Telescope oldfiles <CR>"),
        dashboard.button("t", "📝  Find Text", ":Telescope live_grep <CR>"),
        dashboard.button("c", "⚙️  Config", ":e ~/.config/nvim/init.lua <CR>"),
        dashboard.button("h", "🎯  Keymaps Help", "<leader>?"),
        dashboard.button("a", "🤖  AI Dashboard", "<leader>ai"),
        dashboard.button("q", "🚪  Quit Neovim", ":qa<CR>"),
      }
      
      -- EPIC FOOTER without border
      local footer_lines = {
        "",
        "",
        "",
        "💻 Ready to code like a legend? Let's make some magic happen! 💻",
        " 🎯 Choose your weapon and let's build something amazing! 🎯",
        "",
        "",
        "",
      }
      
      dashboard.section.footer.val = footer_lines
      
      -- Configure alpha with EPIC layout
      alpha.setup(dashboard.opts)
      
      -- Disable folding on alpha buffer
      vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
      
      -- Fix dashboard scrolling and size issues
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "alpha",
        callback = function()
          -- Disable scroll
          vim.opt_local.scrolloff = 0
          vim.opt_local.sidescrolloff = 0
          
          -- Set buffer as non-modifiable
          vim.opt_local.modifiable = false
          vim.opt_local.readonly = true
          
          -- Disable mouse scrolling
          vim.opt_local.mouse = ""
          
          -- Set window options
          local win_id = vim.api.nvim_get_current_win()
          vim.api.nvim_win_set_option(win_id, "wrap", false)
          vim.api.nvim_win_set_option(win_id, "scrollbind", false)
          
          -- Center the content
          vim.api.nvim_win_set_cursor(win_id, {1, 0})
        end
      })
      
      -- ULTIMATE WELCOME ANIMATION
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          -- EPIC welcome notification
          vim.defer_fn(function()
            vim.schedule(function()
              vim.api.nvim_notify("⚡ ULTIMATE DASHBOARD ACTIVATED! Choose your destiny! ⚡", vim.log.levels.INFO, {
                title = "🚀 DUNGNT's ULTIMATE WORKSPACE",
                timeout = 2000,
                position = "bottom_right"
              })
            end)
          end, 500)
          
          -- Set up EPIC colors for dashboard
          vim.api.nvim_create_autocmd("BufEnter", {
            pattern = "*",
            callback = function()
              if vim.bo.filetype == "alpha" then
                -- EPIC color scheme
                vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#7aa2f7", bold = true })
                vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#bb9af7", bold = true })
                vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#7dcfff", italic = true })
                vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#f7768e", bold = true })
                
                -- Add some EPIC effects
                vim.opt.cursorline = true
                vim.api.nvim_set_hl(0, "CursorLine", { bg = "#1a1b26", underline = true })
              end
            end,
            once = true
          })
        end
      })
    end
  },

  -- Essential UI
  { "MunifTanjim/nui.nvim", lazy = true },
  
  -- Mini.icons (Alternative to nvim-web-devicons)
  {
    "echasnovski/mini.icons",
    lazy = true,
    config = function()
      require("mini.icons").setup({
        -- Use nvim-web-devicons as primary, mini.icons as fallback
        enabled = true,
      })
    end,
  },
  
  -- Which-key for better keymap discovery
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
        },
        icons = {
          breadcrumb = "»",
          separator = "➜",
          group = "+",
        },
        win = {
          border = "rounded",
          position = "bottom",
          margin = { 1, 0, 1, 0 },
          padding = { 2, 2, 2, 2 },
        },
        layout = {
          height = { min = 4, max = 25 },
          width = { min = 20, max = 50 },
          spacing = 3,
          align = "left",
        },
      })
    end
  },
  
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto", -- Let Catppuccin handle the theme automatically
          globalstatus = true,
          disabled_filetypes = { statusline = { "alpha" } },
        },
      })
    end
  },

  -- Notifications (Simplified)
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      require("notify").setup({
        stages = "slide",
        timeout = 2000,
        render = "compact",
        top_down = false,
        position = "bottom_right",
        max_width = 50,
        max_height = 10,
      })
      
      -- Override default notify function to always use bottom_right
      local original_notify = vim.notify
      vim.notify = function(msg, level, opts)
        opts = opts or {}
        opts.position = opts.position or "bottom_right"
        return original_notify(msg, level, opts)
      end
    end
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    config = function()
      require("noice").setup({
        lsp = { override = { ["vim.lsp.util.stylize_markdown"] = true } },
        presets = { bottom_search = true, command_palette = true },
      })
    end
  },
} 