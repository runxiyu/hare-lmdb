// Delete items from a database.
//
// This function removes key/data pairs from the database. If the database does not
// support sorted duplicate data items ([[DUPSORT]]), the data parameter is ignored.
// If the database supports sorted duplicates and the data parameter is NULL, all
// of the duplicate data items for the key will be deleted. Otherwise, if the data
// parameter is non-NULL, only the matching data item will be deleted. This function
// will return [[NOTFOUND]] if the specified key/data pair is not in the database.
//
// Parameters:
// - txn: A transaction handle returned by [[txn_begin]]
// - dbi: A database handle returned by [[dbi_open]]
// - key: The key to delete from the database
// - data: The data to delete
//
// Return value: A non-zero error value on failure and 0 on success. Some possible errors are:
// - EACCES: an attempt was made to write in a read-only transaction.
// - EINVAL: an invalid parameter was specified.
export @symbol("mdb_del") fn del(txn: *txn, dbi: *dbi, key: *val, data: *val) int;


// Get items from a database.
//
// This function retrieves key/data pairs from the database. The address and length
// of the data associated with the specified key are returned in the structure to
// which data refers. If the database supports duplicate keys ([[DUPSORT]]), then
// the first data item for the key will be returned. Retrieval of other items
// requires the use of [[cursor_get]].
//
// The memory pointed to by the returned values is owned by the database. The caller
// need not dispose of the memory, and may not modify it in any way. For values
// returned in a read-only transaction, any modification attempts cause a SIGSEGV.
// Values returned from the database are valid only until a subsequent update
// operation, or the end of the transaction.
//
// Parameters:
// - txn: A transaction handle returned by [[txn_begin]]
// - dbi: A database handle returned by [[dbi_open]]
// - key: The key to search for in the database
// - data: The data corresponding to the key
//
// Return value: A non-zero error value on failure and 0 on success. Some possible errors are:
// - [[NOTFOUND]]: the key was not in the database
// - EINVAL: an invalid parameter was specified
export @symbol("mdb_get") fn get(txn: *txn, dbi: *dbi, key: *val, data: *val) int;

// Store items into a database.
//
// This function stores key/data pairs in the database. The default behavior
// is to enter the new key/data pair, replacing any previously existing key
// if duplicates are disallowed, or adding a duplicate data item if duplicates
// are allowed ([[DUPSORT]]).
//
// Parameters:
// - txn: A transaction handle returned by [[txn_begin]]
// - dbi: A database handle returned by [[dbi_open]]
// - key: The key to store in the database
// - data: The data to store
// - flags: Special options for this operation. Must be set to 0 or by bitwise
//   OR'ing together one or more of the values described below.
//
// Flags:
// - [[NODUPDATA]]: enter the new key/data pair only if it does not already appear
//   in the database. Only valid if the database was opened with [[DUPSORT]].
//   Returns [[KEYEXIST]] if the key/data pair already appears.
// - [[NOOVERWRITE]]: enter the new key/data pair only if the key does not already
//   appear in the database. Returns [[KEYEXIST]] if the key is present,
//   even if the database supports duplicates. The data parameter will be set
//   to the existing item.
// - [[RESERVE]]: reserve space for data of the given size, but don't copy the
//   given data. Instead, return a pointer to the reserved space, which the caller
//   can fill later (before the next update or transaction end). This must not
//   be specified if the database was opened with [[DUPSORT]].
// - [[APPEND]]: append the given key/data pair to the end of the database for
//   fast bulk loading when keys are already in correct order. Loading unsorted
//   keys with this flag will cause a [[KEYEXIST]] error.
// - [[APPENDDUP]]: same as [[APPEND]], but for sorted duplicate data.
//
// Return value: A non-zero error value on failure and 0 on success. Some possible errors are:
// - [[MAP_FULL]]: the database is full (see [[env_set_mapsize]])
// - [[TXN_FULL]]: the transaction has too many dirty pages
// - EACCES: an attempt was made to write in a read-only transaction
// - EINVAL: an invalid parameter was specified
export @symbol("mdb_put") fn put(txn: *txn, dbi: *dbi, key: *val, data: *val, flags: uint) int;
