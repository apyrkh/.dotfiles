return {
  "stevearc/oil.nvim",
  opts = {
    default_file_explorer = false,
    keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-s>"] = false, --"actions.select_vsplit",
      ["<C-h>"] = false, --"actions.select_split",
      ["<C-t>"] = false, --"actions.select_tab",
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<C-l>"] = false,
      ["<C-r>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = "actions.tcd",
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      ["g\\"] = false, --"actions.toggle_trash",
    },
    view_options = {
      show_hidden = true,
      is_always_hidden = function (name)
        local hidden_names = {
          ".DS_Store"
        }

        for _, hidden_name in ipairs(hidden_names) do
          if hidden_name == name then
            return true
          end
        end
        return false
      end
    },
  },
  -- Optional dependencies
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
