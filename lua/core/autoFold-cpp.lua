local autoFold_cpp = {}

local function FindFunctionEnd(file_contents, start_pos)
    local pattern = "^}"
    for i=start_pos + 1,#file_contents do
        local line = file_contents[i]
        if string.find(line, pattern) then
            return i
        end
    end
end

function autoFold_cpp:ToggleFold(flag)
    local pattern1 = "^{"
    local path = vim.fn.expand('%')
    local file_contents = vim.fn.readfile(path)
    vim.cmd("normal zE")
    if not flag then
        return
    end
    local preLine
    for i,line in ipairs(file_contents) do
        local result = string.match(line, pattern1)
        if result then
            vim.cmd("normal " .. i .. "G")
            vim.cmd("normal V")
            if preLine then
                vim.cmd("normal k")
                vim.cmd("normal o")
            end
            local end_line = FindFunctionEnd(file_contents, i)
            vim.cmd("normal " .. end_line .. "G")
            vim.cmd("normal zf")
        end
        preLine = line
    end
end

return autoFold_cpp
