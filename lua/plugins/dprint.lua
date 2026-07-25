-- This must be set before dprint-vim-plugin is installed or loaded.
vim.g.dprint_format_on_save = 1

---@type LazySpec
return {
  {
    "Canva/dprint-vim-plugin",
    lazy = false,
  },
}
