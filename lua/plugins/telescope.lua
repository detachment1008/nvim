local builtin = require "telescope.builtin"
vim.keymap.set('n', '<leader>ff', builtin.find_files, {}) -- 找到指定文件
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {}) -- 找到指定字符串
vim.keymap.set('n', '<leader>fb', builtin.buffers, {}) -- 找到指定缓冲区
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {}) -- 帮助文档
vim.keymap.set('n', '<leader>fr', builtin.registers, {}) -- 找到指定寄存器，并粘贴到当前位置
vim.keymap.set('n', '<leader>fcg', builtin.current_buffer_fuzzy_find, {}) -- 当前缓冲区进行实时模糊搜索
vim.keymap.set('n', '<leader>fsg', builtin.spell_suggest, {}) -- 列出当前单词的拼写建议

-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
