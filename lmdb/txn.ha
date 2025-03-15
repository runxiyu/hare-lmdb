use lmdb::ffi;

// Opaque structure for a transaction handle.
export type txn = ffi::txn;

// Initiate a transaction.
export fn txn_begin(env: *env, flags: uint, parent: nullable *txn = null) (*txn | error) = {
	let t: nullable *ffi::txn = null;

	const rc = ffi::txn_begin(env: *ffi::env, parent: nullable *ffi::txn, flags, &t): error;

	switch (rc) {
	case 0 => return t: *txn;
	case => return rc;
	};
};

// Abort a transaction, discaring anything it does.
export fn txn_abort(txn: *txn) (void | error) = {
	const rc = ffi::txn_abort(txn: *ffi::txn): error;

	switch (rc) {
	case 0 => return;
	case => return rc;
	};
};

// Commiting a transaction, writing anything it does.
export fn txn_commit(txn: *txn) (void | error) = {
	const rc = ffi::txn_commit(txn: *ffi::txn): error;

	switch (rc) {
	case 0 => return;
	case => return rc;
	};
};
