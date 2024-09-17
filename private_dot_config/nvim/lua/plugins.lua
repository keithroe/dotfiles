
-- ensure the packer plugin manager is installed
--------------------------------------------------------------------------------
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()


-- Specify plugins
--------------------------------------------------------------------------------
require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")
    -- Collection of common configurations for the Nvim LSP client
    use("neovim/nvim-lspconfig")
    -- Visualize lsp progress
    use({
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup()
        end
    })

    -- Autocompletion framework
    use("hrsh7th/nvim-cmp")
    use({
        -- cmp LSP completion
        "hrsh7th/cmp-nvim-lsp",
        -- cmp Snippet completion
        "hrsh7th/cmp-vsnip",
        -- cmp Path completion
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        after = { "hrsh7th/nvim-cmp" },
        requires = { "hrsh7th/nvim-cmp" },
    })
    -- See hrsh7th other plugins for more great completion sources!
    -- Snippet engine
    use('hrsh7th/vim-vsnip')

    -- Adds extra functionality over rust analyzer
    use("simrat39/rust-tools.nvim")

    use("p00f/clangd_extensions.nvim")

    use({
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            require('lspsaga').setup({})
        end,
    })

    -- Optional
    use("nvim-lua/popup.nvim")
    use("nvim-lua/plenary.nvim")
    use("nvim-telescope/telescope.nvim")

    -- Color schemes 
    use ({
        'shaunsingh/nord.nvim',
        commit = "78f5f001709b5b321a35dcdc44549ef93185e024", -- WORKAROUND for Invalid character bug
        use 'folke/tokyonight.nvim',
        use 'andersevenrud/nordic.nvim',
        use 'EdenEast/nightfox.nvim',
        use 'Mofiqul/dracula.nvim',
        use 'kyazdani42/blue-moon',
        use 'marko-cerovac/material.nvim',
        use { "catppuccin/nvim", as = "catppuccin" }
    })

    use 'ethanholz/nvim-lastplace'

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
    }

    use {
        -- treesitter
        'nvim-treesitter/nvim-treesitter',
    }

    use {
        -- Trouble for rust-analyzer display
        "folke/trouble.nvim",
        --requires = "kyazdani42/nvim-web-devicons", -- already required by nvim-tree
    }

    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
    }

    use {
        -- Bracket matching
        "windwp/nvim-autopairs",
    }
    use {
        -- Cursor jump highlighting
        "danilamihailov/beacon.nvim",
    }

    use {
        -- Term access
        'voldikss/vim-floaterm',
    }

    use {
        -- Fuzzy fast search
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

end)

-- the first run will install packer and our plugins
--------------------------------------------------------------------------------
if packer_bootstrap then
    require("packer").sync()
    return
end


--------------------------------------------------------------------------------
-- Plugin setup
--------------------------------------------------------------------------------

-- nvim-tree
--------------------------------------------------------------------------------
require("nvim-tree").setup({
    sort_by = "case_sensitive",
    -- open_on_setup=true,
    actions = {
        open_file = {
            resize_window = true
        }
    },
    view = {
        width=10,
        adaptive_size = true,
        --mappings = {
        --    list = {
        --        { key = "u", action = "dir_up" },
        --    },
        --},
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
})

-- nvim-treesitter
--------------------------------------------------------------------------------
require'nvim-treesitter.configs'.setup {
    -- A list of parser names, or "all" (the four listed parsers should always be installed)
    ensure_installed = { "c", "diff", "lua", "vim", "vimdoc", "rust", "toml", "cpp", "python" },
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting=false,
    },
    ident = { enable = true },
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    },
    indent = {
        enable = false,
    }
}

-- lualine - this should be before colorscheme setup 
--------------------------------------------------------------------------------
require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
}


-- material colorscheme 
--------------------------------------------------------------------------------
require('material').setup({

    contrast = {
        terminal = false, -- Enable contrast for the built-in terminal
        sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
        floating_windows = false, -- Enable contrast for floating windows
        cursor_line = false, -- Enable darker background for the cursor line
        non_current_windows = true, -- Enable darker background for non-current windows
        filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
    },

    styles = { -- Give comments style such as bold, italic, underline etc.
        comments = { --[[ italic = true ]] },
        strings = { --[[ bold = true ]] },
        keywords = { --[[ underline = true ]] },
        functions = { --[[ bold = true, undercurl = true ]] },
        variables = {},
        operators = {},
        types = {},
    },

    plugins = { -- Uncomment the plugins that you use to highlight them
        -- Available plugins:
        -- "dap",
        -- "dashboard",
        -- "gitsigns",
        -- "hop",
        -- "indent-blankline",
        -- "lspsaga",
        -- "mini",
        -- "neogit",
        -- "nvim-cmp",
        -- "nvim-navic",
        "nvim-tree",
        -- "nvim-web-devicons",
        -- "sneak",
        "telescope",
        "trouble",
        "which-key",
    },

    disable = {
        colored_cursor = false, -- Disable the colored cursor
        borders = false, -- Disable borders between verticaly split windows
        background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
        term_colors = false, -- Prevent the theme from setting terminal colors
        eob_lines = false -- Hide the end-of-buffer lines
    },

    high_visibility = {
        lighter = false, -- Enable higher contrast text for lighter style
        darker = false -- Enable higher contrast text for darker style
    },

    lualine_style = "normal", -- Lualine style ( can be 'stealth' or 'default' )

    async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

    custom_colors = nil, -- If you want to everride the default colors, set this to a function

    custom_highlights = {}, -- Overwrite highlights with your own
})

