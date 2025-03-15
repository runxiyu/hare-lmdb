use fmt;
use io;
use lmdb;
use lmdb_ffi = lmdb::ffi;
use strings;
use types;
use types::c;
use os;

export fn main() void = {
	if (len(os::args) != 3) {
		abort("need two arguments (db dir, key)");
	};

	const key = lmdb::val {
		mv_size = len(strings::toutf8(os::args[2])),
		mv_data = c::unterminatedstr(os::args[2]): *opaque,
	};
	
	let v = io::drain(os::stdin)!;
	defer free(v);

	const val = lmdb::u8s_val(v);

	let env = lmdb::env_create()!;

	lmdb::env_open(env, os::args[1], 0, 0o644)!;

	let txn = lmdb::txn_begin(env, 0)!;

	let dbi = lmdb::dbi_open(txn, null, lmdb_ffi::CREATE)!;

	let val = lmdb::put(dbi, &key, &val, 0)!;

	lmdb::txn_commit(txn)!;
};
