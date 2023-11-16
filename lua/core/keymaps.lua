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
