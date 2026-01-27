return {
  {
    "sainnhe/gruvbox-material",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- Option: Set the background type (hard, medium, soft)
      vim.g.gruvbox_material_background = "soft"

      -- Option: Enable better performance
      vim.g.gruvbox_material_better_performance = 1
      vim.g.gruvbox_material_transparent_background = 1

      -- Load the colorscheme
      vim.cmd.colorscheme("gruvbox-material")
    end,
  },
}
