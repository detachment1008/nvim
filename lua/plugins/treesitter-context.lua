require('treesitter-context').setup {
  enable = true, -- 是否启用插件
  max_lines = 3, -- 上下文窗口应延伸的最大行数。若值小于等于 0，则表示没有限制。
  min_window_height = 0, -- 启用上下文所需的最小窗口高度。若值小于等于 0，则表示没有限制。
  line_numbers = true, -- 是否在上下文窗口中显示行号
  multiline_threshold = 20, -- 每个上下文的最大行数
  trim_scope = 'outer', -- 如果超出 `max_lines`，则应该丢弃哪些上下文行。可选值为 `'inner'` 和 `'outer'`。
  mode = 'cursor', -- 计算上下文的基准行。可选值为 `'cursor'` 和 `'topline'`。
  separator = nil, -- 上下文和内容之间的分隔符。如果设置了分隔符，则只有在光标行之前至少有两行代码时才会显示上下文。
  zindex = 20, -- 上下文窗口的 Z-Index 值
  on_attach = nil -- 在哪些缓冲区中启用插件的回调函数
}
