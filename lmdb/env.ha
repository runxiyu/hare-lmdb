use types::c;

// Create an LMDB environment handle.
// 
// This function allocates memory for a [[env]] structure. To release
// the allocated memory and discard the handle, call [[env_close]].
// Before the handle may be used, it must be opened using [[env_open]].
// Various other options may also need to be set before opening the handle,
// e.g. [[env_set_mapsize]], [[env_set_maxreaders]], [[env_set_maxdbs]],
// depending on usage requirements.
//
// Parameters:
// - env: The address where the new handle will be stored
//
// Return value: A non-zero error value on failure and 0 on success.
export @symbol("mdb_env_create") fn env_create(env: nullable **env) int;

// Open an environment handle.
// 
// If this function fails, [[env_close]] must be called to discard the [[env]] handle.
// 
// Parameters:
// - env: An environment handle returned by [[env_create]]
// - path: The directory in which the database files reside. This
//   directory must already exist and be writable.
// - flags: Special options for this environment. This parameter
//   must be set to 0 or by bitwise OR'ing together one or more of the
//   values described here. Flags set by [[env_set_flags]] are also used.
// - mode: The UNIX permissions to set on created files and semaphores. This
//   parameter is ignored on Windows.
//
// - [[FIXEDMAP]]:
//		use a fixed address for the mmap region. This flag must be specified
//		when creating the environment, and is stored persistently in the environment.
//		If successful, the memory map will always reside at the same virtual address
//		and pointers used to reference data items in the database will be constant
//		across multiple invocations. This option may not always work, depending on
//		how the operating system has allocated memory to shared libraries and other uses.
//		The feature is highly experimental.
// - [[NOSUBDIR]]:
//		By default, LMDB creates its environment in a directory whose
//		pathname is given in path, and creates its data and lock files
//		under that directory. With this option, path is used as-is for
//		the database main data file. The database lock file is the path
//		with "-lock" appended.
// - [[RDONLY]]:
//		Open the environment in read-only mode. No write operations will be
//		allowed. LMDB will still modify the lock file - except on read-only
//		filesystems, where LMDB does not use locks.
// - [[WRITEMAP]]:
//		Use a writeable memory map unless MDB_RDONLY is set. This uses
//		fewer mallocs but loses protection from application bugs
//		like wild pointer writes and other bad updates into the database.
//		This may be slightly faster for DBs that fit entirely in RAM, but
//		is slower for DBs larger than RAM.
//		Incompatible with nested transactions.
//		Do not mix processes with and without MDB_WRITEMAP on the same
//		environment.  This can defeat durability (#mdb_env_sync etc).
// - [[NOMETASYNC]]:
//		Flush system buffers to disk only once per transaction, omit the
//		metadata flush. Defer that until the system flushes files to disk,
//		or next non-MDB_RDONLY commit or [[env_sync]]. This optimization
//		maintains database integrity, but a system crash may undo the last
//		committed transaction. I.e. it preserves the ACI (atomicity,
//		consistency, isolation) but not D (durability) database property.
//		This flag may be changed at any time using [[env_set_flags]].
// - [[NOSYNC]]:
//		Don't flush system buffers to disk when committing a transaction.
//		This optimization means a system crash can corrupt the database or
//		lose the last transactions if buffers are not yet flushed to disk.
//		The risk is governed by how often the system flushes dirty buffers
//		to disk and how often [[env_sync]] is called.  However, if the
//		filesystem preserves write order and the [[WRITEMAP]] flag is not
//		used, transactions exhibit ACI (atomicity, consistency, isolation)
//		properties and only lose D (durability).  I.e. database integrity
//		is maintained, but a system crash may undo the final transactions.
//		Note that ([[NOSYNC]] | [[WRITEMAP)]] leaves the system with no
//		hint for when to write transactions to disk, unless [[env_sync]]
//		is called. ([[MAPASYNC]] | [[WRITEMAP)]] may be preferable.
//		This flag may be changed at any time using [[env_set_flags]].
// - [[MAPASYNC]]:
//		When using [[WRITEMAP]], use asynchronous flushes to disk.
//		As with [[NOSYNC]], a system crash can then corrupt the
//		database or lose the last transactions. Calling [[env_sync]]
//		ensures on-disk database integrity until next commit.
//		This flag may be changed at any time using [[env_set_flags]].
// - [[NOTLS]]:
//		Don't use Thread-Local Storage. Tie reader locktable slots to
//		[[txn]] objects instead of to threads. I.e. [[txn_reset]] keeps
//		the slot reserved for the [[txn]] object. A thread may use parallel
//		read-only transactions. A read-only transaction may span threads if
//		the user synchronizes its use. Applications that multiplex many
//		user threads over individual OS threads need this option. Such an
//		application must also serialize the write transactions in an OS
//		thread, since LMDB's write locking is unaware of the user threads.
// - [[NOLOCK]]:
//		Don't do any locking. If concurrent access is anticipated, the
//		caller must manage all concurrency itself. For proper operation
//		the caller must enforce single-writer semantics, and must ensure
//		that no readers are using old transactions while a writer is
//		active. The simplest approach is to use an exclusive lock so that
//		no readers may be active at all when a writer begins.
// - [[NORDAHEAD]]:
//		Turn off readahead. Most operating systems perform readahead on
//		read requests by default. This option turns it off if the OS
//		supports it. Turning it off may help random read performance
//		when the DB is larger than RAM and system RAM is full.
//		The option is not implemented on Windows.
// - [[NOMEMINIT]]:
//		Don't initialize malloc'd memory before writing to unused spaces
//		in the data file. By default, memory for pages written to the data
//		file is obtained using malloc. While these pages may be reused in
//		subsequent transactions, freshly malloc'd pages will be initialized
//		to zeroes before use. This avoids persisting leftover data from other
//		code (that used the heap and subsequently freed the memory) into the
//		data file. Note that many other system libraries may allocate
//		and free memory from the heap for arbitrary uses. E.g., stdio may
//		use the heap for file I/O buffers. This initialization step has a
//		modest performance cost so some applications may want to disable
//		it using this flag. This option can be a problem for applications
//		which handle sensitive data like passwords, and it makes memory
//		checkers like Valgrind noisy. This flag is not needed with [[WRITEMAP]],
//		which writes directly to the mmap instead of using malloc for pages. The
//		initialization is also skipped if [[RESERVE]] is used; the
//		caller is expected to overwrite all of the memory that was
//		reserved in that case.
//		This flag may be changed at any time using [[env_set_flags]].
//
// Return value: A non-zero error value on failure and 0 on success. Some possible
// errors are:
// - [[VERSION_MISMATCH]] - the version of the LMDB library doesn't match the
//   version that created the database environment.
// - [[INVALID]] - the environment file headers are corrupted.
// - ENOENT - the directory specified by the path parameter doesn't exist.
// - EACCES - the user didn't have permission to access the environment files.
// - EAGAIN - the environment was locked by another process.
export @symbol("mdb_env_open") fn env_open(env: *env, path: const *c::char, flag: uint, mode: mode_t) int;

