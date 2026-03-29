An assortment of reverse polish notation calculators in different languages

## Rules

**Behaviour**
- Read unspecified size input from stdin
- Write output to stdout after a newline
- Must handle values from `-2^63` to `2^63-1`
- Division should be truncating
- Must exit after recieving a CTRL-C interrupt

**Errors**
- Receiving an invalid token must print "Invalid Token"
- Receiving incorrect number of tokens must print "Too Few Arguments"
- Recieving any other invalid input must print "Invalid Input"
- IO, memory, and other system error behaviour is undefined
- Divide by zero behaviour is undefined
- Invalid input must not terminate execution

**Style**
- Must be a single file beginning with a shebang which runs the program
- Use hard tabs for indentation
- File must have the executable bit set
- The smaller and the more optimized the solution the better :)
- Solution should be as language idiomatic as possible

## Test Cases
```rs
1 2 + // 3
10 10 * 5 * // 500
5 10 - // -5
10 2 / // 5
4 2 6 + * // 32
-1 2 3 4 5 -6 + + + + + // 7
```

## Languages (alphabetically)
- [ ] APL
- [x] Awk
- [ ] BASIC
- [ ] BQN
- [x] Bash
- [x] C
- [x] C#
- [x] C++
- [ ] C--
- [x] C3
- [x] Clojure
- [x] D
- [x] Dart
- [ ] Elixir
- [ ] Elm
- [ ] Erlang
- [ ] F#
- [ ] Gleam
- [x] Go
- [x] Grain
- [ ] Groovy
- [x] Hare
- [x] Haskell
- [ ] Holy C
- [ ] Janet
- [x] Java
- [x] JavaScript
- [ ] Julia
- [ ] Kotlin
- [ ] LLVM IR
- [x] Lean
- [x] Lua
- [ ] MoonBit
- [x] OCaml
- [x] Odin
- [ ] PHP
- [ ] Pascal
- [x] Perl
- [x] PowerShell
- [x] Python
- [ ] QBE IR
- [x] Racket
- [x] Raku
- [ ] ReasonML
- [ ] Ruby
- [x] Rust
- [ ] Scala
- [x] Shard
- [ ] TypeScript
- [ ] Uiua
- [ ] WAT
- [x] Zig
- [ ] x86 ASM
