use types::c;

// Open a database in the environment.
//
// A database handle denotes the name and parameters of a database,
// independently of whether such a database actually exists. The database
// handle may be discarded by calling [[dbi_close]]. If the database was
// already open, this function returns the old handle. The handle may only
// be closed once.
//
// The database handle will be private to the current transaction until the
// transaction is successfully committed. If the transaction is aborted, the
// handle will be closed automatically. After a successful commit, the handle
// will reside in the shared environment and may be used by other transactions.
//
// This function must not be called from multiple concurrent transactions in
// the same process. A transaction that uses this function must finish (either
// commit or abort) before any other transaction in the process may use this
// function.
//
// To use named databases (with name != NULL), [[env_set_maxdbs]] must be
// called before opening the environment. Database names are keys in the unnamed
// database, and may be read but not written.
//
// Parameters:
// - txn: A transaction handle returned by [[txn_begin]]
// - name: The name of the database to open. If only a single database is
//   needed in the environment, this value may be NULL.
// - flags: Special options for this database. Must be set to 0 or by
//   bitwise OR'ing together one or more of the defined flags.
// - dbi: Address where the new [[dbi]] handle will be stored.
//
// Flags:
// - [[REVERSEKEY]]: Keys are compared in reverse order (from end to start)
// - [[DUPSORT]]: Duplicate keys may be used in the database
// - [[INTEGERKEY]]: Keys are binary integers in native byte order
// - [[DUPFIXED]]: Requires [[DUPSORT]]. Data items are all the same size
// - [[INTEGERDUP]]: Duplicate data items are binary integers
// - [[REVERSEDUP]]: Duplicate data items are compared in reverse order
// - [[CREATE]]: Create the named database if it does not exist
//
// Return value: A non-zero error value on failure and 0 on success. Some
// possible errors are:
// - [[NOTFOUND]]: The specified database doesn’t exist and [[CREATE]] was not specified
// - [[DBS_FULL]]: Too many databases have been opened (see [[env_set_maxdbs]])
export @symbol("mdb_dbi_open") fn dbi_open(txn: *txn, name: const nullable *c::char, flags: uint, dbi: *dbi) int;
