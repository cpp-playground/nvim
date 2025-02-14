local on_attach_with_format = function(client, _)
    require("lsp-format").on_attach(client)
end

local on_attach_default = function(_, _)
end


return {
        lsp = {
            ensure_installed = {
                "bashls",
                "clangd",
                "cmake",
                "jsonls",
                "marksman",
                "pyright",
                "rust_analyzer",
                "yamlls",
                "lua_ls",
                "texlab"
            },
            server_configs = {
                bashls = { on_attach = on_attach_default },
                clangd = {
                    on_attach = on_attach_with_format,
                    cmd = {
                        "clangd",
                        "--header-insertion=never",
                        "--compile-commands-dir=build"
                    }
                },
                cmake = { on_attach = on_attach_with_format },
                jsonls = { on_attach = on_attach_with_format },
                marksman = { on_attach = on_attach_with_format },
                pyright = { on_attach = on_attach_default },
                rust_analyzer = { on_attach = on_attach_with_format },
                yamlls = {
                    on_attach = on_attach_with_format,
                    settings = {
                        schemas = {
                            ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
                            ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                            ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
                        }
                    }
                },
                lua_ls = { on_attach = on_attach_with_format },
                texlab = { on_attach = on_attach_with_format }
            }
        },
        null_ls = {
            ensure_installed = { "black", "shfmt", "cmake_format" },
            sources = {
                require("null-ls").builtins.formatting.black.with({ extra_args = { "-l 100" } }),
                require("null-ls").builtins.formatting.shfmt.with({
                    extra_args = { "--indent=4",
                        "--language-dialect=bash" }
                }),
                require("null-ls").builtins.formatting.cmake_format,
            }
        },
        supported_languages = {
            "c",
            "cpp",
            "rust",
            "python",
            "bash",
            "cmake",
            "json",
            "lua",
            "markdown",
            "yaml",
            "latex"
        }
}