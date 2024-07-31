local language_support = {}

local function entry_filter_function(entry, ctx)
    local kind = require('cmp.types').lsp.CompletionItemKind[entry:get_kind()]
    if (kind == 'Text')
    then
        return false
    elseif (kind == 'Snippet')
    then
        return false
    end
    return true
end

language_support.setup = function(config)
    require("neodev").setup({})


    local treesitter_languages = {}
    if config.supported_languages ~= nil then
        treesitter_languages = config.supported_languages
    end
    require 'nvim-treesitter.configs'.setup({
        ensure_installed = treesitter_languages,
        auto_install = true,
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        context_commentstring = {
            enable = true,
            enable_autocmd = false,
        },
        rainbow = {
            enable = true,
            extended_mode = false,
            max_file_lines = nil,
        },
        autopairs = { enable = true },
        autotag = { enable = true },
        incremental_selection = { enable = true },
        indent = { enable = false }
    })


    require("mason").setup({
        ui = {
            check_outdated_packages_on_open = true,
            border = "rounded",
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            },
            keymaps = {
                -- Keymap to expand a package
                toggle_package_expand = "<CR>",
                -- Keymap to install the package under the current cursor position
                install_package = "i",
                -- Keymap to reinstall/update the package under the current cursor position
                update_package = "u",
                -- Keymap to check for new version for the package under the current cursor position
                check_package_version = "c",
                -- Keymap to update all installed packages
                update_all_packages = "U",
                -- Keymap to check which installed packages are outdated
                check_outdated_packages = "C",
                -- Keymap to uninstall a package
                uninstall_package = "d",
                -- Keymap to cancel a package installation
                cancel_installation = "<C-c>",
                -- Keymap to apply language filter
                apply_language_filter = "<C-f>",
            },
        },
    })

    local lsp_servers = {}
    if config.lsp ~= nil and config.lsp.ensure_installed ~= nil then
        lsp_servers = config.lsp.ensure_installed
    end
    require("mason-lspconfig").setup({
        ensure_installed = lsp_servers,
        automatic_installation = true,
    })


    local null_ls_servers = {}
    if config.null_ls ~= nil and config.null_ls.ensure_installed ~= nil then
        null_ls_servers = config.null_ls.ensure_installed
    end
    require("mason-null-ls").setup({
        ensure_installed = null_ls_servers,
        automatic_installation = false,
    })


    local lsp_servers_configs = {}
    if config.lsp ~= nil and config.lsp.server_configs ~= nil then
        lsp_servers_configs = config.lsp.server_configs
    end
    for server, conf in pairs(lsp_servers_configs) do
        require("lspconfig")[server].setup(conf)
    end


    local null_ls_servers_configs = {}
    if config.null_ls ~= nil and config.null_ls.sources ~= nil then
        null_ls_servers_configs = config.null_ls.sources
    end
    require("null-ls").setup({
        sources = null_ls_servers_configs,
        on_attach = function(client, bufnr)
            if client.supports_method("textDocument/formatting") then
                vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = augroup,
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format({ bufnr = bufnr })
                    end,
                })
            end
        end,
    })



    local cmp = require 'cmp'

    cmp.setup({
        snippet = {
            expand = function(args)
                require('luasnip').lsp_expand(args.body)
            end,
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        formatting = {
            format = require('lspkind').cmp_format({
                mode = 'symbol_text',
                maxwidth = 50,
            }),
        },

        matching = {
            disallow_fuzzy_matching = true,
        },

        mapping = cmp.mapping.preset.insert({
            ['<A-Up>'] = cmp.mapping.scroll_docs(-4),
            ['<A-Down>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({
                select = true,
                behavior = cmp.ConfirmBehavior.Replace
            }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources(
        --{ name = 'nvim_lsp_signature_help', priority = 8 },
            {
                {
                    name = 'nvim_lsp',
                    priority = 7,
                    entry_filter = entry_filter_function
                },
            }, {
                {
                    name = 'buffer',
                    entry_filter = entry_filter_function
                },
            }),

        sorting = {
            priority_weight = 1.0,
            comparators = {
                cmp.config.compare.locality,
                cmp.config.compare.recently_used,
                cmp.config.compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
                cmp.config.compare.offset,
                cmp.config.compare.order,
            },
        },
        completion = { autocomplete = false }
    })


    local saga = require('lspsaga')

    saga.setup({
        finder = {
            keys =
            {
                toggle_or_open = '<CR>',
                quit = { "q", '<ESC>' },
                close = '<ESC>',

            }
        },
        definition = {
            edit = "<CR>",
            vsplit = "<C-v>",
            split = "<C-s>",
            tabe = "<C-t>",
            quit = { "q", "<ESC>" }
        },
        lightbulb = {
            enable = false
        },
        outline = {
            win_position = "right",
            win_with = "",
            win_width = 40,
            show_detail = true,
            auto_preview = false,
            auto_refresh = true,
            auto_close = true,
            custom_sort = nil,
            keys = {
                expand_or_jump = "<CR>",
                quit = "q",
            },
        },
        ui = {
            -- Currently, only the round theme exists
            theme = "round",
            -- This option only works in Neovim 0.9
            title = true,
            -- Border type can be single, double, rounded, solid, shadow.
            border = "rounded",
            winblend = 0,
            expand = "",
            collapse = "",
            preview = " ",
            code_action = "💡",
            diagnostic = "🐞",
            incoming = " ",
            outgoing = " ",
            hover = ' ',
            kind = {},
        },
    })
end



return language_support
