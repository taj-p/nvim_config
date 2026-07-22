---@type LazySpec
return {
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/snacks.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      picker = "snacks",
      enable_builtin = true,
      use_local_fs = true,
      gh_env = function()
        return {
          CODER = vim.env.CODER,
          CODER_AGENT_URL = vim.env.CODER_AGENT_URL,
          CODER_AGENT_TOKEN = vim.env.CODER_AGENT_TOKEN,
          CODER_AGENT_AUTH = vim.env.CODER_AGENT_AUTH,
        }
      end,
    },
  },
}
