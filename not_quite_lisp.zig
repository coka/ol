const std = @import("std");
const testing = std.testing;

fn follow(directions: []const u8) i32 {
    var floor: i32 = 0;
    for (directions) |c| {
        if (c == '(') {
            floor += 1;
        } else if (c == ')') {
            floor -= 1;
        }
    }
    return floor;
}

test follow {
    try testing.expectEqual(0, follow("(())"));
    try testing.expectEqual(0, follow("()()"));
    try testing.expectEqual(3, follow("((("));
    try testing.expectEqual(3, follow("(()(()("));
    try testing.expectEqual(3, follow("))((((("));
    try testing.expectEqual(-1, follow("())"));
    try testing.expectEqual(-1, follow("))("));
    try testing.expectEqual(-3, follow(")))"));
    try testing.expectEqual(-3, follow(")())())"));
}

fn computeBasementEntryPosition(directions: []const u8) u32 {
    var position: u32 = 0;
    var floor: i32 = 0;
    for (directions) |c| {
        position += 1;
        if (c == '(') {
            floor += 1;
        } else if (c == ')') {
            floor -= 1;
        }
        if (floor < 0) {
            break;
        }
    }
    return position;
}

test computeBasementEntryPosition {
    try testing.expectEqual(1, computeBasementEntryPosition(")"));
    try testing.expectEqual(5, computeBasementEntryPosition("()())"));
}

fn readInput(allocator: std.mem.Allocator) ![]u8 {
    return try std.fs.cwd().readFileAlloc(
        allocator,
        "input.txt",
        1024 * 1024,
    );
}

test "Part One" {
    const directions = try readInput(testing.allocator);
    defer testing.allocator.free(directions);
    const answer = follow(directions);
    try testing.expectEqual(answer, 138);
}

test "Part Two" {
    const directions = try readInput(testing.allocator);
    defer testing.allocator.free(directions);
    const answer = computeBasementEntryPosition(directions);
    try std.testing.expectEqual(answer, 1771);
}
