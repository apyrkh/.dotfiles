-- Extend and create a/i textobjects
-- #code #text-editing #productivity
return {
  "echasnovski/mini.ai",
  version = false,
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    n_lines = 200,
  },
}
