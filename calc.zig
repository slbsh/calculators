#!/usr/bin/env -S sh -c 'f=$(mktemp /tmp/XXXXXX.zig); tail +2 $0 > $f; zig run $f'

const std = @import("std");
const alloc = std.heap.page_allocator;

pub fn main() !void {
	var stdout_buf: [256]u8 = undefined;
	var stdout = std.fs.File.stdout().writer(&stdout_buf);

	loop: while (true) {
		var stdin_buf: [256]u8 = undefined;
		var stdin = std.fs.File.stdin().reader(&stdin_buf);

		defer stdout.interface.flush() catch {};

		var w = std.io.Writer.Allocating.init(alloc);
		const bytes = try stdin.interface.streamDelimiter(&w.writer, '\n');
		if (bytes == 0) continue;

		var toks = std.mem.tokenizeAny(u8, w.written(), " \t\r\n");
		var stack: std.ArrayList(i64) = .empty;
		defer stack.deinit(alloc);

		while (toks.next()) |e| {
			if (std.fmt.parseInt(i64, e, 10) catch null) |n| {
				try stack.append(alloc, n);
				continue;
			}

			if (stack.items.len < 2) {
				try stdout.interface.print("Too Few Arguments\n", .{});
				continue :loop;
			}

			const b = stack.pop().?;
			const a = stack.pop().?;

			if (std.mem.eql(u8, e, "+"))
				try stack.append(alloc, a + b)
			else if (std.mem.eql(u8, e, "-"))
				try stack.append(alloc, a - b)
			else if (std.mem.eql(u8, e, "*"))
				try stack.append(alloc, a * b)
			else if (std.mem.eql(u8, e, "/"))
				try stack.append(alloc, @divTrunc(a, b))
			else {
				try stdout.interface.print("Invalid Token\n", .{});
				continue :loop;
			}
		}

		if (stack.items.len == 1)
			try stdout.interface.print("{}\n", .{stack.pop().?})
		else
			try stdout.interface.print("Invalid Input\n", .{});
	}
}
