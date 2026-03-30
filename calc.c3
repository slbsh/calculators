#!/usr/bin/env -S c3c -q compile-run

module calc;
import std::io, std::collections;

fn void main() {
	while LOOP: (1) {
		List {long} stack;

		foreach (e : io::treadline()!!.tsplit(" ")) {
			String t = e.strip_end("\n");
		
			if (try n = t.to_long()) {
				stack.push(n);
				continue;
			}

			if (stack.len() < 2) {
				io::printn("Too Few arguments");
				continue LOOP;
			}

			long b = stack.pop()!!;
			long a = stack.pop()!!;

			switch (t) {
				case "+": stack.push(a + b);
				case "-": stack.push(a - b);
				case "*": stack.push(a * b);
				case "/": stack.push(a / b);
				default : {
					io::printn("Invalid Token");
					continue LOOP;
				}
			}
		}

		if (stack.len() == 1) {
			io::printn(stack.last()!!);
		} else {
			io::printn("Invalid Input");
		}
	}
}
