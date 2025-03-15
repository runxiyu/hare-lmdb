use types::c;

export @symbol("mdb_strerror") fn strerror(err: int) *c::char;
