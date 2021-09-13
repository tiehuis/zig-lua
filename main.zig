const lua = @cImport({
    @cInclude("lua.h");
    @cInclude("lualib.h");
    @cInclude("lauxlib.h");
});

export fn add(s: ?*lua.lua_State) c_int {
    const a = lua.luaL_checkinteger(s, 1);
    const b = lua.luaL_checkinteger(s, 2);

    const c = a + b;

    lua.lua_pushinteger(s, c);
    return 1;
}

pub fn main() void {
    var s = lua.luaL_newstate();
    lua.luaL_openlibs(s);

    // TODO translate-c: lua_pushcfunction
    lua.lua_pushcclosure(s, add, 0);
    lua.lua_setglobal(s, "zig_add");

    // TODO translate-c: luaL_dostring
    _ = lua.luaL_loadstring(s, "print(zig_add(3, 5))");

    // TODO translate-c: lua_pcall
    _ = lua.lua_pcallk(s, 0, lua.LUA_MULTRET, 0, 0, null);
}
