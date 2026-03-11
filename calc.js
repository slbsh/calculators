#!/usr/bin/env -S node

process.stdin.on('data', line => {
	const stack = [];

	for (const e of line.toString().trim().split(' ')) {
		if (/^-?[0-9]+$/.test(e)) {
			stack.push(Number(e));
			continue;
		}

		if (stack.length < 2) {
			console.log("Too Few Arguments");
			return;
		}
		
		const b = stack.pop();
		const a = stack.pop();

		switch (e) {
			case "+": stack.push(a + b); break;
			case "-": stack.push(a - b); break;
			case "*": stack.push(a * b); break;
			case "/": stack.push(a / b); break;
			default : console.log("Invalid Token"); return;
		}
	}

	if (stack.length == 1)
		console.log(stack[0]);
	else
		console.log("Invalid Input");
});
