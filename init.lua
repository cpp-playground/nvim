-- Initialize the editor
require("vim_config").setup()


-- Download the plugins
require "plugins"


--Configure the plugins
require("plugins_config").setup()

require("key_mappings").setup()

vim.g.mapleader = " "


require("themer").setup({
    colorscheme = "kanagawa",
})
require("themer").setup({ enable_installer = true })

vim.api.nvim_create_autocmd('TermOpen', {
    pattern = '',
    command = 'startinsert'
})
