#!/usr/bin/env wren_cli

import "io" for Stdin

var calculate = Fn.new { |input|
	var stack = []
	var ops = {
		"+": Fn.new { |a, b| a + b },
		"-": Fn.new { |a, b| a - b },
		"*": Fn.new { |a, b| a * b },
		"/": Fn.new { |a, b| (a / b).truncate }
	}

	for (e in input.split(" ")) {
		if (e == "") continue
		var n = Num.fromString(e)
		if (n) {
			stack.add(n)
		} else if (ops.containsKey(e)) {
			if (stack.count < 2) return "Too Few Arguments"
			stack.add(ops[e].call(stack.removeAt(-2), stack.removeAt(-1)))
		} else {
			return "Invalid Token"
		}
	}
	return (stack.count == 1) ? stack[0] : "Invalid Input"
}

var line
while ((line = Stdin.readLine()) != null) {
	var input = line.trim()
	if (input != "") System.print(calculate.call(input))
}
