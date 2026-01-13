vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end
vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- ===============================
-- Plugins
-- ===============================
require("lazy").setup({

{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "html", "javascript", "typescript", "tsx", "xml" },
        highlight = { enable = true },
      })
    end,
  },



  "mistweaverco/kulala.nvim",

{
    "windwp/nvim-ts-autotag",
    dependencies = "nvim-treesitter/nvim-treesitter",
    ft = { "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte", "vue", "xml" },
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

{
"ray-x/go.nvim",
  dependencies = { "ray-x/guihua.lua" },
  config = function()
    require("go").setup({
      goimport = 'gopls',
      gofmt = 'gofumpt', 
      tag_transform = 'snakecase',
      verbose_tests = true,
      lsp_cfg = true,
    })
  end,
  ft = {"go", "gomod"},
  build = ':lua require("go.install").update_all_sync()'
},





  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    init = function() vim.g.db_ui_use_nerd_fonts = 1 end,
  },

  -- Harpoon للتنقل السريع
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ha", function() require("harpoon.mark").add_file() end, desc = "Harpoon Mark File" },
      { "<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon Menu" },
    },
  },
 -- nvim-cmp and dependencies
 {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-path',
            'hrsh7th/vim-vsnip', -- Snippets plugin
        },
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                    end,
                },
                mapping = {
                    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
                    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
                    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
                    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
                    ['<C-e>'] = cmp.mapping({
                        i = cmp.mapping.abort(),
                        c = cmp.mapping.close(),
                    }),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                },
                sources = cmp.config.sources({
                    { name = 'vsnip' }, -- For `vsnip` users.
                    { name = 'path' },
                })
            })
        end
    },
    -- Other plugins that depend on nvim-cmp
    {
        'hrsh7th/cmp-path',
        dependencies = { 'nvim-cmp' }
    },
    {
        'hrsh7th/vim-vsnip',
        dependencies = { 'nvim-cmp' }
    },
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  -- Autocomplete & Snippets
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "saadparwaiz1/cmp_luasnip",
  "L3MON4D3/LuaSnip",
  "rafamadriz/friendly-snippets",









  -- LSP + Mason
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "neovim/nvim-lspconfig",

  -- Treesitter
  -- { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },

  -- Utilities
  "smolck/command-completion.nvim",
  "xiyaowong/transparent.nvim",
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
}, lazy_config)

-- ===============================
-- Load theme
-- ===============================
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"
require("luasnip.loaders.from_vscode").lazy_load()

vim.schedule(function()
  require "mappings"
end)

-- ===============================
-- Command completion
-- ===============================
require('command-completion').setup()
require('transparent').setup()




-- ===============================
-- Snippets
-- ===============================
local luasnip = require("luasnip")

luasnip.filetype_extend("blade", { "html" })
luasnip.filetype_extend("typescriptreact", { "html" })
luasnip.filetype_extend("javascriptreact", { "html" })

require("luasnip.loaders.from_vscode").lazy_load()






-- ===============================
-- Mason & LSP Setup
-- ===============================
require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = {
    "svelte"},
}

local lspconfig = vim.lsp.config 
local capabilities = require('cmp_nvim_lsp').default_capabilities()







local cmp = require("cmp")
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
}
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "php", "blade", "html", "css", "javascript", "svelte", "typescript", "tsx", "json" },
  highlight = { enable = true },
}

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.svelte", "*.ts", "*.tsx", "*.js", "*.jsx", "*.php" },
  command = "lua vim.lsp.buf.format({ async = false })"
})

vim.filetype.add({
  extension = { blade = "blade" },
  pattern = { [".*%.blade%.php"] = "blade" },
})





vim.filetype.add({
  extension = {
    prisma = "prisma",
  },
})
