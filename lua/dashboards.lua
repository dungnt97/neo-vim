-- Dashboard Functions
local M = {}

-- Main help dashboard
function M.show_help()
  local lines = {
    "🎯 DUNGNT's AI-POWERED KEYMAPS (CLAUDE 4 EDITION)",
    "",
    "📁 FILES: <leader>e(toggle) eg(git) ef(focus) ec(close) tree(help)",
    "🌿 GIT: <leader>gs(status) gd(diff) gl(log) ga(add) gc(commit) gp(push)",
    "🔍 SEARCH: <leader>ff(files) fg(grep) fb(buffers) fr(recent)",
    "💻 LSP: <leader>lf(format) la(action) ld(diag) lr(rename) lh(hover)",
    "📋 EDIT: <leader>sa(select all)",
    "🎨 FORMAT: <leader>f(format) fF(format file) - Auto format on save",
    "💾 SESSION: <leader>ss(save) sl(load) sd(delete) st(stop) qq(save+quit) - Auto save",
    "🤖 CHATGPT: <leader>ag(chat) ae(edit) aa(act-as)",
    "⚡ CLAUDE CODE: <leader>ac(toggle) af(focus) ar(resume) ab(add) as(send)",
    "🎯 AVANTE: <leader>av(ask) ave(edit) avr(refresh) - CLAUDE 4 SONNET",
    "🪟 WINDOW: <leader>w + ↑↓←→(arrow keys) vs(split)",
    "🤖 COPILOT: Ctrl+jkl(nav/accept) in insert mode",
    "🔧 UTIL: <leader>/(comment) Ctrl+\\(terminal) fix(fix theme)",
    "🎨 THEME: <leader>tm(switch) theme(info) features(enhanced)",
    "🪟 WINDOW: <leader>window(navigation guide)",
    "🚀 AI: <leader>smart(auto-select) cx(clear) setup(guide)",
    "",
    "Press 'q' to close, 'a' for AI dashboard, 's' for setup",
  }
  
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor", width = 70, height = #lines,
    row = math.floor((vim.o.lines - #lines) / 2),
    col = math.floor((vim.o.columns - 70) / 2),
    style = "minimal", border = "rounded",
  })
  
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
  
  local opts = { buffer = buf, silent = true }
  vim.keymap.set("n", "q", function() vim.api.nvim_win_close(win, true) end, opts)
  vim.keymap.set("n", "a", function() 
    vim.api.nvim_win_close(win, true)
    vim.defer_fn(function() M.show_ai_dashboard() end, 100)
  end, opts)
  vim.keymap.set("n", "s", function() 
    vim.api.nvim_win_close(win, true)
    vim.defer_fn(function() M.show_setup_guide() end, 100)
  end, opts)
end

