-- Line Numbers & Display
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.opt.wrap = false

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- File Safety & Undo
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
-- mkdir -p ~/.vim/undodir

-- Search
-- vim.opt.ignorecase = true
-- vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = false

-- Clipboard
vim.opt.clipboard = ""   -- Vim uses its own internal clipboard

-- Mouse & Colors
vim.opt.mouse = ""           -- disable mouse
vim.opt.termguicolors = true
vim.opt.isfname:append("@-@")

-- Performance
vim.opt.updatetime = 200
vim.opt.lazyredraw = true
