return {

  {
    "neovim/nvim-lspconfig",
    init = function()
      vim.lsp.enable("expert") -- AI coding assistant (Codeium/Expert)
    end,
    opts = {
      servers = {
        bashls = {},
        somesass_ls = {},
        elixirls = {
          enabled = false,
        },
      },
    },
  },
}
