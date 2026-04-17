local gh = function(x) return 'https://github.com/' .. x end

vim.pack.add({
    { src = gh('catppuccin/nvim'), name = 'catppuccin' },
--    { src = gh('nvim-treesitter/nvim-treesitter')},
    { src = gh('mbbill/undotree') },
    { src = gh('tpope/vim-fugitive') },
})

vim.cmd.colorscheme("catppuccin")

--require("plugins.treesitter")
require("plugins.undotree")
require("plugins.vim-fugitive")
