use types::c;

export @symbol("mdb_env_create") fn env_create(env: *nullable *env) int;
export @symbol("mdb_env_open") fn env_open(env: *env, path: const *c::char, flag: uint, mode: mode_t) int;
export @symbol("mdb_env_close") fn env_close(env: *env) void;
export @symbol("mdb_env_set_mapsize") fn env_set_mapsize(env: *env, size_: size) int;
export @symbol("mdb_env_set_maxdbs") fn env_set_maxdbs(env: *env, dbs: dbi) int;
