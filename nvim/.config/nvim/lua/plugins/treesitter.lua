require'nvim-treesitter'.setup {
  -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
  install_dir = vim.fn.stdpath('data') .. '/site'
}

require'nvim-treesitter'.install {
    'bash',
    'css',
    'json',
    'lua',
    'python',
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'bash', 'css', 'json', 'lua', 'python', 'sh' },
  callback = function() vim.treesitter.start() end,
})
