-- ┳━┓┏━┓  ┓━┓┏━┓┏┏┓┳━┓  ┓ ┳┏━┓┳━┓┳┏
-- ┃ ┃┃ ┃  ┗━┓┃ ┃┃┃┃┣━   ┃┃┃┃ ┃┃┳┛┣┻┓
-- ┇━┛┛━┛  ━━┛┛━┛┛ ┇┻━┛  ┗┻┇┛━┛┇┗┛┇ ┛

local opt = vim.opt
local g = vim.g

local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

-- ┳━┓┳  ┳ ┓┏━┓o┏┓┓┓━┓
-- ┃━┛┃  ┃ ┃┃ ┳┃┃┃┃┗━┓
-- ┇  ┇━┛┇━┛┇━┛┇┇┗┛━━┛

local use = require("packer").use
require("packer").startup(function()
  use "wbthomason/packer.nvim"
  use { "nvim-telescope/telescope.nvim", requires =
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      { "jvgrootveld/telescope-zoxide", } }

  -- lsp crap
  use { "nvim-treesitter/nvim-treesitter" }
  use { "neovim/nvim-lspconfig" }
  use { "williamboman/nvim-lsp-installer" }
  use { "hrsh7th/nvim-cmp" } -- Autocompletion plugin
  use { "hrsh7th/cmp-nvim-lsp" } -- LSP source for nvim-cmp
  use { "saadparwaiz1/cmp_luasnip" } -- Snippets source for nvim-cmp
  use { "onsails/lspkind-nvim" } -- Snippets source for nvim-cmp
  use { "L3MON4D3/LuaSnip" } -- Snippets plugin

  -- filetype plugins
  use {"amadeus/vim-mjml", ft = {"mjml"}}
  use {"itspriddle/vim-marked", ft = {"markdown"}}
  use {"plasticboy/vim-markdown", ft = {"markdown"}}
  -- use {"polarmutex/beancount.nvim", ft = {"beancount"}}
  use {"npxbr/glow.nvim", ft = {"markdown"}}
  use { "Iron-E/nvim-libmodal", ft = {"markdown"}}
  use { "Iron-E/nvim-typora", ft = {"markdown"}}

  -- colors & ui!
  use { "norcalli/nvim-colorizer.lua" }
  use { "NTBBloodbath/doom-one.nvim" }
  -- use { "folke/tokyonight.nvim" }
  use { "shadmansaleh/lualine.nvim", requires = {"kyazdani42/nvim-web-devicons"} }
  -- use { "windwp/windline.nvim", requires = {"kyazdani42/nvim-web-devicons"} }

  -- misc
  use { "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } }
  use { "terrortylor/nvim-comment" }
  use { "folke/todo-comments.nvim" }
  use { "windwp/nvim-autopairs" }
  use { "lukas-reineke/indent-blankline.nvim" }
  use { "pocco81/truezen.nvim" }
  use { "akinsho/toggleterm.nvim" }
end)

-- ┏━┓┳━┓┏┓┓o┏━┓┏┓┓┓━┓
-- ┃ ┃┃━┛ ┃ ┃┃ ┃┃┃┃┗━┓
-- ┛━┛┇   ┇ ┇┛━┛┇┗┛━━┛

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

-- ┳━┓┳ ┓┏┓┓┏━┓┏┓┓o┏━┓┏┓┓┓━┓
-- ┣━ ┃ ┃┃┃┃┃   ┃ ┃┃ ┃┃┃┃┗━┓
-- ┇  ┇━┛┇┗┛┗━┛ ┇ ┇┛━┛┇┗┛━━┛

local function navi(wincmd, direction)

  local previous_winnr = vim.fn.winnr()
  vim.cmd("wincmd " .. wincmd)

  if previous_winnr == vim.fn.winnr() then
   vim.fn.system('tmux-yabai.sh ' .. direction)
  end
end

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- ┳━┓o┏┓┓┳━┓o┏┓┓┏━┓┓━┓
-- ┃━┃┃┃┃┃┃ ┃┃┃┃┃┃ ┳┗━┓
-- ┇━┛┇┇┗┛┇━┛┇┇┗┛┇━┛━━┛

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
map("n", "<Leader>tt", ":TodoTelescope<CR>", opt)

-- Oh, those comment headers look nice.
map("n", "<Leader>c", ":.!toilet -f rustofat<CR>:norm gc2j<CR>", opt)

-- Exit terminal with esc
map("t", "<Esc>", "<C-\\><C-n>", opt)

--Remap for dealing with word wrap
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Navigation - Tmux & Vim & Yabai
map("n", "<C-h>", ":lua navi('h', 'west')<CR>", { silent = true })
map("n", "<C-k>", ":lua navi('k', 'north')<CR>", { silent = true })
map("n", "<C-l>", ":lua navi('l', 'east')<CR>", { silent = true })
map("n", "<C-j>", ":lua navi('j', 'south')<CR>", { silent = true })

-- keep visual selection when (de)indenting
map("v", "<", "<gv", opt)
map("v", ">", ">gv", opt)

-- TODO figure this out.
map("n", "<Leader>x", ":lua require('core.utils').close_buffer()<CR>", { silent = true }) -- close  buffer

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

-- ┳━┓┳  ┳ ┓┏━┓o┏┓┓  ┓━┓┳━┓┏┓┓┳ ┓┳━┓
-- ┃━┛┃  ┃ ┃┃ ┳┃┃┃┃  ┗━┓┣━  ┃ ┃ ┃┃━┛
-- ┇  ┇━┛┇━┛┇━┛┇┇┗┛  ━━┛┻━┛ ┇ ┇━┛┇

-- colorscheme
require('doom-one').setup {
    cursor_coloring = true,
    italic_comments = true,
    plugins_integrations = {
        gitsigns = true,
        telescope = true,
    },
}

-- blankline
require("indent_blankline").setup {
    char = "│",
    buftype_exclude = {"terminal", "nofile", },
    filetype_exclude = {"help", "packer", "markdown", "mail", },
    show_trailing_blankline_indent = false,
}

-- truezen
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

-- lualine - stop yak shaving and use a fucking default.
require('lualine').setup()
-- require('wlsample.evil_line')

-- pretty pretty pretty good
require('colorizer').setup()

-- gcc yo
require('nvim_comment').setup()
require("todo-comments").setup()

-- TODO: this is annoying - figure out how to use it properly.
require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
  enable_check_bracket_line = false
})

