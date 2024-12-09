-- Efficiently navigate and manage frequently used files with quickmarks and a streamlined menu
-- #navigation #quickmarks #productivity
return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4, -- Dynamically adjust menu width
    },
  },
}
