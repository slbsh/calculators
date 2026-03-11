#!/usr/bin/env -S sh -c 'f=$(mktemp); o=$(mktemp); tail +2 $0 > $f; c++ -xc++ -o $o $f && $o'

#include <charconv>
#include <cstdint>
#include <sstream>
#include <string>
#include <vector>
#include <iostream>
#include <ostream>

int main() {
	while (1) {
		std::string line;
		std::getline(std::cin, line);

		if (line.empty()) continue;

		std::vector<std::int64_t> stack;

		std::istringstream iss(line);
		for (std::string e; iss >> e;) {
			int64_t v {};
			auto [p, ec] = std::from_chars(e.data(), e.data() + e.size(), v);
			if (ec == std::errc() && p == e.data() + e.size()) {
				stack.push_back(v);
				continue;
			}

			if (stack.size() < 2) {
				std::cout << "Too Few Arguments" << std::endl;
				goto outer;
			}

			int64_t b = stack[stack.size() - 1];
			int64_t a = stack[stack.size() - 2];
			stack.pop_back();

			if (e.size() > 1) {
				std::cout << "Invalid Token" << std::endl;
				goto outer;
			}

			switch (e[0]) {
				case '+': stack[stack.size() - 1] = a + b; break;
				case '-': stack[stack.size() - 1] = a - b; break;
				case '*': stack[stack.size() - 1] = a * b; break;
				case '/': stack[stack.size() - 1] = a / b; break;
				default : std::cout << "Invalid Token" << std::endl; goto outer;
			}
		}

		if (stack.size() == 1)
			std::cout << stack[0] << std::endl;
		else
			std::cout << "Invalid Input" << std::endl;

		outer:;
	}
}
