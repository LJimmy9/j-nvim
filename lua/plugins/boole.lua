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
			{ "tic", "tac", "toe" },
			{ "north", "south", "east", "west" },
			{ "dark", "light" },
		},
		allow_caps_additions = {
			{ "enable", "disable" },
		},
	},
}
