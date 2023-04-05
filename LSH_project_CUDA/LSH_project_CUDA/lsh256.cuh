#include "type.cuh"

#define LSH_BLOCK_BYTE_LEN		128
#define LSH_BLOCK_BIT_LEN		1024
#define LSH_HASH_BYTE_LEN		32

typedef struct {
	uint8_t sv_pt[LSH_BLOCK_BYTE_LEN];
	uint32_t remain_byte_len;
	uint32_t hash_val[16];
}LSH256_info;