return {
	s("trig", t("x3loaded!!")),
	s(
		"choice test",
		c(1, {
			t("another text node"),
			i(nil, "input here"),
			f(function(args)
				return "text"
			end, {}),
		})
	),
}
