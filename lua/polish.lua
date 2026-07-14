-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "tasks.md",
  callback = function(ev)
    vim.opt_local.conceallevel = 2
    vim.opt_local.autoread = true

    vim.keymap.set("n", "<leader>bn", function()
      local line = vim.api.nvim_get_current_line()
      -- match "- [x] Title" or "- [x] [Title](link)"
      local title = line:match("^%- %[.%] %[(.-)%]%(") or line:match("^%- %[.%] (.+)")
      if not title or title == "" then
        vim.notify("No task found on current line", vim.log.levels.WARN)
        return
      end
      local output = vim.fn.system(vim.env.HOME .. "/repos/backlog/target/release/bl note " .. vim.fn.shellescape(title))
      local path = output:match "Notes file ready: (.+)"
      if path then
        vim.cmd("edit " .. vim.fn.fnameescape(vim.trim(path)))
      else
        vim.notify("bl note failed:\n" .. output, vim.log.levels.ERROR)
      end
    end, { buffer = ev.buf, desc = "bl: create note" })

    vim.keymap.set("n", "<leader>bi", function()
      local line = vim.api.nvim_get_current_line()
      -- extract GitHub PR URL from a markdown link: [Title](https://github.com/.../pull/N)
      local pr = line:match("%(https://github%.com/[^)]+%)")
      if pr then
        pr = pr:sub(2, -2) -- strip surrounding parens
      end
      if not pr or pr == "" then
        vim.notify("No GitHub PR URL found on current line", vim.log.levels.WARN)
        return
      end
      local output = vim.fn.system(vim.env.HOME .. "/repos/backlog/target/release/bl ignore " .. vim.fn.shellescape(pr))
      vim.notify(vim.trim(output), vim.log.levels.INFO)
    end, { buffer = ev.buf, desc = "bl: ignore PR" })

    vim.keymap.set("n", "<leader>bg", function()
      local output = vim.fn.system(vim.env.HOME .. "/repos/backlog/target/release/bl github")
      if vim.v.shell_error == 0 then
        vim.notify("GitHub PRs refreshed", vim.log.levels.INFO)
      else
        vim.notify("bl github failed:\n" .. output, vim.log.levels.ERROR)
      end
    end, { buffer = ev.buf, desc = "bl: refresh GitHub PRs" })
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "tasks.md",
  callback = function()
    vim.defer_fn(function()
      vim.cmd "checktime"
    end, 100)
  end,
})
