// BerkeleyDB uses -30800 to -30999, we'll go under them

// Successful result
export def SUCCESS = 0;
// key/data pair already exists
export def KEYEXIST = (-30799);
// key/data pair not found (EOF)
export def NOTFOUND = (-30798);
// Requested page not found - this usually indicates corruption
export def PAGE_NOTFOUND = (-30797);
// Located page was wrong type
export def CORRUPTED = (-30796);
// Update of meta page failed or environment had fatal error
export def PANIC = (-30795);
// Environment version mismatch
export def VERSION_MISMATCH = (-30794);
// File is not a valid LMDB file
export def INVALID = (-30793);
// Environment mapsize reached
export def MAP_FULL = (-30792);
// Environment maxdbs reached
export def DBS_FULL = (-30791);
// Environment maxreaders reached
export def READERS_FULL = (-30790);
// Too many TLS keys in use - Windows only
export def TLS_FULL = (-30789);
// Txn has too many dirty pages
export def TXN_FULL = (-30788);
// Cursor stack too deep - internal error
export def CURSOR_FULL = (-30787);
// Page has not enough space - internal error
export def PAGE_FULL = (-30786);
// Database contents grew beyond environment mapsize
export def MAP_RESIZED = (-30785);
// Operation and DB incompatible, or DB type changed. This can mean:
// (1) The operation expects an [[DUPSORT]] / [[DUPFIXED]] database.
// (2) Opening a named DB when the unnamed DB has [[DUPSORT]] / [[INTEGERKEY]].
// (3) Accessing a data record as a database, or vice versa.
// (4) The database was dropped and recreated with different flags.
export def INCOMPATIBLE = (-30784);
// Invalid reuse of reader locktable slot
export def BAD_RSLOT = (-30783);
// Transaction must abort, has a child, or is invalid
export def BAD_TXN = (-30782);
// Unsupported size of key/DB name/data, or wrong DUPFIXED size
export def BAD_VALSIZE = (-30781);
// The specified DBI was changed unexpectedly
export def BAD_DBI = (-30780);
// The last defined error code
export def LAST_ERRCODE = BAD_DBI;
