-- 用于创建配置的实用程序
local util = require("formatter.util")

-- 提供 Format、FormatWrite、FormatLock 和 FormatWriteLock 命令
require("formatter").setup({
	-- 启用或禁用日志记录
	logging = true,
	-- 设置日志级别
	log_level = vim.log.levels.WARN,
	-- 所有格式化器配置都是选择加入的
	filetype = {
		-- 这里是针对文件类型 "lua" 的格式化器配置，将按顺序执行
		lua = {
			-- "formatter.filetypes.lua" 定义了 "lua" 文件类型的默认配置
			require("formatter.filetypes.lua").stylua,

			-- 也可以定义自己的配置
			function()
				-- 支持条件格式化
				if util.get_current_buffer_file_name() == "special.lua" then
					return nil
				end

				-- 配置的完整说明在下面和 Vim 帮助文件中
				return {
					exe = "stylua",
					args = {
						"--search-parent-directories",
						"--stdin-filepath",
						util.escape_path(util.get_current_buffer_file_path()),
						"--",
						"-",
					},
					stdin = true,
				}
			end,
		},

		cpp = require("config/clangd-format"),

		-- 使用特殊的 "*" 文件类型来定义任何文件类型的格式化器配置
		["*"] = {
			-- "formatter.filetypes.any" 定义了任何文件类型的默认配置
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})
-- vim.cmd([[
--     augroup AutoFormatGroup
--       autocmd!
--       autocmd InsertLeave * Format
--     augroup END
-- ]])
vim.cmd([[
    augroup FormatAutogroup
        autocmd!
        autocmd BufWritePost * FormatWrite
    augroup END
]])
-- vim.cmd([[
--     augroup FormatAutogroup
--         autocmd!
--         autocmd FileType cpp inoremap ; ;<Esc>:Format<CR>a
--     augroup END
-- ]])
-- vim.cmd
-- [[
--     augroup FormatAutogroup
--         autocmd!
--         autocmd User FormatterPre lua print "This will print before formatting"
--         autocmd User FormatterPost lua print "This will print after formatting"
--     augroup END
-- ]]
