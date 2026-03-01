local telescope = require("telescope")
local builtin = require('telescope.builtin')

telescope.setup({
    defaults = {
        vimgrep_arguments = {
            "rg",                -- ripgrep
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",          -- show hidden files
            "--follow",          -- follow symlinks
        },
    },
    pickers = {
        find_files = {
            hidden = true,
            follow = true,
        },
--        buffers = {
--            sort_lastused = true
--        },
    },
})

-- Regular
vim.keymap.set('n', '<leader>ff', builtin.find_files)
vim.keymap.set('n', '<leader>fg', builtin.live_grep)
vim.keymap.set('n', '<leader>fb', builtin.buffers)
vim.keymap.set('n', '<leader>fws', function()
    builtin.grep_string({search = vim.fn.expand("<cword>") });
end)
vim.keymap.set('n', '<leader>fWs', function()
    builtin.grep_string({search = vim.fn.expand("<cWORD>") });
end)
vim.keymap.set('n', '<leader>fs', function()
    builtin.grep_string({search = vim.fn.input("Grep > ") });
end)

-- Git
vim.keymap.set('n', '<leader>gf', builtin.git_files)
