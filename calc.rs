#!/usr/bin/env -S sh -c 'o=$(mktemp); rustc -o $o $0 && $o'

fn main() {
	std::io::stdin().lines()
		.filter_map(Result::ok)
		.for_each(|l| match l.split(" ").try_fold(Vec::new(), |mut stack, e| {
			if let Ok(n) = e.parse::<i64>() {
				stack.push(n);
				return Ok(stack);
			}

			let b = stack.pop().ok_or("Too Few Arguments")?;
			let a = stack.pop().ok_or("Too Few Arguments")?;

			stack.push(match e {
				"+" => a + b,
				"-" => a - b,
				"*" => a * b,
				"/" => a / b,
				_   => return Err("Invalid Token"),
			});

			Ok(stack)
		}) {
			Ok(s)  if s.len() == 1 => println!("{}", s[0]),
			Ok(_)  => println!("Invalid Input"),
			Err(e) => println!("{e}"),
		})
}