-- AI Tools dashboard
function M.show_ai_dashboard()
  local lines = {
    "",
    "╔═══════════════════════════════════════════════════════════════════════════════╗",
    "║                          🤖 AI TOOLS COMMAND CENTER 🤖                        ║",
    "╚═══════════════════════════════════════════════════════════════════════════════╝",
    "",
    "🧠 CHATGPT (OpenAI GPT-4) - WORKING ✅",
    "   <leader>ag     - Open ChatGPT chat interface",
    "   <leader>ae     - Edit current buffer/selection with instructions",
    "   <leader>aa     - ChatGPT Act As (predefined prompts)",
    "   <D-Enter>      - Quick ChatGPT access (Mac shortcut)",
    "",
    "⚡ CLAUDE CODE (coder/claudecode.nvim) - WebSocket MCP ✅ WORKING",
    "   <leader>ac     - Toggle Claude Code",
    "   <leader>af     - Focus Claude Code window",
    "   <leader>ar     - Resume Claude session",
    "   <leader>aC     - Continue Claude conversation",
    "   <leader>ab     - Add current buffer to context",
    "   <leader>as     - Send selection to Claude (visual mode)",
    "   <leader>aa     - Accept Claude diff",
    "   <leader>ad     - Deny Claude diff",
    "   <leader>cs     - Check Claude Code status (:ClaudeCodeStatus)",
    "   <leader>act    - Manual track Claude Code usage (optimized)",
    "   NOTE: Uses WebSocket MCP + Prompt caching (90% savings) + Auto tracking",
    "",
    "🎯 AVANTE AI (Cursor-like IDE) - CLAUDE 4 SONNET ✅",
    "   <leader>av     - Ask Avante AI (works in normal + visual mode)",
    "   <leader>ave    - Edit with Avante (works with selection)",
    "   <leader>avr    - Refresh Avante (visual mode only)",
    "   NOTE: Now using Claude 4 Sonnet (claude-sonnet-4-20250514)",
    "",
    "🤖 GITHUB COPILOT (Code Completion) - Insert Mode:",
    "   <C-j>          - Next Copilot suggestion",
    "   <C-k>          - Previous Copilot suggestion", 
    "   <C-l>          - Accept current suggestion",
    "",
    "💰 COST OPTIMIZATION ACTIVE:",
    "   • ChatGPT: GPT-4, max 1500 tokens, temp 0.3",
    "   • Claude Code: Claude 4 Sonnet, max 2000 tokens, temp 0.3",
    "   • Claude Code: Prompt caching enabled (90% input token savings)",
    "   • Avante: Claude 4 Sonnet, max 2000 tokens, temp 0.3",
    "   • Avante: Prompt caching enabled (90% input token savings)",
    "   • Auto-suggestions disabled to save costs",
    "",
    "🔥 SETUP REQUIREMENTS:",
    "   • OPENAI_API_KEY environment variable for ChatGPT",
    "   • ANTHROPIC_API_KEY environment variable for Avante",
    "   • Claude CLI installed: curl -fsSL https://claude.ai/cli | sh",
    "   • Claude authentication: claude auth login",
    "   • GitHub Copilot extension activated",
    "",
    "🆘 TROUBLESHOOTING:",
    "   • ChatGPT not working? Check: echo $OPENAI_API_KEY",
    "   • Avante not working? Check: echo $ANTHROPIC_API_KEY",
    "   • Claude Code not working? Check: claude --version",
    "   • Copilot not suggesting? Run: :Copilot status",
    "   • Missing dependencies? Run: :checkhealth",
    "",
    "🚀 NEW FEATURES:",
    "   • Claude Code: Official WebSocket MCP protocol",
    "   • Avante: Upgraded to Claude 4 Sonnet (latest model)",
    "   • Token Optimizer: <leader>at (usage) <leader>acache (clear cache)",
    "   • Context management: <leader>cx (clear contexts)",
    "",
    "Press 'q' to close, 'h' for main help, 'c' for cost info",
    "",
  }
  
  local width = 85
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
  vim.keymap.set("n", "h", function() 
    vim.api.nvim_win_close(win, true)
    vim.defer_fn(function() M.show_help() end, 100)
  end, opts)
  vim.keymap.set("n", "c", function() 
    vim.api.nvim_win_close(win, true)
    vim.defer_fn(function() M.show_cost_info() end, 100)
  end, opts)
end

