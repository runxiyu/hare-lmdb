export @symbol("mdb_del") fn del(txn: *txn, dbi: dbi, key: *val, data: *val) int;
export @symbol("mdb_get") fn get(txn: *txn, dbi: dbi, key: *val, data: *val) int;
export @symbol("mdb_put") fn put(txn: *txn, dbi: dbi, key: *val, data: *val, flags: uint) int;
