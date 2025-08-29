return {

  {
    "neovim/nvim-lspconfig",
    init = function()
      vim.lsp.enable("expert")
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
