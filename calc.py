#!/usr/bin/env python3

while True:
	stack = []

	try: s = input()
	except KeyboardInterrupt: exit()

	for e in s.split(" "):
		if e.isdigit() or e.startswith("-") and e[1:].isdigit():
			stack.append(int(e))
			continue

		if e in "+-*/":
			if len(stack) < 2:
				print("Too Few Arguments")
				break
			stack[-2:] = [int(eval(f"stack[-2] {e} stack[-1]"))]
		else:
			print("Invalid Token")
			break

	if len(stack) == 1:
		print(stack[0])
	else:
		print("Invalid Input")
