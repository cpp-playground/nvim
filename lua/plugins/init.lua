require "plugins.packer_bootstrap"
local is_bootstraping = ensure_packer()

local packer = require("packer")


local use = function()
    -- Installation tools
    use "wbthomason/packer.nvim"
    use "williamboman/mason.nvim"           -- Install tools
    use "williamboman/mason-lspconfig.nvim" -- Use Mason to install lsp clients
    use "jayp0521/mason-null-ls.nvim"       -- Use Mason to install formatters

    -- Useful
    use "nvim-tree/nvim-web-devicons" -- Set of icons with color support


    -- Language support related
    use "folke/neodev.nvim"             -- vim support in Lua
    use "neovim/nvim-lspconfig"         -- LSP Server configurator
    use "lukas-reineke/lsp-format.nvim" -- LSP Based code formating
    use { "nvimdev/lspsaga.nvim",
        requires = {
            { "nvim-tree/nvim-web-devicons" },
            { "nvim-treesitter/nvim-treesitter" }
        }
    }                                         -- LSP Integration (code action, etc)
    use "nvimtools/none-ls.nvim"              -- Run formaters as if they were LSP clients
    use "nvim-treesitter/nvim-treesitter"     -- Code parser
    use {
        "hrsh7th/nvim-cmp",                   -- Auto-completion engine
        requires = {
            "hrsh7th/cmp-buffer",             -- Current buffer source for cmp
            "hrsh7th/cmp-nvim-lsp",           -- LSP source for LSP
        }
    }                                         -- Code completion
    use "onsails/lspkind.nvim"                -- cmp output formating
    use({ "L3MON4D3/LuaSnip", tag = "v1.*" }) -- Snipet expansion for cmp


    -- UI elements
    use { 'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons' } -- Buffer line
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }                                         -- Bottom status line
    use "petertriho/nvim-scrollbar"           -- Side scrollbar
    use "lukas-reineke/indent-blankline.nvim" -- Show indent lines
    use "lewis6991/gitsigns.nvim"             -- Nice git status

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    }

    -- Misc
    use "folke/trouble.nvim"          -- Diagnostic visualizer
    use "folke/which-key.nvim"        -- Shows which commands are available
    use "norcalli/nvim-colorizer.lua" -- Shows colors such as #452
    use {
        "folke/todo-comments.nvim", requires = { "nvim-lua/plenary.nvim" }
    }                           -- Support TODO style comments (TODO HACK, FIX, NOTE, BUG WARN)
    use "p00f/nvim-ts-rainbow"  -- Pair apply colors to matching pair of delimiters
    use "famiu/bufdelete.nvim"  -- Nicer buffer closing
    use "numToStr/Comment.nvim" -- Comment/Uncomment code

    use {
        "nvim-telescope/telescope.nvim",
        requires = { { 'nvim-lua/plenary.nvim' } }, tag = "0.1.x"
    }                                   --Finds stuff
    use "ghassan0/telescope-glyph.nvim" -- Find glyphs like 
    use "themercorp/themer.lua"
    use "github/copilot.vim"
    use "FabijanZulj/blame.nvim"
    use { "ThePrimeagen/git-worktree.nvim",
        requires = {
            "nvim-lua/plenary.nvim",
        }
    } -- Some git worktree integration

    if is_bootstraping then
        require("packer").sync()
    end
end


return packer.startup(use)
