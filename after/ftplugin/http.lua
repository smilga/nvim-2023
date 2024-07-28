vim.api.nvim_set_keymap("n", "<C-[>", ":lua require('kulala').jump_prev()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-]>", ":lua require('kulala').jump_next()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-CR>", ":lua require('kulala').run()<CR>", { noremap = true, silent = true })
