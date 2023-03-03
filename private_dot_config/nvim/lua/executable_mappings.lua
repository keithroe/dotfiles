--------------------------------------------------------------------------------
-- mappings
--------------------------------------------------------------------------------

-- Map the leader key to space
vim.g.mapleader = " "

-- general commands
--------------------------------------------------------------------------------

-- Write current buffer
vim.keymap.set('n', '<leader>r', '<cmd>w<cr>')
-- Write and close current buffer
vim.keymap.set('n', '<leader>x', '<cmd>x<cr>')
-- Quit all uffers at once without saving anything
vim.keymap.set('n', '<leader>qq', '<cmd>qall!<cr>')
-- Clear search highlights
vim.keymap.set('n', '<leader> ', '<cmd>noh<cr>')

-- neovim configuration
--------------------------------------------------------------------------------

-- Open mappings
vim.keymap.set('n', '<leader>ncm', '<cmd>e ~/.config/nvim/lua/mappings.lua<cr>')
-- Open plugins
vim.keymap.set('n', '<leader>ncp', '<cmd>e ~/.config/nvim/lua/plugins.lua<cr>')
-- Open UI
vim.keymap.set('n', '<leader>ncu', '<cmd>e ~/.config/nvim/lua/ui.lua<cr>')
-- Open LSP
vim.keymap.set('n', '<leader>ncl', '<cmd>e ~/.config/nvim/lua/lsp.lua<cr>')
-- Open settings
vim.keymap.set('n', '<leader>ncs', '<cmd>e ~/.config/nvim/lua/settings.lua<cr>')
-- Open init
vim.keymap.set('n', '<leader>nci', '<cmd>e ~/.config/nvim/init.lua<cr>')

-- window
--------------------------------------------------------------------------------

-- Increase the size of the current window horizontally
vim.keymap.set('n', '<leader>wf', '<C-w>|')
-- Increase the size of the current window vertically
vim.keymap.set('n', '<leader>wfh', '<C-w>-')
-- Create a new window horizontally
vim.keymap.set('n', '<leader>wh', '<C-w>s')
-- Create a new window vertically
vim.keymap.set('n', '<leader>wv', '<C-w>v')
-- Quit the current window
vim.keymap.set('n', '<leader>wq', '<C-w>q')

-- ctrl + h,j,k,l window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k', {noremap=true})
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- buffers
--------------------------------------------------------------------------------

-- Go to next buffer
vim.keymap.set('n', '<leader>bn', '<cmd>bn<cr>')
-- Go to previous buffer
vim.keymap.set('n', '<leader>bp', '<cmd>bp<cr>')
-- Toggle between last two buffers
vim.keymap.set('n', '<leader>bb', '<cmd>b#<cr>')
-- Delete the current buffer
vim.keymap.set('n', '<leader>bd', '<cmd>bd<cr>')
-- List all buffers
vim.keymap.set('n', '<leader>bl', '<cmd>ls<cr>')
-- Delete all buffers
vim.keymap.set('n', '<leader>bk', '<cmd>bufdo bd!<cr>')

-- telescope
--------------------------------------------------------------------------------

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- nvim-tree
--------------------------------------------------------------------------------

-- Toggle Nvimtree
vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeRefresh<cr>:NvimTreeToggle<cr>')

-- VIM FUGITIVE
--------------------------------------------------------------------------------

-- Git blame on the current file
vim.keymap.set('n', '<leader>gb', '<cmd>Git blame<cr>')
-- Git pull
vim.keymap.set('n', '<leader>gp', '<cmd>Git pull<cr>')
-- Git push
vim.keymap.set('n', '<leader>gpu', '<cmd>Git push<cr>')
-- Git log
vim.keymap.set('n', '<leader>gl', '<cmd>Git log<cr>')
-- Git commit
vim.keymap.set('n', '<leader>gc', '<cmd>Git commit<cr>')
-- Git status / Git
vim.keymap.set('n', '<leader>gs', '<cmd>Git<cr>')
-- Git vertial diff
vim.keymap.set('n', '<leader>gdv', '<cmd>Gvdiff<cr>')
-- Git vertical diff of master branch
vim.keymap.set('n', '<leader>gdm', '<cmd>Gvdiff master<cr>')
-- Push the current branch as a new branch to repository
vim.keymap.set('n', '<leader>gpnb', '<cmd>!gpnb<cr>')


