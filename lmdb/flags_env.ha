// mmap at a fixed address (experimental)
export def FIXEDMAP = 0x01;
// no environment directory
export def NOSUBDIR = 0x4000;
// don't fsync after commit
export def NOSYNC = 0x10000;
// read only
export def RDONLY = 0x20000;
// don't fsync metapage after commit
export def NOMETASYNC = 0x40000;
// use writable mmap
export def WRITEMAP = 0x80000;
// use asynchronous msync when [[WRITEMAP]] is used
export def MAPASYNC = 0x100000;
// tie reader locktable slots to [[txn]] objects instead of to threads
export def NOTLS = 0x200000;
// don't do any locking, caller must manage their own locks
export def NOLOCK = 0x400000;
// don't do readahead (no effect on Windows)
export def NORDAHEAD = 0x800000;
// don't initialize malloc'd memory before writing to datafile
export def NOMEMINIT = 0x1000000;
