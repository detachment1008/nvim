local autoImpl = require "core.autoImpl"

local autoFold = {}
local flag = false
function autoFold:ToggleFold()
    flag = not flag
    local pattern1 = "^function"
    local pattern2 = "^local.+function"
    local path = vim.fn.expand('%')
    local file_contents = vim.fn.readfile(path)
    vim.cmd("normal zE")
    for i,line in ipairs(file_contents) do
        if flag then
            local result = string.match(line, pattern1) or string.match(line, pattern2)
            if result then
                vim.cmd("normal " .. i .. "G")
                vim.cmd("normal V")
                local end_line = autoImpl:FindFunctionEnd(file_contents, i)
                vim.cmd("normal " .. end_line .. "G")
                vim.cmd("normal zf")
            end
        end
    end
end
function AutoFoldFunc()
    autoFold:ToggleFold()
end
-- 设置命令行映射
vim.cmd("command! -nargs=0 ToggleFold :lua AutoFoldFunc()")
return autoFold