-- trouble
--------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>tt', '<cmd>TodoTrouble<cr>')
vim.keymap.set('n', '<leader>tw', '<cmd>TroubleToggle workspace_diagnostics<cr>')
vim.keymap.set('n', '<leader>td', '<cmd>TroubleToggle document_diagnostics<cr>')
vim.keymap.set('n', '<leader>tq', '<cmd>TodoTrouble quickfix<cr>')
vim.keymap.set('n', '<leader>tl', '<cmd>TodoTrouble loclist<cr>')
vim.keymap.set('n', '<leader>tr', '<cmd>TodoTrouble references<cr>')

-- floaterm 
--------------------------------------------------------------------------------
vim.keymap.set('n', "<C-t>", '<cmd>FloatermToggle myfloat<cr>')
vim.keymap.set('t', "<C-t>", '<cmd>FloatermToggle myfloat<cr>')

-- LSP
--------------------------------------------------------------------------------

local bufopts = { noremap=true, silent=true, buffer=bufnr }
-- Restart Neovim LSP
vim.keymap.set('n', '<leader>lt', '<cmd>LspRestart<cr>')
-- Rename the current object under the cursor, this will rename all the occurrences
vim.keymap.set('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<cr>')
-- take code suggestion
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, bufopts)
-- Jump to object declaration
vim.keymap.set('n', '<leader>ldd', '<cmd>lua vim.lsp.buf.declaration()<cr>')
-- Jump to object definition
vim.keymap.set('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<cr>')
-- Show the information of the object under the cursor
vim.keymap.set('n', '<leader>lh', '<cmd>lua vim.lsp.buf.hover()<cr>')
-- Jump to implementation
vim.keymap.set('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<cr>')
-- Show signature of the object under the cursor
vim.keymap.set('n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
-- Jump to type definition
vim.keymap.set('n', '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
-- Show references of the object under the cursor
vim.keymap.set('n', '<leader>le', '<cmd>lua vim.lsp.buf.references()<cr>')
-- Show document symbol list of the current file
vim.keymap.set('n', '<leader>lds', '<cmd>lua vim.lsp.buf.document_symbol()<cr>')
-- Searches for a specific symbol in all the files in the current folder/project
vim.keymap.set('n', '<leader>lws', '<cmd>lua vim.lsp.buf.workspace_symbol()<cr>')
-- Format the current file
vim.keymap.set('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<cr>')
-- Jump to the previous diagnostic entry
vim.keymap.set('n', '<leader>lp', '<cmd>lua vim.diagnostic.goto_prev({ float = false })<cr>')
-- Jump to the next diagnostic entry
vim.keymap.set('n', '<leader>ln', '<cmd>lua vim.diagnostic.goto_next({ float = false })<cr>')
--vim.keymap.set('n', '<leader> ', '<cmd>lua vim.diagnostic.goto_next({ float = false })<cr>')

-- completion
--------------------------------------------------------------------------------
-- NB: these are set in lsp.lua in cmp.setup.  can move here if i can figure out
--     how to apply them only when complete menu is up 
--local cmp = require("cmp")
--vim.keymap.set('i', '<Tab>', cmp.mapping.select_next_item())
--vim.keymap.set('i', '<S-Tab>', cmp.mapping.select_prev_item())
--vim.keymap.set('i', '<C-e>', cmp.mapping.close())
--vim.keymap.set('i', '<C-Space>', cmp.mapping.complete())
--vim.keymap.set('i', '<CR>', cmp.mapping.confirm({
--    behavior = cmp.ConfirmBehavior.Insert,
--    select = true,
--}))

-- language specific
--------------------------------------------------------------------------------

-- Typescript
-- Run current script with ts-node
vim.keymap.set('n', '<leader>pt', '<cmd>!ts-node %<cr>')

-- Javascript
-- Run current script with node
vim.keymap.set('n', '<leader>pj', '<cmd>!node %<cr>')

-- plugins
--------------------------------------------------------------------------------

-- Vimspector
vim.keymap.set('n', '<leader>il', '<Plug>VimspectorLaunch')
vim.keymap.set('n', '<leader>ir', '<cmd>VimspectorReset<cr>')
vim.keymap.set('n', '<leader>ic', '<Plug>VimspectorContinue')
vim.keymap.set('n', '<leader>ii', '<Plug>VimspectorRunToTheCursor')
vim.keymap.set('n', '<leader>ib', '<Plug>VimspectorToggleBreakpoint')
vim.keymap.set('n', '<leader>isi', '<Plug>VimspectorStepInto')
vim.keymap.set('n', '<leader>iso', '<Plug>VimspectorStepOut')
vim.keymap.set('n', '<leader>isv', '<Plug>VimspectorStepOver')
