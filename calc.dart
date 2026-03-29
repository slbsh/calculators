#!/usr/bin/env -S dart

import 'dart:core';
import 'dart:io';

void main() {
	loop: while (true) {
		final stack = [];

		for (final e in stdin.readLineSync()?.split(' ') ?? exit(0)) {
			final n = int.tryParse(e);
			if (n is int) {
				stack.add(n);
				continue;
			}
			
			if (stack.length < 2) {
				print("Too Few Arguments");
				continue loop;
			}

			final b = stack.removeLast();
			final a = stack.removeLast();

			switch (e) {
				case "+": stack.add(a + b);
				case "-": stack.add(a - b);
				case "*": stack.add(a * b);
				case "/": stack.add(a / b);
				default :
					print("Invalid Token");
					continue loop;
			}
		}

		if (stack.length == 1)
			print(stack.last);
		else
			print("Invalid Input");
	}
}
