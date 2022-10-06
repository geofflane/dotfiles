local Plug = require 'usermod.vimplug'

Plug.begin('~/.config/nvim/plugged')

Plug 'kyazdani42/nvim-web-devicons' -- optional, for file icons
Plug('kyazdani42/nvim-tree.lua', {  -- nerdtree replacement
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

-- TODO: Look into fzf or nvim specific one
Plug('ctrlpvim/ctrlp.vim', {
  run = function()
    vim.g.ctrlp_user_command = 'ag %s -l --nocolor -g ""' -- Use ag in CtrlP for listing files. Fast and respects .gitignore
    vim.g.ctrlp_use_caching = 0                           -- ag is fast enough that CtrlP doesn't need to cache
    vim.g.ctrlp_by_filename = 1      -- search by filename by default, that's normally what I want
  end
})

-- I really like surround
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-abolish'

Plug('vim-scripts/tComment')  -- Commenting
Plug('triglav/vim-visual-increment') -- visual increment Ctrl+A

if(vim.fn.has('mac'))
then
  Plug('zerowidth/vim-copy-as-rtf') -- Copy syntax highlighted code into rtg
end

-- Plug('Shougo/neosnippet.vim')
-- Plug('Shougo/neosnippet-snippets')

Plug('tpope/vim-endwise')           --" Put ends after things
Plug('jacquesbh/vim-showmarks')      -- Visually show marks in buffer

-- LSP
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
      local opts = {noremap=true, silent=true}
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
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
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

-- -- TODO: Convert to nvim-lsp?
-- Plug('neoclide/coc.nvim', {
--   merged = false,
--   rev = 'release',
--   config = function()
--     -- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
--     -- delays and poor user experience.
--     vim.opt.updatetime = 300
--
--     -- Always show the signcolumn, otherwise it would shift the text each time
--     -- diagnostics appear/become resolved.
--     vim.opt.signcolumn = 'yes'
--
--     -- Use tab for trigger completion with characters ahead and navigate.
--     -- NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
--     -- other plugin before putting this into your config.
--     vim.cmd [[
--       inoremap <silent><expr> <TAB>
--           \ coc#pum#visible() ? coc#pum#next(1):
--           \ check_backspace() ? "\<Tab>" :
--           \ coc#refresh()
--       inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
--     ]]
--     -- Make <CR> to accept selected completion item or notify coc.nvim to format
--     -- <C-g>u breaks current undo, please make your own choice.
--     vim.cmd [[
--     inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
--       \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
--     ]]
--
--     function check_backspace()
--       vim.cmd [[
--         let col = col('.') - 1
--         return !col || getline('.')[col - 1]  =~# '\s'
--       ]]
--     end
--
--     -- Use <c-space> to trigger completion.
--     if (vim.fn.has('nvim'))
--       then
--       vim.cmd [[inoremap <silent><expr> <c-space> coc#refresh()]]
--     else
--       vim.cmd [[inoremap <silent><expr> <c-@> coc#refresh()]]
--     end
--
--     vim.keymap.set('n', '<C-]>', '<Plug>(coc-definition)', {silent = true})
--     vim.keymap.set('n', 'gs', ':vsp<CR><Plug>(coc-definition)<CR>', {silent = true})
--     vim.keymap.set('n', 'gd', '<Plug>(coc-definition)', {silent = true})
--     vim.keymap.set('n', 'gy', '<Plug>(coc-type-definition)', {silent = true})
--     vim.keymap.set('n', 'gi', '<Plug>(coc-implementation)', {silent = true})
--     vim.keymap.set('n', 'gr', '<Plug>(coc-references)', {silent = true})
--
--     -- nnoremap <silent> K :call <SID>show_documentation()<CR>
--     -- function show_documentation()
--     --   if (vim.fn.index({'vim','help'}, vim.bo.filetype) >= 0)
--     --     then
--     --     vim.cmd [[execute 'h '.expand('<cword>')]]
--     --   elseif (vim.cmd('call coc#rpc#ready()'))
--     --     then
--     --     vim.cmd [[call CocActionAsync('doHover')]]
--     --   else
--     --     vim.cmd [[execute '!' . &keywordprg . " " . expand('<cword>')]]
--     --   end
--     -- end
--
--     -- Formatting selected code.
--     vim.keymap.set('n', '<LEADER>f', '<Plug>(coc-format-selected)', {silent = true})
--     vim.keymap.set('x', '<LEADER>f', '<Plug>(coc-format-selected)', {silent = true})
--     -- Symbol renaming.
--     vim.keymap.set('n', '<LEADER>rn', '<Plug>(coc-rename)', {silent = true})
--   end
-- })
if(not vim.fn.has('nvim'))
then
  Plug('roxma/nvim-yarp')
  Plug('roxma/vim-hug-neovim-rpc')
end


-- ========== Themes and visual ============
-- Themes
Plug('veloce/vim-aldmeris', {
  config = function()
    vim.cmd('colorscheme aldmeris')
  end
})
-- Plug('vim-scripts/Zenburn')
-- Plug('altercation/vim-colors-solarized')
-- Plug('morhetz/gruvbox')
-- Plug('chuling/vim-equinusocio-material')

-- TODO: Convert to nvim-lualine/lualine
Plug('vim-airline/vim-airline', {
    config = function()
      vim.g.airline_powerline_fonts = 1
      vim.g.airline_theme = 'base16_default'
      vim.g['airline#extensions#ale#enabled'] = 1
    end
  }) -- Handy plugin for a nice statusline
Plug('vim-airline/vim-airline-themes')


-- ========== Langauge stuff ==============
Plug('sheerun/vim-polyglot')    -- Polyglot: A collection of language packs, loaded on demand

Plug('vim-scripts/taglist.vim')
Plug('vim-scripts/SyntaxRange') -- Supports multiple syntaxes in the same file
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
