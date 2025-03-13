// Create a cursor handle.
//
// A cursor is associated with a specific transaction and database.
// A cursor cannot be used when its database handle is closed.  Nor
// when its transaction has ended, except with [[cursor_renew]].
//
// It can be discarded with [[cursor_close]].
//
// A cursor in a write-transaction can be closed before its transaction
// ends, and will otherwise be closed when its transaction ends.
//
// A cursor in a read-only transaction must be closed explicitly, before
// or after its transaction ends. It can be reused with
// [[cursor_renew]] before finally closing it.
//
// - txn: A transaction handle returned by [[txn_begin]]
// - dbi: A database handle returned by [[dbi_open]]
// - cursor: Address where the new [[cursor]] handle will be stored
// - return: EINVAL on failure and 0 on success.
export @symbol("mdb_cursor_open") fn cursor_open(txn: *txn, dbi: *dbi, cursor: nullable **cursor) int;

// Close a cursor handle.
//
// The cursor handle will be freed and must not be used again after this call.
// Its transaction must still be live if it is a write-transaction.
//
// - cursor: A cursor handle returned by [[cursor_open]]
export @symbol("mdb_cursor_close") fn cursor_close(cursor: *cursor) void;

// Retrieve by cursor.
//
// This function retrieves key/data pairs from the database. The address and length
// of the key are returned in the object to which key refers (except for the
// case of the [[SET]] option, in which the key object is unchanged), and
// the address and length of the data are returned in the object to which data
// refers.
//
// See [[get]] for restrictions on using the output values.
//
// Parameters:
// - cursor: A cursor handle returned by [[cursor_open]]
// - key: The key for a retrieved item
// - data: The data of a retrieved item
// - op: A cursor operation [[cursor_op]]
//
// Return value: A non-zero error value on failure and 0 on success.
// Some possible errors are:
// - [[NOTFOUND]] - no matching key found;
// - [[EINVAL]] - an invalid parameter was specified.
export @symbol("mdb_cursor_get") fn cursor_get(cursor: *cursor, key: *val, data: *val, op: cursor_op) int;


// Delete current key/data pair
// 
// This function deletes the key/data pair to which the cursor refers.
// This does not invalidate the cursor, so operations such as MDB_NEXT
// can still be used on it.
//
// Both MDB_NEXT and MDB_GET_CURRENT will return the same record after
// this operation.
//
// Parameters:
// - cursor: A cursor handle returned by [[cursor_open]]
// - flags: Options for this operation. This parameter
//   must be set to 0 or one of the values described here.
//
// Flags:
// - [[NODUPDATA]] - delete all of the data items for the current key. This flag
//   may only be specified if the database was opened with [[DUPSORT]].
//
// Return value: A non-zero error value on failure and 0 on success. Some
// possible errors are:
// - EACCES - an attempt was made to write in a read-only transaction.
// - EINVAL - an invalid parameter was specified.
// 
export @symbol("mdb_cursor_del") fn cursor_del(cursor: *cursor, flags: uint) int;
