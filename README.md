# 🚀 DUNGNT's ULTIMATE Neovim Setup (Claude 4 Edition)

## 🎯 Overview

A powerful, AI-enhanced Neovim configuration featuring **Claude 4 Sonnet**, **ChatGPT**, **GitHub Copilot**, and the beautiful **Catppuccin Mocha** theme. Built for maximum productivity with cost optimization, auto-formatting, and session management.

## 🤖 AI-Powered Features

### 🧠 ChatGPT (OpenAI GPT-4)

- **Chat Interface**: `<leader>ag` - Open ChatGPT chat
- **Code Editing**: `<leader>ae` - Edit with instructions (works in normal + visual mode)
- **Act As**: `<leader>aa` - Predefined prompts
- **Quick Access**: `<D-Enter>` - Mac shortcut
- **Cost Optimized**: GPT-4, max 1500 tokens, temperature 0.3

### ⚡ Claude Code (WebSocket MCP)

- **Toggle**: `<leader>ac` - Toggle Claude Code interface
- **Focus**: `<leader>af` - Focus Claude Code window
- **Resume**: `<leader>ar` - Resume session
- **Continue**: `<leader>aC` - Continue conversation
- **Add Context**: `<leader>ab` - Add current buffer
- **Send Selection**: `<leader>as` - Send visual selection
- **Diff Actions**: `<leader>aA` (accept) / `<leader>aD` (deny)
- **Status Check**: `<leader>cs` - Check status
- **Cost Optimized**: Claude 4 Sonnet, max 2000 tokens, prompt caching (90% savings)

### 🎯 Avante AI (Cursor-like IDE)

- **Ask AI**: `<leader>av` - Ask Avante (normal + visual mode)
- **Edit with AI**: `<leader>ave` - Edit with Avante (works with selection)
- **Refresh**: `<leader>avr` - Refresh (visual mode only)
- **Claude 4 Sonnet**: Latest model with extended thinking
- **Cost Optimized**: Max 2000 tokens, temperature 0.3, prompt caching

### 🤖 GitHub Copilot

- **Next Suggestion**: `<C-j>` (insert mode)
- **Previous Suggestion**: `<C-k>` (insert mode)
- **Accept Suggestion**: `<C-l>` (insert mode)
- **Fixed Cost**: $10/month flat rate

## 🎨 UI & Experience

### 🌟 Catppuccin Mocha Theme

- **Pure Black Background**: `#000000` for ultimate contrast
- **Custom Color Palette**: Enhanced visibility and aesthetics
- **Theme Switcher**: `<leader>tm` - Switch between flavours
- **Theme Info**: `<leader>theme` - Detailed theme information
- **Flavours**: latte, frappe, macchiato, mocha

### 🚀 Epic Dashboard

- **Beautiful ASCII Art**: Neovim logo with custom styling
- **Quick Access Buttons**: File operations, AI tools, configuration
- **Welcome Animation**: Enhanced startup experience
- **Custom Highlights**: Optimized for Catppuccin theme
- **Fixed Size**: No scrolling issues, stable layout

### 📊 Status & Notifications

- **Lualine**: Beautiful status line with auto-theme
- **Noice**: Enhanced UI components
- **Notify**: Beautiful notifications with slide animation

## 🔍 Search & Navigation

### 🔎 Telescope

- **Find Files**: `<leader>ff` - Fuzzy file finder
- **Live Grep**: `<leader>fg` - Search in files
- **Find Buffers**: `<leader>fb` - Buffer switcher
- **Recent Files**: `<leader>fr` - Old files

### 🌳 Neo-tree File Explorer

- **Toggle**: `<leader>e` - Toggle file tree
- **Git Status**: `<leader>eg` - Git status view
- **Focus**: `<leader>ef` - Focus file tree
- **Close**: `<leader>ec` - Close file tree
- **Help**: `<leader>tree` - Show keymaps

## 💻 Development Tools

### 🔧 LSP (Language Server Protocol)

- **Format**: `<leader>lf` - Format buffer
- **Code Action**: `<leader>la` - Code actions
- **Diagnostics**: `<leader>ld` - Show diagnostics
- **Rename**: `<leader>lr` - Rename symbol
- **Hover**: `<leader>lh` - Hover documentation
- **Auto Format**: On save for supported files

### 🛠️ Essential Tools

- **Mason**: Package manager for LSP/DAP/linters
- **Treesitter**: Syntax highlighting and indentation
- **Autopairs**: Auto bracket pairing
- **Comment**: `<leader>/` - Toggle comments
- **ToggleTerm**: `<C-\>` - Toggle terminal

## 📝 Code Formatting & Session Management

### 🎨 Conform.nvim (Auto Formatting)

