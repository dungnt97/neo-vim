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

            -- Enable syntax highlighting for diff buffers
            vim.schedule(function()
              if vim.api.nvim_buf_is_valid(bufnr) then
                vim.cmd("syntax on")
                vim.cmd("syntax sync fromstart")

                -- Detect and set proper filetype
                local filetype = vim.filetype.match({ buf = bufnr })
                if filetype and filetype ~= "" then
                  vim.bo[bufnr].filetype = filetype

                  -- Enable treesitter highlighting if available
                  pcall(function()
                    require("nvim-treesitter.highlight").attach(bufnr, filetype)
                  end)
                end
              end
            end)
          end,
          view_opened = function(view)
            -- Auto focus file panel when opening diffview
            vim.defer_fn(function()
              local actions = require("diffview.actions")
              actions.focus_files()
            end, 50)

            -- Optional: Show notification
            vim.notify("📝 Diffview opened - Use j/k or arrows to navigate files, Enter to select", vim.log.levels.INFO, {
              timeout = 3000,
              position = "bottom_right"
            })
          end,
        },
        keymaps = {
          disable_defaults = false, -- IMPORTANT: Keep defaults enabled
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
            ["qq"] = actions.close,
            ["q"] = actions.close,
          },
          file_panel = {
            -- Navigation keys
            ["j"] = actions.next_entry,
            ["k"] = actions.prev_entry,
            ["<down>"] = actions.next_entry,
            ["<up>"] = actions.prev_entry,
            ["<cr>"] = actions.select_entry,
            ["o"] = actions.select_entry,
            ["<2-LeftMouse>"] = actions.select_entry,
            ["l"] = actions.select_entry,
            ["<space>"] = actions.select_entry,

            -- File operations
            ["-"] = actions.toggle_stage_entry,
            ["S"] = actions.stage_all,
            ["U"] = actions.unstage_all,
            ["X"] = actions.restore_entry,
            ["R"] = actions.refresh_files,
            ["L"] = actions.open_commit_log,
            ["zo"] = actions.open_fold,
            ["h"] = actions.close_fold,
            ["zc"] = actions.close_fold,
            ["za"] = actions.toggle_fold,
            ["zR"] = actions.open_all_folds,
            ["zM"] = actions.close_all_folds,

            -- Other actions
            ["<leader>e"] = actions.focus_files,
            ["<leader>b"] = actions.toggle_files,
            ["g<C-x>"] = actions.cycle_layout,
            ["[x"] = actions.prev_conflict,
            ["]x"] = actions.next_conflict,
            ["gf"] = actions.goto_file_edit,
            ["<C-w><C-f>"] = actions.goto_file_split,
            ["<C-w>gf"] = actions.goto_file_tab,
            ["i"] = actions.listing_style,
            ["f"] = actions.toggle_flatten_dirs,
            ["<tab>"] = actions.select_next_entry,
            ["<s-tab>"] = actions.select_prev_entry,
            ["qq"] = actions.close,
            ["q"] = actions.close,
          },
          file_history_panel = {
            -- Navigation
            ["j"] = actions.next_entry,
            ["k"] = actions.prev_entry,
            ["<down>"] = actions.next_entry,
            ["<up>"] = actions.prev_entry,
            ["<cr>"] = actions.select_entry,
            ["o"] = actions.select_entry,
            ["<2-LeftMouse>"] = actions.select_entry,

            -- Other actions
            ["g!"] = actions.options,
            ["<C-A-d>"] = actions.open_in_diffview,
            ["y"] = actions.copy_hash,
            ["L"] = actions.open_commit_log,
            ["zR"] = actions.open_all_folds,
            ["zM"] = actions.close_all_folds,
            ["<tab>"] = actions.select_next_entry,
            ["<s-tab>"] = actions.select_prev_entry,
            ["qq"] = actions.close,
            ["q"] = actions.close,
          },
          option_panel = {
            ["<tab>"] = actions.select_entry,
            ["q"] = actions.close,
            ["<cr>"] = actions.select_entry,
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