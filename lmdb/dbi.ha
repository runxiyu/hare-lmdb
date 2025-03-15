use lmdb::ffi;
use types::c;

// An individual LMDB database, i.e. one key-value store.
//
// They are only valid for the lifetime of their parent transaction.
export type dbi = struct {
	txn: *ffi::txn,
	dbi: ffi::dbi,
};

// Opens a database from a transaction.
export fn dbi_open(txn: *txn, name: nullable *str, flags: uint) (dbi | error) = {
	const n: nullable *c::char = match (name) {
	case *str => yield c::fromstr(*(name as *str));
	case null => yield null;
	};
	defer free(n);

	let d: ffi::dbi = 0;

	const rc = ffi::dbi_open(txn: *ffi::txn, n, flags, &d): error;

	switch (rc) {
	case 0 =>
		return dbi {
			txn = txn: *ffi::txn,
			dbi = d,
		};
	case =>
		return rc;
	};
};

// Get a value from the database. The returned value is only valid for the
// lifetime of the transaction associated with the dbi.
export fn get(dbi: dbi, key: *val) (val | error) = {
	let data = ffi::val {
		mv_size = 0,
		mv_data = null,
	};

	const rc = ffi::get(dbi.txn, dbi.dbi, key: *ffi::val, &data): error;

	switch (rc) {
	case 0 => return data: val;
	case => return rc;
	};
};

// Put a value into the database.
export fn put(dbi: dbi, key: *val, data: *val, flags: uint) (void | error) = {
	const rc = ffi::put(dbi.txn, dbi.dbi, key: *ffi::val, data: *ffi::val, flags): error;

	switch (rc) {
	case 0 => return void;
	case => return rc;
	};
};