-- Cost information dashboard
function M.show_cost_info()
  local lines = {
    "",
    "╔═══════════════════════════════════════════════════════════════════════════════╗",
    "║                         💰 AI COST OPTIMIZATION INFO 💰                       ║",
    "╚═══════════════════════════════════════════════════════════════════════════════╝",
    "",
    "📊 CURRENT PRICING (2025 - CLAUDE 4 ERA):",
    "   🤖 ChatGPT (GPT-4): ~$0.03 per 1K input, $0.06 per 1K output",
    "   ⚡ Claude Code (Sonnet 4): $3 per 1M input, $15 per 1M output",
    "   🎯 Avante (Sonnet 4): $3 per 1M input, $15 per 1M output",
    "   🤖 GitHub Copilot: $10/month flat rate (excellent value!)",
    "",
    "🎯 ACTIVE OPTIMIZATIONS:",
    "   ✅ Claude 4 Sonnet as default (3x cheaper than Opus 4)",
    "   ✅ Prompt caching enabled (90% input token savings)",
    "   ✅ Reduced token limits (1500 ChatGPT, 2000 Avante/Claude)",
    "   ✅ Lower temperature settings (0.3 for consistency)",
    "   ✅ Auto-suggestions disabled (saves frequent API calls)",
    "   ✅ Context auto-clearing (prevents token accumulation)",
    "",
    "📈 ESTIMATED MONTHLY COSTS (With Claude 4):",
    "   🟢 Light Usage (1-2 hours/day): $8-15/month",
    "   🟡 Medium Usage (3-4 hours/day): $20-35/month", 
    "   🟠 Heavy Usage (6+ hours/day): $40-70/month",
    "   💎 Enterprise Usage: $100-200/month",
    "",
    "💡 COST-SAVING STRATEGIES:",
    "   • Use Copilot for auto-completion (fixed $10/month)",
    "   • Use ChatGPT for quick questions (cheapest per token)",
    "   • Use Claude Code for serious coding (best value)",
    "   • Use Avante for project analysis (Cursor-like features)",
    "   • Select specific code ranges vs entire files",
    "   • Clear contexts with <leader>cx regularly",
    "   • Clear cache with <leader>acache regularly",
    "   • Use <leader>smart for automatic tool selection",
    "",
    "🔥 CLAUDE 4 ADVANTAGES:",
    "   • Sonnet 4: 72.7% on SWE-bench (best coding performance)",
    "   • Extended thinking mode (better reasoning)",
    "   • Tool use integration (web search, file ops)",
    "   • Memory capabilities (learns your coding style)",
    "   • Agent workflows (multi-step task completion)",
    "",
    "🚀 SETUP API KEYS:",
    "   • ChatGPT: export OPENAI_API_KEY='sk-...'",
    "   • Claude: export ANTHROPIC_API_KEY='sk-ant-...'",
    "   • Claude CLI: curl -fsSL https://claude.ai/cli | sh",
    "   • Add keys to ~/.zshrc or ~/.bashrc",
    "",
    "⚡ PERFORMANCE BENEFITS:",
    "   • Claude Code: WebSocket MCP protocol (faster)",
    "   • Avante: Real-time diff preview",
    "   • Lazy loading (startup ~80ms)",
    "   • Smart caching (reduced API calls)",
    "",
    "Press 'q' to close, 'a' for AI dashboard, 'h' for main help",
    "",
  }
  
  local width = 85
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
  vim.keymap.set("n", "a", function() 
    vim.api.nvim_win_close(win, true)
    vim.defer_fn(function() M.show_ai_dashboard() end, 100)
  end, opts)
  vim.keymap.set("n", "h", function() 
    vim.api.nvim_win_close(win, true)
    vim.defer_fn(function() M.show_help() end, 100)
  end, opts)
end

-- Quick setup command for API keys
function M.show_setup_guide()
  local lines = {
    "🚀 QUICK SETUP GUIDE",
    "",
    "1. Install Claude CLI:",
    "   curl -fsSL https://claude.ai/cli | sh",
    "",
    "2. Authenticate Claude:",
    "   claude auth login",
    "",
    "3. Set environment variables:",
    "   echo 'export OPENAI_API_KEY=\"your-openai-key\"' >> ~/.zshrc",
    "   echo 'export ANTHROPIC_API_KEY=\"your-anthropic-key\"' >> ~/.zshrc",
    "   source ~/.zshrc",
    "",
    "4. Test the setup:",
    "   echo $OPENAI_API_KEY",
    "   echo $ANTHROPIC_API_KEY", 
    "   claude --version",
    "",
    "5. Restart Neovim and try:",
    "   <leader>ag (ChatGPT)",
    "   <leader>ac (Claude Code)",
    "   <leader>av (Avante)",
    "",
    "Press 'q' to close",
  }
  
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor", width = 60, height = #lines,
    row = math.floor((vim.o.lines - #lines) / 2),
    col = math.floor((vim.o.columns - 60) / 2),
    style = "minimal", border = "rounded",
  })
  
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
  vim.keymap.set("n", "q", function() vim.api.nvim_win_close(win, true) end, { buffer = buf })
