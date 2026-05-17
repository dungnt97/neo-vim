-- Editor Plugins Configuration
return {
  -- File Explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = "Neotree",
    keys = { { "<leader>e", ":Neotree toggle<CR>", desc = "Toggle file tree" } },
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    config = function()
      require("neo-tree").setup({
        window = { 
          width = 35,
          mappings = {
            ["<space>"] = "none", -- Disable space key
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["<esc>"] = "revert_preview",
            ["P"] = { "toggle_preview", config = { use_float = true } },
            ["l"] = "focus_preview",
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            ["t"] = "open_tabnew",
            ["w"] = "open_with_window_picker",
            ["C"] = "close_node",
            ["z"] = "close_all_nodes",
            ["a"] = { 
              "add",
              config = {
                show_path = "none"
              }
            },
            ["A"] = "add_directory",
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy",
            ["m"] = "move",
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
          }
        },
        filesystem = {
          filtered_items = { 
            visible = true, 
            hide_dotfiles = false, 
            hide_gitignored = false 
          },
          follow_current_file = {
            enabled = true,
            leave_dirs_open = false,
          },
          use_libuv_file_watcher = true,
        },
        default_component_configs = {
          indent = {
            with_expanders = true,
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
        },
      })
    end
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find buffers" },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git", "dist", "build" },
          mappings = {
            i = {
              ["<C-j>"] = require("telescope.actions").move_selection_next,
              ["<C-k>"] = require("telescope.actions").move_selection_previous,
            },
          },
        },
      })
    end
  },

  -- Treesitter (main branch API)
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    event = { "BufReadPost", "BufNewFile" },
    build = function() require("nvim-treesitter").update() end,
    config = function()
      local ts = require("nvim-treesitter")
      ts.setup({})

      local parsers = {
        "lua", "python", "javascript", "typescript", "tsx", "html", "css", "json", "markdown",
        "markdown_inline", "rust", "go", "java", "c", "cpp", "bash", "yaml", "toml", "ruby",
        "php", "sql", "regex", "latex", "scss", "svelte", "typst", "vue", "vim", "vimdoc",
      }
      ts.install(parsers)

      -- Map parser -> filetypes for auto highlight/indent on FileType
      local fts = {}
      for _, p in ipairs(parsers) do
        for _, ft in ipairs(vim.treesitter.language.get_filetypes(p) or { p }) do
          table.insert(fts, ft)
        end
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = fts,
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  -- LSP (Optimized)
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    config = function() require("mason").setup() end
  },

  {
    "mason-org/mason-lspconfig.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "neovim/nvim-lspconfig", "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "ts_ls", "rust_analyzer", "html", "cssls", "jsonls" },
      })

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      
      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, silent = true }
        vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
        vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      end

      local servers = { "lua_ls", "pyright", "ts_ls", "rust_analyzer", "html", "cssls", "jsonls" }
      for _, server in ipairs(servers) do
        lspconfig[server].setup({ on_attach = on_attach, capabilities = capabilities })
      end
    end
  },

  -- Autocomplete
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip"
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        snippet = { expand = function(args) require("luasnip").lsp_expand(args.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = { { name = "nvim_lsp" }, { name = "buffer" }, { name = "path" } },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, vim_item)
            vim_item.kind = string.format("%s", vim_item.kind)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              buffer = "[Buffer]",
              path = "[Path]",
              luasnip = "[Snippet]",
            })[entry.source.name]
            return vim_item
          end,
        },
      })
      
      -- Configure CMP documentation to work with Noice
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
      
      -- Handle CMP documentation warning
      vim.api.nvim_create_autocmd("User", {
        pattern = "CmpDocumentation",
        callback = function()
          -- This ensures CMP documentation is handled properly
        end,
      })
    end
  },

  -- Snippets
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    config = function()
      require("luasnip").setup({
        region_check_events = "InsertEnter",
        delete_check_events = "TextChanged,InsertLeave",
      })
    end,
  },

  -- Essential utilities
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function() require("nvim-autopairs").setup() end
  },

  {
    "numToStr/Comment.nvim",
    keys = { { "<leader>/", mode = {"n", "v"} } },
    config = function() require("Comment").setup() end
  },

  {
    "akinsho/toggleterm.nvim",
    keys = { { "<C-\\>", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal" } },
    cmd = "ToggleTerm",
    config = function()
      require("toggleterm").setup({
        size = 20, direction = "float", shell = vim.o.shell,
        float_opts = { border = "curved" },
      })
    end
  },

  -- Open browser plugin
  {
    "tyru/open-browser.vim",
    keys = {
      { "gx", "<Plug>(openbrowser-smart-search)", mode = {"n", "v"}, desc = "Open URL in browser" },
      { "<leader>os", "<Plug>(openbrowser-search)", mode = {"n", "v"}, desc = "Search in browser" },
      { "<leader>oo", "<Plug>(openbrowser-open)", mode = {"n", "v"}, desc = "Open URL" },
      { "<leader>op", ":execute 'OpenBrowser file://' . expand('%:p')<CR>", desc = "Preview current file in browser" },
    },
    cmd = { "OpenBrowser", "OpenBrowserSearch", "OpenBrowserSmartSearch" },
    config = function()
      -- Configure default browser (optional)
      -- vim.g.openbrowser_browser_commands = {
      --   { name = "open", args = {"{browser}", "{uri}"} },  -- macOS
      --   { name = "xdg-open", args = {"{uri}"} },           -- Linux
      --   { name = "start", args = {"", "{uri}"} },          -- Windows
      -- }
      
      -- Configure search engine (default is Google)
      vim.g.openbrowser_default_search = "google"
      
      -- Available search engines
      vim.g.openbrowser_search_engines = {
        google = "https://google.com/search?q={query}",
        github = "https://github.com/search?q={query}",
        duckduckgo = "https://duckduckgo.com/?q={query}",
        stackoverflow = "https://stackoverflow.com/search?q={query}",
      }
      
      -- Auto-detect URLs under cursor
      vim.g.openbrowser_iskeyword = 1
    end
  },

  -- Code formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    -- Removed keys to avoid conflict with <leader>ff (find files)
    -- Use <leader>lf for formatting instead (defined in keymaps.lua)
    opts = {
      -- Define formatters
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "isort", "black" },
        javascript = { { "prettierd", "prettier" } },
        typescript = { { "prettierd", "prettier" } },
        typescriptreact = { { "prettierd", "prettier" } },
        javascriptreact = { { "prettierd", "prettier" } },
        json = { { "prettierd", "prettier" } },
        yaml = { { "prettierd", "prettier" } },
        html = { { "prettierd", "prettier" } },
        css = { { "prettierd", "prettier" } },
        scss = { { "prettierd", "prettier" } },
        markdown = { { "prettierd", "prettier" } },
        rust = { "rustfmt" },
        go = { "gofmt" },
        java = { "google-java-format" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        cs = { "csharpier" },
        php = { "php_cs_fixer" },
        ruby = { "rubocop" },
        sh = { "shfmt" },
        sql = { "sqlformat" },
        vue = { { "prettierd", "prettier" } },
        svelte = { { "prettierd", "prettier" } },
        ["*"] = { "codespell" },
      },
      -- Set up format-on-save
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_fallback = true }
      end,
      -- Customize formatters
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2", "-ci" },
        },
        black = {
          prepend_args = { "--line-length", "88" },
        },
        prettier = {
          prepend_args = { "--print-width", "88", "--tab-width", "2" },
        },
      },
    },
    -- Removed init function to avoid conflicts
    -- Use <leader>lf for formatting (defined in keymaps.lua via LSP section)
  },
} 