- **Auto Format on Save**: Automatically format code when saving
- **Manual Format**: `<leader>f` - Format current buffer
- **Format Entire File**: `<leader>fF` - Format whole file
- **Supported Languages**: Python (black), JS/TS (prettier), Lua (stylua), Rust (rustfmt), Go (gofmt), Ruby, PHP, SQL
- **LSP Fallback**: Uses LSP formatting if external formatter unavailable
- **Configurable**: Custom formatter settings for each language

### 💾 Persisted.nvim (Session Management)

- **Auto Save Session**: Automatically save workspace when quitting
- **Manual Save**: `<leader>ss` - Save current session
- **Load Session**: `<leader>sl` - Load saved session
- **Delete Session**: `<leader>sd` - Delete session
- **Stop Session**: `<leader>st` - Stop session
- **Quick Save & Quit**: `<leader>qq` - Save session and quit all
- **Git Branch Aware**: Separate sessions for different branches
- **Workspace Restoration**: Restore files, windows, tabs, and layout

## 🌿 Git Integration

### 📊 Vim-Fugitive (Complete Git Solution)

- **Status**: `<leader>gs` - Git status
- **Diff**: `<leader>gd` - Git diff
- **Blame**: `<leader>gb` - Git blame
- **Log**: `<leader>gl` - Git log
- **Grep**: `<leader>gg` - Git grep
- **Commit**: `<leader>gc` - Git commit
- **Push**: `<leader>gp` - Git push
- **Fetch**: `<leader>gf` - Git fetch
- **Merge**: `<leader>gm` - Git merge
- **Rebase**: `<leader>gr` - Git rebase
- **Add File**: `<leader>ga` - Add current file
- **Add All**: `<leader>gaa` - Add all files
- **Write**: `<leader>gw` - Add and stage
- **Read**: `<leader>gr` - Checkout file
- **Browse**: `<leader>gbrowse` - Git browse

### 🎯 Git Signs

- **Visual Indicators**: Add/change/delete signs
- **Line Highlighting**: Current line blame
- **Enhanced Status**: Git integration in status line

## 🪟 Window Management

### 🎯 Navigation

- **Arrow Keys**: `<leader>w + ↑↓←→` - Navigate windows
- **Resize**: `Alt + ↑↓←→` - Resize windows
- **Split**: `<leader>wv` (vertical) / `<leader>ws` (horizontal)
- **Help**: `<leader>window` - Window navigation guide

## 💰 Cost Optimization

### 🎯 Active Optimizations

- **Claude 4 Sonnet**: 3x cheaper than Opus 4
- **Prompt Caching**: 90% input token savings
- **Reduced Limits**: 1500-2000 token limits
- **Lower Temperature**: 0.3 for consistency
- **Auto-suggestions Disabled**: Saves frequent API calls
- **Context Management**: Auto-clearing to prevent accumulation

### 📊 Cost Dashboard

- **Usage Tracking**: `<leader>at` - Show token usage
- **Cache Management**: `<leader>acache` - Clear prompt cache
- **Optimization Tips**: `<leader>ao` - Show optimization settings
- **Cost Info**: `<leader>cost` - Detailed cost information

### 💡 Cost-Saving Strategies

- **Use Copilot**: Fixed $10/month for auto-completion
- **Selective Context**: Choose specific code vs entire files
- **Regular Clearing**: Clear contexts and cache regularly
- **Smart Tool Selection**: Use appropriate AI for each task

## 🚀 Quick Setup

### 1. Prerequisites

```bash
# Install Neovim (if not already installed)
brew install neovim

# Install Node.js and ripgrep
brew install node ripgrep
```

### 2. Clone Configuration

```bash
# Backup existing config (if any)
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this repository
git clone <your-repo-url> ~/.config/nvim
```

### 3. Install Claude CLI

```bash
# Install Claude CLI
curl -fsSL https://claude.ai/cli | sh

# Authenticate
claude auth login
```

### 4. Set API Keys

```bash
# Add to your shell config (~/.zshrc or ~/.bashrc)
export OPENAI_API_KEY="your-openai-key-here"
export ANTHROPIC_API_KEY="your-anthropic-key-here"

# Reload config
source ~/.zshrc
```

### 5. Install Formatters (Optional but Recommended)

```bash
# Python
pip install black isort

# JavaScript/TypeScript
npm install -g prettier prettierd

# Lua
brew install stylua

# Rust
rustup component add rustfmt

# Go
go install golang.org/x/tools/cmd/goimports
```

### 6. Start Neovim

```bash
nvim
:Lazy sync
```

## 🎯 Keymaps Reference

### 🤖 AI Tools

