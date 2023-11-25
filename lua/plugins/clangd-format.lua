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

return function()
	return {
		exe = "clang-format",
		args = {
			"-style=" .. style[7],
			"-assume-filename",
			util.escape_path(util.get_current_buffer_file_name()),
		},
		stdin = true,
		try_node_modules = true,
	}
end
