pub const day1 = @import("not_quite_lisp.zig");
pub const day2 = @import("i_was_told_there_would_be_no_math.zig");

test {
    @import("std").testing.refAllDecls(@This());
}