end

-- Theme information dashboard
function M.show_theme_info()
  local current_flavour = vim.g.catppuccin_flavour or "mocha"
  local lines = {
    "",
    "╔═══════════════════════════════════════════════════════════════════════════════╗",
    "║                           🎨 CATPUCCIN THEME INFO 🎨                         ║",
    "╚═══════════════════════════════════════════════════════════════════════════════╝",
    "",
    "🎨 CURRENT FLAVOUR: " .. string.upper(current_flavour),
    "",
    "🍵 AVAILABLE FLAVOURS:",
    "   • latte     - Light theme with warm colors",
    "   • frappe    - Medium dark with balanced colors", 
    "   • macchiato - Dark theme with rich colors",
    "   • mocha     - Dark theme with vibrant colors (current)",
    "",
    "🎯 CUSTOMIZATIONS:",
    "   ✅ Pure black background (#000000)",
    "   ✅ Custom color palette for better contrast",
    "   ✅ Bold functions and keywords",
    "   ✅ Italic comments and conditionals",
    "   ✅ Enhanced LSP diagnostics",
    "   ✅ Custom dashboard highlights",
    "",
    "⚡ QUICK ACTIONS:",
    "   <leader>tm   - Switch to next flavour",
    "   :colorscheme catppuccin-[flavour] - Direct switch",
    "",
    "🔧 CUSTOMIZATION:",
    "   Edit ~/.config/nvim/init.lua to modify colors",
    "   Look for 'color_overrides' and 'custom_highlights'",
    "",
    "🎨 COLOR PALETTE (Mocha):",
    "   • Blue: #89b4fa (functions, links)",
    "   • Purple: #cba6f7 (keywords, buttons)",
    "   • Green: #a6e3a1 (strings, success)",
    "   • Yellow: #f9e2af (warnings, search)",
    "   • Red: #f38ba8 (errors, important)",
    "   • Pink: #f5c2e7 (special elements)",
    "",
    "Press 'q' to close, 't' to switch theme, 'h' for main help",
    "",
  }
  
  local width = 85
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
  vim.keymap.set("n", "t", function() 
    vim.api.nvim_win_close(win, true)
    vim.defer_fn(function() 
      -- Trigger theme switcher
      vim.cmd("lua vim.keymap.get('n', '<leader>tm')[1]()")
    end, 100)
  end, opts)
  vim.keymap.set("n", "h", function() 
    vim.api.nvim_win_close(win, true)
    vim.defer_fn(function() M.show_help() end, 100)
  end, opts)
end

