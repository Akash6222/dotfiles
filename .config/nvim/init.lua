vim.loader.enable()

require("akash.options")
require("akash.keymaps")
require("akash.lazy")
require("akash.autocommands")
--require("akash.macros")
require("akash.icons")
-- require("akash.which-key")

-- Enable autochdir
vim.cmd([[set autochdir]])

-- Enable autochdir
vim.o.autochdir = true

-- Bufferline 
require("bufferline").setup{}
require("octo").setup{}

-- Discord 
require("presence").setup{}

