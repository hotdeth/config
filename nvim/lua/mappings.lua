require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map('t', '<Esc>', [[<C-\><C-n>]], {noremap = true})
map("n", "<leader>ha", function() require("harpoon.mark").add_file() end, { desc = "Harpoon Mark File" })
map("n", "<C-e>", function() require("harpoon.ui").toggle_quick_menu() end, { desc = "Harpoon Menu" })

local map = vim.keymap.set

map('n', 'gd', vim.lsp.buf.definition, { desc = "Go to Definition" })
map('n', 'gD', vim.lsp.buf.declaration, { desc = "Go to Declaration" })
map('n', 'gr', vim.lsp.buf.references, { desc = "Go to References" })
map('n', 'gi', vim.lsp.buf.implementation, { desc = "Go to Implementation" })
map('n', 'K', vim.lsp.buf.hover, { desc = "Hover Documentation" })
