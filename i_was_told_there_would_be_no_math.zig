const std = @import("std");
const Allocator = std.mem.Allocator;
const testing = std.testing;

fn wrap(l: u32, w: u32, h: u32) u32 {
    const s1, const s2, const s3 = .{ l * w, w * h, h * l };
    var slack = s1;
    if (s2 < slack) slack = s2;
    if (s3 < slack) slack = s3;
    return 2 * (s1 + s2 + s3) + slack;
}

test wrap {
    try testing.expectEqual(58, wrap(2, 3, 4));
    try testing.expectEqual(43, wrap(1, 1, 10));
}

fn ribbonFor(l: u32, w: u32, h: u32) u32 {
    var dimensions = [_]u32{ l, w, h };
    std.mem.sort(u32, &dimensions, {}, std.sort.asc(u32));
    const wrap_ribbon = 2 * (dimensions[0] + dimensions[1]);
    const bow_ribbon = l * w * h;
    return wrap_ribbon + bow_ribbon;
}

test ribbonFor {
    try testing.expectEqual(34, ribbonFor(2, 3, 4));
    try testing.expectEqual(14, ribbonFor(1, 1, 10));
}

fn readInput(allocator: Allocator) ![]u8 {
    return try std.fs.cwd().readFileAlloc(
        allocator,
        "input2.txt",
        1024 * 1024,
    );
}

fn parse(line: []const u8) ![3]u32 {
    var dimensions = std.mem.splitScalar(u8, line, 'x');
    const l = try std.fmt.parseInt(u32, dimensions.next().?, 10);
    const w = try std.fmt.parseInt(u32, dimensions.next().?, 10);
    const h = try std.fmt.parseInt(u32, dimensions.next().?, 10);
    return [3]u32{ l, w, h };
}

fn part_one(allocator: Allocator) !u32 {
    const input = try readInput(allocator);
    defer allocator.free(input);
    var sq_ft_of_wrapping_paper: u32 = 0;
    var lines = std.mem.tokenizeAny(u8, input, "\r\n");
    while (lines.next()) |line| {
        const l, const w, const h = try parse(line);
        sq_ft_of_wrapping_paper += wrap(l, w, h);
    }
    return sq_ft_of_wrapping_paper;
}

test part_one {
    const answer = part_one(testing.allocator);
    try testing.expectEqual(1586300, answer);
}

fn part_two(allocator: Allocator) !u32 {
    const input = try readInput(allocator);
    defer allocator.free(input);
    var feet_of_ribbon: u32 = 0;
    var lines = std.mem.tokenizeAny(u8, input, "\r\n");
    while (lines.next()) |line| {
        const l, const w, const h = try parse(line);
        feet_of_ribbon += ribbonFor(l, w, h);
    }
    return feet_of_ribbon;
}

test part_two {
    const answer = part_two(testing.allocator);
    try testing.expectEqual(3737498, answer);
}
