#!/usr/bin/env -S awk -f

{
	top = 0
	for (i = 1; i <= NF; i++) {
		if ($i ~ /^-?[0-9]+$/)
			stack[++top] = $i
		else if (top < 2) {
			print "Too Few Arguments"
			next
		} else if ($i == "+")
			stack[top - 1] = stack[top] + stack[--top]
		else if ($i == "-")
			stack[top - 1] = stack[top] - stack[--top]
		else if ($i == "*")
			stack[top - 1] = stack[top] * stack[--top]
		else if ($i == "/")
			stack[top - 1] = stack[top] / stack[--top]
		else {
			print "Invalid Token"
			next
		}
	}

	if (top = 1)
		print stack[0]
	else
		print "Invalid Input"
}
