#!/usr/bin/env lua

while true do
	local stack = {};

	for t in io.read("*l"):gmatch("%S+") do
		if t:match("^%s*-?%d+%s*$") then
			stack[#stack + 1] = math.tointeger(t)
			goto continue
		end

		if #stack < 2 then
			print("Too Few Arguments")
			goto continue_outer
		end

		local b = table.remove(stack)
		local a = table.remove(stack)

		if t == "+" then stack[#stack + 1] = a + b
		elseif t == "-" then stack[#stack + 1] = a - b
		elseif t == "*" then stack[#stack + 1] = a * b
		elseif t == "/" then stack[#stack + 1] = a / b
		else
			print("Invalid Token")
			goto continue_outer
		end

		::continue::
	end

	if #stack == 1 then
		print(stack[1])
	else
		print("Invalid Input")
	end
	
	::continue_outer::
end
