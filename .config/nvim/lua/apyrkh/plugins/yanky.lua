return {
  "gbprod/yanky.nvim",
  config = function ()
    require("yanky").setup({
      picker = {
        telescope = {
          use_default_mappings = false,
        },
      },
      preserve_cursor_position = {
        enabled = false,
      },
      ring = {
        history_length = 50,
        storage = "memory",
        update_register_on_cycle = true,
      },
    })
  end,
}