| Key              | Action            | Description              |
| ---------------- | ----------------- | ------------------------ |
| `<leader>ai`     | AI Dashboard      | Show all AI tools        |
| `<leader>ag`     | ChatGPT           | Open ChatGPT chat        |
| `<leader>ae`     | Edit with ChatGPT | Edit with instructions   |
| `<leader>aa`     | ChatGPT Act As    | Predefined prompts       |
| `<leader>ac`     | Claude Code       | Toggle Claude Code       |
| `<leader>af`     | Focus Claude      | Focus Claude Code window |
| `<leader>ar`     | Resume Claude     | Resume Claude session    |
| `<leader>aC`     | Continue Claude   | Continue conversation    |
| `<leader>ab`     | Add to Claude     | Add buffer to context    |
| `<leader>as`     | Send to Claude    | Send selection to Claude |
| `<leader>av`     | Avante Ask        | Ask Avante AI            |
| `<leader>ave`    | Avante Edit       | Edit with Avante         |
| `<leader>avr`    | Avante Refresh    | Refresh Avante           |
| `<leader>at`     | Token Usage       | Show usage dashboard     |
| `<leader>acache` | Clear Cache       | Clear prompt cache       |
| `<leader>cost`   | Cost Info         | Show cost optimization   |
| `<leader>setup`  | Setup Guide       | Show setup instructions  |

### 📁 File Operations

| Key          | Action       | Description          |
| ------------ | ------------ | -------------------- |
| `<leader>e`  | Toggle Tree  | Toggle Neo-tree      |
| `<leader>eg` | Git Tree     | Toggle git status    |
| `<leader>ef` | Focus Tree   | Focus file tree      |
| `<leader>ec` | Close Tree   | Close file tree      |
| `<leader>ff` | Find Files   | Telescope find files |
| `<leader>fg` | Live Grep    | Search in files      |
| `<leader>fb` | Find Buffers | Buffer switcher      |
| `<leader>fr` | Recent Files | Old files            |

### 🌿 Git Operations

| Key           | Action      | Description      |
| ------------- | ----------- | ---------------- |
| `<leader>gs`  | Git Status  | Show git status  |
| `<leader>gd`  | Git Diff    | Show git diff    |
| `<leader>gb`  | Git Blame   | Show git blame   |
| `<leader>gl`  | Git Log     | Show git log     |
| `<leader>gg`  | Git Grep    | Search in git    |
| `<leader>gc`  | Git Commit  | Commit changes   |
| `<leader>gp`  | Git Push    | Push to remote   |
| `<leader>ga`  | Git Add     | Add current file |
| `<leader>gaa` | Git Add All | Add all files    |

### 💻 Development

| Key          | Action      | Description         |
| ------------ | ----------- | ------------------- |
| `<leader>lf` | Format      | Format buffer       |
| `<leader>la` | Code Action | LSP code actions    |
| `<leader>ld` | Diagnostics | Show diagnostics    |
| `<leader>lr` | Rename      | Rename symbol       |
| `<leader>lh` | Hover       | Hover documentation |
| `<leader>/`  | Comment     | Toggle comment      |
| `<C-\>`      | Terminal    | Toggle terminal     |

### 🎨 Formatting & Sessions

| Key          | Action         | Description           |
| ------------ | -------------- | --------------------- |
| `<leader>f`  | Format         | Format buffer         |
| `<leader>fF` | Format File    | Format entire file    |
| `<leader>ss` | Save Session   | Save current session  |
| `<leader>sl` | Load Session   | Load saved session    |
| `<leader>sd` | Delete Session | Delete session        |
| `<leader>st` | Stop Session   | Stop session          |
| `<leader>qq` | Save & Quit    | Save session and quit |

### 🪟 Window Management

| Key                | Action   | Description      |
| ------------------ | -------- | ---------------- |
| `<leader>w + ↑↓←→` | Navigate | Navigate windows |
| `Alt + ↑↓←→`       | Resize   | Resize windows   |
| `<leader>wv`       | Split V  | Vertical split   |
| `<leader>ws`       | Split H  | Horizontal split |

### 🎨 Theme & UI

| Key                | Action        | Description               |
| ------------------ | ------------- | ------------------------- |
| `<leader>tm`       | Theme Switch  | Switch Catppuccin flavour |
| `<leader>theme`    | Theme Info    | Show theme information    |
| `<leader>tree`     | Tree Help     | Show Neo-tree keymaps     |
| `<leader>window`   | Window Help   | Show window navigation    |
| `<leader>features` | Features Info | Show enhanced features    |

### 🔧 Utilities

| Key           | Action     | Description                 |
| ------------- | ---------- | --------------------------- |
| `<leader>?`   | Help       | Show main help              |
| `<leader>ch`  | Health     | Check health                |
| `<leader>so`  | Source     | Source current file         |
| `<leader>qq`  | Quit All   | Save session & quit         |
| `<leader>w`   | Save       | Save current file           |
| `<leader>sa`  | Select All | Select all text             |
| `<leader>syn` | Syntax     | Refresh syntax highlighting |

