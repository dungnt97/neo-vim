-- Session Management Configuration
return {
  -- ===== SESSION MANAGEMENT (nvim-session-manager) =====
  {
    "olimorris/persisted.nvim",
    event = "VeryLazy",
    cmd = { "SessionLoad", "SessionSave", "SessionDelete", "SessionStop" },
    keys = {
      { "<leader>ss", "<cmd>SessionSave<CR>", desc = "Save session" },
      { "<leader>sl", "<cmd>SessionLoad<CR>", desc = "Load session" },
      { "<leader>sd", "<cmd>SessionDelete<CR>", desc = "Delete session" },
      { "<leader>st", "<cmd>SessionStop<CR>", desc = "Stop session" },
    },
    opts = {
      save_dir = vim.fn.stdpath("data") .. "/sessions/",
      command = "VimLeavePre",
      use_git_branch = true,
      autosave = true,
      autoload = false,
      on_autoload_no_session = function()
        vim.notify("No session found", "info", { position = "bottom_right" })
      end,
      telescope = {
        before_source = function()
          -- Close all open buffers
          vim.api.nvim_command("%bdelete!")
        end,
        after_source = function(session)
          vim.notify("Loaded session: " .. session.name, "info", { 
            timeout = 2000,
            position = "bottom_right"
          })
        end,
      },
    },
    config = function(_, opts)
      require("persisted").setup(opts)
      
      -- Auto-save session on exit
      vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
          require("persisted").save()
        end,
      })
      
      -- Show session info on startup
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          local session_name = require("persisted").get_session_name()
          if session_name then
            vim.notify("Session: " .. session_name, "info", { 
              timeout = 2000,
              position = "bottom_right"
            })
          end
        end,
      })
    end,
  },
} 