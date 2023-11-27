local util = require("formatter.util")

local style = {
	[1] = "LLVM", -- 两格对齐，大括号在同一行
	[2] = "Google", -- 和 LLVM 似乎相同
	[3] = "GNU", -- 函数返回值在上一行，函数大括号在下一行，其他和 LLVM 相似
	[4] = "Chromium", -- 和 LLVM 似乎相同
	[5] = "Mozilla", -- 函数返回值在上一行，其他和 LLVM 似乎相同
	[6] = "WebKit", -- 四格对齐，函数的大括号在下一行，其他的在同一行
	[7] = "Microsoft", -- 四格对齐，大括号都在下一行
}

--[[
命令行参数
1. "-style=file": 即使用当前项目下的.clang-format 文件进行格式化
当使用-style=file时，每个输入文件的clang-format将尝试找到位于输入文件最接近父目录的.clang-format文件。当使用标准输入时，搜索将从当前目录开始。
当使用-style=file:<format_file_path>时，每个输入文件的clang-format将使用位于<format_file_path>的格式文件。路径可能是绝对的，也可能是相对于工作目录的。
2. "-style=Microsoft": 即使用指定的风格进行格式化

获取 .clang-format: "-style=Microsoft -dump-config > .clang-format"
]]

local path = vim.loop.os_uname().sysname == "Darwin" and "/Users/bole/.config/nvim/lua/config/.clang-format" or '/home/dcr/.config/nvim/lua/config/.clang-format'

return function()
	return {
		exe = "clang-format",
		args = {
			-- "-style=" .. style[7],
			"-style=file:" .. path,
			"-assume-filename",
			util.escape_path(util.get_current_buffer_file_name()),
		},
		stdin = true,
		try_node_modules = true,
	}
end
