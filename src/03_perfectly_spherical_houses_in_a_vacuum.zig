const std = @import("std");
const testing = std.testing;

const Position = struct {
    x: i32,
    y: i32,
};

fn santa(allocator: std.mem.Allocator, moves: []const u8) !u32 {
    var position: Position = Position{ .x = 0, .y = 0 };
    var visited = std.AutoHashMap(Position, void).init(allocator);
    defer visited.deinit();
    try visited.put(position, {});
    for (moves) |m| {
        if (m == '^') {
            position.y -= 1;
        } else if (m == 'v') {
            position.y += 1;
        } else if (m == '>') {
            position.x += 1;
        } else if (m == '<') {
            position.x -= 1;
        }
        if (!visited.contains(position)) {
            try visited.put(position, {});
        }
    }
    return visited.count();
}

test santa {
    try testing.expectEqual(2, santa(std.testing.allocator, ">"));
    try testing.expectEqual(4, santa(std.testing.allocator, "^>v<"));
    try testing.expectEqual(2, santa(std.testing.allocator, "^v^v^v^v^v"));
}

fn santaWithRobotSidekick(allocator: std.mem.Allocator, moves: []const u8) !u32 {
    var position: Position = Position{ .x = 0, .y = 0 };
    var robot_position: Position = Position{ .x = 0, .y = 0 };
    var is_robot_move = false;
    var visited = std.AutoHashMap(Position, void).init(allocator);
    defer visited.deinit();
    try visited.put(position, {});
    for (moves) |m| {
        if (is_robot_move) {
            if (m == '^') {
                robot_position.y -= 1;
            } else if (m == 'v') {
                robot_position.y += 1;
            } else if (m == '>') {
                robot_position.x += 1;
            } else if (m == '<') {
                robot_position.x -= 1;
            }
            if (!visited.contains(robot_position)) {
                try visited.put(robot_position, {});
            }
        } else {
            if (m == '^') {
                position.y -= 1;
            } else if (m == 'v') {
                position.y += 1;
            } else if (m == '>') {
                position.x += 1;
            } else if (m == '<') {
                position.x -= 1;
            }
            if (!visited.contains(position)) {
                try visited.put(position, {});
            }
        }
        is_robot_move = !is_robot_move;
    }
    return visited.count();
}

test santaWithRobotSidekick {
    try testing.expectEqual(3, santaWithRobotSidekick(std.testing.allocator, "^v"));
    try testing.expectEqual(3, santaWithRobotSidekick(std.testing.allocator, "^>v<"));
    try testing.expectEqual(11, santaWithRobotSidekick(std.testing.allocator, "^v^v^v^v^v"));
}

const file = @embedFile("inputs/03.txt");

test "Part One" {
    try testing.expectEqual(2592, santa(std.testing.allocator, file));
}

test "Part Two" {
    try testing.expectEqual(2360, santaWithRobotSidekick(std.testing.allocator, file));
}
