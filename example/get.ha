use fmt;
use io;
use lmdb_ffi = lmdb::ffi;
use lmdb;
use strings;
use types;
use types::c;
use os;

export fn main() void = {
	if (len(os::args) != 3) {
		fmt::fprintln(os::stderr, "need two arguments (db dir, key)")!;
		return;
	};

	match (real()) {
	case void => void;
	case let e: lmdb::error =>
		fmt::fprintln(os::stderr, lmdb::strerror(e))!;
	case let e: io::error =>
		fmt::fprintln(os::stderr, io::strerror(e))!;
	};
};

export fn real() (void | lmdb::error | io::error) = {
	const key = lmdb::val{
		mv_size = len(strings::toutf8(os::args[2])),
		mv_data = c::unterminatedstr(os::args[2]): *opaque,
	};

	let env = lmdb::env_create()?;

	lmdb::env_open(env, os::args[1], 0, 0o644)?;

	let txn = lmdb::txn_begin(env, 0)?;

	let dbi = lmdb::dbi_open(txn, null, lmdb_ffi::CREATE)?;

	let val = lmdb::get(dbi, &key)?;

	let data = lmdb::val_u8s(&val);

	io::write(os::stdout, data)?;

	lmdb::txn_abort(txn)?;
};
