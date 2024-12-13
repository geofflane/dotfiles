return {
  {
    "folke/which-key.nvim",
    opts = {
      preset = "modern",
    },
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 600
    end,
  },
}
