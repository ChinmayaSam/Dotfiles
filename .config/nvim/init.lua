function normal_silent_keymap(key, map)
	vim.api.nvim_set_keymap("n", key, map, { noremap = true, silent = true })
end
function normal_keymap(key, map)
	vim.api.nvim_set_keymap("n", key, map, { noremap = true })
end
function command_keymap(key, map)
	vim.api.nvim_set_keymap("c", key, map, { noremap = true })
end
local o = vim.opt
local g = vim.g

-- Plugins
require("paq")({
	"savq/paq-nvim",
	"junegunn/fzf",
	"alvan/vim-closetag",
	"numToStr/Comment.nvim",
	"nvim-lua/plenary.nvim",
	"maxmellon/vim-jsx-pretty",
	"jose-elias-alvarez/null-ls.nvim",
})
require("Comment").setup()

-- Null-ls Setup
local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
null_ls.setup({
	sources = {
		formatting.yapf.with({
			extra_args = { "--style={use_tabs=True}" },
		}),
		formatting.prettier.with({
			extra_args = { "--use-tabs" },
			filetypes = { "html", "typescript", "javascript", "css", "yaml", "jsonc", "javascriptreact" },
		}),
		formatting.stylua,
	},
})

-- General Settings
o.relativenumber = true
o.number = true
o.guicursor = ""
o.mouse = ""
o.smartcase = true
o.wrap = false
o.backup = false
o.writebackup = false
o.swapfile = false
o.autoindent = true
o.ignorecase = true
o.hlsearch = false
g.fzf_action = { ["enter"] = "tab split" }

-- Tab Settings
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = false
o.list = false

-- Keybindings
g.mapleader = " "
normal_silent_keymap("H", "<cmd>tabprev<cr>")
normal_silent_keymap("L", "<cmd>tabnext<cr>")
normal_silent_keymap("U", "<C-r>") -- redo
normal_silent_keymap("<leader>pv", "<cmd>Tex<cr>")
normal_silent_keymap("<leader>s", "<cmd>source %<cr>")
normal_silent_keymap("<leader>t", "<cmd>echo &ft<cr>")
normal_silent_keymap("<leader>h", "<cmd>bprev<cr>")
normal_silent_keymap("<leader>l", "<cmd>bnext<cr>")
normal_silent_keymap("<leader>dd", "<cmd>bdelete<cr>")
normal_silent_keymap("<leader>nv", "<cmd>tabedit ~/.config/nvim/init.lua<cr>")
normal_silent_keymap("<C-p>", ":FZF<cr>")
normal_keymap("<leader>e", ":tabedit ")
normal_keymap("<leader>r", ":%s///g<left><left><left>")
command_keymap("<C-j>", "<down>")
command_keymap("<C-k>", "<up>")
command_keymap("<C-h>", "<left>")
command_keymap("<C-l>", "<right>")

-- Netrw Settings
g.netrw_banner = 0
g.netrw_list_hide = "__pycache__,.git,node_modules,venv"

-- Closetags
g.closetag_filenames = "*.html,*.jsx"
g.closetag_xhtml_filenames = "*.jsx"
g.closetag_emptyTags_caseSensitive = 1

-- User Commands
vim.api.nvim_create_user_command("Format", function()
	vim.lsp.buf.format({ timeout_ms = 5000 })
end, { nargs = 0 })
