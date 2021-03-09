const clib = @cImport({
    @cInclude("lua.h");
    @cInclude("lualib.h");
    @cInclude("lauxlib.h");
});

export fn add(s: ?*clib.lua_State) c_int {
    const a = clib.luaL_checkinteger(s, 1);
    const b = clib.luaL_checkinteger(s, 2);

    const c = a + b;

    clib.lua_pushinteger(s, c);
    return 1;
}

pub fn main() void {
    var s = clib.luaL_newstate();
    clib.luaL_openlibs(s);

    // TODO translate-c: lua_pushcfunction
    clib.lua_pushcclosure(s, add, 0);
    clib.lua_setglobal(s, "zig_add");

    // TODO translate-c: luaL_dostring
    _ = clib.luaL_loadstring(s, "print(zig_add(3, 5))");

    // TODO translate-c: lua_pcall
    _ = clib.lua_pcallk(s, 0, clib.LUA_MULTRET, 0, 0, null);
}
