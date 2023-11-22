--[[
    键盘映射相关配置
--]]

vim.g.mapleader = ' '

-- --------普通模式-------- --

-- 取消高亮
vim.keymap.set('n', "<leader>hs", ":set hlsearch!<CR>")
-- F5 c++编译执行
vim.keymap.set('n', "<f6>", ":w<CR>:!g++ % -o a.out && ./a.out<CR>")

-- -------- 命令行模式-------- --

-- --------插件-------- --

-- nvim tree
vim.keymap.set('n', "<leader>e", ":NvimTreeToggle<CR>")

-- symbol outline
vim.keymap.set('n', "<leader>so", ":SymbolsOutline<CR>")

-- hop(easymotion)
vim.keymap.set('n', "<leader>c", ":HopChar1<CR>") -- hop: 跳转任意字符
vim.keymap.set('n', "<leader>w", ":HopWord<CR>") -- hop: 跳转任意单词
-- vim.keymap.set('n', "<leader>l", ":HopLine<CR>") -- hop: 跳转任意行
vim.keymap.set('n', "<leader>l", ":HopLineStart<CR>") -- hop: 跳转任意行开始
vim.keymap.set('n', "<leader>a", ":HopAnywhere<CR>") -- hop: 跳转任意位置

-- dap
local dap = require "dap"
vim.keymap.set('n', "<F5>", dap.continue) -- 开始执行
vim.keymap.set('n', "<F9>", dap.toggle_breakpoint) -- 下断点
vim.keymap.set('n', "<F10>", dap.step_over) -- 下一步执行
vim.keymap.set('n', "<F11>", dap.step_into) -- 下一步执行

-- lsp
-- vim.keymap.set('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>') -- 重命名
-- vim.keymap.set('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>') -- code action
vim.keymap.set('n', 'gd', ':lua vim.lsp.buf.definition()<CR>') -- 定义
vim.keymap.set('n', 'gh', ':lua vim.lsp.buf.hover()<CR>') -- 显示提示
vim.keymap.set('n', 'gD', ':lua vim.lsp.buf.declaration()<CR>') -- 声明
vim.keymap.set('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>') -- 实现
vim.keymap.set('n', 'gr', ':lua vim.lsp.buf.references()<CR>') -- 引用
-- diagnostic
-- vim.keymap.set('n', 'go', '<:>lua vim.diagnostic.open_float()<CR>', opt)
-- vim.keymap.set('n', 'gp', '<:>lua vim.diagnostic.goto_prev()<CR>', opt)
-- vim.keymap.set('n', 'gn', '<:>lua vim.diagnostic.goto_next()<CR>', opt)
-- vim.keymap.set('n', '<leader>q', '<:>lua vim.diagnostic.setloclist()<CR>', opt)
-- leader + =
-- vim.keymap.set('n', '<leader>=', '<:>lua vim.lsp.buf.formatting()<CR>', opt)
-- vim.keymap.set('n', '<C-k>', '<:>lua vim.lsp.buf.signature_help()<CR>', opt)
-- vim.keymap.set('n', '<space>wa', '<:>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
-- vim.keymap.set('n', '<space>wr', '<:>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
-- vim.keymap.set('n', '<space>wl', '<:>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
-- vim.keymap.set('n', '<space>D', '<:>lua vim.lsp.buf.type_definition()<CR>', opt)
-- --------终端模式-------- --

vim.keymap.set('t', "<ESC>", "<C-\\><C-n>")

-- 定义函数来获取当前的操作系统
local function get_current_os()
    -- 导入 vim.loop 模块
    local os_name
    -- 获取平台类型
    local platform = vim.loop.os_uname().sysname
    -- 根据平台类型确定操作系统名称
    if platform == "Linux" then
        os_name = "Linux"
        vim.keymap.set('n', "<leader>t", ":split<CR><C-w>r:e term://%:h//72921:/bin/bash<CR>a")
    elseif platform == "Darwin" then
        os_name = "macOS"
        vim.keymap.set('n', "<leader>t", ":split<CR><C-w>r:e term://%:h//2136:/bin/zsh<CR>a")
    elseif platform == "Windows" then
        os_name = "Windows"
    else
        os_name = "Unknown"
    end
    return os_name
end
-- 调用函数获取当前操作系统
local current_os = get_current_os()
