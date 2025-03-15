use lmdb::ffi;

// Opaque structure for a database environment.
//
// A DB environment supports multiple databases, all residing in the same
// shared-memory map.
export type env = ffi::env;

// A handle for an individual database in the DB environment.
export type dbi = ffi::dbi;

// Opaque structure for a transaction handle.
export type txn = ffi::txn;

// Opaque structure for navigating through a database.
export type cursor = ffi::cursor;
