local dap = require("dap")

local path = vim.loop.os_uname().sysname == "Darwin"
		and "/Users/bole/.config/nvim/extensions/extension/debugAdapters/bin/OpenDebugAD7"
	or "/home/dcr/.config/nvim/extensions/extension/debugAdapters/bin/OpenDebugAD7"

-- Adapter
dap.adapters.cppdbg = {
	id = "cppdbg",
	type = "executable",
	command = path,
}

-- Configurations
dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "cppdbg",
		request = "launch",
		program = function()
			-- return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
			return vim.fn.getcwd() .. "/" .. "a.out"
		end,
		cwd = "${workspaceFolder}",
		stopAtEntry = true,
	},
	-- {
	--     name = 'Attach to gdbserver :1234',
	--     type = 'cppdbg',
	--     request = 'launch',
	--     MIMode = 'gdb',
	--     miDebuggerServerAddress = 'localhost:1234',
	--     miDebuggerPath = '/usr/bin/gdb',
	--     cwd = '${workspaceFolder}',
	--     program = function()
	--         return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
	--     end,
	-- },
}

-- pretty-printing
setupCommands = {
	{
		text = "-enable-pretty-printing",
		description = "enable pretty printing",
		ignoreFailures = false,
	},
}

-- c and rust
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
