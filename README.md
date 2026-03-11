An assortment of reverse polish notation calculators in different languages

## Rules

**Behaviour**
- Read input from stdin
- Write output to stdout after a newline
- Must handle negative numbers
- Division should be truncating
- Must exit after recieving a CTRL-C interrupt

**Errors:**
- Receiving an invalid token must print "Invalid Token"
- Receiving incorrect number of tokens must print "Too Few Arguments"
- Recieving any other invalid input must print "Invalid Input"
- IO, memory, and other system error behaviour is undefined
- Divide by zero behaviour is undefined
- Invalid input must not terminate execution

**Formatting**
- Must be a single file behinning with a shebang which runs the program
- Use hard tabs for indentation
- The smaller and the more optimized the solution the better :)

## Test Cases:
```rs
1 2 + // 3
10 10 * 5 * // 500
5 10 - // -5
10 2 / // 5
4 2 6 + * // 32
-1 2 3 4 5 -6 + + + + + // 7
```

## TODO:
- C
- C++
- Clojure
- F#
- Grain
- JavaScript
- TypeScript
- Perl
- Lean
- C#
- x86 ASM
- Raku
- Odin
- C3
- Zig
- Go
- Hare
- Haskell
- QBE IR
- LLVM IR