require('toggleterm').setup{
  open_mapping = [[<leader>t]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = '1', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = false, -- whether or not the open mapping applies in insert mode
  persist_size = true,
  direction = 'float',
  close_on_exit = true, -- close the terminal window when the process exits
  float_opts = {
    border = 'curved',
    width = 100,
    height = 30,
    winblend = 3,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
}

require('gitsigns').setup {
   signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
   status_formatter = nil, -- Use default
   watch_gitdir = {
      interval = 100,
   },
}

-- telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous"
      }
    },
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
    },
  },
}

-- why does zoxide work without this require?
require('telescope').load_extension('fzf')

-- treeshitter
require('nvim-treesitter.configs').setup {
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
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

-- ┳  ┓━┓┳━┓      ┳━┓┏━┓  o  ┏┓┓┳━┓┳━┓┳━┓  ┏┓┓┳ ┳o┓━┓  ┳━┓┳━┓┳━┓┳  ┳  ┓ ┳┏━┓
-- ┃  ┗━┓┃━┛  ━━  ┃ ┃┃ ┃  ┃  ┃┃┃┣━ ┣━ ┃ ┃   ┃ ┃━┫┃┗━┓  ┃┳┛┣━ ┃━┫┃  ┃  ┗┏┛ ┏┛
-- ┇━┛━━┛┇        ┇━┛┛━┛  ┇  ┇┗┛┻━┛┻━┛┇━┛   ┇ ┇ ┻┇━━┛  ┇┗┛┻━┛┛ ┇┇━┛┇━┛ ┇  o

local lsp_installer = require("nvim-lsp-installer")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local function common_on_attach(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    local opts = {noremap = true, silent = true}

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end
end

lsp_installer.on_server_ready(function(server)
    local opts = {
      on_attach = common_on_attach,
  }
  -- FIXME: this doesn't bloody work.
    if server.name == "sumneko_lua" then
        opts.Lua = {
            diagnostics = {
                globals = {"vim", "hs", "spoon"}
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                },
                maxPreload = 100000,
                preloadFileSize = 10000
            },
            telemetry = {
                enable = false
            }
        }
    end
    opts.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- luasnip setup
-- local luasnip = require('luasnip')
local lspkind = require('lspkind')
local cmp = require('cmp')

-- nvim-cmp setup
cmp.setup {
   snippet = {
      expand = function(args)
         require("luasnip").lsp_expand(args.body)
      end,
   },
   formatting = {
    format = lspkind.cmp_format({with_text = false, maxwidth = 50})
  },
  mapping = {
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
         behavior = cmp.ConfirmBehavior.Replace,
         select = true,
      },
      ["<Tab>"] = function(fallback)
         if vim.fn.pumvisible() == 1 then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, true, true), "n")
         elseif require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
         else
            fallback()
         end
      end,
      ["<S-Tab>"] = function(fallback)
         if vim.fn.pumvisible() == 1 then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-p>", true, true, true), "n")
         elseif require("luasnip").jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
         else
            fallback()
         end
      end,
   },
   sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "nvim_lua" },
      -- { name = "path" },
   },
}

-- you need setup cmp first put this after cmp.setup()
require("nvim-autopairs.completion.cmp").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
  auto_select = true, -- automatically select the first item
  insert = false, -- use insert confirm behavior instead of replace
  map_char = { -- modifies the function or method delimiter by filetypes
    all = '(',
    tex = '{'
  }
})

-- ┳━┓┳ ┓┏┓┓┏━┓┏━┓┏━┓┏┏┓┏┏┓┳━┓┏┓┓┳━┓┓━┓
-- ┃━┫┃ ┃ ┃ ┃ ┃┃  ┃ ┃┃┃┃┃┃┃┃━┫┃┃┃┃ ┃┗━┓
-- ┛ ┇┇━┛ ┇ ┛━┛┗━┛┛━┛┛ ┇┛ ┇┛ ┇┇┗┛┇━┛━━┛

-- annoying spaces begone
vim.api.nvim_exec([[
  augroup TrailingSpaces
    autocmd!
    autocmd BufWritePre * :%s/\s\+$//e
  augroup end
]], false)

-- Highlight on wank
vim.api.nvim_exec([[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]], false)

-- spelchek
vim.api.nvim_exec([[
  augroup SpellCheck
    autocmd!
    autocmd BufNewFile,BufRead *.md setlocal spell
  augroup end
]], false)

-- Pack it up, pack it in.
vim.api.nvim_exec( [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]], false)
