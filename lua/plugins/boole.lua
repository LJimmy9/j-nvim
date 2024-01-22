return {
  "nat-418/boole.nvim",
  opts = {
    mappings = {
      increment = "<C-a>",
      decrement = "<C-x>",
    },
    -- User defined loops
    additions = {
      { "Foo",   "Bar",   "Baz" },
      { "tic",   "tac",   "toe" },
      { "north", "south", "east", "west" },
      { "dark",  "light" },
      { "first",
        "second",
        "third",
        "fourth",
        "fifth",
        "sixth",
        "seventh",
        "eighth",
        "ninth",
        "tenth" },
      {
        "one",
        "two",
        "three",
        "four",
        "five",
        "six",
        "seven",
        "eight",
        "nine",
        "ten"
      }
    },
    allow_caps_additions = {
      { "enable", "disable" },
    },
  },
}
