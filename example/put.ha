use fmt;
use lmdb;
use types::c;

export fn main() void = {
	const key = lmdb::val{
		mv_size = 13,
		mv_data = c::unterminatedstr("this is a key"): *opaque,
	};
	const val = lmdb::val{
		mv_size = 15,
		mv_data = c::unterminatedstr("this is a value"): *opaque,
	};

	let env: nullable *lmdb::env = null;
	let rc: int = lmdb::env_create(&env);
	if (rc != 0) {
		fmt::printf("error: {}\n", rc)!;
		abort("failed to create env");
	};
	let env: *lmdb::env = env as *lmdb::env;

	let path = c::fromstr("./test.mdb");
	defer free(path);
	rc = lmdb::env_open(env, path, 0, 0o644);
	if (rc != 0) {
		fmt::printf("error: {}\n", rc)!;
		abort("failed to open env");
	};

	let txn: nullable *lmdb::txn = null;
	rc = lmdb::txn_begin(env, null, 0, &txn);
	if (rc != 0) {
		fmt::printf("error: {}\n", rc)!;
		abort("failed to create txn");
	};
	let txn: *lmdb::txn = txn as *lmdb::txn;

	let dbi: lmdb::dbi = 0;
	rc = lmdb::dbi_open(txn, null, lmdb::CREATE, &dbi);
	if (rc != 0) {
		fmt::printf("error: {}\n", rc)!;
		abort("failed to create dbi");
	};

	rc = lmdb::put(txn, dbi, &key, &val, 0);
	if (rc != 0) {
		fmt::printf("error: {}\n", rc)!;
		abort("failed to put");
	};

	rc = lmdb::txn_commit(txn);
	if (rc != 0) {
		fmt::printf("error: {}\n", rc)!;
		abort("failed to commit");
	};
};
