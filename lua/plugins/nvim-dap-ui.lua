local dap = require("dap")
local dapui = require("dapui")

-- vim.opt.signcolumn = "yes"
vim.opt.signcolumn = "no"
vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0 })
vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0 })
vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0 })

local dap_breakpoint = {
	error = {
		text = "🛑",
		texthl = "DapBreakpoint",
		linehl = "DapBreakpoint",
		numhl = "DapBreakpoint",
	},
	condition = {
		text = "󰟃",
		texthl = "DapBreakpoint",
		linehl = "DapBreakpoint",
		numhl = "DapBreakpoint",
	},
	rejected = {
		text = "󰃤",
		texthl = "DapBreakpint",
		linehl = "DapBreakpoint",
		numhl = "DapBreakpoint",
	},
	logpoint = {
		text = "",
		texthl = "DapLogPoint",
		linehl = "DapLogPoint",
		numhl = "DapLogPoint",
	},
	stopped = {
		text = "󰜴",
		texthl = "DapStopped",
		linehl = "DapStopped",
		numhl = "DapStopped",
	},
}

vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
vim.fn.sign_define("DapBreakpointCondition", dap_breakpoint.condition)
vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
vim.fn.sign_define("DapLogPoint", dap_breakpoint.logpoint)
vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)

dapui.setup({
	-- 快捷键映射关系
	-- element_mappings = {
	--     -- 作用域
	--     scopes = {
	--         edit = "e",
	--         repl = "r",
	--     },
	--     -- 观察变量
	--     watches = {
	--         edit = "e",
	--         repl = "r",
	--     },
	--     -- 堆栈信息
	--     stacks = {
	--         open = "g",
	--     },
	--     -- 断点信息
	--     breakpoints = {
	--         open = "g",
	--         toggle = "b",
	--     },
	-- },
	-- 布局信息
	layouts = {
		{
			-- 包含元素
			elements = {
				-- "scopes",
				"repl",
				"breakpoints",
				"stacks",
			},
			size = 0.2, -- 元素宽度所占比例
			position = "right",
		},
		{
			elements = {
				"watches",
				"console",
			},
			size = 0.4, -- 元素高度所占比例
			position = "bottom",
		},
		-- {
		--     elements = {
		--         "console",
		--     },
		--     size = 0.2,
		--     position = "right",
		-- },
	},
	-- 浮动窗口
	floating = {
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = nil, -- Floats will be treated as percentage of your screen.
		border = "rounded", -- Border style. Can be "single", "double" or "rounded"
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
})

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
