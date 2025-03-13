export def MDB_NOOVERWRITE = 0x10; // For put: Don't write if the key already exists.
export def MDB_NODUPDATA = 0x20; // Only for #MDB_DUPSORT: For put: don't write if the key and data pair already exist. For mdb_cursor_del: remove all duplicate data items.
export def MDB_CURRENT = 0x40; // For mdb_cursor_put: overwrite the current key/data pair
export def MDB_RESERVE = 0x10000; // For put: Just reserve space for data, don't copy it. Return a pointer to the reserved space.
export def MDB_APPEND = 0x20000; // Data is being appended, don't split full pages.
export def MDB_APPENDDUP = 0x40000; // Duplicate data is being appended, don't split full pages.
export def MDB_MULTIPLE = 0x80000; // Store multiple data items in one call. Only for #MDB_DUPFIXED.
