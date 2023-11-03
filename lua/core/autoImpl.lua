local autoImpl = {}

local path
-- local path = "/Users/bole/Documents/UnicornUnity/Assets/LuaScripts/GameTheme/10124/DJNight/View.lua"

local behaviorPattern = {
    [1] = {"ProcessorBase", "(ProcessorBase.)([%w_]+)"},
    [2] = {"ProcessorFree", "(ProcessorFree.)([%w_]+)"},
    [3] = {"ProcessorBonus", "(ProcessorBonus.)([%w_]+)"},
}

local contains = function(tab, target)
    for _,v in pairs(tab) do
        if v == target then
            return true
        end
    end
    return false
end

function autoImpl:ReadViewFile()
    local func_queue = {}
    for i=1,#behaviorPattern do
        local file_name = behaviorPattern[i][1]
        func_queue[file_name] = {}
    end
    local pattern = "^[%s]*{ behavior = "
    path = vim.fn.expand('%')
    -- local file_name = vim.api.nvim_buf_get_name(3)
    local file_contents = vim.fn.readfile(path)
    for _,line in ipairs(file_contents) do
        local result = string.match(line, pattern)
        if result then
            for i=1,#behaviorPattern do
                local cur_pattern = behaviorPattern[i][2]
                local targetFileName,func_name = string.match(line, cur_pattern)
                if func_name then
                    targetFileName = string.sub(targetFileName, 1, #targetFileName - 1)
                    if not contains(func_queue[targetFileName], func_name) then
                        table.insert(func_queue[targetFileName], func_name)
                    end
                    break
                end
            end
        end
    end
    for i=1,#behaviorPattern do
        if not next(func_queue[behaviorPattern[i][1]]) then
            func_queue[behaviorPattern[i][1]] = nil
        end
    end
    return func_queue
end

function autoImpl:GenerateImpl(fileName, functionName)
    local str = {}
    table.insert(str, string.format("function %s:%s()", fileName, functionName))
    table.insert(str, "")
    table.insert(str, "    self.currentGameBoard:Step()")
    table.insert(str, "end")
    table.insert(str, "")
    -- return string.format("function %s:%s()\n\nend\n", fileName, functionName)
    return str
end

function autoImpl:GetTargetFilePath(targetFileName)
    local idx = path:find("/[^/]*$")
    if idx then
        return path:sub(1, idx) .. targetFileName .. ".lua"
    else
        return nil
    end
end

function autoImpl:AutoImpl()
    local func_list = self:ReadViewFile()
    for i,v in pairs(func_list) do
        local total_path = self:GetTargetFilePath(i)
        local default_pos
        for j=#v,1,-1 do
            local func_name = v[j]
            local flag, pos = self:IsFunctionImpl(total_path, func_name)
            if flag then
                default_pos = pos
            else
                if not default_pos then
                    default_pos = pos
                end
                local total_impl_str = self:GenerateImpl(i, func_name)
                self:insert_text(default_pos + 2, total_impl_str, total_path)
                default_pos = default_pos + #total_impl_str
            end
        end
    end
end

function autoImpl:insert_text(lineNumber, txt, filepath)
    for i=1,#txt do
        local line_number = lineNumber + i - 1
        local text = txt[i]
        local bufnr = vim.fn.bufnr(filepath, true) -- 获取文件的缓冲区编号
        vim.api.nvim_set_current_buf(bufnr)
        if bufnr <= 0 then
            vim.cmd("edit " .. filepath)
            bufnr = vim.fn.bufnr(filepath, true)
        end
        vim.api.nvim_buf_set_lines(bufnr, line_number - 1, line_number - 1, false, {text})
    end
    vim.cmd("w")
end

function autoImpl:IsFunctionImpl(file_name, func_name)
    local head = "[-]+BehaviorTree[-]+."
    local default_pos = nil
    local file_contents = vim.fn.readfile(file_name)
    local pattern = "function%s[%g]+[:.]([%w_]+)[%s]*[%(%)]"
    for i,line in ipairs(file_contents) do
        if not default_pos then
            local default = string.find(line, head)
            if default then
                default_pos = i
            end
        end
        local result = string.match(line, pattern)
        if result and result == func_name then
            local end_line = self:FindFunctionEnd(file_contents, i)
            return true, end_line
        end
    end
    return false, default_pos
end

function autoImpl:FindFunctionEnd(file_contents, start_pos)
    local stack = {}
    local black_list = {
        "if",
        "while",
        "function",
        "do",
        "repeat"
    }
    local end_list = {
        "end",
        "until"
    }
    for i=start_pos + 1,#file_contents do
        local line = file_contents[i]
        if not line then
            return nil
        end
        for _,v in ipairs(black_list) do
            if string.find(line, v) then
                table.insert(stack, true)
                break
            end
        end
        for _,v in ipairs(end_list) do
            if string.find(line, v) then
                if #stack == 0 then
                    return i
                else
                    table.remove(stack)
                    break
                end
            end
        end
    end
end

function AutoImplFunc ()
    autoImpl:AutoImpl()
end
-- 设置命令行映射
vim.cmd("command! -nargs=0 GenerateBehavior :lua AutoImplFunc()")

return autoImpl
