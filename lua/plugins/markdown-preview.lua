vim.g.mkdp_auto_start = false -- 设置为 true 后，当你打开一个 Markdown 文件时，预览窗口会自动打开。如果自动打开就会自动切换焦点，不想自动切换焦点
vim.g.mkdp_auto_close = false -- 设置为 true 后，在从 Markdown 缓冲区切换到其他缓冲区时，当前预览窗口会自动关闭。
vim.g.mkdp_refresh_slow = true -- 设置为 true 后，当你保存文档或退出插入模式时，Markdown 预览会刷新。默认情况下，它会在你编辑或移动光标时自动刷新。
vim.g.mkdp_command_for_global = false -- 设置为 true 后，MarkdownPreview 命令可以用于所有文件，而不仅限于 Markdown 文件。
vim.g.mkdp_open_to_the_world = false -- 设置为 true 后，预览服务器可供网络中的其他人使用。默认情况下，服务器监听 localhost（127.0.0.1）。
vim.g.mkdp_open_ip = "" -- 在远程 Vim 上工作并在本地浏览器上进行预览时，可以使用自定义 IP 地址。
vim.g.mkdp_browser = "" -- 指定要用于打开预览页面的浏览器。默认为空。
vim.g.mkdp_echo_preview_url = false -- 设置为 true 后，在打开预览页面时，将在命令行中显示预览页面的 URL。
vim.g.mkdp_browserfunc = "" -- 设置自定义 Lua 函数的名称，用于打开预览页面。该函数将接收 URL 作为参数。默认为空。
vim.g.mkdp_preview_options = {
	mkit = {},
	katex = {},
	uml = {},
	maid = {},
	disable_sync_scroll = false,
	sync_scroll_type = "middle",
	hide_yaml_meta = true,
	sequence_diagrams = {},
	flowchart_diagrams = {},
	content_editable = false,
	disable_filename = false,
	toc = {},
} -- 设置渲染 Markdown 的选项，包括 markdown-it、KaTeX、markdown-it-plantuml 等。你还可以禁用同步滚动、隐藏 YAML 元数据等。具体信息请查看 vim-markdown-preview 的文档。
vim.g.mkdp_markdown_css = "" -- 使用自定义的 Markdown 样式。必须是绝对路径，例如 `/Users/username/markdown.css` 或 `vim.fn.expand('~/markdown.css')`。
vim.g.mkdp_highlight_css = "" -- 使用自定义的高亮样式。必须是绝对路径，例如 `/Users/username/highlight.css` 或 `vim.fn.expand('~/highlight.css')`。
vim.g.mkdp_port = "" -- 使用自定义端口启动服务器，如果留空则使用随机端口。
vim.g.mkdp_page_title = "「${name}」" -- 预览页面的标题。`${name}` 将被替换为文件名。
vim.g.mkdp_images_path = "" -- 为图片使用自定义位置。
vim.g.mkdp_filetypes = { "markdown" } -- 识别的文件类型。这些文件类型将有 MarkdownPreview... 命令。
vim.g.mkdp_theme = "dark" -- 设置预览页面的默认主题。
vim.g.mkdp_combine_preview = false -- 如果启用，则在预览 Markdown 文件时，会重用以前打开的预览窗口。如果启用此选项，请确保设置 `let g:mkdp_auto_close = 0`。
vim.g.mkdp_combine_preview_auto_refresh = true -- 如果启用，则在更改 Markdown 缓冲区时，会自动重新获取合并的预览内容。仅当 `g:mkdp_combine_preview` 为 1 时才有效。
