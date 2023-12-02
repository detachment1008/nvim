--[[
    键盘映射相关配置
--]]

vim.g.mapleader = " "
local platform = vim.loop.os_uname().sysname

-- --------普通模式-------- --

-- 取消高亮
vim.keymap.set("n", "<leader>hs", ":set hlsearch!<CR>")
-- F5 c++编译执行
vim.keymap.set("n", "<f6>", ":w<CR>:!g++ -g -std=c++17 -o a.out % && ./a.out<CR>")
-- 切换头文件和源文件
function SwitchFile()
    local type = vim.bo.filetype
    if type == "c" or type == "cpp" then
        vim.cmd ("ClangdSwitchSourceHeader")
    end
end
vim.keymap.set('n', '<leader>gf', SwitchFile)

-- -------- 命令行模式-------- --

-- --------插件-------- --

-- nvim tree
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- symbol outline
vim.keymap.set("n", "<leader>so", ":SymbolsOutline<CR>")

-- hop(easymotion)
vim.keymap.set("n", "<leader>c", ":HopChar1<CR>") -- hop: 跳转任意字符
vim.keymap.set("n", "<leader>w", ":HopWord<CR>") -- hop: 跳转任意单词
-- vim.keymap.set('n', "<leader>l", ":HopLine<CR>") -- hop: 跳转任意行
vim.keymap.set("n", "<leader>l", ":HopLineStart<CR>") -- hop: 跳转任意行开始
vim.keymap.set("n", "<leader>a", ":HopAnywhere<CR>") -- hop: 跳转任意位置

-- dap
local dap = require("dap")
vim.keymap.set("n", "<F5>", dap.continue) -- 开始执行
vim.keymap.set("n", "<F9>", dap.toggle_breakpoint) -- 下断点
vim.keymap.set("n", "<F10>", dap.step_over) -- 下一步执行
vim.keymap.set("n", "<F11>", dap.step_into) -- 下一步执行

-- lsp
vim.keymap.set("n", "<leader>ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", { silent = true, noremap = true }) -- 函数修复
vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.declaration()<CR>", { silent = true, noremap = true }) -- 跳转到声明
vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.definition()<CR>", { silent = true, noremap = true }) -- 跳转到定义
vim.keymap.set("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", { silent = true, noremap = true }) -- 显示注释文档 跳转到实现
vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", { silent = true, noremap = true }) -- 跳转到引用位置
-- 以浮窗形式显示错误
vim.keymap.set("n", "go", "<cmd>lua vim.diagnostic.open_float()<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "gp", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "gn", "<cmd>lua vim.diagnostic.goto_next()<CR>", { silent = true, noremap = true })

-- format
-- vim.keymap.set("n", "<C-[>", "<cmd>Format<CR>", { silent = true, noremap = true })
-- vim.keymap.set("n", "<leader>;", "<cmd>Format<CR>", { silent = true, noremap = true })

-- --------终端模式-------- --

vim.keymap.set("t", "<ESC>", "<C-\\><C-n>")

-- 定义函数来获取当前的操作系统
local function get_current_os()
	-- 导入 vim.loop 模块
	local os_name
	-- 根据平台类型确定操作系统名称
	if platform == "Linux" then
		os_name = "Linux"
		vim.keymap.set("n", "<leader>t", ":split<CR><C-w>r:e term://%:h//72921:/bin/bash<CR>a")
	elseif platform == "Darwin" then
		os_name = "macOS"
		vim.keymap.set("n", "<leader>t", ":split<CR><C-w>r:e term://%:h//2136:/bin/zsh<CR>a")
	elseif platform == "Windows" then
		os_name = "Windows"
	else
		os_name = "Unknown"
	end
	return os_name
end
-- 调用函数获取当前操作系统
get_current_os()
