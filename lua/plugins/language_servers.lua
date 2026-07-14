---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
        "tsgo",
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    opts = {
      servers = {
        "rust_analyzer",
        "tsgo",
      },
      handlers = {
        -- Use the native Go implementation instead of typescript-language-server.
        ts_ls = false,
      },
    },
  },
}
