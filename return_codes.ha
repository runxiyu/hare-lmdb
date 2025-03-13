// BerkeleyDB uses -30800 to -30999, we'll go under them

export def MDB_SUCCESS = 0; // Successful result
export def MDB_KEYEXIST = (-30799); // key/data pair already exists
export def MDB_NOTFOUND = (-30798); // key/data pair not found (EOF)
export def MDB_PAGE_NOTFOUND = (-30797); // Requested page not found - this usually indicates corruption
export def MDB_CORRUPTED = (-30796); // Located page was wrong type
export def MDB_PANIC = (-30795); // Update of meta page failed or environment had fatal error
export def MDB_VERSION_MISMATCH = (-30794); // Environment version mismatch
export def MDB_INVALID = (-30793); // File is not a valid LMDB file
export def MDB_MAP_FULL = (-30792); // Environment mapsize reached
export def MDB_DBS_FULL = (-30791); // Environment maxdbs reached
export def MDB_READERS_FULL = (-30790); // Environment maxreaders reached
export def MDB_TLS_FULL = (-30789); // Too many TLS keys in use - Windows only
export def MDB_TXN_FULL = (-30788); // Txn has too many dirty pages
export def MDB_CURSOR_FULL = (-30787); // Cursor stack too deep - internal error
export def MDB_PAGE_FULL = (-30786); // Page has not enough space - internal error
export def MDB_MAP_RESIZED = (-30785); // Database contents grew beyond environment mapsize
export def MDB_INCOMPATIBLE = (-30784); // Operation and DB incompatible, or DB type changed. This can mean: (1) The operation expects an #MDB_DUPSORT / #MDB_DUPFIXED database. (2) Opening a named DB when the unnamed DB has #MDB_DUPSORT / #MDB_INTEGERKEY. (3) Accessing a data record as a database, or vice versa. (4) The database was dropped and recreated with different flags.
export def MDB_BAD_RSLOT = (-30783); // Invalid reuse of reader locktable slot
export def MDB_BAD_TXN = (-30782); // Transaction must abort, has a child, or is invalid
export def MDB_BAD_VALSIZE = (-30781); // Unsupported size of key/DB name/data, or wrong DUPFIXED size
export def MDB_BAD_DBI = (-30780); // The specified DBI was changed unexpectedly
export def MDB_LAST_ERRCODE = MDB_BAD_DBI; // The last defined error code
