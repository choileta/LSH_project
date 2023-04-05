#include "type.cuh"

#define LSH_BLOCK_BYTE_LEN		256
#define LSH_BLOCK_BIT_LEN		2048
#define LSH_HASH_BYTE_LEN		64

typedef struct {
	uint8_t sv_pt[LSH_BLOCK_BYTE_LEN];
	uint32_t remain_byte_len;
	uint64_t hash_val[16];
}LSH512_info;