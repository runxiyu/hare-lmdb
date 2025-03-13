export def REVERSEKEY = 0x02; // use reverse string keys
export def DUPSORT = 0x04; // use sorted duplicates
export def INTEGERKEY = 0x08; // numeric keys in native byte order: either unsigned int or size_t. The keys must all be of the same size.
export def DUPFIXED = 0x10; // with [[DUPSORT]], sorted dup items have fixed size
export def INTEGERDUP = 0x20; // with [[DUPSORT]], dups are [[INTEGERKEY]]-style integers
export def REVERSEDUP = 0x40; // with [[DUPSORT]], use reverse string dups
export def CREATE = 0x40000; // create DB if not already existing
