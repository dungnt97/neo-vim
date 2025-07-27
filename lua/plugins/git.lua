-- Git Plugins Configuration
return {
  -- ===== GIT - VIM FUGITIVE (REPLACES EXISTING GIT FUNCTIONALITY) =====
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gstatus", "Gdiff", "Gblame", "Glog", "Ggrep" },
    keys = {
      { "<leader>gs", "<cmd>Git<CR>", desc = "Git status" },
      { "<leader>gd", "<cmd>Gdiff<CR>", desc = "Git diff" },
      { "<leader>gb", "<cmd>Gblame<CR>", desc = "Git blame" },
      { "<leader>gl", "<cmd>Glog<CR>", desc = "Git log" },
      { "<leader>gg", "<cmd>Ggrep<CR>", desc = "Git grep" },
      { "<leader>gc", "<cmd>Git commit<CR>", desc = "Git commit" },
      { "<leader>gp", "<cmd>Git push<CR>", desc = "Git push" },
      { "<leader>gf", "<cmd>Git fetch<CR>", desc = "Git fetch" },
      { "<leader>gm", "<cmd>Git merge<CR>", desc = "Git merge" },
      { "<leader>gr", "<cmd>Git rebase<CR>", desc = "Git rebase" },
      { "<leader>ga", "<cmd>Git add %<CR>", desc = "Git add current file" },
      { "<leader>gaa", "<cmd>Git add .<CR>", desc = "Git add all" },
      { "<leader>gw", "<cmd>Gwrite<CR>", desc = "Git write (add and stage)" },
      { "<leader>gr", "<cmd>Gread<CR>", desc = "Git read (checkout)" },
      { "<leader>gbrowse", "<cmd>GBrowse<CR>", desc = "Git browse" },
    },
    config = function()
      -- Fugitive configuration
      vim.g.fugitive_no_maps = 0 -- Enable default fugitive maps
      
      -- Custom fugitive buffer settings
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "fugitive",
        callback = function()
          -- Set buffer options for fugitive buffers
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
          vim.opt_local.signcolumn = "no"
          
          -- Custom keymaps for fugitive status buffer
          local opts = { buffer = 0, silent = true }
          vim.keymap.set("n", "q", "<cmd>close<CR>", opts)
          vim.keymap.set("n", "<ESC>", "<cmd>close<CR>", opts)
          vim.keymap.set("n", "?", "<cmd>help fugitive-maps<CR>", opts)
        end
      })
      
      -- Fugitive blame buffer settings
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "fugitiveblame",
        callback = function()
          local opts = { buffer = 0, silent = true }
          vim.keymap.set("n", "q", "<cmd>close<CR>", opts)
          vim.keymap.set("n", "<ESC>", "<cmd>close<CR>", opts)
          vim.keymap.set("n", "<CR>", "<cmd>Gedit<CR>", opts)
        end
      })
    end
  },

  -- Git signs (complements fugitive)
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