use lmdb::ffi;
use types::c;

// Any error returned by LMDB.
export type error = !int;

// Create a human-readable error message from an [[error]].
export fn strerror(err: error) str = {
	return c::tostr_unsafe(ffi::strerror(err: int));
};
