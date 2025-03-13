// Create a transaction for use with the environment.
// 
// The transaction handle may be discarded using [[txn_abort]] or [[txn_commit]].
//
// A transaction and its cursors must only be used by a single
// thread, and a thread may only have a single transaction at a time.
// If [[NOTLS]] is in use, this does not apply to read-only transactions.
//
// Cursors may not span transactions.
//
// Parameters
// - env: An environment handle returned by [[env_create]]
// - parent: If this parameter is non-NULL, the new transaction
//   will be a nested transaction, with the transaction indicated by parent
//   as its parent. Transactions may be nested to any level. A parent
//   transaction and its cursors may not issue any other operations than
//   mdb_txn_commit and mdb_txn_abort while it has active child transactions.
// - flags: Special options for this transaction. This parameter
//   must be set to 0 or by bitwise OR'ing together one or more of the
//   values described here.
// - txn: Address where the new [[txn]] handle will be stored
//
// Flags
// - [[MDB_RDONLY]]
//      	This transaction will not perform any write operations.
//
// Return value: A non-zero error value on failure and 0 on success. Some possible
// errors are:
// - [[PANIC]] - a fatal error occurred earlier and the environment
// -     must be shut down.
// - [[MAP_RESIZED]] - another process wrote data beyond this MDB_env's
// -     mapsize and this environment's map must be resized as well.
// -     See [[env_set_mapsize]].
// - [[READERS_FULL]] - a read-only transaction was requested and
// -     the reader lock table is full. See [[env_set_maxreaders]].
// - ENOMEM - out of memory.
export @symbol("mdb_txn_begin") fn txn_begin(env: *env, parent: nullable *txn, flags: uint, txn: *nullable *txn) int;

// Commit all the operations of a transaction into the database.
// 
// The transaction handle is freed. It and its cursors must not be used
// again after this call, except with [[cursor_renew]].
//
// Parameters
// - txn: A transaction handle returned by [[txn_begin]]
//
// Return value: A non-zero error value on failure and 0 on success. Some possible
// errors are:
// - EINVAL - an invalid parameter was specified.
// - ENOSPC - no more disk space.
// - EIO - a low-level I/O error occurred while writing.
// - ENOMEM - out of memory.
export @symbol("mdb_txn_commit") fn txn_commit(txn: *txn) int;

// Abandon all the operations of the transaction instead of saving them.
// 
// The transaction handle is freed. It and its cursors must not be used
// again after this call, except with [[cursor_renew]].
//
// Parameters
// - txn: A transaction handle returned by [[txn_begin]]
export @symbol("mdb_txn_abort") fn txn_abort(txn: *txn) int;
