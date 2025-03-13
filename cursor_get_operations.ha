// This is the set of all operations for retrieving data
// using a cursor.
export type cursor_op = enum {
	FIRST, // Position at first key/data item
	FIRST_DUP, // Position at first data item of current key. Only for [[DUPSORT]]
	GET_BOTH, // Position at key/data pair. Only for [[DUPSORT]]
	GET_BOTH_RANGE, // position at key, nearest data. Only for [[DUPSORT]]
	GET_CURRENT, // Return key/data at current cursor position
	GET_MULTIPLE, // Return up to a page of duplicate data items from current cursor position. Move cursor to prepare for [[NEXT_MULTIPLE]]. Only for [[DUPFIXED]]
	LAST, // Position at last key/data item
	LAST_DUP, // Position at last data item of current key. Only for [[DUPSORT]]
	NEXT, // Position at next data item
	NEXT_DUP, // Position at next data item of current key. Only for [[DUPSORT]]
	NEXT_MULTIPLE, // Return up to a page of duplicate data items from next cursor position. Move cursor to prepare for [[NEXT_MULTIPLE]]. Only for [[DUPFIXED]]
	NEXT_NODUP, // Position at first data item of next key
	PREV, // Position at previous data item
	PREV_DUP, // Position at previous data item of current key. Only for [[DUPSORT]]
	PREV_NODUP, // Position at last data item of previous key
	SET, // Position at specified key
	SET_KEY, // Position at specified key, return key + data
	SET_RANGE, // Position at first key greater than or equal to specified key.
	PREV_MULTIPLE, // Position at previous page and return up to a page of duplicate data items. Only for [[DUPFIXED]]
};
