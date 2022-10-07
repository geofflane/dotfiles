local Plug = require 'usermod.vimplug'

Plug.begin('~/.config/nvim/plugged')

-- ========== General ============
-- For file icons, used by nvim-tree and lualine
Plug 'kyazdani42/nvim-web-devicons'
-- File explorer/Nerdtree replacement
Plug('kyazdani42/nvim-tree.lua', {
  config = function()
    local nvimTree = require("nvim-tree")
    nvimTree.setup()
    vim.api.nvim_set_keymap('', '<Leader><Leader>', ':NvimTreeToggle<CR>', {noremap = true})
  end
})

-- Better file searching
Plug('mileszs/ack.vim', {
  run = function()
    vim.g.ackprg = 'ag --vimgrep --smart-case'
    vim.cmd('cnoreabbrev Ag Ack')
    vim.cmd('cnoreabbrev ag Ack')
    -- Use ag over grep
    vim.opt.grepprg = 'ag --nogroup --nocolor'
  end
})

-- Fuzzy finder, probably don't need Ack
-- <C-q> to send to quickfix
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim', {
    tag = '0.1.0',
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', 'ff', builtin.find_files, {})
      vim.keymap.set('n', '<C-p>', builtin.find_files, {})
      vim.keymap.set('n', 'fg', builtin.live_grep, {})
      vim.keymap.set('n', 'fb', builtin.buffers, {})
      vim.keymap.set('n', 'fh', builtin.help_tags, {})
    end
  })

-- I REALLY like surround
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'
-- Put ends after things
Plug('tpope/vim-endwise')
-- Git support
Plug('tpope/vim-fugitive')

-- Commenting
-- gcc / V gc
Plug('numToStr/Comment.nvim', {
    config = function()
      require('Comment').setup()
    end
  })

-- visual increment Ctrl+A
Plug('triglav/vim-visual-increment')

if(vim.fn.has('mac'))
then
  -- Copy syntax highlighted code into rtg
  Plug('zerowidth/vim-copy-as-rtf')
end

-- Visually show marks in buffer
Plug('jacquesbh/vim-showmarks')

-- ========== LSP ============
Plug('williamboman/mason.nvim', {
    config = function()
      require('mason').setup()
    end
  })
Plug('williamboman/mason-lspconfig.nvim', {
    config = function()
      require("mason-lspconfig").setup({
          ensure_installed = {'elixirls', 'pyright', 'sqlls', 'tsserver', 'yamlls', 'sumneko_lua'},
          automatic_installation = true,
        })
    end
  })
Plug('neovim/nvim-lspconfig', {
    config = function()
      -- Mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      local opts = {noremap = true, silent = true}
      vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = {noremap = true, silent = true, buffer = bufnr}
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<C-[>', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<space>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
      vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
      vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
    end

    local lsp_flags = {
      -- This is the default in Nvim 0.7+
      debounce_text_changes = 150,
    }
    require('lspconfig')['pyright'].setup{
      on_attach = on_attach,
      flags = lsp_flags,
    }
    require('lspconfig')['tsserver'].setup{
      on_attach = on_attach,
      flags = lsp_flags,
    }
    require('lspconfig')['elixirls'].setup{
      on_attach = on_attach,
      flags = lsp_flags,
    }
    require('lspconfig')['sqlls'].setup{
      on_attach = on_attach,
      flags = lsp_flags,
    }
    require('lspconfig')['sumneko_lua'].setup{
      on_attach = on_attach,
      flags = lsp_flags,
      settings = {
        Lua = {
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
        },
      },
    }
  end
})

-- ========== Themes and visual ============
-- Themes
-- Plug('veloce/vim-aldmeris', {
--   config = function()
--     vim.cmd('colorscheme aldmeris')
--   end
-- })
Plug('EdenEast/nightfox.nvim', {
    config = function()
      -- Default options
      require('nightfox').setup({
          options = {
            styles = {              -- Style to be applied to different syntax groups
              comments = "bold",    -- Value is any valid attr-list value `:help attr-list`
            },
          },
        })

      vim.cmd('colorscheme nordfox')
    end
})


Plug('nvim-lualine/lualine.nvim', {
    config = function()
      require('lualine').setup({
        options = {
          icons_enabled = true,
          theme = 'auto',
        }
      })
    end
  })

-- ========== Langauges ==============
Plug('nvim-treesitter/nvim-treesitter', {
  config = function()
    -- vim.cmd('TSUpdate')

    require('nvim-treesitter.configs').setup({
        -- A list of parser names, or "all"
        ensure_installed = {
          'elixir',
          'lua',
          'typescript',
          'tsx',
          'javascript',
          'python',
          'css',
          'json'
        },
        -- Automatically install missing parsers when entering buffer
        auto_install = true,
        highlight = {
          enabled = true
        },
      })
  end
})

-- TODO: Is this needed in Neovim with tree-sitter?
Plug('sheerun/vim-polyglot')    -- Polyglot: A collection of language packs, loaded on demand

-- Plug('vim-scripts/taglist.vim')

-- Ale for syntax checking. Maybe not needed with LSP?
Plug('dense-analysis/ale', {     -- On-the-fly syntax checking
    config = function()
      vim.g.ale_lint_on_text_changed = 'never'
      vim.g.ale_linters = {
        elixir = {'credo'},
        javascript = {'eslint'},
        jsx = {'eslint'},
        typescript = {'eslint', 'tslint', 'typecheck'},
        typescriptreact = {'eslint', 'tslint', 'typecheck'},
      }
    end
  })

-- Elixir
Plug('mhinz/vim-mix-format')
Plug('avdgaag/vim-phoenix')

-- Markdown
-- Plug('tpope/vim-markdown.git')

-- Ruby and Rails
-- Plug('tpope/vim-rbenv')
-- Plug('tpope/vim-bundler')
-- Plug('tpope/vim-rails')
-- Plug('thoughtbot/vim-rspec')

-- Clojure
-- Plug('tpope/vim-fireplace')
-- Plug('tpope/vim-classpath')
-- Plug('vim-scripts/paredit.vim') -- paredit, better paren handling for the lisps
-- Plug('vim-scripts/vim-niji')    -- rainbow
-- -- vim-clojure
-- let g:vimclojure#HighlightBuiltins = 1
-- let g:clojure_align_multiline_strings = 1

-- Haskell
-- Plug('eagletmt/ghcmod-vim')
-- -- ghcmod-vim
-- if has("mac")
--   let g:haddock_browser = "open"
--   let g:haddock_browser_callformat = "%s %s"
-- else
--   let g:haddock_browser="/usr/bin/firefox"
-- endif

Plug.ends()
