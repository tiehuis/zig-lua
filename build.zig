const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const mode = b.standardReleaseOptions();
    const exe = b.addExecutable("lua_example", "main.zig");
    exe.setBuildMode(mode);

    exe.linkSystemLibrary("c");
    b.addCIncludePath("lua-5.3.4/src");

    const lua_c_files = [][]const u8 {
        "lapi.c",
        "lauxlib.c",
        "lbaselib.c",
        "lbitlib.c",
        "lcode.c",
        "lcorolib.c",
        "lctype.c",
        "ldblib.c",
        "ldebug.c",
        "ldo.c",
        "ldump.c",
        "lfunc.c",
        "lgc.c",
        "linit.c",
        "liolib.c",
        "llex.c",
        "lmathlib.c",
        "lmem.c",
        "loadlib.c",
        "lobject.c",
        "lopcodes.c",
        "loslib.c",
        "lparser.c",
        "lstate.c",
        "lstring.c",
        "lstrlib.c",
        "ltable.c",
        "ltablib.c",
        "ltm.c",
        "lundump.c",
        "lutf8lib.c",
        "lvm.c",
        "lzio.c",
    };

    inline for (lua_c_files) |c_file| {
        const c_obj = b.addCObject(c_file, "lua-5.3.4/src/" ++ c_file);
        exe.addObject(c_obj);
    }

    exe.setOutputPath("./lua_example");

    b.default_step.dependOn(&exe.step);
    b.installArtifact(exe);
}
