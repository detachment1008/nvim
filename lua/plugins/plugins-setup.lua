-- 自动安装 packer
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

--[[
    保存此文件自动更新安装软件
--]]
vim.cmd [[
    augroup packer_user_config
        autocmd!
        autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
    augroup end
]]

return require "packer".startup(function(use)

    -- 使用 use+仓库名 就可以了
    use "wbthomason/packer.nvim"    -- packer
    use "folke/tokyonight.nvim"     -- tokyonight
    use {"nvim-lualine/lualine.nvim", requires = {"kyazdani42/nvim-web-devicons", opt = true}} -- 状态栏+状态栏图标
    use {"nvim-tree/nvim-tree.lua", requires = {"nvim-tree/nvim-web-devicons"}} --文档树+文档树图标
    use "christoomey/vim-tmux-navigator" -- 用ctrl-hjkl来定位窗口
    use "nvim-treesitter/nvim-treesitter" -- 语法高亮
    use "p00f/nvim-ts-rainbow" -- 配合treesitter，不同括号颜色区分
    use {"williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim", "neovim/nvim-lspconfig"} -- 支持语法提示的lsp三个插件，中间的相当于是桥梁
    -- 自动补全
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
    use "L3MON4D3/LuaSnip" -- snippets引擎，不装这个自动补全会出问题
    use "saadparwaiz1/cmp_luasnip"
    use "rafamadriz/friendly-snippets"
    use "hrsh7th/cmp-path" -- 文件路径
    use "numToStr/Comment.nvim" -- gcc和gc注释
    use "windwp/nvim-autopairs" -- 自动补全括号
    -- 以后再来研究这两个
    -- use "akinsho/bufferline.nvim" --buffer分割线
    -- use "lewis6991/gitsigns.nvim" -- 左则git提示
    use {"nvim-telescope/telescope.nvim", tag = "0.1.1", requires = {{"nvim-lua/plenary.nvim"}}} -- 文件检索
    use "Mofiqul/vscode.nvim" -- vscode主题
    -- markdown-preview
    -- install without yarn or npm
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })
    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install", setup = function() vim.g.mkdp_filetypes = { "markdown" } end, ft = { "markdown" }, })
    use "nvim-treesitter/nvim-treesitter-context" -- 超框显示代码块头
    use "simrat39/symbols-outline.nvim" -- 函数等符号大纲
    -- hop(easymotion)
    use {
        'phaazon/hop.nvim',
        branch = 'v2', -- optional but strongly recommended
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
        end
    }



    if packer_bootstrap then
        require "packer".sync()
    end
end)
