return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- linting
        "eslint_d",

        --formatters
        "black",
        "goimports",
        "prettier",
        "shfmt",
        "stylua",

        --language servers
        "css-lsp",
        "eslint-lsp",
        "gopls",
        "html-lsp",
        "intelephense",
        "lua-language-server",
        "pyright",
        "typescript-language-server",

        --Parser generator + grammar tooling
        "tree-sitter-cli",
      },
    },
  },
}
