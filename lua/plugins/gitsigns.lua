require('gitsigns').setup {
    signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
    },
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
        follow_files = true
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
        -- Options passed to nvim_open_win
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
    yadm = {
        enable = false
    },

    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, {expr=true})

        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, {expr=true})

        -- Actions
        map('n', '<leader>gs', gs.stage_hunk) -- 当前块加入暂存区
        map('n', '<leader>gS', gs.stage_buffer) -- 当前文件加入暂存区
        map('n', '<leader>gr', gs.reset_hunk) -- 当前块恢复到上一次提交的状态
        map('n', '<leader>gR', gs.reset_buffer) -- 当前文件恢复到上一次提交的状态
        map('n', '<leader>gu', gs.undo_stage_hunk) -- 当前块取消暂存(似乎有 bug?)
        map('n', '<leader>gp', gs.preview_hunk) -- 查看当前块的修改
        map('n', '<leader>gb', function() gs.blame_line{full=true} end) -- 查看当前块最近一次提交的修改记录
        -- map('n', '<leader>tb', gs.toggle_current_line_blame)
        map('n', '<leader>gd', gs.diffthis) -- 查看当前文件的修改记录: 左边是原始的，右边是修改后的
        -- map('n', '<leader>hD', function() gs.diffthis('~') end) -- 似乎和上面的相同
        -- map('n', '<leader>td', gs.toggle_deleted) -- 不知道是什么意思
        map('v', '<leader>gs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end) -- 可视模式: 选中的加入暂存区
        map('v', '<leader>gr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end) -- 可视模式: 选中的恢复到上一次提交的状态

        -- Text object
        map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
}

vim.cmd(":Gitsigns toggle_current_line_blame")
