require "nvim-treesitter.configs".setup
{
    -- 添加识别的语言
    ensure_installed = {"vim", "bash", "c", "cpp"--[[, "c_sharp"--]], "json", "lua"},
    -- 高亮
    highlight = { enable = false },
    -- 自动缩进
    indent = { enable = false },
    --[[
    rainbow =
    {
        enable = true,
        -- disable = { "jsx", "cpp"}
        extended_mode = true,
        max_file_lines = nil,
        colors = {
            '#00FFFF', -- 青色
            '#FFFF00', -- 黄色
            '#0F0F00', -- 绿色
            '#00F0F0', -- 未知色
            '#0000FF', -- 蓝色
            '#FF00FF', -- 品红色
        },
    }
    --]]
}

