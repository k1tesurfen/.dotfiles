-- lua/plugins/lspconfig.lua
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          settings = {
            intelephense = {
              stubs = { "wordpress", "core", "json" },
              environment = {
                includePaths = { vim.fn.expand("~/.local/share/php-stubs/vendor/php-stubs/wordpress-stubs") },
                phpVersion = "8.0",
              },
            },
          },
        },
      },
    },
  },
}
