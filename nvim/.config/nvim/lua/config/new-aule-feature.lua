-- lua/custom/create-aule-feature.lua

local M = {}

--- Formats a string into PascalCase with hyphens (e.g., "My-New-Feature").
local function create_pascal_case_hyphen_name(name)
  local words = {}
  for word in string.gmatch(name, "%S+") do
    table.insert(words, string.upper(string.sub(word, 1, 1)) .. string.lower(string.sub(word, 2)))
  end
  return table.concat(words, "-")
end

--- Formats a string with capitalized words (e.g., "My New Feature").
local function create_capitalized_words_name(name)
  local words = {}
  for word in string.gmatch(name, "%S+") do
    table.insert(words, string.upper(string.sub(word, 1, 1)) .. string.lower(string.sub(word, 2)))
  end
  return table.concat(words, " ")
end

--- Creates a new feature by copying and processing a default template directory.
function M.create_feature(args)
  local original_name = args.fargs[1]
  if not original_name or original_name == "" then
    vim.notify("Error: Please provide a name for the feature.", vim.log.levels.ERROR, { title = "Aulë Feature" })
    return
  end

  -- 1. PREPARE ALL NAME VARIATIONS AND PATHS
  ----------------------------------------------------------------------
  original_name = original_name:gsub('^"', ""):gsub('"$', "") -- Clean input

  local feature_name = create_pascal_case_hyphen_name(original_name)
  local natural_feature_name = create_capitalized_words_name(original_name)
  local file_feature_name_dash = string.lower(feature_name)
  local file_feature_name_under = string.gsub(file_feature_name_dash, "-", "_")

  local current_dir = vim.fn.getcwd()
  -- Use "Feature-Template" as the source directory
  local template_path = current_dir .. "/Feature-Template"
  local new_feature_path = current_dir .. "/features/" .. feature_name

  if vim.fn.isdirectory(template_path) == 0 then
    vim.notify(
      "Error: Template 'Feature-Template' directory not found.",
      vim.log.levels.ERROR,
      { title = "Aulë Feature" }
    )
    return
  end
  if vim.fn.isdirectory(new_feature_path) == 1 then
    vim.notify(
      "Error: Feature '" .. feature_name .. "' already exists.",
      vim.log.levels.ERROR,
      { title = "Aulë Feature" }
    )
    return
  end

  -- 2. COPY TEMPLATE DIRECTORY
  ----------------------------------------------------------------------
  local copy_command =
    string.format("cp -R %s %s", vim.fn.shellescape(template_path), vim.fn.shellescape(new_feature_path))
  vim.fn.system(copy_command)

  -- 3. RENAME FILES AND DIRECTORIES (NEW!)
  ----------------------------------------------------------------------
  -- Use `find -depth` to process files before their parent directories.
  local rename_targets = vim.fn.systemlist("find " .. vim.fn.shellescape(new_feature_path) .. " -depth")
  local replacements = {
    { "NATURALFEATURENAME", natural_feature_name },
    { "FILEFEATURENAMEDASH", file_feature_name_dash },
    { "FILEFEATURENAMEUNDER", file_feature_name_under },
    { "FEATURENAME", feature_name }, -- Must be last
  }

  for _, current_path in ipairs(rename_targets) do
    local new_path = current_path
    local path_was_changed = false
    -- Check against each keyword replacement
    for _, rep in ipairs(replacements) do
      if string.find(new_path, rep[1], 1, true) then
        new_path = string.gsub(new_path, rep[1], rep[2])
        path_was_changed = true
      end
    end

    -- If a change was made and the original path still exists, rename it.
    if path_was_changed and (vim.fn.filereadable(current_path) > 0 or vim.fn.isdirectory(current_path) > 0) then
      vim.fn.rename(current_path, new_path)
    end
  end

  -- 4. REPLACE CONTENT INSIDE FILES
  ----------------------------------------------------------------------
  local function run_content_replacement(keyword, value)
    local cmd = string.format(
      "find %s -type f -exec sed -i '' 's/%s/%s/g' {} +",
      vim.fn.shellescape(new_feature_path),
      keyword,
      value
    )
    vim.fn.system(cmd)
  end

  run_content_replacement("NATURALFEATURENAME", natural_feature_name)
  run_content_replacement("FILEFEATURENAMEDASH", file_feature_name_dash)
  run_content_replacement("FILEFEATURENAMEUNDER", file_feature_name_under)
  run_content_replacement("FEATURENAME", feature_name) -- Must be last

  -- 5. FINAL NOTIFICATION
  ----------------------------------------------------------------------
  vim.notify("Created feature from template: " .. feature_name, vim.log.levels.INFO, { title = "Aulë Feature" })
end

-- SETUP COMMANDS AND KEYMAPS
----------------------------------------------------------------------
vim.api.nvim_create_user_command("NewAuleFeature", M.create_feature, {
  nargs = 1,
  desc = "Create a new aulë feature from the default template",
})

vim.keymap.set("n", "<leader>af", ":NewAuleFeature ", {
  noremap = true,
  silent = false,
  desc = "Create [A]ulë [F]eature",
})

return M
