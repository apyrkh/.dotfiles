local get_select = function()
  return {
    enable = true,
    lookahead = true,
    keymaps = {
      -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects/blob/master/queries/ecma/textobjects.scm
      ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
      ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

      ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
      ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },

      ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
      ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

      ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
      ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

      ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
      ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

      ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a argument" },
      ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a argument" },

      ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
      ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
      ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
      ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },
    }
  }
end

local get_swap = function()
  return {
    enable = true,
    swap_previous = {
      ["<leader>pm"] = { query = "@function.outer", desc = "Swap function with previous" },
      ["<leader>pa"] = { query = "@parameter.inner", desc = "Swap argument with prev" },
      ["<leader>p="] = { query = "@assignment.outer", desc = "Swap object property with prev" },
    },
    swap_next = {
      ["<leader>nm"] = { query = "@function.outer", desc = "Swap function with next" },
      ["<leader>na"] = { query = "@parameter.inner", desc = "Swap argument with next" },
      ["<leader>n="] = { query = "@assignment.outer", desc = "Swap object property with next" },
    },
  }
end

local get_move = function()
  return {
    enable = true,
    set_jumps = true, -- whether to set jumps in the jumplist
    goto_previous_start = {
      ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
      ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
      ["[c"] = { query = "@class.outer", desc = "Prev class start" },
      ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
      ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
    },
    goto_previous_end = {
      ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
      ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
      ["[C"] = { query = "@class.outer", desc = "Prev class end" },
      ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
      ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
    },
    goto_next_start = {
      ["]f"] = { query = "@call.outer", desc = "Next function call start" },
      ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
      ["]c"] = { query = "@class.outer", desc = "Next class start" },
      ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
      ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
    },
    goto_next_end = {
      ["]F"] = { query = "@call.outer", desc = "Next function call end" },
      ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
      ["]C"] = { query = "@class.outer", desc = "Next class end" },
      ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
      ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
    },
  }
end

return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  lazy = true,
  config = function()
    require("nvim-treesitter.configs").setup({
      textobjects = {
        select = get_select(),
        swap = get_swap(),
        move = get_move()
      }
    })

    local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

    -- vim way: ; goes to the direction you were moving.
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

    -- make builtin f, F, t, T also repeatable with ; and ,
    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
  end
}
