export @symbol("mdb_cursor_open") fn cursor_open(txn: *txn, dbi: *dbi, cursor: *nullable *cursor) int;
export @symbol("mdb_cursor_close") fn cursor_close(cursor: *cursor) void;
export @symbol("mdb_cursor_get") fn cursor_get(cursor: *cursor, key: *val, data: *val, op: cursor_op) int;
export @symbol("mdb_cursor_del") fn cursor_del(cursor: *cursor, flags: uint) int;
