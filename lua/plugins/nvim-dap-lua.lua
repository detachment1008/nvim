local dap = require("dap")
-- Adapter

local path = vim.loop.os_uname().sysname == "macOS" and "/Users/bole/.config/nvim/extensions/local-lua-debugger-vscode/" or "/home/dcr/.config/nvim/extensions/local-lua-debugger-vscode/"
local lua_version = vim.loop.os_uname().sysname == "macOS" and "lua5.4" or "lua5.3"
dap.adapters["local-lua"] = {
    type = "executable",
    command = "node",
    args = {
        path .. "extension/debugAdapter.js"
    },
    enrich_config = function(config, on_config)
        if not config["extensionPath"] then
            local c = vim.deepcopy(config)
            -- 💀 If this is missing or wrong you'll see 
            -- "module 'lldebugger' not found" errors in the dap-repl when trying to launch a debug session
            c.extensionPath = path
            on_config(c)
        else
            on_config(config)
        end
    end,
}

-- Configuration
dap.configurations.lua = {
    {
        name = 'Current file (local-lua-dbg, lua)',
        type = 'local-lua',
        request = 'launch',
        cwd = '${workspaceFolder}',
        program = {
            lua = lua_version,
            file = '${file}',
        },
        args = {},
    },
}
