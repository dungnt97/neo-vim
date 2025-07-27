-- Token Optimizer Module
local M = {}

-- Token usage tracking
local token_usage = {
  daily = 0,
  monthly = 0,
  last_reset = os.time(),
}

-- Cost calculation (based on Anthropic pricing)
local COSTS = {
  claude_sonnet = {
    input = 3,    -- $3 per million input tokens
    output = 15,  -- $15 per million output tokens
  },
  gpt4 = {
    input = 30,   -- $30 per million input tokens
    output = 60,  -- $60 per million output tokens
  }
}

-- Initialize token tracking
function M.init()
  local cache_dir = vim.fn.expand("~/.cache/avante")
  if vim.fn.isdirectory(cache_dir) == 0 then
    vim.fn.mkdir(cache_dir, "p")
  end
  
  -- Load existing usage data
  M.load_usage_data()
  
  -- Setup daily reset
  M.setup_daily_reset()
end

-- Load usage data from file
function M.load_usage_data()
  local usage_file = vim.fn.expand("~/.cache/avante/token_usage.json")
  if vim.fn.filereadable(usage_file) == 1 then
    local content = vim.fn.readfile(usage_file)
    if #content > 0 then
      local success, data = pcall(vim.json.decode, table.concat(content, "\n"))
      if success then
        token_usage = data
      end
    end
  end
end

-- Save usage data to file
function M.save_usage_data()
  local usage_file = vim.fn.expand("~/.cache/avante/token_usage.json")
  local content = vim.json.encode(token_usage)
  vim.fn.writefile(vim.split(content, "\n"), usage_file)
end

-- Track token usage
function M.track_usage(input_tokens, output_tokens, model)
  local current_time = os.time()
  
  -- Reset daily counter if it's a new day
  local current_date = os.date("*t", current_time)
  current_date.hour = 0
  current_date.min = 0
  current_date.sec = 0
  local day_start = os.time(current_date)
  
  if token_usage.last_reset < day_start then
    token_usage.daily = 0
    token_usage.last_reset = current_time
  end
  
  -- Add tokens
  local total_tokens = input_tokens + output_tokens
  token_usage.daily = token_usage.daily + total_tokens
  token_usage.monthly = token_usage.monthly + total_tokens
  
  -- Save data
  M.save_usage_data()
  
  -- Show notification if approaching limits
  M.check_limits()
  
  return total_tokens
end

-- Check usage limits
function M.check_limits()
  local daily_limit = 100000
  local monthly_limit = 2000000
  
  if token_usage.daily > daily_limit * 0.8 then
    vim.notify("⚠️ Daily token usage: " .. token_usage.daily .. "/" .. daily_limit, "warn", { position = "bottom_right" })
  end
  
  if token_usage.monthly > monthly_limit * 0.8 then
    vim.notify("⚠️ Monthly token usage: " .. token_usage.monthly .. "/" .. monthly_limit, "warn", { position = "bottom_right" })
  end
end

-- Calculate cost
function M.calculate_cost(input_tokens, output_tokens, model)
  local costs = COSTS[model] or COSTS.claude_sonnet
  local input_cost = (input_tokens / 1000000) * costs.input
  local output_cost = (output_tokens / 1000000) * costs.output
  return input_cost + output_cost
end

-- Show token usage dashboard
function M.show_usage()
  local current_time = os.time()
  local daily_cost = M.calculate_cost(token_usage.daily, 0, "claude_sonnet")
  local monthly_cost = M.calculate_cost(token_usage.monthly, 0, "claude_sonnet")
  
  local lines = {
    "🚀 AI Token Usage Dashboard",
    "",
    "📊 Daily Usage:",
    "   Tokens: " .. token_usage.daily .. "/100,000",
    "   Cost: $" .. string.format("%.4f", daily_cost),
    "",
    "📈 Monthly Usage:",
    "   Tokens: " .. token_usage.monthly .. "/2,000,000",
    "   Cost: $" .. string.format("%.4f", monthly_cost),
    "",
    "🤖 INTEGRATED AI TOOLS:",
    "   ✅ ChatGPT (GPT-4) - Auto tracking",
    "   ✅ Avante (Claude 4 Sonnet) - Auto tracking",
    "   ✅ Claude Code - Auto tracking (optimized)",
    "",
    "💰 Cost Optimization Tips:",
    "   • Use prompt caching (saves 90% input tokens)",
    "   • Enable batch processing (saves 50% output tokens)",
    "   • Limit context files (max 20 files)",
    "   • Use Claude Sonnet instead of Opus",
    "",
    "🔧 Commands:",
    "   <leader>at - Show this dashboard",
    "   <leader>acache - Clear prompt cache",
    "   <leader>ao - Optimize settings",
  }
  
  -- Create floating window
  local width = 60
  local height = #lines
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)
  
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })
  
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
  vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
  
  -- Set keymaps for the window
  local opts = { buffer = buf, silent = true }
  vim.keymap.set("n", "q", function() vim.api.nvim_win_close(win, true) end, opts)
  vim.keymap.set("n", "<ESC>", function() vim.api.nvim_win_close(win, true) end, opts)
end

-- Clear prompt cache
function M.clear_cache()
  local cache_dir = vim.fn.expand("~/.cache/avante/prompts")
  if vim.fn.isdirectory(cache_dir) == 1 then
    vim.fn.delete(cache_dir, "rf")
    vim.fn.mkdir(cache_dir, "p")
    vim.notify("✅ Prompt cache cleared!", "info", { position = "bottom_right" })
  else
    vim.notify("ℹ️ No prompt cache to clear", "info", { position = "bottom_right" })
  end
end

-- Optimize settings for token saving
function M.optimize_settings()
  local lines = {
    "🎯 Token Optimization Settings",
    "",
    "Current optimizations enabled:",
    "✅ Prompt caching (saves 90% input tokens)",
    "✅ Batch processing (saves 50% output tokens)",
    "✅ Smart context selection (max 20 files)",
    "✅ Token usage tracking",
    "",
    "Recommended actions:",
    "1. Use Claude Sonnet instead of Opus",
    "2. Limit max_tokens to 2000",
    "3. Enable temperature = 0.3 for focused responses",
    "4. Use specific file selection instead of whole project",
    "",
    "Press 'q' to close",
  }
  
  local width = 60
  local height = #lines
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)
  
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })
  
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
  
  local opts = { buffer = buf, silent = true }
  vim.keymap.set("n", "q", function() vim.api.nvim_win_close(win, true) end, opts)
  vim.keymap.set("n", "<ESC>", function() vim.api.nvim_win_close(win, true) end, opts)
end

-- Setup daily reset timer
function M.setup_daily_reset()
  -- This would ideally use a timer, but for now we check on each usage
  -- In a real implementation, you might want to use a background job
end

-- Initialize when loaded
M.init()

return M 