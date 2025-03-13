use fmt;
use io;
use lmdb;
use types;
use types::c;
use os;

export fn main() void = {
	const key = lmdb::val{
		mv_size = 13,
		mv_data = c::unterminatedstr("this is a key"): *opaque,
	};
	let val: lmdb::val = lmdb::val{
		mv_size = 0,
		mv_data = null,
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

	rc = lmdb::get(txn, dbi, &key, &val);
	if (rc != 0) {
		fmt::printf("error: {}\n", rc)!;
		abort("failed to get");
	};

	rc = lmdb::txn_abort(txn);
	if (rc != 0) {
		fmt::printf("error: {}\n", rc)!;
		abort("failed to abort");
	};

	let data: []u8 = *(&(types::slice {
		data = val.mv_data,
		length = val.mv_size,
		capacity = val.mv_size,
	}): *[]u8);

	io::write(os::stdout, data)!;
};
