return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      -- Ensure the table exists
      opts.formatters_by_ft = opts.formatters_by_ft or {}

      -- Web / data
      opts.formatters_by_ft.json = { "prettier" }
      opts.formatters_by_ft.jsonc = { "prettier" }
      opts.formatters_by_ft.yaml = { "prettier" }
      opts.formatters_by_ft.html = { "prettier" }
      opts.formatters_by_ft.css = { "prettier" }
      opts.formatters_by_ft.scss = { "prettier" }
      opts.formatters_by_ft.javascript = { "prettier" }
      opts.formatters_by_ft.typescript = { "prettier" }
      opts.formatters_by_ft.typescriptreact = { "prettier" }
      opts.formatters_by_ft.markdown = { "prettier" }

      -- PHP
      opts.formatters_by_ft.php = { "php_cs_fixer" }

      -- Python
      opts.formatters_by_ft.python = { "black" }

      -- Go
      opts.formatters_by_ft.go = { "gofmt", "goimports" }
    end,
  },
}
