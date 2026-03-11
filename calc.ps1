#!/usr/bin/env pwsh

# for the Stack C# class :) because PS doesn't have stack unless you manually use arrays...
using namespace System.Collections;

:loop while($true) {
	[Stack]$stack = @();
	$input = $(read-host).split(" ", [stringsplitoptions]::removeemptyentries);

	foreach ($e in $input) {
		if ($e -match "^-?\d+$") {
			$stack.push([int]($e));
			continue;
		}

		if ($stack.count -lt 2) {
			write-host "Wrong Argument Count";
			continue loop;
		}

		$b = $stack.pop();
		$a = $stack.pop();

		switch($e) {
			"+" { $stack.push($a + $b) }
			"-" { $stack.push($a - $b) }
			"*" { $stack.push($a * $b) }
			"/" { $stack.push($a / $b) }
			default { 
				write-host "Invalid Operator $($e)" 
				continue loop;
			}
		}
	}

	if ($stack.count -eq 1) {
		write-host $stack.peek();
	} else {
		write-host "Invalid Input";
	}
}
