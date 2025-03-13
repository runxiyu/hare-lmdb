// Check for stale entries in the reader lock table.
// 
// Parameters
// - env: An environment handle returned by [[env_create]]
// - dead: Number of stale slots that were cleared
//
// Return value: 0 on success, non-zero on failure.
export @symbol("mdb_reader_check") fn reader_check(env: *env, dead: int) int;
