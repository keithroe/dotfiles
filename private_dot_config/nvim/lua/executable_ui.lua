--------------------------------------------------------------------------------
--
-- UI
--------------------------------------------------------------------------------

-- Fix sign column (the column before the numbers) to avoid layout shifting
vim.o.signcolumn = 'yes:1'
-- Hide unused command line
vim.o.ls = 0
--vim.o.ch = 0
-- Enables 24-bit RGB color in the |TUI|
vim.o.termguicolors = true
-- Set 4 lines on the edge of the screen
vim.o.scrolloff = 4
-- Highlight cursor line
vim.o.cursorline = false
-- Show column markers at column 80 and 100
vim.o.colorcolumn = 80
-- One status line for Neovim instance instead one per window
vim.o.laststatus = 3

-- Set default theme
--vim.cmd 'colorscheme night-owl'
--vim.cmd 'colorscheme nord'
--vim.cmd 'colorscheme tokyonight-moon'
--vim.cmd 'colorscheme nordic'
--vim.cmd 'colorscheme nordfox'
--vim.cmd 'colorscheme dracula'
--vim.cmd 'colorscheme catppuccin'
--vim.cmd 'colorscheme blue-moon'
vim.cmd 'colorscheme material'

-- Hides tildes from non-existing lines
--
vim.cmd 'hi EndOfBuffer guifg=bg'
