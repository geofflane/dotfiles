return {
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
          'ruby_lsp',
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
      require('lspconfig')['ruby_lsp'].setup({flags = lsp_flags, on_attach = on_attach})
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
}
