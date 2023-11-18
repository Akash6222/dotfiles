local wk = require("whichkey")
local mappings = {
  --q = { ":q<cr>", "Quit" },
  --Q = { ":wq<cr>", "Save & Quit" },
  --w = { ":w<cr>", "Save" },
  --x = { ":bdelete<cr>", "Close" },
  --E = { ":e ~/.config/nvim/init.lua<cr>", "Edit config" },
  F = { ":Telescope find_files<cr>", "Telescope Find Files" },
  r = { ":Telescope live_grep<cr>", "Telescope Live Grep" },
  t = {
    t = { ":ToggleTerm<cr>", "Split Below" },
    f = { toggle_float, "Floating Terminal" },
    l = { toggle_lazygit, "LazyGit" }
  },
}

local opts = {prefix  = '<leader>'}
wk.register{mappings, opts}
