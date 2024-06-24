return {
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
    init = function()
      vim.g.ackprg = 'rg --vimgrep --smart-case'
    end,
    config = function()
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



  -- Markdown
  {
    'tpope/vim-markdown', ft = {'markdown'}
  }
}
