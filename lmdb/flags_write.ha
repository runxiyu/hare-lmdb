// For put: Don't write if the key already exists.
export def NOOVERWRITE = 0x10;
// Only for [[DUPSORT]]: For put: don't write if the key and data pair already exist. For mdb_cursor_del: remove all duplicate data items.
export def NODUPDATA = 0x20;
// For mdb_cursor_put: overwrite the current key/data pair
export def CURRENT = 0x40;
// For put: Just reserve space for data, don't copy it. Return a pointer to the reserved space.
export def RESERVE = 0x10000;
// Data is being appended, don't split full pages.
export def APPEND = 0x20000;
// Duplicate data is being appended, don't split full pages.
export def APPENDDUP = 0x40000;
// Store multiple data items in one call. Only for [[DUPFIXED]].
export def MULTIPLE = 0x80000;
