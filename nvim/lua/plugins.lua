local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require('lazy').setup({
  -- ========== General ============
  -- File explorer/Nerdtree replacement
  {
    'kyazdani42/nvim-tree.lua',
    -- For file icons, used by nvim-tree and lualine
    dependencies = {
      'kyazdani42/nvim-web-devicons'
    },
    config = function()
      local nvimTree = require("nvim-tree")
      nvimTree.setup()
      vim.api.nvim_set_keymap('', '<Leader><Leader>', ':NvimTreeToggle<CR>', {noremap = true})
    end
  },

  -- Better file searching
  {
    'mileszs/ack.vim',
    config = function()
      vim.g.ackprg = 'rg --vimgrep --smart-case'
      vim.cmd('cnoreabbrev Ag Ack')
      vim.cmd('cnoreabbrev ag Ack')
      -- Use rg over grep
      vim.opt.grepprg = 'rg --vimgrep --smart-case --hidden'
    end
  },

  -- Fuzzy finder, probably don't need Ack
  -- <C-q> to send to quickfix
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {'nvim-lua/plenary.nvim'},
    tag = '0.1.5',
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', 'ff', builtin.find_files, {})
      vim.keymap.set('n', '<C-p>', builtin.find_files, {})
      vim.keymap.set('n', 'fg', builtin.live_grep, {})
      vim.keymap.set('n', 'fb', builtin.buffers, {})
      vim.keymap.set('n', 'fh', builtin.help_tags, {})
    end
  },

  -- I REALLY like surround, this is an nvim version with repeat included
  {
    'kylechui/nvim-surround',
    config = function()
      require('nvim-surround').setup()
    end
  },

  -- Funky replacement and case changing
  'tpope/vim-abolish',
  -- Git support
  'tpope/vim-fugitive',

  -- Commenting
  -- gcc / V gc
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  },

  -- visual increment Ctrl+A
  'triglav/vim-visual-increment',

    -- Copy syntax highlighted code into rtg
  {
    'zerowidth/vim-copy-as-rtf',
    enabled = (vim.fn.has('mac') == 1)
  },

  -- Visually show marks in buffer
  'jacquesbh/vim-showmarks',

  -- fixme/todo/etc handling
  {
    'folke/todo-comments.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('todo-comments').setup({})
    end
  },

  -- ========== LSP ============
  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
      'neovim/nvim-lspconfig',
    },

    config = function()
      require('mason').setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          'bashls',
          'cssls',
          'dockerls',
          'elixirls',
          'erlangls',
          'eslint',
          'gopls',
          'html',
          'jsonls',
          'marksman', -- markdown
          'pyright',
          'ruby_ls',
          'ruff_lsp',
          'sqlls',
          'lua_ls',
          'tsserver',
          -- 'yamlls' -- yamlls doesn't work well with cloudformation
        },
        automatic_installation = true,
      })

      -- Use internal formatting for bindings like gq. null-ls or neovim messes this up somehow
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          vim.bo[args.buf].formatexpr = nil
        end,
      })

      -- Mappings.
      -- See `:help vim.diagnostic.*` for documentation on any of the below functions
      local opts = { noremap=true, silent=true }
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
        local bufopts = { noremap=true, buffer=bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<LEADER>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<LEADER>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<LEADER>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, bufopts)
        vim.keymap.set('n', '<LEADER>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<LEADER>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<LEADER>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<LEADER>f', function() vim.lsp.buf.format { async = true } end, bufopts)
      end

      local lsp_flags = {
        debounce_text_changes = 150
      }

      -- hook up cmp_nvim_lsp for completion
      local lspconfig = require('lspconfig')
      local lsp_defaults = lspconfig.util.default_config
      local capabilities = vim.tbl_deep_extend("force",
        vim.lsp.protocol.make_client_capabilities(),
        require('cmp_nvim_lsp').default_capabilities()
      )
      lsp_defaults.capabilities = capabilities

      require('lspconfig')['bashls'].setup({flags = lsp_flags, on_attach = on_attach})
      require('lspconfig')['cssls'].setup({flags = lsp_flags, on_attach = on_attach})
      require('lspconfig')['dockerls'].setup({flags = lsp_flags, on_attach = on_attach})
      require('lspconfig')['elixirls'].setup({flags = lsp_flags, on_attach = on_attach})
      require('lspconfig')['erlangls'].setup({flags = lsp_flags, on_attach = on_attach})
      require('lspconfig')['eslint'].setup({flags = lsp_flags, on_attach = on_attach})
      require('lspconfig')['ruff_lsp'].setup({flags = lsp_flags, on_attach = on_attach})
      require('lspconfig')['gopls'].setup({flags = lsp_flags, on_attach = on_attach})
      require('lspconfig')['html'].setup({flags = lsp_flags, on_attach = on_attach})
      require('lspconfig')['jsonls'].setup({flags = lsp_flags, on_attach = on_attach})
      require('lspconfig')['marksman'].setup({flags = lsp_flags, on_attach = on_attach}) -- markdown
      require('lspconfig')['pyright'].setup({flags = lsp_flags, on_attach = on_attach})
      require('lspconfig')['ruby_ls'].setup({flags = lsp_flags, on_attach = on_attach})
      require('lspconfig')['sqlls'].setup({flags = lsp_flags, on_attach = on_attach})
      require('lspconfig')['lua_ls'].setup({
        flags = lsp_flags,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {'vim'},
            },
          },
        },
      })
      require('lspconfig')['tsserver'].setup({flags = lsp_flags, on_attach = on_attach})
      -- require('lspconfig')['yamlls'].setup({flags = lsp_flags, on_attach = on_attach})

      -- Just needed if I have problems
      -- vim.lsp.set_log_level("debug")
    end
  },

  -- Use Neovim as a language server to inject LSP diagnostics, code
  -- actions, and more via Lua.
  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sar/cmp-lsp.nvim',
      'nvimtools/none-ls-extras.nvim',
    },
    config = function()
      local b = require('null-ls.builtins')
      require('null-ls').setup({
          -- debug = true,
          sources = {
            ----------------------
            --   Code Actions   --
            ----------------------
            require('none-ls.diagnostics.eslint_d'),

            ----------------------
            --    Diagnostics   --
            ----------------------
            b.diagnostics.actionlint,
            b.diagnostics.codespell,

            b.diagnostics.credo.with {
              -- run credo in strict mode even if strict mode is not enabled in
              -- .credo.exs
              extra_args = { '--strict' },
              -- only register credo source if it is installed in the current project
              condition = function(_utils)
                local cmd = { 'rg', ':credo', 'mix.exs' }
                local credo_installed = ('' == vim.fn.system(cmd))
                return not credo_installed
              end,
            },
            b.diagnostics.yamllint,
            b.diagnostics.cfn_lint,
          },
        })

      -- Is this in the right place?
      -- The basis for configuring completion
      vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
    end
  },

  -- ========== Completion ============
  -- -- Snippets, need to understand more about how to use this
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        build = 'make install_jsregexp',
      },
      'hrsh7th/cmp-nvim-lsp', -- completion from LSP
      'hrsh7th/cmp-buffer',   -- completion from this buffer
      'hrsh7th/cmp-path',     -- completion from file paths
      'saadparwaiz1/cmp_luasnip', -- completion from snippets
      'rafamadriz/friendly-snippets'
    },
    config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      require('luasnip.loaders.from_vscode').lazy_load({paths = './snippets'})

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
  },

  -- ========== Themes and visual ============
  -- Themes
  -- use('veloce/vim-aldmeris', {
  --   config = function()
  --     vim.cmd('colorscheme aldmeris')
  --   end
  -- })
  {
    'EdenEast/nightfox.nvim',
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
  },

  {
    'nvim-lualine/lualine.nvim',
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
  },

  -- ========== Languages ==============
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      -- Put ends after things
      'RRethy/nvim-treesitter-endwise',
    },
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
            enable = true
            -- use_languagetree = true
          },
          indent = {
            enable = true
          },
          endwise = {
            enable = true
          },
        })
    end
  },

  -- Markdown
  {
    'tpope/vim-markdown', ft = {'markdown'}
  }
})
