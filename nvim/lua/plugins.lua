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
  config = function()
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
    branch = '0.1.x',
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', 'ff', builtin.find_files, {})
      vim.keymap.set('n', '<C-p>', builtin.find_files, {})
      vim.keymap.set('n', 'fg', builtin.live_grep, {})
      vim.keymap.set('n', 'fb', builtin.buffers, {})
      vim.keymap.set('n', 'fh', builtin.help_tags, {})
    end
  })

-- I REALLY like surround, this is an nvim version with repeat included
Plug('kylechui/nvim-surround', {
    config = function()
      require('nvim-surround').setup()
    end
})

-- Funky replacement and case changing
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

if (vim.fn.has('mac') == 1)
then
  -- Copy syntax highlighted code into rtg
  Plug('zerowidth/vim-copy-as-rtf')
end

-- Visually show marks in buffer
Plug('jacquesbh/vim-showmarks')

-- ========== LSP ============
Plug('williamboman/mason.nvim')
Plug('williamboman/mason-lspconfig.nvim', {
    config = function()
      require('mason').setup()
      require("mason-lspconfig").setup({
          ensure_installed = {
            'bashls',
            'cssls',
            'dockerls',
            'elixirls',
            'erlangls',
            'gopls',
            'html',
            'jsonls',
            'marksman', -- markdown
            'pyright',
            'ruby_ls',
            'sqlls',
            'sumneko_lua',
            'tsserver',
            'yamlls',
          },
          automatic_installation = true,
        })
    end
  })
