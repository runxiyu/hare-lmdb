export def MDB_REVERSEKEY = 0x02; // use reverse string keys
export def MDB_DUPSORT = 0x04; // use sorted duplicates
export def MDB_INTEGERKEY = 0x08; // numeric keys in native byte order: either unsigned int or size_t. The keys must all be of the same size.
export def MDB_DUPFIXED = 0x10; // with #MDB_DUPSORT, sorted dup items have fixed size
export def MDB_INTEGERDUP = 0x20; // with #MDB_DUPSORT, dups are #MDB_INTEGERKEY-style integers
export def MDB_REVERSEDUP = 0x40; // with #MDB_DUPSORT, use reverse string dups
export def MDB_CREATE = 0x40000; // create DB if not already existing
