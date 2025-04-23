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

const file = @embedFile("inputs/01.txt");

fn partOne(input: []const u8) i32 {
    const directions = input;
    return follow(directions);
}

test partOne {
    try testing.expectEqual(138, partOne(file));
}

fn partTwo(input: []const u8) u32 {
    const directions = input;
    return computeBasementEntryPosition(directions);
}

test partTwo {
    try testing.expectEqual(1771, partTwo(file));
}
