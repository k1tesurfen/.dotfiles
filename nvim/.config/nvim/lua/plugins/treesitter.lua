return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        -- Core
        "bash",
        "lua",
        "vim",
        "vimdoc",

        -- PHP / WordPress
        "php",
        "phpdoc",
        "html",
        "css",
        "scss",
        "sql",

        -- JS / TS / React / Gutenberg
        "javascript",
        "typescript",
        "tsx",
        "jsdoc",

        -- Data / config
        "json",
        "jsonc",
        "yaml",
        "toml",

        -- Docs
        "markdown",
        "markdown_inline",

        -- Tooling
        "regex",
        "dockerfile",
      },
      auto_install = false, -- IMPORTANT for stability
    },
  },
}
