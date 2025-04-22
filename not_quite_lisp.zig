const std = @import("std");

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    const input = try std.fs.cwd().readFileAlloc(allocator, "input.txt", 1024 * 1024);
    defer allocator.free(input);
    var iterator = std.unicode.Utf8Iterator{ .bytes = input, .i = 0 };
    var floor: i32 = 0;
    while (iterator.nextCodepoint()) |c| {
        if (c == '(') {
            floor += 1;
        } else if (c == ')') {
            floor -= 1;
        }
    }
    std.debug.print("{d}\n", .{floor});
}
