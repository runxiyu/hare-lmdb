use lmdb::ffi;
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

// Convert a [[val]] to a []u8.
export fn val_u8s(s: *val) []u8 = {
	return *(&types::slice {
		data = s.mv_data,
		length = s.mv_size,
		capacity = s.mv_size,
	}: *[]u8);
};
