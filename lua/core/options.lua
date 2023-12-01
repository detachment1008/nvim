--[[
    选项相关配置
--]]

-- 行号
vim.opt.number = true
vim.opt.relativenumber = true

-- 缩进
vim.opt.tabstop = 4                     -- tab 时的缩进
vim.opt.shiftwidth = 4                  -- << 和 >> 时的缩进
vim.opt.expandtab = true                -- 用空格代替 Tab 字符
vim.opt.autoindent = true               -- 在新行中根据上一行自动缩进
-- vim.opt.formatoptions:remove('c')       -- 移除复制注释
-- vim.opt.formatoptions:remove('r')       -- 移除自动缩进
-- vim.opt.formatoptions:remove('o')       -- 移除自动换行

-- 开启 indentexpr 格式模式，用以处理 std: 这样格式会自动缩进为 0 的情况，同时还会保持 public: 这样的自动缩进处理
vim.api.nvim_command([[
function! MyIndent()
return luaeval("MyLuaIndent()")
endfunction
]])
_G.MyLuaIndent = function()
    if vim.bo.filetype ~= "c" and vim.bo.filetype ~= "cpp" then
        return -1
    end
    local line = vim.fn.getline(".")
    local str = line:match("^%s*(%w+):")
    if not str or str == "public" or str == "protected" or str == "private" then
        return vim.fn.cindent(vim.fn.line("."))
    else
        return -1
    end
end
vim.o.indentexpr = "MyIndent()"

-- 启用鼠标
vim.opt.mouse:append("a")

-- 系统剪切板
vim.opt.clipboard:append("unnamedplus")

-- 外观
vim.opt.termguicolors = true    -- 使用终端颜色
vim.opt.signcolumn = "no"       -- 左侧是否多一列
vim.opt.hlsearch = false

-- 智能匹配(忽略大小写)
vim.opt.smartcase = true
vim.opt.ignorecase = true
