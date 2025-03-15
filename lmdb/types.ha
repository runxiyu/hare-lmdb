use lmdb::ffi;

// Opaque structure for navigating through a database.
export type cursor = ffi::cursor;
