return {
  "toppair/peek.nvim",
  event = { "VeryLazy" },
  build = "deno task --quiet build:fast",
  config = function()
    require("peek").setup({
      auto_load = true,         -- whether to automatically load preview when entering markdown buffer
      close_on_bdelete = true,  -- close preview window on buffer delete
      syntax = true,            -- enable syntax highlighting, affects performance
      theme = "dark",           -- "dark" or "light"
      update_on_change = true,
      app = "webview",          -- "webview" for terminal preview, "browser" for external browser
      filetype = { "markdown" }, -- list of filetypes to recognize as markdown
      -- relevant if update_on_change is true
      throttle_at = 200000,     -- start throttling when file exceeds this amount of bytes in size
      throttle_time = "auto",   -- minimum amount of time in milliseconds that has to pass before updating preview
    })

    -- Keymaps for markdown preview
    local keymap = vim.keymap
    keymap.set("n", "<leader>mp", function()
      local peek = require("peek")
      if peek.is_open() then
        peek.close()
      else
        peek.open()
      end
    end, { desc = "Toggle Markdown Preview" })

    keymap.set("n", "<leader>ms", function()
      require("peek").open()
    end, { desc = "Start Markdown Preview" })

    keymap.set("n", "<leader>mx", function()
      require("peek").close()
    end, { desc = "Stop Markdown Preview" })
  end,
}