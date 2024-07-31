local editor_ui = {}

local function show_global_diff()
    vim.api.nvim_command("Neotree float git_status")
end


function copilot_status()
    local enabled = vim.g.copilot_enabled == 1
    local ret = ""
    if enabled then
        ret = "ﯙ "
    end
    return ret
end

editor_ui.setup = function()
    -- INFO: Configuration of akinsho/bufferline.nvim
    -- Handles the file tabs element of the UI
    -- (aka top statusline)
    require('bufferline').setup {
        options = {
            mode = "buffers", -- set to "tabs" to only show tabpages instead
            numbers = "none",
            close_command = "Bdelete! %d",
            middle_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
            left_mouse_command = "buffer %d",     -- can be a string | function, see "Mouse actions"
            right_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
            buffer_close_icon = '',
            modified_icon = '●',
            close_icon = '',
            left_trunc_marker = '',
            right_trunc_marker = '',


            max_name_length = 18,
            max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
            truncate_names = false, -- whether or not tab names should be truncated
            tab_size = 18,
            offsets = {
                {
                    filetype = "neo-tree",
                    text = "File Explorer",
                    text_align = "center",
                    separator = true,
                }
            },
            color_icons = true,         -- whether or not to add the filetype icon highlights
            show_tab_indicators = true,
            persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
            show_close_icon = false,
        }
    }

    -- INFO: Configuration of nvim-lualine/lualine.nvim
    -- Handles the statusline element of the UI
    -- (aka bottom statusline)
    require('lualine').setup {
        options = {
            theme = 'auto',
            component_separators = '',
            section_separators = { left = '', right = '' },
            globalstatus = true,
            refresh = { statusline = 500, },
        },

        sections = {
            lualine_a = {
                { 'mode', separator = { left = '', right = '' } }
            },

            lualine_b = { 'branch', {
                'diff',
                symbols = { added = ' ', modified = ' ', removed = ' ' },
                on_click = show_global_diff
            } },
            lualine_c = {},
            lualine_x = {},
            lualine_y = { { "copilot_status()" }, { 'filetype', icon_only = false, icon = true },
                { 'diagnostics',     always_visible = true } },
            lualine_z = { 'location', { 'progress', separator = { left = '', right = '' } } }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
        },
        tabline = {},
        extensions = {},
    }

    -- INFO: Configuration of petertriho/nvim-scrollba
    require("scrollbar").setup()



    require("neo-tree").setup({
        close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        sources = {
            "filesystem",
            "document_symbols",
        },
        default_source = "filesystem",
        default_component_configs = {
            git_status = {

                symbols = {
                    -- Change type
                    added     = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                    modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
                    deleted   = "", -- this can only be used in the git_status source
                    renamed   = "", -- this can only be used in the git_status source
                    -- Status type
                    untracked = "",
                    ignored   = "",
                    unstaged  = "",
                    staged    = "",
                    conflict  = "",
                }
            },
        }
    })
end

return editor_ui
