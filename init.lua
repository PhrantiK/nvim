local opt = vim.opt
local g = vim.g
   
-- Install packer
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

local use = require("packer").use
require("packer").startup(function()
  use "wbthomason/packer.nvim"
  use { "nvim-telescope/telescope.nvim", requires =
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      { "jvgrootveld/telescope-zoxide", } }
  use { "terrortylor/nvim-comment" }
  use { "NTBBloodbath/doom-one.nvim" }
  -- use { "folke/tokyonight.nvim" }
  -- use { "rafamadriz/neon" }
  -- use { "rafamadriz/themes.nvim" }
  use { "norcalli/nvim-colorizer.lua" }
  use { "shadmansaleh/lualine.nvim", requires = {"kyazdani42/nvim-web-devicons"} }
  use { "lukas-reineke/indent-blankline.nvim" }
  use { "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } }
  use { "nvim-treesitter/nvim-treesitter" }
  use { "pocco81/truezen.nvim" }
  -- use { "akinsho/toggleterm.nvim" } 
  use {"amadeus/vim-mjml", ft = {"mjml"}}
  use {"itspriddle/vim-marked", ft = {"markdown"}}
  use {"plasticboy/vim-markdown", ft = {"markdown"}}
  -- use {"polarmutex/beancount.nvim", ft = {"beancount"}}
  use {"npxbr/glow.nvim", ft = {"markdown"}}
end)

-- vim.cmd [[colorscheme tokyonight]]

opt.termguicolors = true
opt.ruler = false
opt.hidden = true
opt.ignorecase = true
opt.splitbelow = true
opt.splitright = true
opt.cul = true
opt.mouse = "a"
opt.signcolumn = "yes"
opt.cmdheight = 1
opt.updatetime = 250 -- update interval for gitsigns
opt.timeoutlen = 400
opt.clipboard = "unnamedplus"
opt.scrolloff = 3
opt.lazyredraw = true
opt.undofile = true
opt.grepprg = "rg --vimgrep"
opt.incsearch = true -- Makes search act like search in modern browsers
opt.scrolloff = 4 -- Lines of context
opt.number = true
opt.numberwidth = 2
opt.relativenumber = true
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.shortmess:append("asI") --disable intro
opt.fillchars = {eob = " "}
opt.foldlevelstart = 3
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldmethod = "marker"

g.loaded_fancy_comment = 1

local disabled_built_ins = {
    "netrw",
    "netrwPlugin",
    "netrwSettings",
    "netrwFileHandlers",
    "gzip",
    "zip",
    "zipPlugin",
    "tar",
    "tarPlugin",
    "getscript",
    "getscriptPlugin",
    "vimball",
    "vimballPlugin",
    "2html_plugin",
    "logipat",
    "rrhelper",
    "spellfile_plugin",
    "matchit"
}
 
for _, plugin in pairs(disabled_built_ins) do
    vim.g["loaded_" .. plugin] = 1
end


function navi(wincmd, direction)

  previous_winnr = vim.fn.winnr()
  vim.cmd("wincmd " .. wincmd)

  if previous_winnr == vim.fn.winnr() then
   vim.fn.system('tmux-yabai.sh ' .. direction)
  end
end

function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

opt = {}

--Remap space as leader key
map('', '<Space>', '<Nop>', { noremap = true, silent = true })
g.mapleader = ' '
g.maplocalleader = ' '

map("n", "<Leader>gt", ":Telescope git_status <CR>", opt)
map("n", "<Leader>cm", ":Telescope git_commits <CR>", opt)
map("n", "<Leader>ff", ":Telescope find_files <CR>", opt)
map("n", "<Leader>fb", ":Telescope current_buffer_fuzzy_find <CR>", opt)
map("n", "<Leader>th", ":Telescope colorscheme <CR>", opt)
map("n", "<Leader>fd", ":Telescope find_files --hidden <CR>", opt)
map("n", "<Leader>cd", ":Telescope zoxide list <CR>", opt)
map("n", "<Leader>fw", ":Telescope live_grep<CR>", opt)
map("n", "<Leader><space>", ":Telescope buffers<CR>", opt)
map("n", "<Leader>fh", ":Telescope help_tags<CR>", opt)
map("n", "<Leader>fo", ":Telescope oldfiles<CR>", opt)

--Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Navigation - Tmux & Vim & Yabai
-- map("n", "<C-h>", ":lua navi('h', 'west')<CR>", { silent = true })
-- map("n", "<C-k>", ":lua navi('k', 'north')<CR>", { silent = true })
-- map("n", "<C-l>", ":lua navi('l', 'east')<CR>", { silent = true })
-- map("n", "<C-j>", ":lua navi('j', 'south')<CR>", { silent = true })

-- keep visual selection when (de)indenting
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)

