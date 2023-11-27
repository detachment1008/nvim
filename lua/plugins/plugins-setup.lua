-- 自动安装 packer
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

--[[
    保存此文件自动更新安装软件
--]]
vim.cmd([[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
    augroup end
]])

return require("packer").startup(function(use)
	-- packer
	use("wbthomason/packer.nvim")

	-- tokyonight
	use("folke/tokyonight.nvim")

	-- 状态栏 + 状态栏图标
	use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } })

	-- 文档树 + 文档树图标
	use({ "nvim-tree/nvim-tree.lua", requires = { "nvim-tree/nvim-web-devicons" } })

	-- -- 用ctrl-hjkl来定位窗口
	-- use("christoomey/vim-tmux-navigator")

	-- 语法高亮
	use("nvim-treesitter/nvim-treesitter")

	-- 配合 treesitter，不同括号颜色区分
	use("p00f/nvim-ts-rainbow")

	-- lsp
	-- 支持语法提示的lsp三个插件，中间的相当于是桥梁
	use({ "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig" })

	-- 自动补全
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")

	-- snippets引擎，不装这个自动补全会出问题
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use("rafamadriz/friendly-snippets")

	-- gcc 和 gc 注释
	use("numToStr/Comment.nvim")

	-- 自动补全括号
	use("windwp/nvim-autopairs")

	-- 文件检索
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.4", requires = { { "nvim-lua/plenary.nvim" } } })

	-- 用于提升 telescope 性能
	use({
		"nvim-telescope/telescope-fzf-native.nvim",
		run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	})

	-- vscode主题
	use("Mofiqul/vscode.nvim")

	-- markdown-preview
	-- install without yarn or npm
	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	})

	-- 超框显示代码块头
	use("nvim-treesitter/nvim-treesitter-context")

	-- 函数等符号大纲
	use("simrat39/symbols-outline.nvim")

	-- hop(easymotion)
	use({
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	})

	-- debugger: nvim-dap
	use("mfussenegger/nvim-dap") -- dap
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
	use("theHamsta/nvim-dap-virtual-text")

	-- gitsign
	use("lewis6991/gitsigns.nvim")

	-- 格式化
	use({ "mhartington/formatter.nvim" })

	if packer_bootstrap then
		require("packer").sync()
	end
end)
