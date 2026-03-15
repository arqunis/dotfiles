---- Use Unicode by default.
vim.cmd.language("en_US.UTF-8")
vim.opt.encoding = "utf-8"

---- Syntax highlighting
vim.cmd.syntax("on")

---- Absolute line numbering
vim.opt.number = true

---- Plugins (via vim-plug)
local Plug = vim.fn["plug#"]

vim.call("plug#begin")

Plug("sheerun/vim-polyglot")

Plug("itchyny/lightline.vim")
Plug("catppuccin/nvim", { ["as"] = "catppuccin" })

vim.call("plug#end")

---- Theme.
vim.opt.background = "dark"

if vim.fn.has("termguicolors") then
    vim.opt.termguicolors = true

    vim.cmd.colorscheme("catppuccin-macchiato")
    vim.g.lightline = { colorscheme = "catppuccin" }
end

---- Altering defaults

-- Set the leader key to a space.
vim.g.mapleader = " "

-- Do not show the current mode. The theme already does it for us.
vim.opt.showmode = false

-- Always show the statusline.
vim.opt.laststatus = 2

-- Split windows in a sane way, new window on the bottom vertically and right
-- horizontally.
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Leave a 3 character margin whenever scrolling vertically or horizontally.
vim.opt.scrolloff = 3
vim.opt.sidescroll = 3

-- Display a ruler to keep track of the number of characters in a line.
vim.opt.ruler = true
vim.opt.colorcolumn = "80"

-- Write spaces instead of tabs, which are equal to four columns.
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1

-- Remove autoindents and newlines when backspacing.
vim.opt.backspace = { "indent", "eol", "start" }

-- Highlight text when searching
vim.opt.incsearch = true
vim.opt.showmatch = true
vim.opt.hlsearch = true

-- Clear the highlighting
vim.keymap.set("n", "\\", ":noh<cr>")

-- Allow resizing windows with the mouse
vim.opt.mouse = "a"

-- Limit the amount of lines in the command line.
vim.opt.cmdheight = 2

vim.opt.shortmess:append("c")
vim.opt.signcolumn = "yes"

---- Autocommands

-- Strip trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    command = "%s/\\s\\+$//e",
})

---- Keybindings

-- Disable Ex mode
vim.keymap.set("n", "Q", "<Nop>")

-- Disable :find-manpage keybind
vim.keymap.set("n", "K", "<Nop>")

function InsertTabWrapper()
    local col = vim.fn.col(".") - 1

    if col == 0 or vim.regex([[\k]]):match_str(vim.fn.getline("."):sub(col, col)) == nil then
        return "<tab>"
    else
        return "<c-n>"
    end
end

-- Utilise builtin autocompletion
vim.keymap.set("i", "<tab>", InsertTabWrapper, { expr = true })

-- Split vertically using <c-w>n
vim.keymap.set("n", "<c-w>n", "<c-w>s")
vim.keymap.set("n", "<c-w><c-n>", "<c-w>s")
