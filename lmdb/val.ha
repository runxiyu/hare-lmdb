use types;

// Generic structure used for passing keys and data in and out
// of the database.
export type val = ffi::val;

// Convert a []u8 to a [[val]].
export fn u8s_val(s: []u8) val = {
	let ss = *(&s: *types::slice);
	return val {
		mv_size = ss.length,
		mv_data = ss.data,
	};
};