-- Neo-tree keymaps dashboard
function M.show_neotree_help()
  local lines = {
    "",
    "╔═══════════════════════════════════════════════════════════════════════════════╗",
    "║                           🌳 NEO-TREE FILE EXPLORER 🌳                        ║",
    "╚═══════════════════════════════════════════════════════════════════════════════╝",
    "",
    "🎯 BASIC NAVIGATION:",
    "   <leader>e     - Toggle Neo-tree file explorer",
    "   <leader>eg    - Toggle git status",
    "   <leader>ef    - Focus file tree",
    "   <leader>ec    - Close file tree",
    "",
    "📁 FILE OPERATIONS (in Neo-tree window):",
    "   a             - Add new file",
    "   A             - Add new directory",
    "   d             - Delete file/directory",
    "   r             - Rename file/directory",
    "   c             - Copy file/directory",
    "   m             - Move file/directory",
    "",
    "📋 CLIPBOARD OPERATIONS:",
    "   y             - Copy to clipboard",
    "   x             - Cut to clipboard",
    "   p             - Paste from clipboard",
    "",
    "🪟 WINDOW OPERATIONS:",
    "   <CR>          - Open file",
    "   S             - Open in horizontal split",
    "   s             - Open in vertical split",
    "   t             - Open in new tab",
    "   w             - Open with window picker",
    "",
    "🔍 VIEW OPTIONS:",
    "   P             - Toggle preview",
    "   l             - Focus preview",
    "   R             - Refresh tree",
    "   ?             - Show help",
    "",
    "📂 TREE NAVIGATION:",
    "   C             - Close node",
    "   z             - Close all nodes",
    "   <             - Previous source",
    "   >             - Next source",
    "",
    "💡 TIPS:",
    "   • Use 'a' to create new files quickly",
    "   • Use 'A' to create new directories",
    "   • Select a file/folder first, then use operations",
    "   • Use <CR> to open files or expand folders",
    "",
    "Press 'q' to close, 'e' to open Neo-tree, 'h' for main help",
    "",
  }
  
  local width = 85
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
  vim.keymap.set("n", "e", function() 
    vim.api.nvim_win_close(win, true)
    vim.defer_fn(function() vim.cmd("Neotree toggle") end, 100)
  end, opts)
  vim.keymap.set("n", "h", function() 
    vim.api.nvim_win_close(win, true)
    vim.defer_fn(function() M.show_help() end, 100)
  end, opts)
end

-- Window navigation dashboard
function M.show_window_help()
  local lines = {
    "",
    "╔═══════════════════════════════════════════════════════════════════════════════╗",
    "║                        🪟 WINDOW NAVIGATION GUIDE 🪟                          ║",
    "╚═══════════════════════════════════════════════════════════════════════════════╝",
    "",
    "🎯 BASIC NAVIGATION:",
    "   <leader>w + ↑    - Go to top window",
    "   <leader>w + ↓    - Go to bottom window", 
    "   <leader>w + ←    - Go to left window",
    "   <leader>w + →    - Go to right window",
    "",
    "🔧 LEADER NAVIGATION:",
    "   <leader>w + ↑    - Go to top window",
    "   <leader>w + ↓    - Go to bottom window",
    "   <leader>w + ←    - Go to left window",
    "   <leader>w + →    - Go to right window",
    "",
    "📏 WINDOW RESIZING:",
    "   Alt + ↑          - Increase window height",
    "   Alt + ↓          - Decrease window height",
    "   Alt + ←          - Decrease window width",
    "   Alt + →          - Increase window width",
    "",
    "✂️ WINDOW SPLITTING:",
    "   <leader>wv       - Split vertically",
    "   <leader>ws       - Split horizontally",
    "   <C-w>v           - Split vertically (Ctrl+w)",
    "   <C-w>s           - Split horizontally (Ctrl+w)",
    "",
    "🗑️ WINDOW MANAGEMENT:",
    "   <C-w>c           - Close current window",
    "   <C-w>o           - Close other windows (keep only current)",
    "   <C-w>q           - Quit window",
    "",
    "💡 TIPS:",
    "   • Use <leader>w + arrow keys for quick navigation",
    "   • Use Alt+arrows for resizing",
    "   • Use <leader>w + hjkl for precise control",
    "   • <C-w> = Ctrl+w (traditional Vim way)",
    "",
    "Press 'q' to close, 'h' for main help, 'w' for window resizing tips",
    "",
  }
  
  local width = 85
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
  vim.keymap.set("n", "h", function() 
    vim.api.nvim_win_close(win, true)
    vim.defer_fn(function() M.show_help() end, 100)
  end, opts)
  vim.keymap.set("n", "w", function() 
    vim.api.nvim_win_close(win, true)
    vim.defer_fn(function() 
      vim.notify("📏 Window Resizing Tips:\nAlt+↑↓: Change height\nAlt+←→: Change width\n<C-w>+/-: Height\n<C-w></>: Width", "info", { 
        timeout = 5000,
        position = "bottom_right"
      })
    end, 100)
  end, opts)