-- Turn off search matches with double-<Esc>
map('n', '<Esc><Esc>', '<Esc>:nohlsearch<CR>', { silent = true })

-- Don't copy the replaced text after pasting in visual mode
map("v", "p", '"_dP', opt)

-- COPY EVERYTHING --
map("n", "<C-a>", " : %y+<CR>", opt)

-- toggle Zen
map("n", "<leader>z", " : TZAtaraxis<CR>",{ silent = true }) 

-- Map <leader>o & <leader>O to newline without insert mode
map('n', '<leader>o',
    ':<C-u>call append(line("."), repeat([""], v:count1))<CR>',
    { silent = true })

map('n', '<leader>O',
    ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>',
    { silent = true })

require('doom-one').setup {
    cursor_coloring = true,
    italic_comments = true,
    enable_treesitter = true,
    plugins_integrations = {
        gitsigns = true,
        telescope = true,
        indent_blankline = true,
    },
}

require("indent_blankline").setup {
    char = "│",
    buftype_exclude = {"terminal", "nofile", },
    filetype_exclude = {"help", "packer", "markdown", "mail", },
    -- char_highlight_list = { "Whitespace", },
    show_trailing_blankline_indent = false,
}

-- require("indent_blankline").setup {
--     space_char_blankline = " ",
--     char_highlight_list = {
--         "NonText",
--     },
-- }

local colors = {
  black        = '#282828',
  white        = '#ebdbb2',
  red          = '#fb4934',
  green        = '#b8bb26',
  blue         = '#83a598',
  yellow       = '#fe8019',
  gray         = '#a89984',
  darkgray     = '#3c3836',
  lightgray    = '#504945',
  inactivegray = '#7c6f64',
}

require("true-zen").setup {
  modes = {
      ataraxis = {
          quit = "quit",
      },
  },
  integrations = {
      gitsigns = true,
      lualine = true
  },
}

require('lualine').setup()
require('colorizer').setup()
require('nvim_comment').setup()
-- require('toggleterm').setup{
--   -- size can be a number or function which is passed the current terminal
--   open_mapping = [[<leader>t]],
--   hide_numbers = true, -- hide the number column in toggleterm buffers
--   shade_filetypes = {},
--   shade_terminals = true,
--   shading_factor = '1', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
--   start_in_insert = true,
--   insert_mappings = true, -- whether or not the open mapping applies in insert mode
--   persist_size = true,
--   direction = 'float',
--   close_on_exit = true, -- close the terminal window when the process exits
--   -- This field is only relevant if direction is set to 'float'
--   float_opts = {
--     -- The border key is *almost* the same as 'nvim_open_win'
--     -- see :h nvim_open_win for details on borders however
--     -- the 'curved' border is a custom border type
--     -- not natively supported but implemented in this plugin.
--     border = 'curved',
--     width = 100,
--     height = 30,
--     winblend = 3,
--     highlights = {
--       border = "Normal",
--       background = "Normal",
--     },
--   },
-- }

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}

-- Telescope
require('telescope').setup {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    layout_config = {
      horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8
      },
      vertical = {
          mirror = false
      },
      width = 0.87,
      height = 0.80,
      preview_cutoff = 120
    },
    set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case" -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
    },
  },
}

-- This will load fzy_native and have it override the default file sorter
require('telescope').load_extension('fzf')

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
}

-- Highlight on yank
vim.api.nvim_exec( [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]], false)

vim.api.nvim_exec([[
  augroup SpellCheck
    autocmd!
    autocmd BufNewFile,BufRead *.md setlocal spell
  augroup end
]], false)

vim.api.nvim_exec( [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]], false)

