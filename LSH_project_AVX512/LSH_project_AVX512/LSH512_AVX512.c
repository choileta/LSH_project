#include "LSH512_AVX512.h"

static const LSH_ALIGNED_(64) uint64_t IV512[CV_WORD_LEN] = {
	0xADD50F3C7F07094E, 0xE3F3CEE8F9418A4F, 0xB527ECDE5B3D0AE9, 0x2EF6DEC68076F501,
	0x8CB994CAE5ACA216, 0xFBB9EAE4BBA48CC7, 0x650A526174725FEA, 0x1F9A61A73F8D8085,
	0xB6607378173B539B, 0x1BC99853B0C0B9ED, 0xDF727FC19B182D47, 0xDBEF360CF893A457,
	0x4981F5E570147E80, 0xD00C4490CA7D3E30, 0x5D73940C0E4AE1EC, 0x894085E2EDB2D819
};

static const LSH_ALIGNED_(32) uint64_t StepConst[CONST_WORD_LEN * STEP_NUM] = {
	0x97884283c938982aULL, 0xba1fca93533e2355ULL, 0xc519a2e87aeb1c03ULL, 0x9a0fc95462af17b1ULL,
	0xfc3dda8ab019a82bULL, 0x02825d079a895407ULL, 0x79f2d0a7ee06a6f7ULL, 0xd76d15eed9fdf5feULL,
	0x1fcac64d01d0c2c1ULL, 0xd9ea5de69161790fULL, 0xdebc8b6366071fc8ULL, 0xa9d91db711c6c94bULL,
	0x3a18653ac9c1d427ULL, 0x84df64a223dd5b09ULL, 0x6cc37895f4ad9e70ULL, 0x448304c8d7f3f4d5ULL,
	0xea91134ed29383e0ULL, 0xc4484477f2da88e8ULL, 0x9b47eec96d26e8a6ULL, 0x82f6d4c8d89014f4ULL,
	0x527da0048b95fb61ULL, 0x644406c60138648dULL, 0x303c0e8aa24c0edcULL, 0xc787cda0cbe8ca19ULL,
	0x7ba46221661764caULL, 0x0c8cbc6acd6371acULL, 0xe336b836940f8f41ULL, 0x79cb9da168a50976ULL,
	0xd01da49021915cb3ULL, 0xa84accc7399cf1f1ULL, 0x6c4a992cee5aeb0cULL, 0x4f556e6cb4b2e3e0ULL,
	0x200683877d7c2f45ULL, 0x9949273830d51db8ULL, 0x19eeeecaa39ed124ULL, 0x45693f0a0dae7fefULL,
	0xedc234b1b2ee1083ULL, 0xf3179400d68ee399ULL, 0xb6e3c61b4945f778ULL, 0xa4c3db216796c42fULL,
	0x268a0b04f9ab7465ULL, 0xe2705f6905f2d651ULL, 0x08ddb96e426ff53dULL, 0xaea84917bc2e6f34ULL,
	0xaff6e664a0fe9470ULL, 0x0aab94d765727d8cULL, 0x9aa9e1648f3d702eULL, 0x689efc88fe5af3d3ULL,
	0xb0950ffea51fd98bULL, 0x52cfc86ef8c92833ULL, 0xe69727b0b2653245ULL, 0x56f160d3ea9da3e2ULL,
	0xa6dd4b059f93051fULL, 0xb6406c3cd7f00996ULL, 0x448b45f3ccad9ec8ULL, 0x079b8587594ec73bULL,
	0x45a50ea3c4f9653bULL, 0x22983767c1f15b85ULL, 0x7dbed8631797782bULL, 0x485234be88418638ULL,
	0x842850a5329824c5ULL, 0xf6aca914c7f9a04cULL, 0xcfd139c07a4c670cULL, 0xa3210ce0a8160242ULL,
	0xeab3b268be5ea080ULL, 0xbacf9f29b34ce0a7ULL, 0x3c973b7aaf0fa3a8ULL, 0x9a86f346c9c7be80ULL,
	0xac78f5d7cabcea49ULL, 0xa355bddcc199ed42ULL, 0xa10afa3ac6b373dbULL, 0xc42ded88be1844e5ULL,
	0x9e661b271cff216aULL, 0x8a6ec8dd002d8861ULL, 0xd3d2b629beb34be4ULL, 0x217a3a1091863f1aULL,
	0x256ecda287a733f5ULL, 0xf9139a9e5b872fe5ULL, 0xac0535017a274f7cULL, 0xf21b7646d65d2aa9ULL,
	0x048142441c208c08ULL, 0xf937a5dd2db5e9ebULL, 0xa688dfe871ff30b7ULL, 0x9bb44aa217c5593bULL,
	0x943c702a2edb291aULL, 0x0cae38f9e2b715deULL, 0xb13a367ba176cc28ULL, 0x0d91bd1d3387d49bULL,
	0x85c386603cac940cULL, 0x30dd830ae39fd5e4ULL, 0x2f68c85a712fe85dULL, 0x4ffeecb9dd1e94d6ULL,
	0xd0ac9a590a0443aeULL, 0xbae732dc99ccf3eaULL, 0xeb70b21d1842f4d9ULL, 0x9f4eda50bb5c6fa8ULL,
	0x4949e69ce940a091ULL, 0x0e608dee8375ba14ULL, 0x983122cba118458cULL, 0x4eeba696fbb36b25ULL,
	0x7d46f3630e47f27eULL, 0xa21a0f7666c0dea4ULL, 0x5c22cf355b37cec4ULL, 0xee292b0c17cc1847ULL,
	0x9330838629e131daULL, 0x6eee7c71f92fce22ULL, 0xc953ee6cb95dd224ULL, 0x3a923d92af1e9073ULL,
	0xc43a5671563a70fbULL, 0xbc2985dd279f8346ULL, 0x7ef2049093069320ULL, 0x17543723e3e46035ULL,
	0xc3b409b00b130c6dULL, 0x5d6aee6b28fdf090ULL, 0x1d425b26172ff6edULL, 0xcccfd041cdaf03adULL,
	0xfe90c7c790ab6cbfULL, 0xe5af6304c722ca02ULL, 0x70f695239999b39eULL, 0x6b8b5b07c844954cULL,
	0x77bdb9bb1e1f7a30ULL, 0xc859599426ee80edULL, 0x5f9d813d4726e40aULL, 0x9ca0120f7cb2b179ULL,
	0x8f588f583c182cbdULL, 0x951267cbe9eccce7ULL, 0x678bb8bd334d520eULL, 0xf6e662d00cd9e1b7ULL,
	0x357774d93d99aaa7ULL, 0x21b2edbb156f6eb5ULL, 0xfd1ebe846e0aee69ULL, 0x3cb2218c2f642b15ULL,
	0xe7e7e7945444ea4cULL, 0xa77a33b5d6b9b47cULL, 0xf34475f0809f6075ULL, 0xdd4932dce6bb99adULL,
	0xacec4e16d74451dcULL, 0xd4a0a8d084de23d6ULL, 0x1bdd42f278f95866ULL, 0xeed3adbb938f4051ULL,
	0xcfcf7be8992f3733ULL, 0x21ade98c906e3123ULL, 0x37ba66711fffd668ULL, 0x267c0fc3a255478aULL,
	0x993a64ee1b962e88ULL, 0x754979556301faaaULL, 0xf920356b7251be81ULL, 0xc281694f22cf923fULL,
	0x9f4b6481c8666b02ULL, 0xcf97761cfe9f5444ULL, 0xf220d7911fd63e9fULL, 0xa28bd365f79cd1b0ULL,
	0xd39f5309b1c4b721ULL, 0xbec2ceb864fca51fULL, 0x1955a0ddc410407aULL, 0x43eab871f261d201ULL,
	0xeaafe64a2ed16da1ULL, 0x670d931b9df39913ULL, 0x12f868b0f614de91ULL, 0x2e5f395d946e8252ULL,
	0x72f25cbb767bd8f4ULL, 0x8191871d61a1c4ddULL, 0x6ef67ea1d450ba93ULL, 0x2ea32a645433d344ULL,
	0x9a963079003f0f8bULL, 0x74a0aeb9918cac7aULL, 0x0b6119a70af36fa3ULL, 0x8d9896f202f0d480ULL,
	0x654f1831f254cd66ULL, 0x1318a47f0366a25eULL, 0x65752076250b4e01ULL, 0xd1cd8eb888071772ULL,
	0x30c6a9793f4e9b25ULL, 0x154f684b1e3926eeULL, 0x6c7ac0b1fe6312aeULL, 0x262f88f4f3c5550dULL,
	0xb4674a24472233cbULL, 0x2bbd23826a090071ULL, 0xda95969b30594f66ULL, 0x9f5c47408f1e8a43ULL,
	0xf77022b88de9c055ULL, 0x64b7b36957601503ULL, 0xe73b72b06175c11aULL, 0x55b87de8b91a6233ULL,
	0x1bb16e6b6955ff7fULL, 0xe8e0a5ec7309719cULL, 0x702c31cb89a8b640ULL, 0xfba387cfada8cde2ULL,
	0x6792db4677aa164cULL, 0x1c6b1cc0b7751867ULL, 0x22ae2311d736dc01ULL, 0x0e3666a1d37c9588ULL,
	0xcd1fd9d4bf557e9aULL, 0xc986925f7c7b0e84ULL, 0x9c5dfd55325ef6b0ULL, 0x9f2b577d5676b0ddULL,
	0xfa6e21be21c062b3ULL, 0x8787dd782c8d7f83ULL, 0xd0d134e90e12dd23ULL, 0x449d087550121d96ULL,
	0xecf9ae9414d41967ULL, 0x5018f1dbf789934dULL, 0xfa5b52879155a74cULL, 0xca82d4d3cd278e7cULL,
	0x688fdfdfe22316adULL, 0x0f6555a4ba0d030aULL, 0xa2061df720f000f3ULL, 0xe1a57dc5622fb3daULL,
	0xe6a842a8e8ed8153ULL, 0x690acdd3811ce09dULL, 0x55adda18e6fcf446ULL, 0x4d57a8a0f4b60b46ULL,
	0xf86fbfc20539c415ULL, 0x74bafa5ec7100d19ULL, 0xa824151810f0f495ULL, 0x8723432791e38ebbULL,
	0x8eeaeb91d66ed539ULL, 0x73d8a1549dfd7e06ULL, 0x0387f2ffe3f13a9bULL, 0xa5004995aac15193ULL,
	0x682f81c73efdda0dULL, 0x2fb55925d71d268dULL, 0xcc392d2901e58a3dULL, 0xaa666ab975724a42ULL
};

