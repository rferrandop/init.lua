local map = vim.keymap.set

map({"n", "i"}, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- Show native file explorer
map("n", "<C-e>", "<cmd>:Ex<cr>", { desc = "Show file explorer" })

-- Buffers
map("n", "<S-h>", "<cmd>bprev<cr>", { desc = "Go previous buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Go next buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr><esc>", { desc = "Delete buffer" })

-- Move lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })
