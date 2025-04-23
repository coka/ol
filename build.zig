const std = @import("std");

pub fn build(b: *std.Build) void {
    const tests = b.addTest(.{
        .root_source_file = b.path("aoc.zig"),
    });
    const run_tests = b.addRunArtifact(tests);
    const test_step = b.step("test", "Run tests");
    test_step.dependOn(&run_tests.step);
}
