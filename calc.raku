#!/usr/bin/env raku

use MONKEY-SEE-NO-EVAL;

LOOP: loop {
	my @stack;

	for get.words -> $t {
		with try $t.Int { @stack.push: $_; next }
		@stack.elems >= 2 or (say "Too Few Arguments"; next LOOP);
		$t ~~ any(<+ - * />) or (say "Invalid Token"; next LOOP);

		@stack.splice(*-2, 2, [EVAL("@stack[*-2] $t @stack[*-1]")]);
	}

	say @stack.elems eq 1 ?? @stack[0] !! "Invalid Input";
}
