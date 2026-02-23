return {
  "folke/snacks.nvim",
  opts = function(_, opts)
    opts.picker = opts.picker or {}
    opts.picker.win = opts.picker.win or {}
    opts.picker.win.title = ""

    -- Also target the explorer-specific window config
    opts.picker.sources = opts.picker.sources or {}
    opts.picker.sources.explorer = opts.picker.sources.explorer or {}
    opts.picker.sources.explorer.title = ""

    local explorer = opts.picker.sources.explorer
    explorer.hidden = true -- show dotfiles
    explorer.ignored = true -- show gitignored files (like node_modules)
    explorer.exclude = {} -- ensure nothing is manually excluded

    explorer.layout = explorer.layout or {}
    explorer.layout.layout = explorer.layout.layout or {}
    explorer.layout.layout.width = 40

    opts.image = opts.image or {}
    opts.image.enabled = true

    opts.dashboard = {
      width = 44,
      row = nil,
      col = nil,
      pane_gap = 2,
      autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", -- autokey sequence
      preset = {
        -- Defaults to a picker that supports `fzf-lua`, `telescope.nvim` and `mini.pick`
        ---@type fun(cmd:string, opts:table)|nil
        pick = nil,
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
        },
        -- Used by the `header` section
        header = [[
  █████╗ ██████╗ ████████╗██╗███████╗███╗   ███╗███████╗██████╗ ██╗ █████╗
  ██╔══██╗██╔══██╗╚══██╔══╝██║██╔════╝████╗ ████║██╔════╝██╔══██╗██║██╔══██╗
  ███████║██████╔╝   ██║   ██║███████╗██╔████╔██║█████╗  ██║  ██║██║███████║
  ██╔══██║██╔══██╗   ██║   ██║╚════██║██║╚██╔╝██║██╔══╝  ██║  ██║██║██╔══██║
  ██║  ██║██║  ██║   ██║   ██║███████║██║ ╚═╝ ██║███████╗██████╔╝██║██║  ██║
  ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝╚══════╝╚═╝     ╚═╝╚══════╝╚═════╝ ╚═╝╚═╝  ╚═╝]],
      },
      -- item field formatters
      formats = {
        icon = function(item)
          if item.file and item.icon == "file" or item.icon == "directory" then
            return M.icon(item.file, item.icon)
          end
          return { item.icon, width = 2, hl = "icon" }
        end,
        footer = { "%s", align = "center" },
        header = { "%s", align = "center" },
        keys = { "%s", align = "left" },
        startup = { "%s", align = "center" },
        file = function(item, ctx)
          local fname = vim.fn.fnamemodify(item.file, ":~")
          fname = ctx.width and #fname > ctx.width and vim.fn.pathshorten(fname) or fname
          if #fname > ctx.width then
            local dir = vim.fn.fnamemodify(fname, ":h")
            local file = vim.fn.fnamemodify(fname, ":t")
            if dir and file then
              file = file:sub(-(ctx.width - #dir - 2))
              fname = dir .. "/…" .. file
            end
          end
          local dir, file = fname:match("^(.*)/(.+)$")
          return dir and { { dir .. "/", hl = "dir" }, { file, hl = "file" } } or { { fname, hl = "file" } }
        end,
      },
      sections = {
        {
          -- {
          --   section = "terminal",
          --   cmd = "kitten icat --align center --place 40x12@0x0 ~/.config/nvim/images/vala.png; sleep .1",
          --   height = 12,
          --   padding = 1,
          -- },
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
    }

    return opts
  end,
}
