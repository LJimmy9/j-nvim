return {
  "nat-418/boole.nvim",
  opts = {
    mappings = {
      increment = "<C-a>",
      decrement = "<C-x>",
    },
    -- User defined loops
    additions = {
      { "Foo", "Bar", "Baz" },
      { "tic", "tac", "toe" }
    },
    allow_caps_additions = {
      { "enable", "disable" },
      { "north",  "south",  "east", "west" },
      { "dark",   "light" },
      { "get",    "post",   "put",  "delete" },
      { "low",    "medium", "high" },
      { "day",    "night" },
      { "slow",   "normal", "fast" },
      { "up",     "down",   "left", "right" },
      { "jump",   "run",    "walk", "crouch" },
      { "play",   "pause",  "stop", "restart" },
      { "easy",   "medium", "hard", "extreme" }
    }
  }
}
