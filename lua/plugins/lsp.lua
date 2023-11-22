-- mason：配置显示的图标
require "mason".setup({
    ui =
    {
        icons =
        {
            package_installed = '✓',
            package_pending = '→',
            package_uninstalled = '✗',
        }
    }
})

-- lsp
require "mason-lspconfig".setup({
    -- 确保安装，根据需要安装
    ensure_installed =
    {
        "lua_ls",
        "clangd",
        -- "csharp_ls",
    },
})

local capabilities = require "cmp_nvim_lsp".default_capabilities()

require "lspconfig".lua_ls.setup { capabilities = capabilities }
require "lspconfig".clangd.setup { capabilities = capabilities }

-- local lspconfig = require('lspconfig')
-- require("mason-lspconfig").setup_handlers({
--   function (server_name)
--     require("lspconfig")[server_name].setup{}
--   end,
--   -- Next, you can provide targeted overrides for specific servers.
--   ["lua_ls"] = function ()
--     lspconfig.lua_ls.setup {
--       settings = {
--         Lua = {
--           diagnostics = {
--             globals = { "vim" }
--           }
--         }
--     }
--   }
--   end,
--   ["clangd"] = function ()
--     lspconfig.clangd.setup {
--       cmd = {
--         "clangd",
--         "--header-insertion=never",
--         "--query-driver=/opt/homebrew/opt/llvm/bin/clang",
--         "--all-scopes-completion",
--         "--completion-style=detailed",
--       }
--     }
--   end
-- })
