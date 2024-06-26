return {
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
}
