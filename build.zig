const std = @import("std");

const day = 1;

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const dayStr = std.fmt.comptimePrint("{}", .{day});
    const name = "aoc-24-zig-" ++ dayStr;
    const source = "src/aoc_" ++ dayStr ++ ".zig";

    const exe = b.addExecutable(.{
        .name = name,
        .root_source_file = b.path(source),
        .target = target,
        .optimize = optimize,
    });

    b.installArtifact(exe);

    // Check step
    const exe_check = b.addExecutable(.{
        .name = "check",
        .root_source_file = b.path(source),
        .target = target,
        .optimize = optimize,
    });

    const check = b.step("check", "Check if it compiles");
    check.dependOn(&exe_check.step);

    const run_cmd = b.addRunArtifact(exe);

    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
