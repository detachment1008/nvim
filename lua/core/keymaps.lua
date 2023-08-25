--[[
    键盘映射相关配置
--]]

vim.g.mapleader = ' '

-- --------普通模式-------- --
-- 取消高亮
vim.keymap.set('n', "<leader>hs", ":set hlsearch!<CR>")

-- F5 c++编译执行
vim.keymap.set('n', "<F5>", ":w<CR>:!g++ % -o a.out && ./a.out<CR>")

-- --------插件-------- --
vim.keymap.set('n', "<leader>e", ":NvimTreeToggle<CR>")

-- --------终端模式-------- --
vim.keymap.set('t', "<ESC>", "<C-\\><C-n>")
vim.keymap.set('n', "<leader>t", ":split term://~/.config/nvim/lua/core//2136:/bin/zsh<CR>a")