Plug('neovim/nvim-lspconfig', {
    config = function()
      -- Mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      local opts = {noremap = true, silent = true}
      vim.keymap.set('n', '<LEADER>e', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', '<LEADER>q', vim.diagnostic.setloclist, opts)

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
        vim.keymap.set('n', '<LEADER>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<LEADER>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<LEADER>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workLEADER_folders()))
        end, bufopts)
      vim.keymap.set('n', '<LEADER>D', vim.lsp.buf.type_definition, bufopts)
      vim.keymap.set('n', '<LEADER>rn', vim.lsp.buf.rename, bufopts)
      vim.keymap.set('n', '<LEADER>ca', vim.lsp.buf.code_action, bufopts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
      vim.keymap.set('n', '<LEADER>f', function() vim.lsp.buf.format { async = true } end, bufopts)
    end

    local lsp_defaults = {
      flags = {
        debounce_text_changes = 150,
      },
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
      on_attach = on_attach
      -- on_attach = function(client, bufnr)
      --   vim.api.nvim_exec_autocmds('User', {pattern = 'LspAttached'})
      -- end
    }

    local lspconfig = require('lspconfig')
    lspconfig.util.default_config = vim.tbl_deep_extend('force', lspconfig.util.default_config, lsp_defaults)

    require('lspconfig')['bashls'].setup({})
    require('lspconfig')['cssls'].setup({})
    require('lspconfig')['dockerls'].setup({})
    require('lspconfig')['elixirls'].setup({})
    require('lspconfig')['erlangls'].setup({})
    require('lspconfig')['gopls'].setup({})
    require('lspconfig')['html'].setup({})
    require('lspconfig')['jsonls'].setup({})
    require('lspconfig')['marksman'].setup({}) -- markdown
    require('lspconfig')['pyright'].setup({})
    require('lspconfig')['ruby_ls'].setup({})
    require('lspconfig')['sqlls'].setup({})
    require('lspconfig')['sumneko_lua'].setup({
      settings = {
        Lua = {
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
        },
      },
    })
    require('lspconfig')['tsserver'].setup({})
    require('lspconfig')['yamlls'].setup({})
  end
})

-- ========== Completeion ============
-- Snippets, need to understand more about how to use this
Plug('L3MON4D3/LuaSnip', {
  tag = 'v1.*',
  config = function()
    require('luasnip.loaders.from_vscode').lazy_load()
  end
})
Plug('rafamadriz/friendly-snippets') -- language specific snippets

Plug('saadparwaiz1/cmp_luasnip') -- completion from snippets
Plug('hrsh7th/cmp-nvim-lsp') -- completion from LSP
Plug('hrsh7th/cmp-buffer')   -- completion from this buffer
Plug('hrsh7th/cmp-path')     -- completion from file paths

-- The basis for configuring completion
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
Plug('hrsh7th/nvim-cmp', {
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      local select_opts = {behavior = cmp.SelectBehavior.Select}

      cmp.setup({
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end
          },
          sources = {
            {name = 'path'},
            {name = 'nvim_lsp', keyword_length = 3},
            {name = 'buffer', keyword_length = 3},
            {name = 'luasnip', keyword_length = 2},
          },
          window = {
            documentation = cmp.config.window.bordered()
          },
          formatting = {
            fields = {'menu', 'abbr', 'kind'},
            format = function(entry, item)
              local menu_icon = {
                nvim_lsp = 'λ',
                luasnip = '⋗',
                buffer = 'Ω',
                path = '🖫',
              }

              item.menu = menu_icon[entry.source.name]
              return item
            end,
          },
          mapping = {
            ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
            ['<Down>'] = cmp.mapping.select_next_item(select_opts),

            ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
            ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),

            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({select = true}),

            ['<C-d>'] = cmp.mapping(function(fallback)
              if luasnip.jumpable(1) then
                luasnip.jump(1)
              else
                fallback()
              end
            end, {'i', 's'}),

            ['<C-b>'] = cmp.mapping(function(fallback)
              if luasnip.jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, {'i', 's'}),

            ['<Tab>'] = cmp.mapping(function(fallback)
              local col = vim.fn.col('.') - 1

              if cmp.visible() then
                cmp.select_next_item(select_opts)
              elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                fallback()
              else
                cmp.complete()
              end
            end, {'i', 's'}),

            ['<S-Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item(select_opts)
              else
                fallback()
              end
            end, {'i', 's'}),
        },
      })
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
        },
        sections = {
          lualine_c = {
            {
              'filename',
              file_status = true, -- displays file status (readonly status, modified status)
              path = 1            -- 1 - Relative path, 2 -- absolute path
            },
          },
        },
        inactive_sections = {
          lualine_c = {
            {
              'filename',
              path = 1            -- 1 - Relative path, 2 -- absolute path
            }
          },
        },
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
          'bash',
          'comment',
          'css',
          'dockerfile',
          'eex',
          'elixir',
          'erlang',
          'go',
          'heex',
          'javascript',
          'json',
          'lua',
          'markdown',
          'python',
          'ruby',
          'rust',
          'scss',
          'tsx',
          'typescript',
          'vim',
          'yaml',
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
-- Polyglot: A collection of language packs, loaded on demand
Plug('sheerun/vim-polyglot')

-- Plug('vim-scripts/taglist.vim')

-- Ale for on-the-fly syntax checking.
-- TODO: Maybe not needed with LSP?
Plug('dense-analysis/ale', {
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
Plug('mhinz/vim-mix-format', {ft = {'elixir'}})
Plug('avdgaag/vim-phoenix', {ft = {'elixir'}})

-- Markdown
Plug('tpope/vim-markdown', {ft = {'markdown'}})

-- Ruby and Rails
-- Plug('tpope/vim-rbenv', {ft = {'ruby'}})
-- Plug('tpope/vim-bundler', {ft = {'ruby'}})
-- Plug('tpope/vim-rails', {ft = {'ruby'}})
-- Plug('thoughtbot/vim-rspec', {ft = {'ruby'}})

-- Clojure
-- Plug('tpope/vim-fireplace')
-- Plug('tpope/vim-classpath')
-- Plug('vim-scripts/paredit', {ft = {'clojure', 'scheme'}})     -- paredit, better paren handling for the lisps
-- Plug('vim-scripts/vim-niji', {ft = {'clojure', 'scheme'}})    -- rainbow
-- -- vim-clojure
-- vim.g['vimclojure#HighlightBuiltins'] = 1
-- vim.g.clojure_align_multiline_strings = 1

-- Haskell
-- -- ghcmod-vim
-- Plug('eagletmt/ghcmod-vim', {
--   config = function()
--     -- if (vim.fn.has("mac") == 1)
--      then
--        vim.g.haddock_browser = "open"
--        vim.g.haddock_browser_callformat = "%s %s"
--      else
--        vim.g.haddock_browser = "/usr/bin/firefox"
--      end
--   end
-- })


Plug.ends()
