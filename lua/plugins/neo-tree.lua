---@type LazySpec
return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      -- Avoid whole-worktree Git scans, which are prohibitively expensive in
      -- large monorepos. Git information remains available through GitSigns
      -- and the Snacks Git pickers.
      enable_git_status = false,
      filesystem = {
        filtered_items = {
          hide_gitignored = false,
        },
      },
    },
  },
}
