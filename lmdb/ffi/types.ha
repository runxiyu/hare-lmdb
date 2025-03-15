export type cursor = opaque;
export type dbi = uint;
export type env = opaque;
export type txn = opaque;
export type val = struct {
	mv_size: size,
	mv_data: nullable *opaque,
};
export type mode_t = u32;