static const LSH_ALIGNED_(32) uint64_t BytePermu[8] = {
	0x0706050403020100, 0x0d0c0b0a09080f0e, 0x1312111017161514, 0x19181f1e1d1c1b1a,
	0x0605040302010007, 0x0c0b0a09080f0e0d, 0x1211101716151413, 0x181f1e1d1c1b1a19
};

static const LSH_ALIGNED_(32) uint64_t wordPermu[16] = {
	0x06, 0x04, 0x05, 0x07, 0x0c, 0x0f, 0x0e, 0x0d,
	0x02, 0x00, 0x01, 0x03, 0x08, 0x0b, 0x0a, 0x09
};

static const LSH_ALIGNED_(32) uint64_t MsgWordPermu[16] = {
	0x03, 0x02, 0x00, 0x01, 0x07, 0x04, 0x05, 0x06,
	0x0b, 0x0a, 0x08, 0x09, 0x0f, 0x0c, 0x0d, 0x0e
};

/* ------------------------------------------ *
*  LSH: function macro
*  ------------------------------------------ */

#define LOAD(x)			_mm512_loadu_si512((__m512*)x)
#define STORE(x, y)		_mm512_storeu_si512((__m512*)x, y)
#define XOR(x, y)		_mm512_xor_si512(x, y)
#define OR(x, y)		_mm512_or_si512(x, y)
#define AND(x, y)		_mm512_and_si512(x, y)
#define SHUFFLE8(x, y)	_mm512_shuffle_epi8(x, y)

