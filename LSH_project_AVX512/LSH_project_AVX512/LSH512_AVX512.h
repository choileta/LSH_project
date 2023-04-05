#pragma once
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <immintrin.h>
#include <xmmintrin.h>
#include <emmintrin.h>
#include <immintrin.h>
#include <Windows.h>
#include <stdint.h>

/* ------------------------------------------ *
*  LSH: parameters
*  ------------------------------------------ */

#define BLOCK_WORD_LEN		32
#define WORD_BIT_LEN		64
#define CV_WORD_LEN			16
#define CONST_WORD_LEN		8
#define MSG_BLK_BYTE_LEN	256
#define DIGEST_LEN			64			

#define STEP_NUM			28
#define STEP_EVEN_ALPHA		23
#define STEP_EVEN_BETA		59
#define STEP_ODD_ALPHA		7
#define STEP_ODD_BETA		3
#define LSH_ALIGNED_(x) __declspec(align(x))
#define INLINE __forceinline

/* ------------------------------------------ *
*  LSH: struct
*  ------------------------------------------ */
typedef struct LSH_ALIGNED_(32) {
	__m512i	submsg_e_l[1];
	__m512i	submsg_e_r[1];
	__m512i submsg_o_l[1];
	__m512i submsg_o_r[1];
}LSH512AVX512_internal;

typedef struct LSH_ALIGNED_(32) {
	__m512i cv_l[1];
	__m512i cv_r[1];
	uint8_t last_block[MSG_BLK_BYTE_LEN];
	uint64_t remain_byte;
}LSH512_context;

//Function
void lsh512_init(LSH512_context* ctx);
void lsh512_process(const uint8_t* pt, uint64_t ptLen, LSH512_context* ctx);
void lsh512_final(uint8_t* digest, LSH512_context* ctx);
void lsh512_avx512(uint8_t* data, uint64_t size, uint8_t* digest);
