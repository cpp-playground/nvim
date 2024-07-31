local plugins_config = {}

local prequire = function(mod_name)
    local ok, err = pcall(require, mod_name)
    if not ok then return nil, err end
    return err
end

plugins_config.setup = function()
    require("plugins_config.editor_ui").setup()

    local user_config = require("plugins_config.language_support.user_config")
    require("plugins_config.language_support").setup(user_config)


    require("trouble").setup({
        use_diagnostic_signs = true
    })

    local telescope = require('telescope')
    telescope.setup({
        extensions = {
            glyph = {
                action = function(glyph)
                    vim.api.nvim_put({ glyph.value }, 'c', false, true)
                end,
            },
        },
    })


    telescope.load_extension('glyph')
    telescope.load_extension('themes')

    require 'colorizer'.setup({ "*" }, {
        RGB    = true,  -- #RGB hex codes
        RRGGBB = true,  -- #RRGGBB hex codes
        names  = false, -- "Name" codes like Blue
    })

    require("todo-comments").setup({})

    require("Comment").setup({
        ignore = '^$',
        mapping = false,
    })


    require("git-worktree").setup()
    require("telescope").load_extension("git_worktree")

    require("ibl").setup()
    require("blame").setup()
    require("gitsigns").setup()
end

return plugins_config
