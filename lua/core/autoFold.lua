local autoFold = {}

local enable_file_type = {
    "lua",
}
local function FindFunctionEnd(file_contents, start_pos)
    local pattern = "^end"
    for i=start_pos + 1,#file_contents do
        local line = file_contents[i]
        if string.find(line, pattern) then
            return i
        end
    end
end
local flag = false

function autoFold:ToggleFold()
    local t = true
    for _,v in pairs(enable_file_type) do
        if v == vim.bo.filetype then
            t = false
            break
        end
    end
    if t then
        return
    end
    flag = not flag
    local pattern1 = "^function"
    local pattern2 = "^local.+function%s*(.*)$"
    local path = vim.fn.expand('%')
    local file_contents = vim.fn.readfile(path)
    vim.cmd("normal zE")
    if not flag then
        return
    end
    for i,line in ipairs(file_contents) do
        local result = string.match(line, pattern1) or string.match(line, pattern2)
        if result then
            vim.cmd("normal " .. i .. "G")
            vim.cmd("normal V")
            local end_line = FindFunctionEnd(file_contents, i)
            vim.cmd("normal " .. end_line .. "G")
            vim.cmd("normal zf")
        end
    end
end
-- change state
function AutoFoldFunc()
    autoFold:ToggleFold()
end
-- open
function AutoFoldOpen()
    flag = true
    autoFold:ToggleFold()
end
-- close
function AutoFoldClose()
    flag = false
    autoFold:ToggleFold()
end
-- 设置命令行映射
vim.cmd("command! -nargs=0 ToggleFold :lua AutoFoldFunc()")
vim.cmd("command! -nargs=0 OpenFold :lua AutoFoldOpen()")
vim.cmd("command! -nargs=0 CloseFold :lua AutoFoldClose()")
return autoFold
