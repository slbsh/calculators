#!/usr/bin/env -S sh -c 'f=$(mktemp); o=$(mktemp); tail +2 $0 > $f; cc -xc -o $o $f && $o'

#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

static int parse_i64(const char* s, size_t len, int64_t* out) {
	int is_neg = 0;

	if (s[0] == '-') is_neg = 1;

	uint64_t u = 0;
	uint64_t lim = is_neg ? (uint64_t)INT64_MAX + 1ull : (uint64_t)INT64_MAX;

	for (size_t i = is_neg ? 1 : 0; i < len; i++) {
		unsigned c = (unsigned)(unsigned char)s[i];

		if (c < '0' || c > '9') return 0;
		unsigned d = c - '0';
		if (u > (lim - d) / 10) return 0;

		u = u * 10 + d;
	}

	if (is_neg)
		*out = (u == lim) ? INT64_MIN : -(int64_t)u;
	else
		*out = (int64_t)u;

	return 1;
}

int main() {
	while (1) {
		char* line = NULL;
		size_t cap = 0;
		ssize_t line_len = getline(&line, &cap, stdin);

		if (line_len < 0) return 1;
		
		int64_t* stack   = NULL;
		size_t stack_len = 0;
		size_t stack_cap = 0;

		if (line_len == 1) goto outer;

		for (size_t i = 0; i < line_len;) {
			while (i < line_len && line[i] == ' ') i++;
			if (i >= line_len) break;
			size_t start = i;
			while (i < line_len && line[i] != ' ') i++;

			int64_t v = 0;
			if (parse_i64(line + start, i - start, &v)) {
				if (!stack) {
					stack_cap = 4;
					stack = malloc(sizeof(int64_t) * stack_cap);
					if (!stack) abort();
				}

				if (stack_len >= stack_cap) {
					stack_cap *= 2;
					stack = realloc(stack, sizeof(int64_t) * stack_cap);
					if (!stack) abort();
				}

				stack[stack_len] = v;
				stack_len++;

				continue;
			}

			if (stack_len < 2) {
				puts("Too Few Arguments");
				goto outer;
			}

			int64_t b = stack[stack_len - 1];
			int64_t a = stack[stack_len - 2];
			stack_len--;

			if (i - start > 2) {
				puts("Invalid Token");
				goto outer;
			}

			switch (*(line + start)) {
				case '+': stack[stack_len - 1] = a + b; break;
				case '-': stack[stack_len - 1] = a - b; break;
				case '*': stack[stack_len - 1] = a * b; break;
				case '/': stack[stack_len - 1] = a / b; break;
				default : puts("Invalid Token"); goto outer;
			}

		}

		if (stack_len == 1)
			printf("%" PRId64 "\n", stack[0]);
		else
			puts("Invalid Input");

		outer:;

		free(stack);
		free(line);
	}
}
