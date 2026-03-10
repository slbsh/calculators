#!/usr/bin/env -S awk -f

{
	for (i = 1; i <= NF; i++) {
		if ($i ~ /^-?[0-9]+$/)
			stack[++top] = $i
		else if ($i == "+")
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
		print "Too Few Arguments"
}