// Close the environment and release the memory map.
// 
// Only a single thread may call this function. All transactions, databases,
// and cursors must already be closed before calling this function. Attempts to
// use any such handles after calling this function will cause a SIGSEGV.
// The environment handle will be freed and must not be used again after this call.
//
// Parameters:
// - env: An environment handle returned by [[env_create]]
export @symbol("mdb_env_close") fn env_close(env: *env) void;

// Set the size of the memory map to use for this environment.
//
// The size should be a multiple of the OS page size. The default is
// 10485760 bytes. The size of the memory map is also the maximum size
// of the database. The value should be chosen as large as possible,
// to accommodate future growth of the database.
//
// This function should be called after [[env_create]] and before [[env_open]].
// It may be called at later times if no transactions are active in
// this process. Note that the library does not check for this condition,
// the caller must ensure it explicitly.
//
// The new size takes effect immediately for the current process but
// will not be persisted to any others until a write transaction has been
// committed by the current process. Also, only mapsize increases are
// persisted into the environment.
//
// If the mapsize is increased by another process, and data has grown
// beyond the range of the current mapsize, [[txn_begin]] will
// return [[MAP_RESIZED]]. This function may be called with a size
// of zero to adopt the new size.
//
// Any attempt to set a size smaller than the space already consumed
// by the environment will be silently changed to the current size of the used space.
//
// Parameters
// - env: An environment handle returned by [[env_create]]
// - size: The size in bytes
//
// Return value: A non-zero error value on failure and 0 on success. Some possible
// errors are:
// - EINVAL - an invalid parameter was specified, or the environment has
//   an active write transaction.
export @symbol("mdb_env_set_mapsize") fn env_set_mapsize(env: *env, size_: size) int;

// Set the maximum number of named databases for the environment.
//
// This function is only needed if multiple databases will be used in the
// environment. Simpler applications that use the environment as a single
// unnamed database can ignore this option.
//
// This function may only be called after [[env_create]] and before [[env_open]].
//
// Currently a moderate number of slots are cheap but a huge number gets
// expensive: 7-120 words per transaction, and every [[dbi_open]]
// does a linear search of the opened slots.
//
// Parameters
// - env: An environment handle returned by [[env_create]]
// - dbs: The maximum number of databases
//
// Return value: A non-zero error value on failure and 0 on success. Some possible
// errors are:
// - EINVAL - an invalid parameter was specified, or the environment is already open.
export @symbol("mdb_env_set_maxdbs") fn env_set_maxdbs(env: *env, dbs: dbi) int;
