--[[
    自动命令相关的设置
--]]

-- 格式化
vim.cmd([[autocmd BufEnter * set formatoptions-=c]]) -- 移除复制注释
vim.cmd([[autocmd BufEnter * set formatoptions-=r]]) -- 移除自动缩进
vim.cmd([[autocmd BufEnter * set formatoptions-=o]]) -- 移除自动换行

-- 折叠
vim.cmd([[autocmd BufWinLeave * silent! mkview]])
vim.cmd([[autocmd BufRead * silent! loadview]])