#define ADD(x, y)		_mm512_add_epi64(x, y)
#define SHIFT_L(x, r)	_mm512_slli_epi64(x, r)
#define SHIFT_R(x, r)	_mm512_srli_epi64(x, r)

/* ------------------------------------------ *
*  LSH: iternal function
*  ------------------------------------------ */

static INLINE void load_blk(__m512i* dst, const void* src) {
	dst[0] = LOAD((const __m512i*)src);
}

static INLINE void load_msg_blk(LSH512AVX512_internal* i_state, const uint64_t* msgblk) {
	load_blk(i_state->submsg_e_l, msgblk + 0);
	load_blk(i_state->submsg_e_r, msgblk + 8);
	load_blk(i_state->submsg_o_l, msgblk + 16);
	load_blk(i_state->submsg_o_r, msgblk + 24);
}

static INLINE void msg_add_even(__m512i* cv_l, __m512i* cv_r, const LSH512AVX512_internal* i_state) {
	cv_l[0] = XOR(cv_l[0], i_state->submsg_e_l[0]);
	cv_r[0] = XOR(cv_r[0], i_state->submsg_e_r[0]);
}

static INLINE void msg_add_odd(__m512i* cv_l, __m512i* cv_r, const LSH512AVX512_internal* i_state) {
	cv_l[0] = XOR(cv_l[0], i_state->submsg_o_l[0]);
	cv_r[0] = XOR(cv_r[0], i_state->submsg_o_r[0]);
}