-- dracula
--------------------------------------------------------------------------------
local dracula = require("dracula")
dracula.setup({
  -- customize dracula color palette
  colors = {
    bg = "#282A36",
    fg = "#F8F8F2",
    selection = "#44475A",
    comment = "#6272A4",
    red = "#FF5555",
    orange = "#FFB86C",
    yellow = "#F1FA8C",
    green = "#50fa7b",
    purple = "#BD93F9",
    cyan = "#8BE9FD",
    pink = "#FF79C6",
    bright_red = "#FF6E6E",
    bright_green = "#69FF94",
    bright_yellow = "#FFFFA5",
    bright_blue = "#D6ACFF",
    bright_magenta = "#FF92DF",
    bright_cyan = "#A4FFFF",
    bright_white = "#FFFFFF",
    menu = "#21222C",
    visual = "#3E4452",
    gutter_fg = "#4B5263",
    nontext = "#3B4048",
  },
  -- show the '~' characters after the end of buffers
  show_end_of_buffer = true, -- default false
  -- use transparent background
  transparent_bg = true, -- default false
  -- set custom lualine background color
  lualine_bg_color = "#44475a", -- default nil
  -- set italic comment
  italic_comment = true, -- default false
  -- overrides the default highlights see `:h synIDattr`
  overrides = {
    -- Examples
    -- NonText = { fg = dracula.colors().white }, -- set NonText fg to white
    -- NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
    -- Nothing = {} -- clear highlight of Nothing
  },
})

-- nightfox
--------------------------------------------------------------------------------

local palettes = {
    --white, orange, pink
    nordfox = {
        red = { base = "#D8DEE9", bright = "#00FF00", dim = "#00FF00" }, -- self, lsp
        yellow = { base = "#8FBCBB", bright = "#8FBCBB", dim = "#8FBCBB" }, -- class names: nord7
        pink = { base = "#88C0D0", bright = "#88C0D0", dim = "#88C0D0" }, -- use: nord8
        blue = { base = "#81A1C1", bright = "#81A1C1", dim = "#81A1C1" }, -- function names: nord9
        magenta = { base = "#5E81AC", bright = "#5E81AC", dim = "#5E81AC" }, -- keywords: nord10
        green = { base = "#A3BE8C", bright = "#A3BE8C", dim = "#A3BE8C" }, -- strings, lsp: nord14
        cyan = { base = "#B48EAD", bright = "#B48EAD", dim = "#B48EAD" }, -- builin types, namespaces: nord15
        --white = { base = "#5E81AC", bright = "#5E81AC", dim = "#5E81AC" }, -- keywords: nord10
        --orange = { base = "#5E81AC", bright = "#5E81AC", dim = "#5E81AC" }, -- keywords: nord10
        --pink= "#81A1C1",
    },
}
--local palettes = {} -- uncomment for default nordfox colors

require("nightfox").setup({
    options = {
        -- Compiled file's destination location
        compile_path = vim.fn.stdpath("cache") .. "/nightfox",
        compile_file_suffix = "_compiled", -- Compiled file suffix
        transparent = false,     -- Disable setting background
        terminal_colors = true,  -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
        dim_inactive = false,    -- Non focused panes set to alternative background
        module_default = true,   -- Default enable value for modules
        colorblind = {
            enable = false,        -- Enable colorblind support
            simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
            severity = {
                protan = 0,          -- Severity [0,1] for protan (red)
                deutan = 0,          -- Severity [0,1] for deutan (green)
                tritan = 0,          -- Severity [0,1] for tritan (blue)
            },
        },
        styles = {
            -- Style to be applied to different syntax groups
            comments = "NONE",     -- Value is any valid attr-list value `:help attr-list`
            conditionals = "NONE",
            constants = "NONE",
            functions = "NONE",
            keywords = "NONE",
            numbers = "NONE",
            operators = "NONE",
            strings = "NONE",
            types = "NONE",
            variables = "NONE",
        },
        inverse = {
            -- Inverse highlight for different types
            match_paren = false,
            visual = false,
            search = false,
        },
        modules = {
            -- List of various plugins and additional options
        },
    },
    specs = {},
    groups = {},
    palettes = palettes,
})

-- catpuccin 
--------------------------------------------------------------------------------
require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false,
    show_end_of_buffer = true, -- show the '~' characters after the end of buffers
    term_colors = false,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    no_italic = true, -- Force no italic
    no_bold = true, -- Force no bold
    styles = {
        --comments = { "italic" },
        --conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    color_overrides = {
        all = {
            --flamingo = "#939ab7",
            red = "#939ab7",
        },
    },
    custom_highlights = {},
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})

-- lastplace
--------------------------------------------------------------------------------
require'nvim-lastplace'.setup {
    lastplace_ignore_buftype = {"quickfix", "nofile", "help"},
    lastplace_ignore_filetype = {"gitcommit", "gitrebase", "svn", "hgcommit"},
    lastplace_open_folds = true
}

-- trouble
--------------------------------------------------------------------------------
require("trouble").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    position = "right",
    width = 80,
}

-- todo-comments
--------------------------------------------------------------------------------
require("todo-comments").setup {
}

