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
