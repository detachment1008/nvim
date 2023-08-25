--[[
    选项相关配置
--]]

-- 行号
vim.opt.number = true
vim.opt.relativenumber = true

-- 缩进
vim.opt.tabstop = 4             -- tab 时的缩进
vim.opt.shiftwidth = 4          -- << 和 >> 时的缩进
vim.opt.expandtab = true        -- 用空格代替 Tab 字符
vim.opt.autoindent = true       -- 在新行中根据上一行自动缩进

-- 启用鼠标
vim.opt.mouse:append("a")

-- 系统剪切板
vim.opt.clipboard:append("unnamedplus")

-- 外观
vim.opt.termguicolors = true    -- 使用终端颜色
vim.opt.signcolumn = "no"       -- 左侧是否多一列
vim.opt.hlsearch = false
