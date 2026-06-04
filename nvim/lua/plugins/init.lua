-- return {
--   {
--     "stevearc/conform.nvim",
--     -- event = 'BufWritePre', -- uncomment for format on save
--     opts = require "configs.conform",
--   },
--
--   -- These are some examples, uncomment them if you want to see them work!
--   {
--     "neovim/nvim-lspconfig",
--     config = function()
--       require "configs.lspconfig"
--     end,
--   },

-- NAME: clean this up
return {
  { "kylechui/nvim-surround", event = "VeryLazy", config = true },

  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "moon",
        transparent = true,
        styles = { comments = { italic = true }, keywords = { italic = true } },
      })
      vim.cmd([[colorscheme tokyonight-moon]])
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "html", "javascript", "typescript", "tsx", "svelte", "go", "php", "blade", "prisma" },
      highlight = { enable = true },
    },
  },

  { "mistweaverco/kulala.nvim", ft = "http" },

  {
    "windwp/nvim-ts-autotag",
    ft = { "html", "javascript", "typescript", "svelte", "xml" },
    config = function() require("nvim-ts-autotag").setup() end,
  },

  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua" },
    ft = {"go", "gomod"},
    build = ':lua require("go.install").update_all_sync()',
    config = function() require("go").setup({ lsp_cfg = true }) end,
  },

  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = { "tpope/vim-dadbod", lazy = true },
    cmd = { "DBUI", "DBUIToggle" },
  },

  { "ThePrimeagen/harpoon", dependencies = { "nvim-lua/plenary.nvim" } },

  { "xiyaowong/transparent.nvim", lazy = false },

{
    "smolck/command-completion.nvim",
    event = "CmdlineEnter", 
    config = function()
      require("command-completion").setup({
        highlight_selection = true,
      })
    end,
  },


{
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    cmdline = {
      enabled = true,
      view = "cmdline_popup", 
    },
    popupmenu = {
      enabled = true, 
    },
  },
},
{
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  lazy = false, 
  opts = {}
},

{
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  opts = {},
},

{
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {},
  -- Optional dependencies
  dependencies = { { "nvim-mini/mini.icons", opts = {} } },
  -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}



}