static INLINE void load_sc(__m512i* const_v, uint32_t i) {
	load_blk(const_v, StepConst + i);
}

static INLINE void add_blk(__m512i* cv_l, const __m512i* cv_r) {
	cv_l[0] = ADD(cv_l[0], cv_r[0]);
}

static INLINE void rotate_blk_even_alpha(__m512i* cv) {
	cv[0] = OR(SHIFT_L(cv[0], STEP_EVEN_ALPHA), SHIFT_R(cv[0], WORD_BIT_LEN - STEP_EVEN_ALPHA));

}

static INLINE void rotate_blk_odd_alpha(__m512i* cv) {
	cv[0] = OR(SHIFT_L(cv[0], STEP_ODD_ALPHA), SHIFT_R(cv[0], WORD_BIT_LEN - STEP_ODD_ALPHA));
}

static INLINE void xor_with_const(__m512i* cv_l, const __m512i* const_v) {
	cv_l[0] = XOR(cv_l[0], const_v[0]);
}

static INLINE void rotate_blk_even_beta(__m512i* cv) {
	cv[0] = OR(SHIFT_L(cv[0], STEP_EVEN_BETA), SHIFT_R(cv[0], WORD_BIT_LEN - STEP_EVEN_BETA));
}

static INLINE void rotate_blk_odd_beta(__m512i* cv) {
	cv[0] = OR(SHIFT_L(cv[0], STEP_ODD_BETA), SHIFT_R(cv[0], WORD_BIT_LEN - STEP_ODD_BETA));
}

static INLINE void rotate_msg_gamma(__m512i* cv_r, const __m512i* byte_perm_step) {
	cv_r[0] = SHUFFLE8(cv_r[0], byte_perm_step[0]);
}

static INLINE void mix_even(__m512i* cv_l, __m512i* cv_r, const __m512i* const_v, const __m512i* byte_perm_step) {
	add_blk(cv_l, cv_r);
	rotate_blk_even_alpha(cv_l);
	xor_with_const(cv_l, const_v);
	add_blk(cv_r, cv_l);
	rotate_blk_even_beta(cv_r);
	add_blk(cv_l, cv_r);
	rotate_msg_gamma(cv_r, byte_perm_step);
}

static INLINE mix_odd(__m512i* cv_l, __m512i* cv_r, const __m512i* const_v, const __m512i* byte_perm_step) {
	add_blk(cv_l, cv_r);
	rotate_blk_odd_alpha(cv_l);
	xor_with_const(cv_l, const_v);
	add_blk(cv_r, cv_l);
	rotate_blk_odd_beta(cv_r);
	add_blk(cv_l, cv_r);
	rotate_msg_gamma(cv_r, byte_perm_step);
}

static INLINE void word_perm(__m512i* cv_l, __m512i* cv_r, __m512i* permu) {
	__m512i temp;

	temp = cv_l[0];
	cv_l[0] = _mm512_permutex2var_epi64(cv_l[0], permu[0], cv_r[0]);
	cv_r[0] = _mm512_permutex2var_epi64(temp, permu[1], cv_r[0]);
}

static INLINE void msg_exp_even(LSH512AVX512_internal* i_state) {
	__m512i permu = LOAD((__m512i*)MsgWordPermu);
	i_state->submsg_e_l[0] = ADD(i_state->submsg_o_l[0], _mm512_permutexvar_epi64(permu, i_state->submsg_e_l[0]));
	permu = LOAD((__m512i*)MsgWordPermu + 1);
	i_state->submsg_e_r[0] = ADD(i_state->submsg_o_r[0], _mm512_permutexvar_epi64(permu, i_state->submsg_e_r[0]));
}

static INLINE void msg_exp_odd(LSH512AVX512_internal* i_state) {
	__m512i permu = LOAD((__m512i*)MsgWordPermu);
	i_state->submsg_o_l[0] = ADD(i_state->submsg_e_l[0], _mm512_permutexvar_epi64(permu, i_state->submsg_o_l[0]));
	i_state->submsg_o_r[0] = ADD(i_state->submsg_e_r[0], _mm512_permutexvar_epi64(permu, i_state->submsg_o_r[0]));

}

