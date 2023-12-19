vim.g.mapleader = ','

vim.keymap.set('n', 'w', ':call camelcasemotion#Motion("w", v:count1, "n")<cr>')
vim.keymap.set('n', 'b', ':call camelcasemotion#Motion("b", v:count1, "n")<cr>')
vim.keymap.set('n', 'e', ':call camelcasemotion#Motion("e", v:count1, "n")<cr>')
vim.keymap.set('v', 'w', ':call camelcasemotion#Motion("w", v:count1, "v")<cr>')
vim.keymap.set('v', 'b', ':call camelcasemotion#Motion("b", v:count1, "v")<cr>')
vim.keymap.set('v', 'e', ':call camelcasemotion#Motion("e", v:count1, "v")<cr>')

vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', { desc = "Save File" })
vim.keymap.set('n', '<leader>k', '<cmd>BD!<cr>', { desc = "Kill Buffer" })
vim.keymap.set('n', '<leader>n', '<cmd>:NvimTreeToggle<cr>', { desc = "File Tree" })
vim.keymap.set('n', '<leader>m', '<cmd>:NvimTreeFindFile<cr>', { desc = "File Tree Focus" })
vim.keymap.set('n', '<leader>f', '<cmd>:Telescope find_files<cr>', { desc = "Find File" })
vim.keymap.set('n', '<leader>l', function() require('telescope.builtin').buffers({sort_lastused=true}) end, { desc = "Buffers" })
vim.keymap.set('n', '<leader>j', '<cmd>:Telescope jumplist<cr>', { desc = "Jumplist" })
vim.keymap.set('n', '<leader>d', '<cmd>:Telescope diagnostics<cr>', { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>s", '<cmd>:Telescope live_grep<cr>', { desc = "Search" })
vim.keymap.set("n", "<leader>t", '<cmd>:edit term://zsh<cr>', { desc = "Terminal" })
vim.keymap.set("n", "<leader>o", '<cmd>:Oil<cr>', { desc = "File buffer 🤯" })
vim.keymap.set("n", "<leader>ec", '<cmd>:Telescope colorscheme<cr>', { desc = "Colorschemes" })
vim.keymap.set("n", "<leader>es", '<cmd>:PackerSync<cr>', { desc = "Sync Plugins" })

local function on_list(options)
  vim.fn.setqflist({}, ' ', options)
  vim.api.nvim_command('cfirst')
end
vim.keymap.set("n", "gd", function() vim.lsp.buf.definition({on_list=on_list}) end, opts)
vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
vim.keymap.set("n", "gt", function() require('test-helpers').switch() end, opts)

-- Git related shortkeys
vim.keymap.set('n', '<leader>gc', '<cmd>:Telescope git_commits<cr>', { desc = "Commits" })
vim.keymap.set('n', '<leader>gb', '<cmd>:Telescope git_branches<cr>', { desc = "Branches" })
vim.keymap.set('n', '<leader>gp', '<cmd>:Gitsigns preview_hunk<cr>', { desc = "Preview Hunk" })
vim.keymap.set('n', '<leader>gs', '<cmd>:Gitsigns stage_hunk<cr>', { desc = "Stage Hunk" })
vim.keymap.set('n', '<leader>gr', '<cmd>:Gitsigns reset_hunk<cr>', { desc = "Reset Hunk" })
vim.keymap.set('n', '<leader>gd', '<cmd>:Gitsigns diffthis<cr>', { desc = "Diff" })
vim.keymap.set('n', '<leader>gl', '<cmd>:Gitsigns blame_line<cr>', { desc = "Line Blame" })
vim.keymap.set('n', '<leader>gj', '<cmd>:Telescope git_status<cr>', { desc = "Status" })
vim.keymap.set('n', '<leader>go', '<cmd>:DiffviewOpen<cr>', { desc = "Diff View Open" })
vim.keymap.set('n', '<leader>gw', '<cmd>:DiffviewClose<cr>', { desc = "Diff View Close" })
-- Code related shortkeys prefixed with c
vim.keymap.set('n', '<leader>cr', function() vim.lsp.buf.rename() end, { desc = "Rename" })
vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, { desc = "Actions" })
vim.keymap.set("n", "<leader>cf", function() vim.lsp.buf.format() end, { desc = "Format" })
vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, { desc = "Documentation" })
vim.keymap.set('n', '<leader>cu', '<cmd>:Telescope lsp_references<cr>', { desc = "References" })
vim.keymap.set("n", "<leader>cd", '<cmd>:Telescope lsp_definitions<cr>', { desc = "Definitions" })
vim.keymap.set("n", "<leader>cs", '<cmd>:Telescope lsp_document_symbols<cr>', { desc = "Symbols" })
vim.keymap.set("n", "<leader>cn", '<cmd>:PhpActor new_class<cr>', { desc = "New PHP Class" })


vim.keymap.set("i", "<C-J>", function() require("copilot.suggestion").next() end, { desc = "Copilot" })
vim.keymap.set("i", "<C-K>", function() require("copilot.suggestion").prev() end, { desc = "Copilot" })
vim.keymap.set("i", "<C-L>", function() require("copilot.suggestion").accept() end, { desc = "Copilot" })
-- fixer/linter run
-- code actions
--
vim.keymap.set('i', '<C-J>', '<C-\\><C-N><C-w>j')
vim.keymap.set('i', '<C-K>', '<C-\\><C-N><C-w>k')
vim.keymap.set('i', '<C-H>', '<C-\\><C-N><C-w>h')
vim.keymap.set('i', '<C-L>', '<C-\\><C-N><C-w>l')
vim.keymap.set('t', '<C-J>', '<C-\\><C-N><C-w>j')
vim.keymap.set('t', '<C-K>', '<C-\\><C-N><C-w>k')
vim.keymap.set('t', '<C-H>', '<C-\\><C-N><C-w>h')
vim.keymap.set('t', '<C-L>', '<C-\\><C-N><C-w>l')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

vim.keymap.set('n', '<C-J>', '<C-W><C-J>')
vim.keymap.set('n', '<C-K>', '<C-W><C-K>')
vim.keymap.set('n', '<C-H>', '<C-W><C-H>')
vim.keymap.set('n', '<C-L>', '<C-W><C-L>')

vim.keymap.set({ 'n', 'x' }, 'cp', '"+y')
vim.keymap.set({ 'n', 'x' }, 'cv', '"+p')

vim.keymap.set('n', '<CR>', '<cmd>:noh<CR><CR>', { desc = "Clear Search" })
