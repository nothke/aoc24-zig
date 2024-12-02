const std = @import("std");

const data = @embedFile("aoc_1_data.txt");

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const alloc = gpa.allocator();
    defer _ = gpa.deinit();

    var list1 = try std.ArrayList(i32).initCapacity(alloc, 1000);
    defer list1.deinit();
    var list2 = try std.ArrayList(i32).initCapacity(alloc, 1000);
    defer list2.deinit();

    const dataSlice: []const u8 = data;

    var lineIter = std.mem.splitSequence(u8, dataSlice, "\n");

    while (lineIter.next()) |line| {
        const tline = std.mem.trim(u8, line, "\n\r");

        var wordIter = std.mem.splitSequence(u8, tline, "   ");

        var secondRow = false;
        while (wordIter.next()) |word| {
            secondRow = !secondRow;

            const n = try std.fmt.parseInt(i32, word, 10);

            if (!secondRow) {
                try list1.append(n);
            } else {
                try list2.append(n);
            }
        }
    }

    std.mem.sort(i32, list1.items, {}, std.sort.asc(i32));
    std.mem.sort(i32, list2.items, {}, std.sort.asc(i32));

    var totalDistance: i32 = 0;
    for (list1.items, list2.items) |v1, v2| {
        totalDistance += v2 - v1;

        std.debug.print("s: {} '{}'\n", .{ v1, v2 });
    }

    std.debug.print("Total distance is: {}", .{totalDistance});
}