static INLINE void fin(__m512i* cv_l, __m512i* cv_r) {
	cv_l[0] = XOR(cv_l[0], cv_r[0]);
}

static INLINE void get_hash(__m512i* cv_l, uint8_t* digest) {
	uint8_t hash_val[DIGEST_LEN];
	STORE(hash_val, cv_l[0]);
	memcpy(digest, hash_val, DIGEST_LEN);
}

/* ------------------------------------------ *
*  LSH: step function
*  ------------------------------------------ */
static INLINE void compress(__m512i* cv_l, __m512i* cv_r, const uint64_t pdMsgBlk[BLOCK_WORD_LEN]) {
	__m512i const_v[1];
	__m512i byte_perm_step[1];
	__m512i word_perm_step[2];
	LSH512AVX512_internal i_state[1];
	int i;

	byte_perm_step[0] = LOAD(BytePermu);
	word_perm_step[0] = LOAD(wordPermu);
	word_perm_step[1] = LOAD(wordPermu + 1);

	load_msg_blk(i_state, pdMsgBlk);

	msg_add_even(cv_l, cv_r, i_state);
	load_sc(const_v, 0);
	mix_even(cv_l, cv_r, const_v, byte_perm_step);
	word_perm(cv_l, cv_r, word_perm_step);

	msg_add_odd(cv_l, cv_r, i_state);
	load_sc(const_v, 8);
	mix_odd(cv_l, cv_r, const_v, byte_perm_step);
	word_perm(cv_l, cv_r, word_perm_step);

	for (i = 1; i < STEP_NUM / 2; i++) {
		msg_exp_even(i_state);
		msg_add_even(cv_l, cv_r, i_state);
		load_sc(const_v, 16 * i);
		mix_even(cv_l, cv_r, const_v, byte_perm_step);
		word_perm(cv_l, cv_r, word_perm_step);

		msg_exp_odd(i_state);
		msg_add_odd(cv_l, cv_r, i_state);
		load_sc(const_v, 16 * i + 8);
		mix_odd(cv_l, cv_r, const_v, byte_perm_step);
		word_perm(cv_l, cv_r, word_perm_step);
	}
	msg_exp_even(i_state);
	msg_add_even(cv_l, cv_r, i_state);
}

void lsh512_init(LSH512_context* ctx) {
	memset(ctx->last_block, 0, MSG_BLK_BYTE_LEN);
	ctx->remain_byte = 0;
	load_blk(ctx->cv_l, IV512);
	load_blk(ctx->cv_r, IV512 + 8);
}

void lsh512_process(const uint8_t* pt, uint64_t ptLen, LSH512_context* ctx) {
	uint64_t pt_index = 0;
	while ((ptLen + ctx->remain_byte) >= MSG_BLK_BYTE_LEN) {
		memcpy(ctx->last_block + ctx->remain_byte, pt + pt_index, MSG_BLK_BYTE_LEN - ctx->remain_byte);
		compress(ctx->cv_l, ctx->cv_r, (uint64_t*)(ctx->last_block));
		ptLen -= (MSG_BLK_BYTE_LEN - ctx->remain_byte);
		pt_index += (MSG_BLK_BYTE_LEN - ctx->remain_byte);
		ctx->remain_byte = 0;
	}
	memcpy(ctx->last_block + ctx->remain_byte, pt, ctx->remain_byte + ptLen);
	ctx->remain_byte = ctx->remain_byte + ptLen;
}

void lsh512_final(uint8_t* digest, LSH512_context* ctx) {
	uint64_t R = (ctx->remain_byte) % MSG_BLK_BYTE_LEN;
	ctx->last_block[R++] = 0x80;
	memset(ctx->last_block + R, 0, MSG_BLK_BYTE_LEN - R);
	compress(ctx->cv_l, ctx->cv_r, (uint64_t*)(ctx->last_block));
	fin(ctx->cv_l, ctx->cv_r);
	get_hash(ctx->cv_l, digest);
}

void lsh512_avx512(uint8_t* data, uint64_t size, uint8_t* digest) {
	LSH512_context ctx;
	lsh512_init(&ctx);
	lsh512_process(data, size, &ctx);
	lsh512_final(digest, &ctx);
}

int main() {
	uint8_t test_data[3] = { 0x61, 0x62, 0x63 };
	uint8_t test_digest[64] = { 0, };
	lsh512_avx512(test_data, 3, test_digest);

	return 0;
}