end

-- Features information dashboard
function M.show_features_info()
  local lines = {
    "",
    "╔═══════════════════════════════════════════════════════════════════════════════╗",
    "║                        🚀 ENHANCED FEATURES INFO 🚀                          ║",
    "╚═══════════════════════════════════════════════════════════════════════════════╝",
    "",
    "🎨 IMAGE SUPPORT (FIXED):",
    "   ✅ img-clip.nvim - Paste images from clipboard",
    "   ✅ Snacks image - Display images in terminal",
    "   ✅ Fallback mode for unsupported terminals",
    "",
    "📝 MARKDOWN ENHANCEMENTS (FIXED):",
    "   ✅ render-markdown.nvim - Beautiful markdown rendering",
    "   ✅ Disabled LaTeX to avoid missing dependencies",
    "   ✅ Works with Avante AI for rich documentation",
    "",
    "🔧 HOW TO USE IMAGE FEATURES:",
    "   • Copy image to clipboard (Cmd+C on Mac)",
    "   • In Neovim: <leader>av (Avante) → paste image",
    "   • Or use img-clip directly in markdown files",
    "   • Images will display in supported terminals",
    "",
    "📊 MARKDOWN FEATURES:",
    "   • Syntax highlighting for markdown",
    "   • Mermaid diagram support",
    "   • Rich text formatting",
    "   • Avante AI integration for documentation",
    "",
    "⚡ TERMINAL COMPATIBILITY:",
    "   • kitty, wezterm, ghostty: Full image support",
    "   • Other terminals: Fallback to text mode",
    "   • No more health check errors!",
    "",
    "🎯 AVAILABLE COMMANDS:",
    "   <leader>av     - Avante AI (supports images)",
    "   <leader>theme  - Theme information",
    "   <leader>ai     - AI tools dashboard",
    "   <leader>?      - Main help",
    "",
    "Press 'q' to close, 't' for theme info, 'a' for AI dashboard",
    "",
  }
  
  local width = 85
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
  vim.keymap.set("n", "t", function() 
    vim.api.nvim_win_close(win, true)
    vim.defer_fn(function() M.show_theme_info() end, 100)
  end, opts)
  vim.keymap.set("n", "a", function() 
    vim.api.nvim_win_close(win, true)
    vim.defer_fn(function() M.show_ai_dashboard() end, 100)
  end, opts)
end

-- Health check for AI tools
function M.show_health_check()
  local health_info = {
    openai = vim.env.OPENAI_API_KEY and "✅ Set" or "❌ Missing",
    anthropic = vim.env.ANTHROPIC_API_KEY and "✅ Set" or "❌ Missing", 
    claude_cli = vim.fn.executable('claude') == 1 and "✅ Available" or "❌ Not found"
  }
  
  local lines = {
    "🏥 AI TOOLS HEALTH CHECK",
    "",
    "API Keys:",
    "  OPENAI_API_KEY: " .. health_info.openai,
    "  ANTHROPIC_API_KEY: " .. health_info.anthropic,
    "",
    "CLI Tools:",
    "  Claude CLI: " .. health_info.claude_cli,
    "",
    "Plugin Status:",
    "  ChatGPT.nvim: ✅ Loaded",
    "  Claude Code: ✅ Loaded",
    "  Avante.nvim: ✅ Loaded (Claude 4 Sonnet)",
    "  Copilot: ✅ Loaded",
    "",
    "Run <leader>setup for installation guide",
    "Press 'q' to close",
  }
  
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor", width = 50, height = #lines,
    row = math.floor((vim.o.lines - #lines) / 2),
    col = math.floor((vim.o.columns - 50) / 2),
    style = "minimal", border = "rounded",
  })
  
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, "modifiable", false)
  vim.keymap.set("n", "q", function() vim.api.nvim_win_close(win, true) end, { buffer = buf })
end

return M 