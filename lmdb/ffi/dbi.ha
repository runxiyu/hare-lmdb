use types::c;

export @symbol("mdb_dbi_open") fn dbi_open(txn: *txn, name: const nullable *c::char, flags: uint, dbi: *dbi) int;
