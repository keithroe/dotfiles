
-- Rust LSP
--------------------------------------------------------------------------------
local function on_attach(client, buffer)
    -- This callback is called when the LSP is atttached/enabled for this buffer
    -- we could set keymaps related to LSP, etc here.
end

-- Configure LSP through rust-tools.nvim plugin.
-- rust-tools will configure and enable certain LSP features for us.
-- See https://github.com/simrat39/rust-tools.nvim#configuration
local opts = {
    tools = {
        runnables = {
            use_telescope = true,
        },
        inlay_hints = {
            auto = true,
            show_parameter_hints = true,
            parameter_hints_prefix = "<- ",
            other_hints_prefix = "=> ",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy",
                },
            },
        },
    },
}

require("rust-tools").setup(opts)


-- CPP LSP
--------------------------------------------------------------------------------

require("clangd_extensions").setup {
    server = {
        -- options to pass to nvim-lspconfig
        -- i.e. the arguments to require("lspconfig").clangd.setup({})
    },
    extensions = {
        -- defaults:
        -- Automatically set inlay hints (type hints)
        autoSetHints = true,
        -- These apply to the default ClangdSetInlayHints command
        inlay_hints = {
            -- Only show inlay hints for the current line
            only_current_line = false,
            -- Event which triggers a refersh of the inlay hints.
            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- not that this may cause  higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = "CursorHold",
            -- whether to show parameter hints with the inlay hints or not
            show_parameter_hints = true,
            -- prefix for parameter hints
            parameter_hints_prefix = "<- ",
            -- prefix for all the other hints (type, chaining)
            other_hints_prefix = "=> ",
            -- whether to align to the length of the longest line in the file
            max_len_align = false,
            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,
            -- whether to align to the extreme right or not
            right_align = false,
            -- padding from the right if right_align is true
            right_align_padding = 7,
            -- The color of the hints
            highlight = "Comment",
            -- The highlight group priority for extmark
            priority = 100,
        },
        ast = {
            -- These are unicode, should be available in any font
            role_icons = {
                 type = "🄣",
                 declaration = "🄓",
                 expression = "🄔",
                 statement = ";",
                 specifier = "🄢",
                 ["template argument"] = "🆃",
            },
            kind_icons = {
                Compound = "🄲",
                Recovery = "🅁",
                TranslationUnit = "🅄",
                PackExpansion = "🄿",
                TemplateTypeParm = "🅃",
                TemplateTemplateParm = "🅃",
                TemplateParamObject = "🅃",
            },
            --[[ These require codicons (https://github.com/microsoft/vscode-codicons)
            role_icons = {
                type = "",
                declaration = "",
                expression = "",
                specifier = "",
                statement = "",
                ["template argument"] = "",
            },

            kind_icons = {
                Compound = "",
                Recovery = "",
                TranslationUnit = "",
                PackExpansion = "",
                TemplateTypeParm = "",
                TemplateTemplateParm = "",
                TemplateParamObject = "",
            }, ]]

            highlights = {
                detail = "Comment",
            },
        },
        memory_usage = {
            border = "none",
        },
        symbol_info = {
            border = "none",
        },
    },
}


-- Completion
--------------------------------------------------------------------------------
-- See https://github.com/hrsh7th/nvim-cmp#basic-configuration

local cmp = require("cmp")
cmp.setup({
    preselect = cmp.PreselectMode.None,
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),
    },
    -- Installed sources
    sources = {
        { name = "nvim_lsp" },
        { name = "vsnip" },
        { name = "cmp-vsnip" },
        { name = "vim-vsnip" },
        { name = "path" },
        { name = "buffer" },
    },
})


-- Show diagnostic popup on cursor hover
local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        vim.diagnostic.open_float(nil, { focusable = false })
    end,
    group = diag_float_grp,
})

vim.wo.signcolumn = "yes"

