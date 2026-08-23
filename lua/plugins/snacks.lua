local function lightspeed_paths()
  return {
    "./export_worker/src/main/rust/lightspeed",
    "./web/src/ui/rendering/lightspeed",
    "./analytics_event_client/src/main/proto/events/editor/editing/lightspeed.analytics.proto",
  }
end

---@type LazySpec
return {
  {
    "folke/snacks.nvim",
    keys = {
      {
        "<Leader>fF",
        function()
          require("snacks").picker.files {
            -- Unlike fd, rg supports mixing directories and exact file paths.
            cmd = "rg",
            dirs = lightspeed_paths(),
            desc = "Lightspeed Files",
          }
        end,
        desc = "Find Lightspeed files",
      },
      {
        "<Leader>fw",
        function()
          require("snacks").picker.grep {
            dirs = lightspeed_paths(),
            desc = "Lightspeed Grep",
          }
        end,
        desc = "Grep Lightspeed files",
      },
    },
    opts = function(_, opts)
      local is_ssh = vim.env.SSH_CONNECTION ~= nil or vim.env.SSH_TTY ~= nil

      opts.gitbrowse = opts.gitbrowse or {}
      opts.gitbrowse.notify = not is_ssh
      opts.gitbrowse.open = function(url)
        if is_ssh then
          require("vim.ui.clipboard.osc52").copy "+" { url }
          vim.notify("Git URL copied to local clipboard", vim.log.levels.INFO, { title = "Git Browse" })
        else
          vim.ui.open(url)
        end
      end
    end,
  },
}
