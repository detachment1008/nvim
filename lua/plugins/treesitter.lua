
require "nvim-treesitter.configs".setup
{
    -- 添加识别的语言
    ensure_installed = {"vim", "bash", "c", "cpp"--[[, "c_sharp"--]], "json", "lua"},

    -- 高亮
    highlight = { enable = false },

    -- 自动缩进
    indent = { enable = true },

    -- 不同括号的颜色区分(似乎有问题，先禁用。它会错误的将某些括号变色，且无法自动变回来，只能重新输入)
    -- 误会解除，是tokyonight的锅
    -- 但是它会把括号颜色变成红色，奇怪
    rainbow = {
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
}

