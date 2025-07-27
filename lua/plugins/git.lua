-- Git Plugins Configuration
return {
  -- ===== GIT - DIFFVIEW.NVIM (MODERN GIT DIFF INTERFACE) =====
  {
    "sindrets/diffview.nvim",
    dependencies = { 
      "nvim-lua/plenary.nvim"
    },
    cmd = { 
      "DiffviewOpen", 
      "DiffviewClose", 
      "DiffviewToggleFiles", 
      "DiffviewFocusFiles",
      "DiffviewFileHistory" -- Added missing command
    },
    keys = {
      -- Main diffview commands
      { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Open diffview" },
      { "<leader>gdc", "<cmd>DiffviewClose<CR>", desc = "Close diffview" },
      { "<leader>gdf", "<cmd>DiffviewToggleFiles<CR>", desc = "Toggle file panel" },
      { "<leader>gff", "<cmd>DiffviewFocusFiles<CR>", desc = "Focus file panel" },
      
      -- Git status and history
      { "<leader>gs", "<cmd>DiffviewOpen<CR>", desc = "Git status (diffview)" },
      { "<leader>gh", "<cmd>DiffviewFileHistory<CR>", desc = "File history" },
      { "<leader>ghc", "<cmd>DiffviewFileHistory %<CR>", desc = "Current file history" },
      
      -- Git operations (using terminal commands)
      { "<leader>gc", "<cmd>Terminal git commit<CR>", desc = "Git commit" },
      { "<leader>gp", "<cmd>Terminal git push<CR>", desc = "Git push" },
      { "<leader>gf", "<cmd>Terminal git fetch<CR>", desc = "Git fetch" },
      { "<leader>gm", "<cmd>Terminal git merge<CR>", desc = "Git merge" },
      { "<leader>gr", "<cmd>Terminal git rebase<CR>", desc = "Git rebase" },
      { "<leader>ga", "<cmd>Terminal git add %<CR>", desc = "Git add current file" },
      { "<leader>gaa", "<cmd>Terminal git add .<CR>", desc = "Git add all" },
      { "<leader>gb", "<cmd>Terminal git blame %<CR>", desc = "Git blame" },
      { "<leader>gl", "<cmd>Terminal git log --oneline<CR>", desc = "Git log" },
      { "<leader>gg", "<cmd>Terminal git grep<CR>", desc = "Git grep" },
    },
    config = function()
      local actions = require("diffview.actions")
      
      require("diffview").setup({
        enhanced_diff_hl = true,
        git_cmd = { "git" },
        use_icons = true,
        icons = {
          folder_closed = " ",
          folder_open = " ",
        },
        signs = {
          fold_closed = "",
          fold_open = "",
          done = "✓",
        },
        view = {
          default = {
            layout = "diff2_horizontal",
            winbar_info = true,
          },
          merge_tool = {
            layout = "diff3_horizontal",
            disable_diagnostics = true,
            winbar_info = true,
          },
          file_history = {
            layout = "diff2_horizontal",
            winbar_info = true,
          },
        },
        file_panel = {
          listing_style = "tree",
          tree_options = {
            flatten_dirs = true,
            folder_statuses = "only_folded",
          },
        },
        file_history_panel = {
          log_options = {
            git = {
              single_file = {
                diff_merges = "combined",
              },
              multi_file = {
                diff_merges = "first-parent",
              },
            },
          },
          win_config = {
            position = "bottom",
            width = 50,
            height = 10,
          },
        },
        commit_log_panel = {
          win_config = {
            position = "bottom",
            width = 50,
            height = 10,
          },
        },
        default_args = {
          DiffviewOpen = {},
          DiffviewFileHistory = {},
        },
        hooks = {
          diff_buf_read = function(bufnr)
            -- Change local options in diff buffers
            vim.opt_local.wrap = false
            vim.opt_local.list = false
            vim.opt_local.colorcolumn = { 80 }
          end,
          view_opened = function(view)
            print(
              ("A new %s was opened on tab page %d!")
              :format(view.class:name(), view.tabpage)
            )
          end,
          file_panel_buf_read = function(bufnr)
            -- Force override Enter key in file panel
            vim.keymap.set('n', '<CR>', function()
              local actions = require("diffview.actions")
              actions.select_entry()
            end, { buffer = bufnr, desc = "Select file in diffview", noremap = true, silent = true })
            
            -- Also map Enter in insert mode
            vim.keymap.set('i', '<CR>', function()
              local actions = require("diffview.actions")
              actions.select_entry()
            end, { buffer = bufnr, desc = "Select file in diffview", noremap = true, silent = true })
          end,
        },
        keymaps = {
          disable_defaults = true, -- Disable defaults to avoid conflicts
          view = {
            -- The `view` bindings are active in the diff buffers, only when the current
            -- tabpage is a Diffview.
            ["<tab>"] = actions.select_next_entry,
            ["<s-tab>"] = actions.select_prev_entry,
            ["gf"] = actions.goto_file_edit,
            ["<C-w><C-f>"] = actions.goto_file_split,
            ["<C-w>gf"] = actions.goto_file_tab,
            ["<leader>e"] = actions.focus_files,
            ["<leader>b"] = actions.toggle_files,
            ["g<C-x>"] = actions.cycle_layout,
            ["[x"] = actions.prev_conflict,
            ["]x"] = actions.next_conflict,
          },
          file_panel = {
            ["j"] = actions.next_entry,
            ["<down>"] = actions.next_entry,
            ["k"] = actions.prev_entry,
            ["<up>"] = actions.prev_entry,
            ["<cr>"] = actions.select_entry, -- ENTER key to select file
            ["<Enter>"] = actions.select_entry, -- Alternative ENTER mapping
            ["<Return>"] = actions.select_entry, -- Another ENTER mapping
            ["o"] = actions.select_entry,
            ["l"] = actions.select_entry,
            ["<2-LeftMouse>"] = actions.select_entry,
            ["-"] = actions.toggle_stage_entry,
            ["S"] = actions.stage_all,
            ["U"] = actions.unstage_all,
            ["X"] = actions.restore_entry,
            ["<C-b>"] = actions.scroll_view(-0.25),
            ["<C-f>"] = actions.scroll_view(0.25),
            ["<tab>"] = actions.select_next_entry,
            ["<s-tab>"] = actions.select_prev_entry,
            ["gf"] = actions.goto_file_edit,
            ["<C-w><C-f>"] = actions.goto_file_split,
            ["<C-w>gf"] = actions.goto_file_tab,
            ["<leader>e"] = actions.focus_files,
            ["<leader>b"] = actions.toggle_files,
            ["g<C-x>"] = actions.cycle_layout,
            ["[F"] = actions.select_first_entry,
            ["]F"] = actions.select_last_entry,
          },
          file_history_panel = {
            ["g!"] = actions.options,
            ["<C-A-d>"] = actions.open_in_diffview,
            ["y"] = actions.copy_hash,
            ["gf"] = actions.goto_file_edit,
            ["<C-w><C-f>"] = actions.goto_file_split,
            ["<C-w>gf"] = actions.goto_file_tab,
            ["<leader>e"] = actions.focus_files,
            ["<leader>b"] = actions.toggle_files,
            ["<tab>"] = actions.select_next_entry,
            ["<s-tab>"] = actions.select_prev_entry,
            ["j"] = actions.next_entry,
            ["<down>"] = actions.next_entry,
            ["k"] = actions.prev_entry,
            ["<up>"] = actions.prev_entry,
            ["<cr>"] = actions.select_entry,
            ["o"] = actions.select_entry,
            ["l"] = actions.select_entry,
            ["<2-LeftMouse>"] = actions.select_entry,
            ["<C-b>"] = actions.scroll_view(-0.25),
            ["<C-f>"] = actions.scroll_view(0.25),
            ["[F"] = actions.select_first_entry,
            ["]F"] = actions.select_last_entry,
          },
          option_panel = {
            ["<tab>"] = actions.select_entry,
            ["q"] = actions.close,
          },
        },
      })
    end
  },

  -- Git signs (complements diffview)
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" }, 
          change = { text = "│" }, 
          delete = { text = "_" },
          topdelete = { text = "‾" }, 
          changedelete = { text = "~" },
        },
        signcolumn = true,
        numhl = true,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 1000,
        },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        preview_config = {
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
      })
    end
  },
} 