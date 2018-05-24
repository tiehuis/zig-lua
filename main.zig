use @cImport({
    @cInclude("lua.h");
    @cInclude("lualib.h");
    @cInclude("lauxlib.h");
});

export fn add(s: ?&lua_State) c_int {
    const a = luaL_checkinteger(s, 1);
    const b = luaL_checkinteger(s, 2);

    const c = a + b;

    lua_pushinteger(s, c);
    return 1;
}

pub fn main() void {
    var s = luaL_newstate();
    luaL_openlibs(s);

    // TODO translate-c: lua_pushcfunction
    lua_pushcclosure(s, add, 0);
    lua_setglobal(s, c"zig_add");

    // TODO translate-c: luaL_dostring
    _ = luaL_loadstring(s, c"print(zig_add(3, 5))");

    // TODO translate-c: lua_pcall
    _ = lua_pcallk(s, 0, LUA_MULTRET, 0, 0, null);
}
