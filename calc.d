#!/usr/bin/env rdmd

import std.stdio, std.string, std.algorithm, std.conv;

void main() {
	for (;;) {
		try {
			auto s = readln.split.fold!((s, t) {
				try return s ~ t.to!long; catch(Exception e) { }
				if (s.length < 2) throw new Exception("Too Few Arguments");

				static foreach (c; "+-*/") if (t == [c])
					return s[0 .. $-2] ~ mixin("s[$-2] " ~ c ~ " s[$-1]");

				throw new Exception("Invalid Token");
			})((long[]).init);

			if (s.length == 1) s[0].writeln;
			else "Invalid Input".writeln;
		} catch (Exception e) e.msg.writeln;
	}
}
