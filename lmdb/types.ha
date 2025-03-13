// Opaque structure for navigating through a database
export type cursor = opaque;

// A handle for an individual database in the DB environment.
export type dbi = uint;

// Opaque structure for a database environment.
//
// A DB environment supports multiple databases, all residing in the same
// shared-memory map.
export type env = opaque;

// Opaque structure for a transaction handle.
//
// All database operations require a transaction handle. Transactions may be
// read-only or read-write.
export type txn = opaque;

// Generic structure used for passing keys and data in and out
// of the database.
//
// Values returned from the database are valid only until a subsequent
// update operation, or the end of the transaction. Do not modify or
// free them, they commonly point into the database itself.
//
// Key sizes must be between 1 and #mdb_env_get_maxkeysize() inclusive.
// The same applies to data sizes in databases with the [[DUPSORT]] flag.
// Other data items can in theory be from 0 to 0xffffffff bytes long.
export type val = struct {
	mv_size: size,
	mv_data: *opaque,
};

// Unix permissions for creating files, or dummy definition for Windows
export type mode_t = u32;
