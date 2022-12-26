return require('packer').startup(function(use)



    use {
        -- Packer can manage itself
        'wbthomason/packer.nvim',
    }

    use ({
        -- color schemes
        'shaunsingh/nord.nvim',
        commit = "78f5f001709b5b321a35dcdc44549ef93185e024", -- WORKAROUND for Invalid character bug
    })

    use {

        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
    }

    use {
        -- Used to install rust analyzer
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }

    use {
        -- Attach rust-analyzer to nvim
        'simrat39/rust-tools.nvim',
    }

    use {
        -- treesitter
        'nvim-treesitter/nvim-treesitter',
    }

    use {
        -- Completion framework:
        'hrsh7th/nvim-cmp',
    }

    use {
        -- LSP completion source:
        'hrsh7th/cmp-nvim-lsp',
    }

    use {
        -- Useful completion sources:
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-vsnip',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'hrsh7th/vim-vsnip',
    }

    use {
        -- Trouble for rust-analyzer display
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
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

end)