## 🔧 Troubleshooting

### Common Issues

1. **Plugins not loading**

   ```vim
   :Lazy sync
   :checkhealth
   ```

2. **API keys not working**

   ```bash
   echo $OPENAI_API_KEY
   echo $ANTHROPIC_API_KEY
   claude --version
   ```

3. **Claude Code not working**

   ```bash
   # Check Claude CLI installation
   claude --version

   # Re-authenticate if needed
   claude auth login
   ```

4. **LSP not working**

   ```vim
   :Mason
   # Install required language servers
   ```

5. **Formatting not working**

   ```bash
   # Install formatters
   pip install black isort
   npm install -g prettier prettierd
   brew install stylua
   ```

6. **Syntax highlighting issues**

   ```vim
   <leader>syn  # Refresh syntax highlighting
   :TSUpdate    # Update treesitter parsers
   :TSInstall ruby  # Install specific parser
   ```

7. **Performance issues**
   - Check for large files
   - Monitor token usage with `<leader>at`
   - Clear cache with `<leader>acache`

### Health Check

```vim
:checkhealth
:checkhealth lazy
:checkhealth mason
:checkhealth nvim-treesitter
:checkhealth conform
```

## 📚 Supported Languages

- **Lua** - Full LSP support with lua_ls
- **Python** - Pyright LSP with type checking, black/isort formatting
- **JavaScript/TypeScript** - tsserver with full support, prettier formatting
- **Rust** - rust-analyzer with cargo integration, rustfmt formatting
- **Go** - gopls with Go modules, gofmt formatting
- **Java** - jdtls with Maven/Gradle
- **C/C++** - clangd with compilation database
- **HTML/CSS** - Built-in LSPs with validation, prettier formatting
- **JSON/YAML** - Built-in LSPs with schema validation, prettier formatting
- **Markdown** - Treesitter with enhanced highlighting, prettier formatting
- **Bash** - Treesitter with shell integration, shfmt formatting
- **Ruby** - Treesitter with syntax highlighting
- **PHP** - Treesitter with syntax highlighting
- **SQL** - Treesitter with syntax highlighting

## 🎉 Features Highlights

### 🚀 AI-Powered Development

- **Multi-Model Support**: ChatGPT, Claude 4 Sonnet, GitHub Copilot
- **Cost Optimization**: Smart token management and caching
- **Context Awareness**: Intelligent code analysis and suggestions
- **Real-time Assistance**: Live coding help and explanations

### 🎨 Modern UI/UX

- **Catppuccin Theme**: Beautiful, customizable color scheme
- **Epic Dashboard**: Stunning startup screen with quick access
- **Enhanced Notifications**: Beautiful, informative notifications
- **Responsive Design**: Optimized for different screen sizes
- **Fixed Layout**: Stable dashboard without scrolling issues

### 🔧 Developer Experience

- **Auto-formatting**: Format on save for clean, consistent code
- **Session Management**: Persistent workspace across sessions
- **Git Integration**: Complete Git workflow with vim-fugitive
- **LSP Support**: Full language server integration
- **Terminal Integration**: Seamless terminal access
- **Syntax Highlighting**: Enhanced code coloring with Treesitter

### 💾 Workspace Persistence

- **Auto-save Sessions**: Never lose your workspace
- **Git Branch Aware**: Separate sessions per branch
- **Quick Save & Quit**: One key to save and exit
- **Workspace Restoration**: Restore files, windows, and layout

## 🆘 Support & Help

### Built-in Help System

- `<leader>?` - Main help dashboard
- `<leader>ai` - AI tools dashboard
- `<leader>cost` - Cost optimization info
- `<leader>setup` - Setup guide
- `<leader>theme` - Theme information
- `<leader>tree` - Neo-tree keymaps
- `<leader>window` - Window navigation guide
- `<leader>features` - Enhanced features info

### External Resources

- **Neovim**: https://neovim.io/
- **Lazy.nvim**: https://github.com/folke/lazy.nvim
- **Catppuccin**: https://github.com/catppuccin/nvim
- **ChatGPT.nvim**: https://github.com/jackMort/ChatGPT.nvim
- **Claude Code**: https://github.com/coder/claudecode.nvim
- **Avante**: https://github.com/yetone/avante.nvim
- **Conform.nvim**: https://github.com/stevearc/conform.nvim
- **Persisted.nvim**: https://github.com/olimorris/persisted.nvim

---

**🎯 Ready to code like a legend with Claude 4 Sonnet? Let's make some magic happen! 🚀**
