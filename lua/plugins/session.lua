-- Session Management Configuration
return {
  -- ===== SESSION MANAGEMENT (persisted.nvim) =====
  {
    "olimorris/persisted.nvim",
    event = "VimEnter", -- Load immediately on startup to enable autoload
    cmd = { "SessionLoad", "SessionSave", "SessionDelete", "SessionStop", "SessionToggle" },
    keys = {
      { "<leader>ss", "<cmd>SessionSave<CR>", desc = "Save session" },
      { "<leader>sl", "<cmd>SessionLoad<CR>", desc = "Load session" },
      { "<leader>sd", "<cmd>SessionDelete<CR>", desc = "Delete session" },
      { "<leader>st", "<cmd>SessionStop<CR>", desc = "Stop session" },
      { "<leader>stg", "<cmd>SessionToggle<CR>", desc = "Toggle session" },
    },
    opts = {
      save_dir = vim.fn.stdpath("data") .. "/sessions/",
      command = "VimLeavePre",
      use_git_branch = true,
      autosave = true,
      autoload = true, -- Enable automatic session loading
      on_autoload_no_session = function()
        vim.notify("No session found - starting fresh", "info", { 
          position = "bottom_right",
          timeout = 2000
        })
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
      
      -- Trigger autoload on startup
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          -- Try to autoload session
          local persisted = require("persisted")
          local success, result = pcall(persisted.autoload)
          
          if success and result then
            local session_name = persisted.get_session_name()
            if session_name then
              vim.notify("Session loaded: " .. session_name, "info", { 
                timeout = 2000,
                position = "bottom_right"
              })
            end
          else
            vim.notify("No session found - starting fresh", "info", { 
              timeout = 2000,
              position = "bottom_right"
            })
          end
        end,
      })
      
      -- Additional autoload trigger when buffer is read
      vim.api.nvim_create_autocmd("BufReadPost", {
        callback = function()
          -- Only autoload if no session is currently active
          local persisted = require("persisted")
          local current_session = persisted.current()
          if not current_session then
            local success, result = pcall(persisted.autoload)
            if success and result then
              local session_name = persisted.get_session_name()
              if session_name then
                vim.notify("Session auto-loaded: " .. session_name, "info", { 
                  timeout = 2000,
                  position = "bottom_right"
                })
              end
            end
          end
        end,
        once = true, -- Only run once
      })
      
      -- Trigger autoload after Lazy.nvim is done loading
      vim.api.nvim_create_autocmd("User", {
        pattern = "LazyDone",
        callback = function()
          -- Delay slightly to ensure everything is ready
          vim.defer_fn(function()
            local persisted = require("persisted")
            local current_session = persisted.current()
            if not current_session then
              local success, result = pcall(persisted.autoload)
              if success and result then
                local session_name = persisted.get_session_name()
                if session_name then
                  vim.notify("Session loaded: " .. session_name, "info", { 
                    timeout = 2000,
                    position = "bottom_right"
                  })
                end
              end
            end
          end, 100)
        end,
        once = true,
      })
    end,
  },
} 