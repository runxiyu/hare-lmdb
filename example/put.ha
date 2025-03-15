use fmt;
use io;
use lmdb_ffi = lmdb::ffi;
use strings;
use types;
use types::c;
use os;

export fn main() void = {
	if (len(os::args) != 3) {
		abort("need two arguments (db dir, key)");
	};

	const key = lmdb_ffi::val{
		mv_size = len(strings::toutf8(os::args[2])),
		mv_data = c::unterminatedstr(os::args[2]): *opaque,
	};
	
	let v = io::drain(os::stdin)!;
	defer free(v);

	const val = lmdb_ffi::val{
		mv_size = len(v),
		mv_data = (*(&v: *types::slice)).data: *opaque,
	};

	let env: nullable *lmdb_ffi::env = null;
	let rc: int = lmdb_ffi::env_create(&env);
	if (rc != 0) {
		fmt::printf("error: {}\n", rc)!;
		abort("failed to create env");
	};
	let env: *lmdb_ffi::env = env as *lmdb_ffi::env;

	let path = c::fromstr(os::args[1]);
	defer free(path);
	rc = lmdb_ffi::env_open(env, path, 0, 0o644);
	if (rc != 0) {
		fmt::printf("error: {}\n", rc)!;
		abort("failed to open env");
	};

	let txn: nullable *lmdb_ffi::txn = null;
	rc = lmdb_ffi::txn_begin(env, null, 0, &txn);
	if (rc != 0) {
		fmt::printf("error: {}\n", rc)!;
		abort("failed to create txn");
	};
	let txn: *lmdb_ffi::txn = txn as *lmdb_ffi::txn;

	let dbi: lmdb_ffi::dbi = 0;
	rc = lmdb_ffi::dbi_open(txn, null, lmdb_ffi::CREATE, &dbi);
	if (rc != 0) {
		fmt::printf("error: {}\n", rc)!;
		abort("failed to create dbi");
	};

	rc = lmdb_ffi::put(txn, dbi, &key, &val, 0);
	if (rc != 0) {
		fmt::printf("error: {}\n", rc)!;
		abort("failed to put");
	};

	rc = lmdb_ffi::txn_commit(txn);
	if (rc != 0) {
		fmt::printf("error: {}\n", rc)!;
		abort("failed to commit");
	};
};
