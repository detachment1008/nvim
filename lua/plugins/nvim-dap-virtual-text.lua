require("nvim-dap-virtual-text").setup({
	enabled = true, -- 启用该插件（默认为 true）
	enabled_commands = true, -- 创建命令 DapVirtualTextEnable、DapVirtualTextDisable、DapVirtualTextToggle（以及 DapVirtualTextForceRefresh，用于在调试适配器未通知终止时进行刷新）
	highlight_changed_variables = true, -- 使用 NvimDapVirtualTextChanged 高亮已更改的值，否则始终使用 NvimDapVirtualText
	highlight_new_as_changed = false, -- 与已更改的变量一样高亮新变量（如果 highlight_changed_variables 为真）
	show_stop_reason = true, -- 停止异常时显示停止原因
	commented = false, -- 在虚拟文本前添加注释字符串
	only_first_definition = true, -- 仅在第一次定义时显示虚拟文本（如果有多个定义）
	all_references = false, -- 在所有引用的变量上显示虚拟文本（不仅限于定义）
	clear_on_continue = false, -- 在 "continue" 时清除虚拟文本（可能会导致跳动）
	--- 决定如何显示变量或是否应省略变量的回调函数
	--- @param variable Variable https://microsoft.github.io/debug-adapter-protocol/specification#Types_Variable
	--- @param buf number
	--- @param stackframe dap.StackFrame https://microsoft.github.io/debug-adapter-protocol/specification#Types_StackFrame
	--- @param node userdata 作为变量定义或引用的 tree-sitter 节点（参见 `:h tsnode`）
	--- @param options nvim_dap_virtual_text_options nvim-dap-virtual-text 的当前选项
	--- @return string|nil 虚拟文本的显示方式，或者如果不应显示此变量则返回 nil
	display_callback = function(variable, buf, stackframe, node, options)
		if options.virt_text_pos == "inline" then
			return " = " .. variable.value
		else
			return variable.name .. " = " .. variable.value
		end
	end,
	-- 虚拟文本的位置，参见 `:h nvim_buf_set_extmark()`，默认尝试内联虚拟文本。使用 'eol' 来将其设置为行尾
	virt_text_pos = vim.fn.has("nvim-0.10") == 1 and "inline" or "eol",

	-- 实验性特性：
	all_frames = false, -- 在所有堆栈帧上显示虚拟文本，而不仅仅是当前帧。只在我的机器上适用于 debugpy。
	virt_lines = false, -- 显示虚拟行而不是虚拟文本（会闪烁！）
	virt_text_win_col = nil, -- 将虚拟文本定位在固定的窗口列（从第一列开始），例如 80 表示在第 80 列定位，参见 `:h nvim_buf_set_extmark()`
})
