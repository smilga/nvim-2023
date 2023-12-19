require('keys')
require('set')

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    'onsails/lspkind.nvim',
    {
        "olimorris/persisted.nvim",
        config = function()
            require('persisted').setup({
                autoload = true
            })
        end
    },
    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    },
    {
        'stevearc/oil.nvim',
        opts = {},
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    'nvim-lualine/lualine.nvim',
    'rmehri01/onenord.nvim',
    'rebelot/kanagawa.nvim',
    'sainnhe/everforest',
    'sainnhe/gruvbox-material',
    'mhartington/formatter.nvim', -- Formatter to format on save if LSP is not handing that
    "sindrets/diffview.nvim",
    'tpope/vim-fugitive',
    'qpkorr/vim-bufkill',
    'chaoren/vim-wordmotion',
    'joshdick/onedark.vim',
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = {
            'nvim-lua/plenary.nvim'
        }
    },
    {
        {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v3.x',
            lazy = true,
            config = false,
            init = function()
                -- Disable automatic setup, we are doing it manually
                vim.g.lsp_zero_extend_cmp = 0
                vim.g.lsp_zero_extend_lspconfig = 0
            end,
        },
        {
            'williamboman/mason.nvim',
            lazy = false,
            config = true,
        },

        -- Autocompletion
        {
            'hrsh7th/nvim-cmp',
            event = 'InsertEnter',
            dependencies = {
                {
                    'L3MON4D3/LuaSnip',
                    'saadparwaiz1/cmp_luasnip',
                    'hrsh7th/cmp-calc',
                    'hrsh7th/cmp-nvim-lsp-signature-help',
                    'hrsh7th/cmp-path',
                    'hrsh7th/cmp-buffer',
                },
            },
            config = function()
                -- Here is where you configure the autocompletion settings.
                local lsp_zero = require('lsp-zero')
                lsp_zero.extend_cmp()

                -- And you can configure cmp even more, if you want to.
                local cmp = require('cmp')
                local cmp_action = lsp_zero.cmp_action()
                local lspkind = require('lspkind')

                local cmp_autopairs = require('nvim-autopairs.completion.cmp')
                cmp.event:on(
                    'confirm_done',
                    cmp_autopairs.on_confirm_done()
                )

                cmp.setup({
                    completion = {
                        completeopt = 'menu,menuone,preview,noselect',
                    },
                    formatting = {
                        format = lspkind.cmp_format({
                            mode = 'symbol_text',  -- show only symbol annotations
                            maxwidth = 30,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

                            -- The function below will be called before any actual modifications from lspkind
                            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                            before = function(entry, vim_item)
                                return vim_item
                            end
                        })
                    },
                    window = {
                        -- completion = cmp.config.window.bordered(),
                        -- documentation = cmp.config.window.bordered(),
                    },
                    snippet = {
                        expand = function(args)
                            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                        end,
                    },
                    sources = cmp.config.sources({
                        { name = 'luasnip' },
                        { name = 'buffer' },
                        { name = 'nvim_lsp' },
                        { name = 'path' },
                        { name = 'calc' },
                        { name = 'nvim-lsp-signature-help' },
                    }),
                    mapping = cmp.mapping.preset.insert({
                        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                        ['<C-f>'] = cmp.mapping.scroll_docs(4),
                        ['<C-Space>'] = cmp.mapping.complete(),
                        ['<C-e>'] = cmp.mapping.abort(),
                        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                        ['<Tab>'] = cmp_action.luasnip_supertab(),
                        ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
                    }),
                })
            end
        },

        -- LSP
        {
            'neovim/nvim-lspconfig',
            cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
            event = { 'BufReadPre', 'BufNewFile' },
            dependencies = {
                { 'hrsh7th/cmp-nvim-lsp' },
                { 'williamboman/mason-lspconfig.nvim' },
            },
            config = function()
                -- This is where all the LSP shenanigans will live
                local lsp_zero = require('lsp-zero')
                lsp_zero.extend_lspconfig()

                lsp_zero.on_attach(function(client, bufnr)
                    -- see :help lsp-zero-keybindings
                    -- to learn the available actions
                    lsp_zero.default_keymaps({ buffer = bufnr })
                end)

                require('mason-lspconfig').setup({
                    ensure_installed = { "intelephense", "phpactor" },
                    handlers = {
                        function(server_name) -- default handler (optional)
                            require("lspconfig")[server_name].setup {}
                        end,
                        lsp_zero.default_setup,
                        lua_ls = function()
                            -- (Optional) Configure lua language server for neovim
                            local lua_opts = lsp_zero.nvim_lua_ls()
                            require('lspconfig').lua_ls.setup(lua_opts)
                        end,
                        phpactor = function()
                            require('lspconfig').phpactor.setup {
                                on_attach = function(client)
                                    vim.print(client.server_capabilities)
                                    -- client.server_capabilities.documentFormattingProvider = true
                                    -- client.server_capabilities.documentRangeFormattingProvider = true
                                end,
                            }
                        end,
                        intelephense = function()
                            require('lspconfig').intelephense.setup {
                                on_attach = function(client)
                                    vim.print(client.server_capabilities)
                                    -- client.server_capabilities.documentFormattingProvider = true
                                    -- client.server_capabilities.documentRangeFormattingProvider = true
                                end,
                                init_options = {
                                    licenceKey = "/Users/smilga/.config/intelephense_licence.txt"
                                },
                                settings = {
                                    intelephense = {
                                        files = {
                                            maxSize = 3000000
                                        },
                                        completion = {
                                            insertUseDeclaration = true, -- Automatically add use declarations
                                        },
                                    },
                                },
                            }
                        end
                    }
                })
            end
        }
    },
    {
        'nvim-tree/nvim-tree.lua',
        dependecies = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly'                    -- optional, updated every week. (see issue #1193)
    },
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    { 'stevearc/dressing.nvim' },
    { 'lewis6991/gitsigns.nvim' },
    {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end
    },
    --{
    --    "zbirenbaum/copilot.lua",
    --    cmd = "Copilot",
    --    event = "InsertEnter",
    --    config = function()
    --        require("copilot").setup({
    --            suggestion = {
    --                enabled = true,
    --                auto_trigger = true,
    --            },
    --        })
    --    end,
    --},

    ----use {
    ----    "zbirenbaum/copilot-cmp",
    ----    after = { "copilot.lua" },
    ----    config = function ()
    ----        require("copilot_cmp").setup()
    ----    end
    ----}
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },
    'AlexvZyl/nordic.nvim',
    'folke/tokyonight.nvim',
    'tpope/vim-surround',
    'onsails/lspkind.nvim',
    {
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        dependecies = {
            "nvim-lua/plenary.nvim",
        },
    },
    --{
    --    "gbprod/phpactor.nvim",
    --    run = require("phpactor.handler.update"),
    --    requires = {
    --        "nvim-lua/plenary.nvim", -- required to update phpactor
    --        "neovim/nvim-lspconfig" -- required to automaticly register lsp serveur
    --    },
    --    config = function()
    --        require("phpactor").setup({
    --            -- your configuration comes here
    --            -- or leave it empty to use the default settings
    --            -- refer to the configuration section below
    --        })
    --    end
    --}
})
