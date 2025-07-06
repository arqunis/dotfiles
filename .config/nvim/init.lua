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

    -- Unnecessary in Neovim, but kept just in case.
    -- vim.opt.t_8f="\\<Esc>[37;2;%lu;%lu;%lum"
    -- vim.opt.t_8b="\\<Esc>[48;2;%lu;%lu;%lum"

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

-- Improve regex.
vim.opt.magic = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Use spaces in lieu of tabs.
vim.opt.expandtab = true
vim.opt.smarttab = true

-- A tab is equal to four spaces.
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Copy indents when creating new lines.
vim.opt.autoindent = true

-- Always use `\n` newlines for delimiting a line.
vim.opt.fileformat = "unix"

-- Remove autoindents and newlines when backspacing.
vim.opt.backspace = { "indent", "eol", "start" }

-- When changing buffers, hide them
vim.opt.hidden = true

-- Highlight text when searching
vim.opt.incsearch = true
vim.opt.showmatch = true
vim.opt.hlsearch = true

-- Clear the highlighting
vim.keymap.set("n", "\\", ":noh<cr>")

-- Allow resizing windows with the mouse
vim.opt.mouse = "a"

-- Do not make backups each time before overwriting a file
vim.opt.backup = false
vim.opt.writebackup = false

-- Neither make swaps of currently open files
vim.opt.swapfile = false

-- Limit the amount of lines in the command line.
vim.opt.cmdheight = 2

vim.opt.shortmess:append("c")
vim.opt.signcolumn = "yes"
vim.opt.lazyredraw = true

-- Searching for files easier
-- credit: https://youtu.be/XA2WjJbmmoM?t=425
vim.opt.path:append("**")
vim.opt.wildmenu = true

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

-- Move between panels using <c-hjkl>
vim.keymap.set("n", "<c-h>", "<c-w>h")
vim.keymap.set("n", "<c-j>", "<c-w>j")
vim.keymap.set("n", "<c-k>", "<c-w>k")
vim.keymap.set("n", "<c-l>", "<c-w>l")

-- Split vertically using <c-w>n
vim.keymap.set("n", "<c-w>n", "<c-w>s")
vim.keymap.set("n", "<c-w><c-n>", "<c-w>s")

-- Close the current panel using <c-q>
vim.keymap.set("n", "<c-q>", "<c-w>q")

-- Same as above, but for the terminal mode.
vim.keymap.set("t", "<c-h>", "<c-\\><c-n><c-w>h")
vim.keymap.set("t", "<c-j>", "<c-\\><c-n><c-w>j")
vim.keymap.set("t", "<c-k>", "<c-\\><c-n><c-w>k")
vim.keymap.set("t", "<c-l>", "<c-\\><c-n><c-w>l")

vim.keymap.set("t", "<c-w>n", "<c-\\><c-n><c-w>s")
vim.keymap.set("t", "<c-w><c-n>", "<c-\\><c-n><c-w>s")

vim.keymap.set("t", "<c-q>", "<c-\\><c-n><c-w>q")

-- Turn to normal mode from terminal mode with Escape.
vim.keymap.set("t", "<esc>", "<c-\\><c-n>")
