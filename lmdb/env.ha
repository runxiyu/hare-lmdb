use lmdb::ffi;
use types::c;

// Opaque structure for a database environment.
//
// A DB environment supports multiple databases, all residing in the same
// shared-memory map.
export type env = ffi::env;

// Creates an [[env]]. The caller must free it with [[env_close]].
export fn env_create() (*env | error) = {
	let e: nullable *ffi::env = null;

	const rc = ffi::env_create(&e): error;

	switch (rc) {
	case 0 => return e: *env;
	case => return rc;
	};
};

// Closes an [[env]].
export fn env_close(env: *env) void = {
	ffi::env_close(env: *ffi::env);
};

// Associates an [[env]] with a on-disk environment.
export fn env_open(env: *env, path: str, flag: uint, mode: u32) (void | error) = {
	const p = c::fromstr(path);
	defer free(p);

	const rc = ffi::env_open(env: *ffi::env, p, flag, mode): error;

	return switch (rc) {
	case 0 => yield;
	case => yield rc;
	};
};
