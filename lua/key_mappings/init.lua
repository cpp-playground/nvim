local key_mappings = {}

local function toggle_hints()
    local enabled = vim.lsp.inlay_hint.is_enabled()
    vim.lsp.inlay_hint.enable(0, not enabled)
end

local function comment_blockwise()
    vim.api.nvim_feedkeys(esc, 'nx', false)
    require("Comment.api").toggle.blockwise(vim.fn.visualmode())
end

local function comment_linewise()
    vim.api.nvim_feedkeys(esc, 'nx', false)
    require("Comment.api").toggle.linewise(vim.fn.visualmode())
end

key_mappings.setup = function()
    local wk = require("which-key")

    local conf = {
        preset = "modern",
        icons = {
            rules = false
        }
    }
    wk.setup(conf)

    -- LSP mappings
    wk.add({
        { "<leader>l",   group = "Language Server tools" },
        { "<leader>lf",  "<cmd>Lspsaga finder<CR>",                  desc = "Find symbol",         mode = "n" },
        { "<leader>la",  "<cmd>Lspsaga code_action<CR>",             desc = "Code action",         mode = { "n", "v" } },
        { "<leader>lr",  "<cmd>Lspsaga rename<CR>",                  desc = "Rename symbol",       mode = "n" },
        { "<leader>lg",  "<cmd>Lspsaga goto_definition<CR>",         desc = "Go to definition",    mode = "n" },
        { "<leader>lp",  "<cmd>Lspsaga peek_definition<CR>",         desc = "Peek definition",     mode = "n" },
        { "<leader>lo",  "<cmd>Neotree document_symbols<CR>",        desc = "Show buffer outline", mode = "n" },
        { "<leader>ld",  "<cmd>Lspsaga hover_doc<CR>",               desc = "Show documentation",  mode = "n" },
        { "<leader>lF",  "<cmd>Lspsaga finder<CR>",                  desc = "Search" },
        { "<leader>lFs", "<cmd>Telescope lsp_document_symbols<CR>",  desc = "Document symbols",    mode = "n" },
        { "<leader>lFS", "<cmd>Telescope lsp_workspace_symbols<CR>", desc = "Workspace symbols",   mode = "n" }
    })

    -- Git mappings
    wk.add({
        { "<leader>g",   group = "Git" },
        { "<leader>gB",  "<cmd>Telescope git_branches<CR>",                     desc = "Search Branches",       mode = "n" },
        { "<leader>gL",  "<cmd>Telescope git_bcommits<CR>",                     desc = "Search Buffer Commits", mode = "n" },
        { "<leader>gl",  "<cmd>Telescope git_commits<CR>",                      desc = "Search Commits",        mode = "n" },
        { "<leader>gs",  "<cmd>Telescope git_status<CR>",                       desc = "Status",                mode = "n" },
        { "<leader>gb",  "<cmd>BlameToggle virtual<CR>",                        desc = "Blame as virtual text", mode = "n" },
        { "<leader>gg",  "<cmd>BlameToggle virtual<CR>",                        desc = "Blame",                 mode = "n" },
        { "<leader>gt",  group = "Worktrees" },
        { "<leader>gtt", "<cmd>Telescope git_worktree git_worktrees<CR>",       desc = "Manage worktrees",      mode = "n" },
        { "<leader>gtn", "<cmd>Telescope git_worktree create_git_worktree<CR>", desc = "New worktree",          mode = "n" },
    })

    -- Telescope mappings
    wk.add({
        { "<leader>f",  group = "Find" },
        { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "File name",       mode = "n" },
        { "<leader>fg", "<cmd>Telescope live_grep<CR>",  desc = "File contents",   mode = "n" },
        { "<leader>fb", "<cmd>Telescope buffers<CR>",    desc = "Buffer contents", mode = "n" },
    })

    -- Misc mappings
    wk.add({
        { "<leader>w",  "<cmd>w<CR>",                                   desc = "Save file",          mode = "n" },
        { "<leader>t",  "<cmd>terminal<CR>",                            desc = "Open terminal",      mode = "n" },
        { "<leader>e",  "<cmd>Neotree toggle<CR>",                      desc = "File explorer",      mode = "n" },
        { "<leader>/",  require("Comment.api").toggle.linewise.current, desc = "Comment line",       mode = "n" },
        { "<leader>/",  comment_linewise,                               desc = "Comment selection",  mode = "v" },
        { "<leader>\\", comment_blockwise,                              desc = "Comment line",       mode = "v" },
        { "<leader>h",  toggle_hints,                                   desc = "Toggle inlay hints", mode = "n" },
    })



    local keymap = vim.keymap.set
    keymap("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { silent = true, desc = "Previous Tab" })
    keymap("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { silent = true, desc = "Next Tab" })

    keymap("n", "<C-h>", "<cmd>wincmd h<CR>", { silent = true, desc = "Goto left window" })
    keymap("n", "<C-l>", "<cmd>wincmd l<CR>", { silent = true, desc = "Goto right window" })
    keymap("n", "<C-j>", "<cmd>wincmd j<CR>", { silent = true, desc = "Goto top window" })
    keymap("n", "<C-k>", "<cmd>wincmd k<CR>", { silent = true, desc = "Goto bottom window" })

    -- Triggers copilot suggestion with Alt + space
    keymap("i", "<F8>", "<Plug>(copilot-suggest)", { silent = true, desc = "Trigger copilot suggestion" })
    keymap("i", "<F10>", "<Plug>(copilot-next)", { silent = true, desc = "Next copilot suggestion" })
    keymap("i", "<F9>", "<Plug>(copilot-previous)", { silent = true, desc = "Previous copilot suggestion" })

    keymap('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })
end


return key_mappings
