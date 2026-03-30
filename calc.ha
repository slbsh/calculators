#!/usr/bin/env -S sh -c 'f=$(mktemp /tmp/XXXXXX.ha); tail +2 $0 > $f; hare run -q $f'

use fmt;
use os;
use bufio;
use strings;
use strconv;

export fn main() void = {
	for :loop (true) {
		const line = bufio::read_line(os::stdin)! as []u8;
		const toks = strings::tokenize(strings::fromutf8(line)!, " ");

		let stack: []i64 = [];

		for (const e => strings::next_token(&toks)) {
			match (strconv::stoi64(e)) {
				case let n: i64 => {
					append(stack, n)!;
					continue;
				};
				case strconv::invalid => yield;
				case strconv::overflow => return;
			};

			if (len(stack) < 2) {
				fmt::println("Too Few Arguments")!;
				continue :loop;
			};

			const b = stack[len(stack) - 1];
			const a = stack[len(stack) - 2];
			delete(stack[len(stack) - 1]);

			switch (e) {
				case "+" => stack[len(stack) - 1] = a + b;
				case "-" => stack[len(stack) - 1] = a - b;
				case "*" => stack[len(stack) - 1] = a * b;
				case "/" => stack[len(stack) - 1] = a / b;
				case => {
					fmt::println("Invalid Token")!;
					continue :loop;
				};
			};
		};

		if (len(stack) == 1) {
			fmt::println(stack[len(stack) - 1])!;
		} else {
			fmt::println("Invalid Input")!;
		};
	};
};
