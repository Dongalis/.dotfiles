-- bootstrap Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
    --{ "nvim-lualine/lualine.nvim", config = function() require("plugins.lualine") end },
    { "catppuccin/nvim", name = "catppuccin", config = function() vim.cmd.colorscheme "catppuccin" end },
    { "nvim-telescope/telescope.nvim", config = function() require("plugins.telescope") end },
    { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = function() require("plugins.treesitter") end },
    { "mbbill/undotree", config = function() require("plugins.undotree") end },
    { "tpope/vim-fugitive", config = function() require("plugins.undotree") end },
}, {
    install = { 
        colorscheme = { "gruvbox" },
        missing = true,
    },
    --checker = { enabled = true },  -- automatically check for plugin updates
})
