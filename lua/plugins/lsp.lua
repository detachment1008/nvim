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

-- local inspect = require('vim.inspect')

local capabilities = require "cmp_nvim_lsp".default_capabilities()
-- print(inspect(capabilities))

require "lspconfig".lua_ls.setup { capabilities = capabilities }
require "lspconfig".clangd.setup { capabilities = capabilities }

-- local lspconfig = require('lspconfig')
--
-- -- 启动 clangd
-- lspconfig.clangd.setup {
--   cmd = { "clangd", "--background-index" },
--   filetypes = {"c", "cpp", "objc", "objcpp"},
--
--   -- 设置 .clang-format 文件路径
--   root_dir = function()
--     return vim.loop.cwd()
--   end,
--
--   -- 设置 LSP 格式化器
--   settings = {
--     clangd = {
--       format = {
--         FileStyle = "ALLMAN",
--         Enable = true,
--       }
--     }
--   }
-- }
-- lspconfig.clangd.setup({
--     filetypes = { "c", "cpp" },
--     settings = {
--         ccls = {
--             format = {
--                 {
--                     Command = "clang-format",
--                     Args = {
--                         "-style={BasedOnStyle: llvm, IndentWidth: 4, BraceWrapping: { AfterClass: true, AfterFunction: true }}",
--                         "$FILENAME"
--                     },
--                     Stdin = true
--                 }
--             }
--         }
--     }
-- })
