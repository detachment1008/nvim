local autoFold_lua = {}

local function FindFunctionEnd(file_contents, start_pos)
    local pattern = "^end"
    for i=start_pos + 1,#file_contents do
        local line = file_contents[i]
        if string.find(line, pattern) then
            return i
        end
    end
end

function autoFold_lua:ToggleFold(flag)
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

return autoFold_lua
