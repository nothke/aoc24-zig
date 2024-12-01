const std = @import("std");

pub fn main() !void {
    var list1 = [_]i32{ 3, 4, 2, 1, 3, 3 };
    var list2 = [_]i32{ 4, 3, 5, 3, 9, 3 };

    std.mem.sort(i32, list1[0..], {}, std.sort.asc(i32));
    std.mem.sort(i32, list2[0..], {}, std.sort.asc(i32));

    var totalDistance: i32 = 0;
    for (list1, list2) |v1, v2| {
        totalDistance += v2 - v1;
    }

    std.debug.print("Total distance is: {}", .{totalDistance});
}
