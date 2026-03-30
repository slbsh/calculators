#!/usr/bin/env -S sh -c 'odin run "$0" -file'

package calc

import "core:fmt"
import "core:os"
import "core:bufio"
import "core:strings"
import "core:strconv"

main :: proc() {
	stdin : bufio.Reader;
	bufio.reader_init(&stdin, os.to_stream(os.stdin));

	loop: for {
		line, e1 := bufio.reader_read_string(&stdin, '\n');
		defer delete(line);
		if e1 != nil { return }

		toks, e2 := strings.split(line[:len(line) - 1], " ");
		defer delete(toks);
		if e2 != nil { return }

		stack: [dynamic]i64;
		defer delete(stack);

		for e in toks {
			n, e3 := strconv.parse_i64(e, 10);
			if e3 {
				append(&stack, n);
				continue;
			}

			if len(stack) < 2 {
				fmt.println("Too Few Arguments");
				continue loop;
			}

			b := pop(&stack);
			a := pop(&stack);

			switch e {
				case "+": append(&stack, a + b)
				case "-": append(&stack, a - b)
				case "*": append(&stack, a * b)
				case "/": append(&stack, a / b)
				default : {
					fmt.println("Invalid Token");
					continue loop;
				}
			}
		}

		if len(stack) == 1 {
			fmt.println(stack[0]);
		} else {
			fmt.println("Invalid Input");
		}
	}
}
