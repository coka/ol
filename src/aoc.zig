pub const day01 = @import("01_not_quite_lisp.zig");
pub const day02 = @import("02_i_was_told_there_would_be_no_math.zig");
pub const day03 = @import("03_perfectly_spherical_houses_in_a_vacuum.zig");

test {
    @import("std").testing.refAllDecls(@This());
}
