local vim_config = {}

vim_config.setup = function()
    -- Generic terminal setup
    vim.api.nvim_command('set termguicolors')

    vim.opt.number      = true
    -- Tabs
    vim.opt.tabstop     = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth  = 4
    vim.api.nvim_command('set expandtab')

    -- Allow mouse control support
    vim.api.nvim_command('set mouse=nvi')

    vim.fn.sign_define("DiagnosticSignError",
        { text = " ", texthl = "DiagnosticSignError" })
    vim.fn.sign_define("DiagnosticSignWarn",
        { text = " ", texthl = "DiagnosticSignWarn" })
    vim.fn.sign_define("DiagnosticSignInfo",
        { text = " ", texthl = "DiagnosticSignInfo" })
    vim.fn.sign_define("DiagnosticSignHint",
        { text = "", texthl = "DiagnosticSignHint" })

    vim.opt.timeoutlen = 300

    local esc = vim.api.nvim_replace_termcodes(
        '<ESC>', true, false, true
    )
end

return vim_config
