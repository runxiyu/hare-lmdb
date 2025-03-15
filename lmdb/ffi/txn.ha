export @symbol("mdb_txn_begin") fn txn_begin(env: *env, parent: nullable *txn, flags: uint, txn: *nullable *txn) int;
export @symbol("mdb_txn_commit") fn txn_commit(txn: *txn) int;
export @symbol("mdb_txn_abort") fn txn_abort(txn: *txn) int;
