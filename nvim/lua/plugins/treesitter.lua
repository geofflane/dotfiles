return {
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
            'embedded_template',
            'eex',
            'elixir',
            'erlang',
            'go',
            'heex',
            'html',
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
}
