local autoFold = {}

local enable_file_type = {
    ["lua"] = require "core/autoFold-lua",
    ["cpp"] = require "core/autoFold-cpp",
}
local flag = false

function autoFold:ToggleFold()
    for k,v in pairs(enable_file_type) do
        if k == vim.bo.filetype then
            v:ToggleFold(flag)
        end
    end
end

-- change state
function AutoFoldFunc()
    autoFold:ToggleFold()
end
-- open
function AutoFoldOpen()
    flag = false
    autoFold:ToggleFold()
end
-- close
function AutoFoldClose()
    flag = true
    autoFold:ToggleFold()
end
-- 设置命令行映射
vim.cmd("command! -nargs=0 ToggleFold :lua AutoFoldFunc()")
vim.cmd("command! -nargs=0 OpenFold :lua AutoFoldOpen()")
vim.cmd("command! -nargs=0 CloseFold :lua AutoFoldClose()")
return autoFold
