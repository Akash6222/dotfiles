vim.loader.enable()

require("rj.options")
require("rj.keymaps")
require("rj.lazy")
require("rj.autocommands")
--require("rj.macros")
require("rj.icons")
-- require("rj.which-key")

-- Enable autochdir
vim.cmd([[set autochdir]])

-- Enable autochdir
vim.o.autochdir = true

-- Bufferline 
require("bufferline").setup{}
