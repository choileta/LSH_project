#include "lsh512.cuh"

__device__ void lsh512_core(uint64_t* state, uint64_t* hash) {
	asm("{\n\t"
		//Setting parameters
		".reg.u64               e_l<8>;		\n\t"
		".reg.u64               e_r<8>;		\n\t"
		".reg.u64               o_l<8>;		\n\t"
		".reg.u64               o_r<8>;		\n\t"
		".reg.u64               cv_l<8>;	\n\t"
		".reg.u64               cv_r<8>;	\n\t"
		".reg.u64				tmp<1>;		\n\t"

		//hash value copy
		"mov.u64 	            cv_l0,        %16;	\n\t"
		"mov.u64 	            cv_l1,        %17;	\n\t"
		"mov.u64 	            cv_l2,        %18;	\n\t"
		"mov.u64 	            cv_l3,        %19;	\n\t"
		"mov.u64 	            cv_l4,        %20;	\n\t"
		"mov.u64 	            cv_l5,        %21;	\n\t"
		"mov.u64 	            cv_l6,        %22;	\n\t"
		"mov.u64 	            cv_l7,        %23;	\n\t"

		"mov.u64 	            cv_r0,        %24;	\n\t"
		"mov.u64 	            cv_r1,        %25;	\n\t"
		"mov.u64 	            cv_r2,        %26;	\n\t"
		"mov.u64 	            cv_r3,        %27;	\n\t"
		"mov.u64 	            cv_r4,        %28;	\n\t"
		"mov.u64 	            cv_r5,        %29;	\n\t"
		"mov.u64 	            cv_r6,        %30;	\n\t"
		"mov.u64 	            cv_r7,        %31;	\n\t"
		//data value copy
		"mov.u64 	            e_l0,			%32;	\n\t"
		"mov.u64 	            e_l1,			%33;	\n\t"
		"mov.u64 	            e_l2,			%34;	\n\t"
		"mov.u64 	            e_l3,			%35;	\n\t"
		"mov.u64 	            e_l4,			%36;	\n\t"
		"mov.u64 	            e_l5,			%37;	\n\t"
		"mov.u64 	            e_l6,			%38;	\n\t"
		"mov.u64 	            e_l7,			%39;	\n\t"
		"mov.u64 	            e_r0,			%40;	\n\t"
		"mov.u64 	            e_r1,			%41;	\n\t"
		"mov.u64 	            e_r2,			%42;	\n\t"
		"mov.u64 	            e_r3,			%43;	\n\t"
		"mov.u64 	            e_r4,			%44;	\n\t"
		"mov.u64 	            e_r5,			%45;	\n\t"
		"mov.u64 	            e_r6,			%46;	\n\t"
		"mov.u64 	            e_r7,			%47;	\n\t"
		"mov.u64 	            o_l0,			%48;	\n\t"
		"mov.u64 	            o_l1,			%49;	\n\t"
		"mov.u64 	            o_l2,			%50;	\n\t"
		"mov.u64 	            o_l3,			%51;	\n\t"
		"mov.u64 	            o_l4,			%52;	\n\t"
		"mov.u64 	            o_l5,			%53;	\n\t"
		"mov.u64 	            o_l6,			%54;	\n\t"
		"mov.u64 	            o_l7,			%55;	\n\t"
		"mov.u64 	            o_r0,			%56;	\n\t"
		"mov.u64 	            o_r1,			%57;	\n\t"
		"mov.u64 	            o_r2,			%58;	\n\t"
		"mov.u64 	            o_r3,			%59;	\n\t"
		"mov.u64 	            o_r4,			%60;	\n\t"
		"mov.u64 	            o_r5,			%61;	\n\t"
		"mov.u64 	            o_r6,			%62;	\n\t"
		"mov.u64 	            o_r7,			%63;	\n\t"

		//! MSG_ADD_EVEN
		"xor.b64				cv_l0, e_l0, cv_l0;	\n\t"
		"xor.b64				cv_l1, e_l1, cv_l1;	\n\t"
		"xor.b64				cv_l2, e_l2, cv_l2;	\n\t"
		"xor.b64				cv_l3, e_l3, cv_l3;	\n\t"
		"xor.b64				cv_l4, e_l4, cv_l4;	\n\t"
		"xor.b64				cv_l5, e_l5, cv_l5;	\n\t"
		"xor.b64				cv_l6, e_l6, cv_l6;	\n\t"
		"xor.b64				cv_l7, e_l7, cv_l7;	\n\t"
		"xor.b64				cv_r0, e_r0, cv_r0;	\n\t"
		"xor.b64				cv_r1, e_r1, cv_r1;	\n\t"
		"xor.b64				cv_r2, e_r2, cv_r2;	\n\t"
		"xor.b64				cv_r3, e_r3, cv_r3;	\n\t"
		"xor.b64				cv_r4, e_r4, cv_r4;	\n\t"
		"xor.b64				cv_r5, e_r5, cv_r5;	\n\t"
		"xor.b64				cv_r6, e_r6, cv_r6;	\n\t"
		"xor.b64				cv_r7, e_r7, cv_r7;	\n\t"
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//MIX(even)
		//rotate_blk(cv_l, 23)
		"shl.b64				tmp0,	cv_l0,	23;\n\t"
		"shr.b64				cv_l0,	cv_l0,	41;\n\t"
		"or.b64					cv_l0,	tmp0,	cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	23;\n\t"
		"shr.b64				cv_l1,	cv_l1,	41;\n\t"
		"or.b64					cv_l1,	tmp0,	cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	23;\n\t"
		"shr.b64				cv_l2,	cv_l2,	41;\n\t"
		"or.b64					cv_l2,	tmp0,	cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	23;\n\t"
		"shr.b64				cv_l3,	cv_l3,	41;\n\t"
		"or.b64					cv_l3,	tmp0,	cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	23;\n\t"
		"shr.b64				cv_l4,	cv_l4,	41;\n\t"
		"or.b64					cv_l4,	tmp0,	cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	23;\n\t"
		"shr.b64				cv_l5,	cv_l5,	41;\n\t"
		"or.b64					cv_l5,	tmp0,	cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	23;\n\t"
		"shr.b64				cv_l6,	cv_l6,	41;\n\t"
		"or.b64					cv_l6,	tmp0,	cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	23;\n\t"
		"shr.b64				cv_l7,	cv_l7,	41;\n\t"
		"or.b64					cv_l7,	tmp0,	cv_l7;\n\t"
		//xor_with_const
		"xor.b64				cv_l0, cv_l0, 0x97884283c938982a;\n\t"
		"xor.b64				cv_l1, cv_l1, 0xba1fca93533e2355;\n\t"
		"xor.b64				cv_l2, cv_l2, 0xc519a2e87aeb1c03;\n\t"
		"xor.b64				cv_l3, cv_l3, 0x9a0fc95462af17b1;\n\t"
		"xor.b64				cv_l4, cv_l4, 0xfc3dda8ab019a82b;\n\t"
		"xor.b64				cv_l5, cv_l5, 0x02825d079a895407;\n\t"
		"xor.b64				cv_l6, cv_l6, 0x79f2d0a7ee06a6f7;\n\t"
		"xor.b64				cv_l7, cv_l7, 0xd76d15eed9fdf5fe;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 59)
		"shl.b64				tmp0,	cv_r0,	59;\n\t"
		"shr.b64				cv_r0,	cv_r0,	5;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	59;\n\t"
		"shr.b64				cv_r1,	cv_r1,	5;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	59;\n\t"
		"shr.b64				cv_r2,	cv_r2,	5;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	59;\n\t"
		"shr.b64				cv_r3,	cv_r3,	5;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	59;\n\t"
		"shr.b64				cv_r4,	cv_r4,	5;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	59;\n\t"
		"shr.b64				cv_r5,	cv_r5,	5;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	59;\n\t"
		"shr.b64				cv_r6,	cv_r6,	5;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	59;\n\t"
		"shr.b64				cv_r7,	cv_r7,	5;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"
		//!msg_add_odd(cv_l, cv_r, i_state)
		"xor.b64				cv_l0, o_l0, cv_l0;\n\t"
		"xor.b64				cv_l1, o_l1, cv_l1;\n\t"
		"xor.b64				cv_l2, o_l2, cv_l2;\n\t"
		"xor.b64				cv_l3, o_l3, cv_l3;\n\t"
		"xor.b64				cv_l4, o_l4, cv_l4;\n\t"
		"xor.b64				cv_l5, o_l5, cv_l5;\n\t"
		"xor.b64				cv_l6, o_l6, cv_l6;\n\t"
		"xor.b64				cv_l7, o_l7, cv_l7;\n\t"
		"xor.b64				cv_r0, o_r0, cv_r0;\n\t"
		"xor.b64				cv_r1, o_r1, cv_r1;\n\t"
		"xor.b64				cv_r2, o_r2, cv_r2;\n\t"
		"xor.b64				cv_r3, o_r3, cv_r3;\n\t"
		"xor.b64				cv_r4, o_r4, cv_r4;\n\t"
		"xor.b64				cv_r5, o_r5, cv_r5;\n\t"
		"xor.b64				cv_r6, o_r6, cv_r6;\n\t"
		"xor.b64				cv_r7, o_r7, cv_r7;\n\t"
		//!MIX(odd)
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_l, 7)
		"shl.b64				tmp0,	cv_l0,	7;\n\t"
		"shr.b64				cv_l0,	cv_l0,	57;\n\t"
		"or.b64					cv_l0,  tmp0, cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	7;\n\t"
		"shr.b64				cv_l1,	cv_l1,	57;\n\t"
		"or.b64					cv_l1,  tmp0, cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	7;\n\t"
		"shr.b64				cv_l2,	cv_l2,	57;\n\t"
		"or.b64					cv_l2,  tmp0, cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	7;\n\t"
		"shr.b64				cv_l3,	cv_l3,	57;\n\t"
		"or.b64					cv_l3,  tmp0, cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	7;\n\t"
		"shr.b64				cv_l4,	cv_l4,	57;\n\t"
		"or.b64					cv_l4,  tmp0, cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	7;\n\t"
		"shr.b64				cv_l5,	cv_l5,	57;\n\t"
		"or.b64					cv_l5,  tmp0, cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	7;\n\t"
		"shr.b64				cv_l6,	cv_l6,	57;\n\t"
		"or.b64					cv_l6,  tmp0, cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	7;\n\t"
		"shr.b64				cv_l7,	cv_l7,	57;\n\t"
		"or.b64					cv_l7,  tmp0, cv_l7;\n\t"
		//xor with const
		"xor.b64				cv_l0, cv_l0, 0x1fcac64d01d0c2c1;\n\t"
		"xor.b64				cv_l1, cv_l1, 0xd9ea5de69161790f;\n\t"
		"xor.b64				cv_l2, cv_l2, 0xdebc8b6366071fc8;\n\t"
		"xor.b64				cv_l3, cv_l3, 0xa9d91db711c6c94b;\n\t"
		"xor.b64				cv_l4, cv_l4, 0x3a18653ac9c1d427;\n\t"
		"xor.b64				cv_l5, cv_l5, 0x84df64a223dd5b09;\n\t"
		"xor.b64				cv_l6, cv_l6, 0x6cc37895f4ad9e70;\n\t"
		"xor.b64				cv_l7, cv_l7, 0x448304c8d7f3f4d5;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 3)
		"shl.b64				tmp0,	cv_r0,	3;\n\t"
		"shr.b64				cv_r0,	cv_r0,	61;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	3;\n\t"
		"shr.b64				cv_r1,	cv_r1,	61;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	3;\n\t"
		"shr.b64				cv_r2,	cv_r2,	61;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	3;\n\t"
		"shr.b64				cv_r3,	cv_r3,	61;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	3;\n\t"
		"shr.b64				cv_r4,	cv_r4,	61;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	3;\n\t"
		"shr.b64				cv_r5,	cv_r5,	61;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	3;\n\t"
		"shr.b64				cv_r6,	cv_r6,	61;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	3;\n\t"
		"shr.b64				cv_r7,	cv_r7,	61;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"
		//!loop start
		//!MsgExp
		"mov.b64 	            tmp0, e_l0;\n\t"
		"add.u64				e_l0, o_l0, e_l3;\n\t"
		"add.u64				e_l3, o_l3, e_l1;\n\t"
		"add.u64				e_l1, o_l1, e_l2;\n\t"
		"add.u64				e_l2, o_l2, tmp0;\n\t"
		"mov.b64 	            tmp0, e_l4;\n\t"
		"add.u64				e_l4, o_l4, e_l7;\n\t"
		"add.u64				e_l7, o_l7, e_l6;\n\t"
		"add.u64				e_l6, o_l6, e_l5;\n\t"
		"add.u64				e_l5, o_l5, tmp0;\n\t"
		"mov.b64 	            tmp0, e_r0;\n\t"
		"add.u64				e_r0, o_r0, e_r3;\n\t"
		"add.u64				e_r3, o_r3, e_r1;\n\t"
		"add.u64				e_r1, o_r1, e_r2;\n\t"
		"add.u64				e_r2, o_r2, tmp0;\n\t"
		"mov.b64 	            tmp0, e_r4;\n\t"
		"add.u64				e_r4, o_r4, e_r7;\n\t"
		"add.u64				e_r7, o_r7, e_r6;\n\t"
		"add.u64				e_r6, o_r6, e_r5;\n\t"
		"add.u64				e_r5, o_r5, tmp0;\n\t"
		//! msg_add_even(i_state)
		"xor.b64				cv_l0, e_l0, cv_l0;\n\t"
		"xor.b64				cv_l1, e_l1, cv_l1;\n\t"
		"xor.b64				cv_l2, e_l2, cv_l2;\n\t"
		"xor.b64				cv_l3, e_l3, cv_l3;\n\t"
		"xor.b64				cv_l4, e_l4, cv_l4;\n\t"
		"xor.b64				cv_l5, e_l5, cv_l5;\n\t"
		"xor.b64				cv_l6, e_l6, cv_l6;\n\t"
		"xor.b64				cv_l7, e_l7, cv_l7;\n\t"
		"xor.b64				cv_r0, e_r0, cv_r0;\n\t"
		"xor.b64				cv_r1, e_r1, cv_r1;\n\t"
		"xor.b64				cv_r2, e_r2, cv_r2;\n\t"
		"xor.b64				cv_r3, e_r3, cv_r3;\n\t"
		"xor.b64				cv_r4, e_r4, cv_r4;\n\t"
		"xor.b64				cv_r5, e_r5, cv_r5;\n\t"
		"xor.b64				cv_r6, e_r6, cv_r6;\n\t"
		"xor.b64				cv_r7, e_r7, cv_r7;\n\t"

		//MIX(even)
		//rotate_blk(cv_l, 23)
		"shl.b64				tmp0,	cv_l0,	23;\n\t"
		"shr.b64				cv_l0,	cv_l0,	41;\n\t"
		"or.b64					cv_l0,	tmp0,	cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	23;\n\t"
		"shr.b64				cv_l1,	cv_l1,	41;\n\t"
		"or.b64					cv_l1,	tmp0,	cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	23;\n\t"
		"shr.b64				cv_l2,	cv_l2,	41;\n\t"
		"or.b64					cv_l2,	tmp0,	cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	23;\n\t"
		"shr.b64				cv_l3,	cv_l3,	41;\n\t"
		"or.b64					cv_l3,	tmp0,	cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	23;\n\t"
		"shr.b64				cv_l4,	cv_l4,	41;\n\t"
		"or.b64					cv_l4,	tmp0,	cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	23;\n\t"
		"shr.b64				cv_l5,	cv_l5,	41;\n\t"
		"or.b64					cv_l5,	tmp0,	cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	23;\n\t"
		"shr.b64				cv_l6,	cv_l6,	41;\n\t"
		"or.b64					cv_l6,	tmp0,	cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	23;\n\t"
		"shr.b64				cv_l7,	cv_l7,	41;\n\t"
		"or.b64					cv_l7,	tmp0,	cv_l7;\n\t"
		//xor_with_const
		"xor.b64				cv_l0, cv_l0, 0xea91134ed29383e0;\n\t"
		"xor.b64				cv_l1, cv_l1, 0xc4484477f2da88e8;\n\t"
		"xor.b64				cv_l2, cv_l2, 0x9b47eec96d26e8a6;\n\t"
		"xor.b64				cv_l3, cv_l3, 0x82f6d4c8d89014f4;\n\t"
		"xor.b64				cv_l4, cv_l4, 0x527da0048b95fb61;\n\t"
		"xor.b64				cv_l5, cv_l5, 0x644406c60138648d;\n\t"
		"xor.b64				cv_l6, cv_l6, 0x303c0e8aa24c0edc;\n\t"
		"xor.b64				cv_l7, cv_l7, 0xc787cda0cbe8ca19;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 59)
		"shl.b64				tmp0,	cv_r0,	59;\n\t"
		"shr.b64				cv_r0,	cv_r0,	5;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	59;\n\t"
		"shr.b64				cv_r1,	cv_r1,	5;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	59;\n\t"
		"shr.b64				cv_r2,	cv_r2,	5;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	59;\n\t"
		"shr.b64				cv_r3,	cv_r3,	5;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	59;\n\t"
		"shr.b64				cv_r4,	cv_r4,	5;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	59;\n\t"
		"shr.b64				cv_r5,	cv_r5,	5;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	59;\n\t"
		"shr.b64				cv_r6,	cv_r6,	5;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	59;\n\t"
		"shr.b64				cv_r7,	cv_r7,	5;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"
		//!MsgExp(odd)
		"mov.b64 	            tmp0, o_l0;\n\t"
		"add.u64				o_l0, e_l0, o_l3;\n\t"
		"add.u64				o_l3, e_l3, o_l1;\n\t"
		"add.u64				o_l1, e_l1, o_l2;\n\t"
		"add.u64				o_l2, e_l2, tmp0;\n\t"
		"mov.b64 	            tmp0, o_l4;\n\t"
		"add.u64				o_l4, e_l4, o_l7;\n\t"
		"add.u64				o_l7, e_l7, o_l6;\n\t"
		"add.u64				o_l6, e_l6, o_l5;\n\t"
		"add.u64				o_l5, e_l5, tmp0;\n\t"
		"mov.b64 	            tmp0, o_r0;\n\t"
		"add.u64				o_r0, e_r0, o_r3;\n\t"
		"add.u64				o_r3, e_r3, o_r1;\n\t"
		"add.u64				o_r1, e_r1, o_r2;\n\t"
		"add.u64				o_r2, e_r2, tmp0;\n\t"
		"mov.b64 	            tmp0, o_r4;\n\t"
		"add.u64				o_r4, e_r4, o_r7;\n\t"
		"add.u64				o_r7, e_r7, o_r6;\n\t"
		"add.u64				o_r6, e_r6, o_r5;\n\t"
		"add.u64				o_r5, e_r5, tmp0;\n\t"
		//!msg_add_odd(cv_l, cv_r, i_state)
		"xor.b64				cv_l0, o_l0, cv_l0;\n\t"
		"xor.b64				cv_l1, o_l1, cv_l1;\n\t"
		"xor.b64				cv_l2, o_l2, cv_l2;\n\t"
		"xor.b64				cv_l3, o_l3, cv_l3;\n\t"
		"xor.b64				cv_l4, o_l4, cv_l4;\n\t"
		"xor.b64				cv_l5, o_l5, cv_l5;\n\t"
		"xor.b64				cv_l6, o_l6, cv_l6;\n\t"
		"xor.b64				cv_l7, o_l7, cv_l7;\n\t"
		"xor.b64				cv_r0, o_r0, cv_r0;\n\t"
		"xor.b64				cv_r1, o_r1, cv_r1;\n\t"
		"xor.b64				cv_r2, o_r2, cv_r2;\n\t"
		"xor.b64				cv_r3, o_r3, cv_r3;\n\t"
		"xor.b64				cv_r4, o_r4, cv_r4;\n\t"
		"xor.b64				cv_r5, o_r5, cv_r5;\n\t"
		"xor.b64				cv_r6, o_r6, cv_r6;\n\t"
		"xor.b64				cv_r7, o_r7, cv_r7;\n\t"
		//!MIX(odd)
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_l, 7)
		"shl.b64				tmp0,	cv_l0,	7;\n\t"
		"shr.b64				cv_l0,	cv_l0,	57;\n\t"
		"or.b64					cv_l0,  tmp0, cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	7;\n\t"
		"shr.b64				cv_l1,	cv_l1,	57;\n\t"
		"or.b64					cv_l1,  tmp0, cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	7;\n\t"
		"shr.b64				cv_l2,	cv_l2,	57;\n\t"
		"or.b64					cv_l2,  tmp0, cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	7;\n\t"
		"shr.b64				cv_l3,	cv_l3,	57;\n\t"
		"or.b64					cv_l3,  tmp0, cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	7;\n\t"
		"shr.b64				cv_l4,	cv_l4,	57;\n\t"
		"or.b64					cv_l4,  tmp0, cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	7;\n\t"
		"shr.b64				cv_l5,	cv_l5,	57;\n\t"
		"or.b64					cv_l5,  tmp0, cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	7;\n\t"
		"shr.b64				cv_l6,	cv_l6,	57;\n\t"
		"or.b64					cv_l6,  tmp0, cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	7;\n\t"
		"shr.b64				cv_l7,	cv_l7,	57;\n\t"
		"or.b64					cv_l7,  tmp0, cv_l7;\n\t"
		//xor with const
		"xor.b64				cv_l0, cv_l0, 0x7ba46221661764ca;\n\t"
		"xor.b64				cv_l1, cv_l1, 0x0c8cbc6acd6371ac;\n\t"
		"xor.b64				cv_l2, cv_l2, 0xe336b836940f8f41;\n\t"
		"xor.b64				cv_l3, cv_l3, 0x79cb9da168a50976;\n\t"
		"xor.b64				cv_l4, cv_l4, 0xd01da49021915cb3;\n\t"
		"xor.b64				cv_l5, cv_l5, 0xa84accc7399cf1f1;\n\t"
		"xor.b64				cv_l6, cv_l6, 0x6c4a992cee5aeb0c;\n\t"
		"xor.b64				cv_l7, cv_l7, 0x4f556e6cb4b2e3e0;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 3)
		"shl.b64				tmp0,	cv_r0,	3;\n\t"
		"shr.b64				cv_r0,	cv_r0,	61;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	3;\n\t"
		"shr.b64				cv_r1,	cv_r1,	61;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	3;\n\t"
		"shr.b64				cv_r2,	cv_r2,	61;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	3;\n\t"
		"shr.b64				cv_r3,	cv_r3,	61;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	3;\n\t"
		"shr.b64				cv_r4,	cv_r4,	61;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	3;\n\t"
		"shr.b64				cv_r5,	cv_r5,	61;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	3;\n\t"
		"shr.b64				cv_r6,	cv_r6,	61;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	3;\n\t"
		"shr.b64				cv_r7,	cv_r7,	61;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"

		//MIX(even)
		//rotate_blk(cv_l, 23)
		"shl.b64				tmp0,	cv_l0,	23;\n\t"
		"shr.b64				cv_l0,	cv_l0,	41;\n\t"
		"or.b64					cv_l0,	tmp0,	cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	23;\n\t"
		"shr.b64				cv_l1,	cv_l1,	41;\n\t"
		"or.b64					cv_l1,	tmp0,	cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	23;\n\t"
		"shr.b64				cv_l2,	cv_l2,	41;\n\t"
		"or.b64					cv_l2,	tmp0,	cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	23;\n\t"
		"shr.b64				cv_l3,	cv_l3,	41;\n\t"
		"or.b64					cv_l3,	tmp0,	cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	23;\n\t"
		"shr.b64				cv_l4,	cv_l4,	41;\n\t"
		"or.b64					cv_l4,	tmp0,	cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	23;\n\t"
		"shr.b64				cv_l5,	cv_l5,	41;\n\t"
		"or.b64					cv_l5,	tmp0,	cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	23;\n\t"
		"shr.b64				cv_l6,	cv_l6,	41;\n\t"
		"or.b64					cv_l6,	tmp0,	cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	23;\n\t"
		"shr.b64				cv_l7,	cv_l7,	41;\n\t"
		"or.b64					cv_l7,	tmp0,	cv_l7;\n\t"
		//xor_with_const
		"xor.b64				cv_l0, cv_l0, 0x200683877d7c2f45;\n\t"
		"xor.b64				cv_l1, cv_l1, 0x9949273830d51db8;\n\t"
		"xor.b64				cv_l2, cv_l2, 0x19eeeecaa39ed124;\n\t"
		"xor.b64				cv_l3, cv_l3, 0x45693f0a0dae7fef;\n\t"
		"xor.b64				cv_l4, cv_l4, 0xedc234b1b2ee1083;\n\t"
		"xor.b64				cv_l5, cv_l5, 0xf3179400d68ee399;\n\t"
		"xor.b64				cv_l6, cv_l6, 0xb6e3c61b4945f778;\n\t"
		"xor.b64				cv_l7, cv_l7, 0xa4c3db216796c42f;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 59)
		"shl.b64				tmp0,	cv_r0,	59;\n\t"
		"shr.b64				cv_r0,	cv_r0,	5;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	59;\n\t"
		"shr.b64				cv_r1,	cv_r1,	5;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	59;\n\t"
		"shr.b64				cv_r2,	cv_r2,	5;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	59;\n\t"
		"shr.b64				cv_r3,	cv_r3,	5;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	59;\n\t"
		"shr.b64				cv_r4,	cv_r4,	5;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	59;\n\t"
		"shr.b64				cv_r5,	cv_r5,	5;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	59;\n\t"
		"shr.b64				cv_r6,	cv_r6,	5;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	59;\n\t"
		"shr.b64				cv_r7,	cv_r7,	5;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"
		//!MsgExp(odd)
		"mov.b64 	            tmp0, o_l0;\n\t"
		"add.u64				o_l0, e_l0, o_l3;\n\t"
		"add.u64				o_l3, e_l3, o_l1;\n\t"
		"add.u64				o_l1, e_l1, o_l2;\n\t"
		"add.u64				o_l2, e_l2, tmp0;\n\t"
		"mov.b64 	            tmp0, o_l4;\n\t"
		"add.u64				o_l4, e_l4, o_l7;\n\t"
		"add.u64				o_l7, e_l7, o_l6;\n\t"
		"add.u64				o_l6, e_l6, o_l5;\n\t"
		"add.u64				o_l5, e_l5, tmp0;\n\t"
		"mov.b64 	            tmp0, o_r0;\n\t"
		"add.u64				o_r0, e_r0, o_r3;\n\t"
		"add.u64				o_r3, e_r3, o_r1;\n\t"
		"add.u64				o_r1, e_r1, o_r2;\n\t"
		"add.u64				o_r2, e_r2, tmp0;\n\t"
		"mov.b64 	            tmp0, o_r4;\n\t"
		"add.u64				o_r4, e_r4, o_r7;\n\t"
		"add.u64				o_r7, e_r7, o_r6;\n\t"
		"add.u64				o_r6, e_r6, o_r5;\n\t"
		"add.u64				o_r5, e_r5, tmp0;\n\t"
		//!msg_add_odd(cv_l, cv_r, i_state)
		"xor.b64				cv_l0, o_l0, cv_l0;\n\t"
		"xor.b64				cv_l1, o_l1, cv_l1;\n\t"
		"xor.b64				cv_l2, o_l2, cv_l2;\n\t"
		"xor.b64				cv_l3, o_l3, cv_l3;\n\t"
		"xor.b64				cv_l4, o_l4, cv_l4;\n\t"
		"xor.b64				cv_l5, o_l5, cv_l5;\n\t"
		"xor.b64				cv_l6, o_l6, cv_l6;\n\t"
		"xor.b64				cv_l7, o_l7, cv_l7;\n\t"
		"xor.b64				cv_r0, o_r0, cv_r0;\n\t"
		"xor.b64				cv_r1, o_r1, cv_r1;\n\t"
		"xor.b64				cv_r2, o_r2, cv_r2;\n\t"
		"xor.b64				cv_r3, o_r3, cv_r3;\n\t"
		"xor.b64				cv_r4, o_r4, cv_r4;\n\t"
		"xor.b64				cv_r5, o_r5, cv_r5;\n\t"
		"xor.b64				cv_r6, o_r6, cv_r6;\n\t"
		"xor.b64				cv_r7, o_r7, cv_r7;\n\t"
		//!MIX(odd)
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_l, 7)
		"shl.b64				tmp0,	cv_l0,	7;\n\t"
		"shr.b64				cv_l0,	cv_l0,	57;\n\t"
		"or.b64					cv_l0,  tmp0, cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	7;\n\t"
		"shr.b64				cv_l1,	cv_l1,	57;\n\t"
		"or.b64					cv_l1,  tmp0, cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	7;\n\t"
		"shr.b64				cv_l2,	cv_l2,	57;\n\t"
		"or.b64					cv_l2,  tmp0, cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	7;\n\t"
		"shr.b64				cv_l3,	cv_l3,	57;\n\t"
		"or.b64					cv_l3,  tmp0, cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	7;\n\t"
		"shr.b64				cv_l4,	cv_l4,	57;\n\t"
		"or.b64					cv_l4,  tmp0, cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	7;\n\t"
		"shr.b64				cv_l5,	cv_l5,	57;\n\t"
		"or.b64					cv_l5,  tmp0, cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	7;\n\t"
		"shr.b64				cv_l6,	cv_l6,	57;\n\t"
		"or.b64					cv_l6,  tmp0, cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	7;\n\t"
		"shr.b64				cv_l7,	cv_l7,	57;\n\t"
		"or.b64					cv_l7,  tmp0, cv_l7;\n\t"
		//xor with const
		"xor.b64				cv_l0, cv_l0, 0x268a0b04f9ab7465;\n\t"
		"xor.b64				cv_l1, cv_l1, 0xe2705f6905f2d651;\n\t"
		"xor.b64				cv_l2, cv_l2, 0x08ddb96e426ff53d;\n\t"
		"xor.b64				cv_l3, cv_l3, 0xaea84917bc2e6f34;\n\t"
		"xor.b64				cv_l4, cv_l4, 0xaff6e664a0fe9470;\n\t"
		"xor.b64				cv_l5, cv_l5, 0x0aab94d765727d8c;\n\t"
		"xor.b64				cv_l6, cv_l6, 0x9aa9e1648f3d702e;\n\t"
		"xor.b64				cv_l7, cv_l7, 0x689efc88fe5af3d3;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 3)
		"shl.b64				tmp0,	cv_r0,	3;\n\t"
		"shr.b64				cv_r0,	cv_r0,	61;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	3;\n\t"
		"shr.b64				cv_r1,	cv_r1,	61;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	3;\n\t"
		"shr.b64				cv_r2,	cv_r2,	61;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	3;\n\t"
		"shr.b64				cv_r3,	cv_r3,	61;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	3;\n\t"
		"shr.b64				cv_r4,	cv_r4,	61;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	3;\n\t"
		"shr.b64				cv_r5,	cv_r5,	61;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	3;\n\t"
		"shr.b64				cv_r6,	cv_r6,	61;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	3;\n\t"
		"shr.b64				cv_r7,	cv_r7,	61;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"

		//MIX(even)
		//rotate_blk(cv_l, 23)
		"shl.b64				tmp0,	cv_l0,	23;\n\t"
		"shr.b64				cv_l0,	cv_l0,	41;\n\t"
		"or.b64					cv_l0,	tmp0,	cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	23;\n\t"
		"shr.b64				cv_l1,	cv_l1,	41;\n\t"
		"or.b64					cv_l1,	tmp0,	cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	23;\n\t"
		"shr.b64				cv_l2,	cv_l2,	41;\n\t"
		"or.b64					cv_l2,	tmp0,	cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	23;\n\t"
		"shr.b64				cv_l3,	cv_l3,	41;\n\t"
		"or.b64					cv_l3,	tmp0,	cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	23;\n\t"
		"shr.b64				cv_l4,	cv_l4,	41;\n\t"
		"or.b64					cv_l4,	tmp0,	cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	23;\n\t"
		"shr.b64				cv_l5,	cv_l5,	41;\n\t"
		"or.b64					cv_l5,	tmp0,	cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	23;\n\t"
		"shr.b64				cv_l6,	cv_l6,	41;\n\t"
		"or.b64					cv_l6,	tmp0,	cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	23;\n\t"
		"shr.b64				cv_l7,	cv_l7,	41;\n\t"
		"or.b64					cv_l7,	tmp0,	cv_l7;\n\t"
		//xor_with_const
		"xor.b64				cv_l0, cv_l0, 0xb0950ffea51fd98b;\n\t"
		"xor.b64				cv_l1, cv_l1, 0x52cfc86ef8c92833;\n\t"
		"xor.b64				cv_l2, cv_l2, 0xe69727b0b2653245;\n\t"
		"xor.b64				cv_l3, cv_l3, 0x56f160d3ea9da3e2;\n\t"
		"xor.b64				cv_l4, cv_l4, 0xa6dd4b059f93051f;\n\t"
		"xor.b64				cv_l5, cv_l5, 0xb6406c3cd7f00996;\n\t"
		"xor.b64				cv_l6, cv_l6, 0x448b45f3ccad9ec8;\n\t"
		"xor.b64				cv_l7, cv_l7, 0x079b8587594ec73b;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 59)
		"shl.b64				tmp0,	cv_r0,	59;\n\t"
		"shr.b64				cv_r0,	cv_r0,	5;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	59;\n\t"
		"shr.b64				cv_r1,	cv_r1,	5;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	59;\n\t"
		"shr.b64				cv_r2,	cv_r2,	5;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	59;\n\t"
		"shr.b64				cv_r3,	cv_r3,	5;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	59;\n\t"
		"shr.b64				cv_r4,	cv_r4,	5;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	59;\n\t"
		"shr.b64				cv_r5,	cv_r5,	5;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	59;\n\t"
		"shr.b64				cv_r6,	cv_r6,	5;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	59;\n\t"
		"shr.b64				cv_r7,	cv_r7,	5;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"
		//!MsgExp(odd)
		"mov.b64 	            tmp0, o_l0;\n\t"
		"add.u64				o_l0, e_l0, o_l3;\n\t"
		"add.u64				o_l3, e_l3, o_l1;\n\t"
		"add.u64				o_l1, e_l1, o_l2;\n\t"
		"add.u64				o_l2, e_l2, tmp0;\n\t"
		"mov.b64 	            tmp0, o_l4;\n\t"
		"add.u64				o_l4, e_l4, o_l7;\n\t"
		"add.u64				o_l7, e_l7, o_l6;\n\t"
		"add.u64				o_l6, e_l6, o_l5;\n\t"
		"add.u64				o_l5, e_l5, tmp0;\n\t"
		"mov.b64 	            tmp0, o_r0;\n\t"
		"add.u64				o_r0, e_r0, o_r3;\n\t"
		"add.u64				o_r3, e_r3, o_r1;\n\t"
		"add.u64				o_r1, e_r1, o_r2;\n\t"
		"add.u64				o_r2, e_r2, tmp0;\n\t"
		"mov.b64 	            tmp0, o_r4;\n\t"
		"add.u64				o_r4, e_r4, o_r7;\n\t"
		"add.u64				o_r7, e_r7, o_r6;\n\t"
		"add.u64				o_r6, e_r6, o_r5;\n\t"
		"add.u64				o_r5, e_r5, tmp0;\n\t"
		//!msg_add_odd(cv_l, cv_r, i_state)
		"xor.b64				cv_l0, o_l0, cv_l0;\n\t"
		"xor.b64				cv_l1, o_l1, cv_l1;\n\t"
		"xor.b64				cv_l2, o_l2, cv_l2;\n\t"
		"xor.b64				cv_l3, o_l3, cv_l3;\n\t"
		"xor.b64				cv_l4, o_l4, cv_l4;\n\t"
		"xor.b64				cv_l5, o_l5, cv_l5;\n\t"
		"xor.b64				cv_l6, o_l6, cv_l6;\n\t"
		"xor.b64				cv_l7, o_l7, cv_l7;\n\t"
		"xor.b64				cv_r0, o_r0, cv_r0;\n\t"
		"xor.b64				cv_r1, o_r1, cv_r1;\n\t"
		"xor.b64				cv_r2, o_r2, cv_r2;\n\t"
		"xor.b64				cv_r3, o_r3, cv_r3;\n\t"
		"xor.b64				cv_r4, o_r4, cv_r4;\n\t"
		"xor.b64				cv_r5, o_r5, cv_r5;\n\t"
		"xor.b64				cv_r6, o_r6, cv_r6;\n\t"
		"xor.b64				cv_r7, o_r7, cv_r7;\n\t"
		//!MIX(odd)
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_l, 7)
		"shl.b64				tmp0,	cv_l0,	7;\n\t"
		"shr.b64				cv_l0,	cv_l0,	57;\n\t"
		"or.b64					cv_l0,  tmp0, cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	7;\n\t"
		"shr.b64				cv_l1,	cv_l1,	57;\n\t"
		"or.b64					cv_l1,  tmp0, cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	7;\n\t"
		"shr.b64				cv_l2,	cv_l2,	57;\n\t"
		"or.b64					cv_l2,  tmp0, cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	7;\n\t"
		"shr.b64				cv_l3,	cv_l3,	57;\n\t"
		"or.b64					cv_l3,  tmp0, cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	7;\n\t"
		"shr.b64				cv_l4,	cv_l4,	57;\n\t"
		"or.b64					cv_l4,  tmp0, cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	7;\n\t"
		"shr.b64				cv_l5,	cv_l5,	57;\n\t"
		"or.b64					cv_l5,  tmp0, cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	7;\n\t"
		"shr.b64				cv_l6,	cv_l6,	57;\n\t"
		"or.b64					cv_l6,  tmp0, cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	7;\n\t"
		"shr.b64				cv_l7,	cv_l7,	57;\n\t"
		"or.b64					cv_l7,  tmp0, cv_l7;\n\t"
		//xor with const
		"xor.b64				cv_l0, cv_l0, 0x45a50ea3c4f9653b;\n\t"
		"xor.b64				cv_l1, cv_l1, 0x22983767c1f15b85;\n\t"
		"xor.b64				cv_l2, cv_l2, 0x7dbed8631797782b;\n\t"
		"xor.b64				cv_l3, cv_l3, 0x485234be88418638;\n\t"
		"xor.b64				cv_l4, cv_l4, 0x842850a5329824c5;\n\t"
		"xor.b64				cv_l5, cv_l5, 0xf6aca914c7f9a04c;\n\t"
		"xor.b64				cv_l6, cv_l6, 0xcfd139c07a4c670c;\n\t"
		"xor.b64				cv_l7, cv_l7, 0xa3210ce0a8160242;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 3)
		"shl.b64				tmp0,	cv_r0,	3;\n\t"
		"shr.b64				cv_r0,	cv_r0,	61;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	3;\n\t"
		"shr.b64				cv_r1,	cv_r1,	61;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	3;\n\t"
		"shr.b64				cv_r2,	cv_r2,	61;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	3;\n\t"
		"shr.b64				cv_r3,	cv_r3,	61;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	3;\n\t"
		"shr.b64				cv_r4,	cv_r4,	61;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	3;\n\t"
		"shr.b64				cv_r5,	cv_r5,	61;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	3;\n\t"
		"shr.b64				cv_r6,	cv_r6,	61;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	3;\n\t"
		"shr.b64				cv_r7,	cv_r7,	61;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"

		//MIX(even)
		//rotate_blk(cv_l, 23)
		"shl.b64				tmp0,	cv_l0,	23;\n\t"
		"shr.b64				cv_l0,	cv_l0,	41;\n\t"
		"or.b64					cv_l0,	tmp0,	cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	23;\n\t"
		"shr.b64				cv_l1,	cv_l1,	41;\n\t"
		"or.b64					cv_l1,	tmp0,	cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	23;\n\t"
		"shr.b64				cv_l2,	cv_l2,	41;\n\t"
		"or.b64					cv_l2,	tmp0,	cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	23;\n\t"
		"shr.b64				cv_l3,	cv_l3,	41;\n\t"
		"or.b64					cv_l3,	tmp0,	cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	23;\n\t"
		"shr.b64				cv_l4,	cv_l4,	41;\n\t"
		"or.b64					cv_l4,	tmp0,	cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	23;\n\t"
		"shr.b64				cv_l5,	cv_l5,	41;\n\t"
		"or.b64					cv_l5,	tmp0,	cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	23;\n\t"
		"shr.b64				cv_l6,	cv_l6,	41;\n\t"
		"or.b64					cv_l6,	tmp0,	cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	23;\n\t"
		"shr.b64				cv_l7,	cv_l7,	41;\n\t"
		"or.b64					cv_l7,	tmp0,	cv_l7;\n\t"
		//xor_with_const
		"xor.b64				cv_l0, cv_l0, 0xeab3b268be5ea080;\n\t"
		"xor.b64				cv_l1, cv_l1, 0xbacf9f29b34ce0a7;\n\t"
		"xor.b64				cv_l2, cv_l2, 0x3c973b7aaf0fa3a8;\n\t"
		"xor.b64				cv_l3, cv_l3, 0x9a86f346c9c7be80;\n\t"
		"xor.b64				cv_l4, cv_l4, 0xac78f5d7cabcea49;\n\t"
		"xor.b64				cv_l5, cv_l5, 0xa355bddcc199ed42;\n\t"
		"xor.b64				cv_l6, cv_l6, 0xa10afa3ac6b373db;\n\t"
		"xor.b64				cv_l7, cv_l7, 0xc42ded88be1844e5;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 59)
		"shl.b64				tmp0,	cv_r0,	59;\n\t"
		"shr.b64				cv_r0,	cv_r0,	5;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	59;\n\t"
		"shr.b64				cv_r1,	cv_r1,	5;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	59;\n\t"
		"shr.b64				cv_r2,	cv_r2,	5;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	59;\n\t"
		"shr.b64				cv_r3,	cv_r3,	5;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	59;\n\t"
		"shr.b64				cv_r4,	cv_r4,	5;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	59;\n\t"
		"shr.b64				cv_r5,	cv_r5,	5;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	59;\n\t"
		"shr.b64				cv_r6,	cv_r6,	5;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	59;\n\t"
		"shr.b64				cv_r7,	cv_r7,	5;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"
		//!MsgExp(odd)
		"mov.b64 	            tmp0, o_l0;\n\t"
		"add.u64				o_l0, e_l0, o_l3;\n\t"
		"add.u64				o_l3, e_l3, o_l1;\n\t"
		"add.u64				o_l1, e_l1, o_l2;\n\t"
		"add.u64				o_l2, e_l2, tmp0;\n\t"
		"mov.b64 	            tmp0, o_l4;\n\t"
		"add.u64				o_l4, e_l4, o_l7;\n\t"
		"add.u64				o_l7, e_l7, o_l6;\n\t"
		"add.u64				o_l6, e_l6, o_l5;\n\t"
		"add.u64				o_l5, e_l5, tmp0;\n\t"
		"mov.b64 	            tmp0, o_r0;\n\t"
		"add.u64				o_r0, e_r0, o_r3;\n\t"
		"add.u64				o_r3, e_r3, o_r1;\n\t"
		"add.u64				o_r1, e_r1, o_r2;\n\t"
		"add.u64				o_r2, e_r2, tmp0;\n\t"
		"mov.b64 	            tmp0, o_r4;\n\t"
		"add.u64				o_r4, e_r4, o_r7;\n\t"
		"add.u64				o_r7, e_r7, o_r6;\n\t"
		"add.u64				o_r6, e_r6, o_r5;\n\t"
		"add.u64				o_r5, e_r5, tmp0;\n\t"
		//!msg_add_odd(cv_l, cv_r, i_state)
		"xor.b64				cv_l0, o_l0, cv_l0;\n\t"
		"xor.b64				cv_l1, o_l1, cv_l1;\n\t"
		"xor.b64				cv_l2, o_l2, cv_l2;\n\t"
		"xor.b64				cv_l3, o_l3, cv_l3;\n\t"
		"xor.b64				cv_l4, o_l4, cv_l4;\n\t"
		"xor.b64				cv_l5, o_l5, cv_l5;\n\t"
		"xor.b64				cv_l6, o_l6, cv_l6;\n\t"
		"xor.b64				cv_l7, o_l7, cv_l7;\n\t"
		"xor.b64				cv_r0, o_r0, cv_r0;\n\t"
		"xor.b64				cv_r1, o_r1, cv_r1;\n\t"
		"xor.b64				cv_r2, o_r2, cv_r2;\n\t"
		"xor.b64				cv_r3, o_r3, cv_r3;\n\t"
		"xor.b64				cv_r4, o_r4, cv_r4;\n\t"
		"xor.b64				cv_r5, o_r5, cv_r5;\n\t"
		"xor.b64				cv_r6, o_r6, cv_r6;\n\t"
		"xor.b64				cv_r7, o_r7, cv_r7;\n\t"
		//!MIX(odd)
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_l, 7)
		"shl.b64				tmp0,	cv_l0,	7;\n\t"
		"shr.b64				cv_l0,	cv_l0,	57;\n\t"
		"or.b64					cv_l0,  tmp0, cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	7;\n\t"
		"shr.b64				cv_l1,	cv_l1,	57;\n\t"
		"or.b64					cv_l1,  tmp0, cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	7;\n\t"
		"shr.b64				cv_l2,	cv_l2,	57;\n\t"
		"or.b64					cv_l2,  tmp0, cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	7;\n\t"
		"shr.b64				cv_l3,	cv_l3,	57;\n\t"
		"or.b64					cv_l3,  tmp0, cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	7;\n\t"
		"shr.b64				cv_l4,	cv_l4,	57;\n\t"
		"or.b64					cv_l4,  tmp0, cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	7;\n\t"
		"shr.b64				cv_l5,	cv_l5,	57;\n\t"
		"or.b64					cv_l5,  tmp0, cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	7;\n\t"
		"shr.b64				cv_l6,	cv_l6,	57;\n\t"
		"or.b64					cv_l6,  tmp0, cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	7;\n\t"
		"shr.b64				cv_l7,	cv_l7,	57;\n\t"
		"or.b64					cv_l7,  tmp0, cv_l7;\n\t"
		//xor with const
		"xor.b64				cv_l0, cv_l0, 0x9e661b271cff216a;\n\t"
		"xor.b64				cv_l1, cv_l1, 0x8a6ec8dd002d8861;\n\t"
		"xor.b64				cv_l2, cv_l2, 0xd3d2b629beb34be4;\n\t"
		"xor.b64				cv_l3, cv_l3, 0x217a3a1091863f1a;\n\t"
		"xor.b64				cv_l4, cv_l4, 0x256ecda287a733f5;\n\t"
		"xor.b64				cv_l5, cv_l5, 0xf9139a9e5b872fe5;\n\t"
		"xor.b64				cv_l6, cv_l6, 0xac0535017a274f7c;\n\t"
		"xor.b64				cv_l7, cv_l7, 0xf21b7646d65d2aa9;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 3)
		"shl.b64				tmp0,	cv_r0,	3;\n\t"
		"shr.b64				cv_r0,	cv_r0,	61;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	3;\n\t"
		"shr.b64				cv_r1,	cv_r1,	61;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	3;\n\t"
		"shr.b64				cv_r2,	cv_r2,	61;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	3;\n\t"
		"shr.b64				cv_r3,	cv_r3,	61;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	3;\n\t"
		"shr.b64				cv_r4,	cv_r4,	61;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	3;\n\t"
		"shr.b64				cv_r5,	cv_r5,	61;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	3;\n\t"
		"shr.b64				cv_r6,	cv_r6,	61;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	3;\n\t"
		"shr.b64				cv_r7,	cv_r7,	61;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"

		//MIX(even)
		//rotate_blk(cv_l, 23)
		"shl.b64				tmp0,	cv_l0,	23;\n\t"
		"shr.b64				cv_l0,	cv_l0,	41;\n\t"
		"or.b64					cv_l0,	tmp0,	cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	23;\n\t"
		"shr.b64				cv_l1,	cv_l1,	41;\n\t"
		"or.b64					cv_l1,	tmp0,	cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	23;\n\t"
		"shr.b64				cv_l2,	cv_l2,	41;\n\t"
		"or.b64					cv_l2,	tmp0,	cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	23;\n\t"
		"shr.b64				cv_l3,	cv_l3,	41;\n\t"
		"or.b64					cv_l3,	tmp0,	cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	23;\n\t"
		"shr.b64				cv_l4,	cv_l4,	41;\n\t"
		"or.b64					cv_l4,	tmp0,	cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	23;\n\t"
		"shr.b64				cv_l5,	cv_l5,	41;\n\t"
		"or.b64					cv_l5,	tmp0,	cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	23;\n\t"
		"shr.b64				cv_l6,	cv_l6,	41;\n\t"
		"or.b64					cv_l6,	tmp0,	cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	23;\n\t"
		"shr.b64				cv_l7,	cv_l7,	41;\n\t"
		"or.b64					cv_l7,	tmp0,	cv_l7;\n\t"
		//xor_with_const
		"xor.b64				cv_l0, cv_l0, 0x048142441c208c08;\n\t"
		"xor.b64				cv_l1, cv_l1, 0xf937a5dd2db5e9eb;\n\t"
		"xor.b64				cv_l2, cv_l2, 0xa688dfe871ff30b7;\n\t"
		"xor.b64				cv_l3, cv_l3, 0x9bb44aa217c5593b;\n\t"
		"xor.b64				cv_l4, cv_l4, 0x943c702a2edb291a;\n\t"
		"xor.b64				cv_l5, cv_l5, 0x0cae38f9e2b715de;\n\t"
		"xor.b64				cv_l6, cv_l6, 0xb13a367ba176cc28;\n\t"
		"xor.b64				cv_l7, cv_l7, 0x0d91bd1d3387d49b;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 59)
		"shl.b64				tmp0,	cv_r0,	59;\n\t"
		"shr.b64				cv_r0,	cv_r0,	5;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	59;\n\t"
		"shr.b64				cv_r1,	cv_r1,	5;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	59;\n\t"
		"shr.b64				cv_r2,	cv_r2,	5;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	59;\n\t"
		"shr.b64				cv_r3,	cv_r3,	5;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	59;\n\t"
		"shr.b64				cv_r4,	cv_r4,	5;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	59;\n\t"
		"shr.b64				cv_r5,	cv_r5,	5;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	59;\n\t"
		"shr.b64				cv_r6,	cv_r6,	5;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	59;\n\t"
		"shr.b64				cv_r7,	cv_r7,	5;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"
		//!MsgExp(odd)
		"mov.b64 	            tmp0, o_l0;\n\t"
		"add.u64				o_l0, e_l0, o_l3;\n\t"
		"add.u64				o_l3, e_l3, o_l1;\n\t"
		"add.u64				o_l1, e_l1, o_l2;\n\t"
		"add.u64				o_l2, e_l2, tmp0;\n\t"
		"mov.b64 	            tmp0, o_l4;\n\t"
		"add.u64				o_l4, e_l4, o_l7;\n\t"
		"add.u64				o_l7, e_l7, o_l6;\n\t"
		"add.u64				o_l6, e_l6, o_l5;\n\t"
		"add.u64				o_l5, e_l5, tmp0;\n\t"
		"mov.b64 	            tmp0, o_r0;\n\t"
		"add.u64				o_r0, e_r0, o_r3;\n\t"
		"add.u64				o_r3, e_r3, o_r1;\n\t"
		"add.u64				o_r1, e_r1, o_r2;\n\t"
		"add.u64				o_r2, e_r2, tmp0;\n\t"
		"mov.b64 	            tmp0, o_r4;\n\t"
		"add.u64				o_r4, e_r4, o_r7;\n\t"
		"add.u64				o_r7, e_r7, o_r6;\n\t"
		"add.u64				o_r6, e_r6, o_r5;\n\t"
		"add.u64				o_r5, e_r5, tmp0;\n\t"
		//!msg_add_odd(cv_l, cv_r, i_state)
		"xor.b64				cv_l0, o_l0, cv_l0;\n\t"
		"xor.b64				cv_l1, o_l1, cv_l1;\n\t"
		"xor.b64				cv_l2, o_l2, cv_l2;\n\t"
		"xor.b64				cv_l3, o_l3, cv_l3;\n\t"
		"xor.b64				cv_l4, o_l4, cv_l4;\n\t"
		"xor.b64				cv_l5, o_l5, cv_l5;\n\t"
		"xor.b64				cv_l6, o_l6, cv_l6;\n\t"
		"xor.b64				cv_l7, o_l7, cv_l7;\n\t"
		"xor.b64				cv_r0, o_r0, cv_r0;\n\t"
		"xor.b64				cv_r1, o_r1, cv_r1;\n\t"
		"xor.b64				cv_r2, o_r2, cv_r2;\n\t"
		"xor.b64				cv_r3, o_r3, cv_r3;\n\t"
		"xor.b64				cv_r4, o_r4, cv_r4;\n\t"
		"xor.b64				cv_r5, o_r5, cv_r5;\n\t"
		"xor.b64				cv_r6, o_r6, cv_r6;\n\t"
		"xor.b64				cv_r7, o_r7, cv_r7;\n\t"
		//!MIX(odd)
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_l, 7)
		"shl.b64				tmp0,	cv_l0,	7;\n\t"
		"shr.b64				cv_l0,	cv_l0,	57;\n\t"
		"or.b64					cv_l0,  tmp0, cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	7;\n\t"
		"shr.b64				cv_l1,	cv_l1,	57;\n\t"
		"or.b64					cv_l1,  tmp0, cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	7;\n\t"
		"shr.b64				cv_l2,	cv_l2,	57;\n\t"
		"or.b64					cv_l2,  tmp0, cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	7;\n\t"
		"shr.b64				cv_l3,	cv_l3,	57;\n\t"
		"or.b64					cv_l3,  tmp0, cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	7;\n\t"
		"shr.b64				cv_l4,	cv_l4,	57;\n\t"
		"or.b64					cv_l4,  tmp0, cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	7;\n\t"
		"shr.b64				cv_l5,	cv_l5,	57;\n\t"
		"or.b64					cv_l5,  tmp0, cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	7;\n\t"
		"shr.b64				cv_l6,	cv_l6,	57;\n\t"
		"or.b64					cv_l6,  tmp0, cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	7;\n\t"
		"shr.b64				cv_l7,	cv_l7,	57;\n\t"
		"or.b64					cv_l7,  tmp0, cv_l7;\n\t"
		//xor with const
		"xor.b64				cv_l0, cv_l0, 0x85c386603cac940c;\n\t"
		"xor.b64				cv_l1, cv_l1, 0x30dd830ae39fd5e4;\n\t"
		"xor.b64				cv_l2, cv_l2, 0x2f68c85a712fe85d;\n\t"
		"xor.b64				cv_l3, cv_l3, 0x4ffeecb9dd1e94d6;\n\t"
		"xor.b64				cv_l4, cv_l4, 0xd0ac9a590a0443ae;\n\t"
		"xor.b64				cv_l5, cv_l5, 0xbae732dc99ccf3ea;\n\t"
		"xor.b64				cv_l6, cv_l6, 0xeb70b21d1842f4d9;\n\t"
		"xor.b64				cv_l7, cv_l7, 0x9f4eda50bb5c6fa8;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 3)
		"shl.b64				tmp0,	cv_r0,	3;\n\t"
		"shr.b64				cv_r0,	cv_r0,	61;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	3;\n\t"
		"shr.b64				cv_r1,	cv_r1,	61;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	3;\n\t"
		"shr.b64				cv_r2,	cv_r2,	61;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	3;\n\t"
		"shr.b64				cv_r3,	cv_r3,	61;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	3;\n\t"
		"shr.b64				cv_r4,	cv_r4,	61;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	3;\n\t"
		"shr.b64				cv_r5,	cv_r5,	61;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	3;\n\t"
		"shr.b64				cv_r6,	cv_r6,	61;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	3;\n\t"
		"shr.b64				cv_r7,	cv_r7,	61;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"

		//MIX(even)
		//rotate_blk(cv_l, 23)
		"shl.b64				tmp0,	cv_l0,	23;\n\t"
		"shr.b64				cv_l0,	cv_l0,	41;\n\t"
		"or.b64					cv_l0,	tmp0,	cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	23;\n\t"
		"shr.b64				cv_l1,	cv_l1,	41;\n\t"
		"or.b64					cv_l1,	tmp0,	cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	23;\n\t"
		"shr.b64				cv_l2,	cv_l2,	41;\n\t"
		"or.b64					cv_l2,	tmp0,	cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	23;\n\t"
		"shr.b64				cv_l3,	cv_l3,	41;\n\t"
		"or.b64					cv_l3,	tmp0,	cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	23;\n\t"
		"shr.b64				cv_l4,	cv_l4,	41;\n\t"
		"or.b64					cv_l4,	tmp0,	cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	23;\n\t"
		"shr.b64				cv_l5,	cv_l5,	41;\n\t"
		"or.b64					cv_l5,	tmp0,	cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	23;\n\t"
		"shr.b64				cv_l6,	cv_l6,	41;\n\t"
		"or.b64					cv_l6,	tmp0,	cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	23;\n\t"
		"shr.b64				cv_l7,	cv_l7,	41;\n\t"
		"or.b64					cv_l7,	tmp0,	cv_l7;\n\t"
		//xor_with_const
		"xor.b64				cv_l0, cv_l0, 0x4949e69ce940a091;\n\t"
		"xor.b64				cv_l1, cv_l1, 0x0e608dee8375ba14;\n\t"
		"xor.b64				cv_l2, cv_l2, 0x983122cba118458c;\n\t"
		"xor.b64				cv_l3, cv_l3, 0x4eeba696fbb36b25;\n\t"
		"xor.b64				cv_l4, cv_l4, 0x7d46f3630e47f27e;\n\t"
		"xor.b64				cv_l5, cv_l5, 0xa21a0f7666c0dea4;\n\t"
		"xor.b64				cv_l6, cv_l6, 0x5c22cf355b37cec4;\n\t"
		"xor.b64				cv_l7, cv_l7, 0xee292b0c17cc1847;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 59)
		"shl.b64				tmp0,	cv_r0,	59;\n\t"
		"shr.b64				cv_r0,	cv_r0,	5;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	59;\n\t"
		"shr.b64				cv_r1,	cv_r1,	5;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	59;\n\t"
		"shr.b64				cv_r2,	cv_r2,	5;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	59;\n\t"
		"shr.b64				cv_r3,	cv_r3,	5;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	59;\n\t"
		"shr.b64				cv_r4,	cv_r4,	5;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	59;\n\t"
		"shr.b64				cv_r5,	cv_r5,	5;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	59;\n\t"
		"shr.b64				cv_r6,	cv_r6,	5;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	59;\n\t"
		"shr.b64				cv_r7,	cv_r7,	5;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"
		//!MsgExp(odd)
		"mov.b64 	            tmp0, o_l0;\n\t"
		"add.u64				o_l0, e_l0, o_l3;\n\t"
		"add.u64				o_l3, e_l3, o_l1;\n\t"
		"add.u64				o_l1, e_l1, o_l2;\n\t"
		"add.u64				o_l2, e_l2, tmp0;\n\t"
		"mov.b64 	            tmp0, o_l4;\n\t"
		"add.u64				o_l4, e_l4, o_l7;\n\t"
		"add.u64				o_l7, e_l7, o_l6;\n\t"
		"add.u64				o_l6, e_l6, o_l5;\n\t"
		"add.u64				o_l5, e_l5, tmp0;\n\t"
		"mov.b64 	            tmp0, o_r0;\n\t"
		"add.u64				o_r0, e_r0, o_r3;\n\t"
		"add.u64				o_r3, e_r3, o_r1;\n\t"
		"add.u64				o_r1, e_r1, o_r2;\n\t"
		"add.u64				o_r2, e_r2, tmp0;\n\t"
		"mov.b64 	            tmp0, o_r4;\n\t"
		"add.u64				o_r4, e_r4, o_r7;\n\t"
		"add.u64				o_r7, e_r7, o_r6;\n\t"
		"add.u64				o_r6, e_r6, o_r5;\n\t"
		"add.u64				o_r5, e_r5, tmp0;\n\t"
		//!msg_add_odd(cv_l, cv_r, i_state)
		"xor.b64				cv_l0, o_l0, cv_l0;\n\t"
		"xor.b64				cv_l1, o_l1, cv_l1;\n\t"
		"xor.b64				cv_l2, o_l2, cv_l2;\n\t"
		"xor.b64				cv_l3, o_l3, cv_l3;\n\t"
		"xor.b64				cv_l4, o_l4, cv_l4;\n\t"
		"xor.b64				cv_l5, o_l5, cv_l5;\n\t"
		"xor.b64				cv_l6, o_l6, cv_l6;\n\t"
		"xor.b64				cv_l7, o_l7, cv_l7;\n\t"
		"xor.b64				cv_r0, o_r0, cv_r0;\n\t"
		"xor.b64				cv_r1, o_r1, cv_r1;\n\t"
		"xor.b64				cv_r2, o_r2, cv_r2;\n\t"
		"xor.b64				cv_r3, o_r3, cv_r3;\n\t"
		"xor.b64				cv_r4, o_r4, cv_r4;\n\t"
		"xor.b64				cv_r5, o_r5, cv_r5;\n\t"
		"xor.b64				cv_r6, o_r6, cv_r6;\n\t"
		"xor.b64				cv_r7, o_r7, cv_r7;\n\t"
		//!MIX(odd)
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_l, 7)
		"shl.b64				tmp0,	cv_l0,	7;\n\t"
		"shr.b64				cv_l0,	cv_l0,	57;\n\t"
		"or.b64					cv_l0,  tmp0, cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	7;\n\t"
		"shr.b64				cv_l1,	cv_l1,	57;\n\t"
		"or.b64					cv_l1,  tmp0, cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	7;\n\t"
		"shr.b64				cv_l2,	cv_l2,	57;\n\t"
		"or.b64					cv_l2,  tmp0, cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	7;\n\t"
		"shr.b64				cv_l3,	cv_l3,	57;\n\t"
		"or.b64					cv_l3,  tmp0, cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	7;\n\t"
		"shr.b64				cv_l4,	cv_l4,	57;\n\t"
		"or.b64					cv_l4,  tmp0, cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	7;\n\t"
		"shr.b64				cv_l5,	cv_l5,	57;\n\t"
		"or.b64					cv_l5,  tmp0, cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	7;\n\t"
		"shr.b64				cv_l6,	cv_l6,	57;\n\t"
		"or.b64					cv_l6,  tmp0, cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	7;\n\t"
		"shr.b64				cv_l7,	cv_l7,	57;\n\t"
		"or.b64					cv_l7,  tmp0, cv_l7;\n\t"
		//xor with const
		"xor.b64				cv_l0, cv_l0, 0x9330838629e131da;\n\t"
		"xor.b64				cv_l1, cv_l1, 0x6eee7c71f92fce22;\n\t"
		"xor.b64				cv_l2, cv_l2, 0xc953ee6cb95dd224;\n\t"
		"xor.b64				cv_l3, cv_l3, 0x3a923d92af1e9073;\n\t"
		"xor.b64				cv_l4, cv_l4, 0xc43a5671563a70fb;\n\t"
		"xor.b64				cv_l5, cv_l5, 0xbc2985dd279f8346;\n\t"
		"xor.b64				cv_l6, cv_l6, 0x7ef2049093069320;\n\t"
		"xor.b64				cv_l7, cv_l7, 0x17543723e3e46035;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 3)
		"shl.b64				tmp0,	cv_r0,	3;\n\t"
		"shr.b64				cv_r0,	cv_r0,	61;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	3;\n\t"
		"shr.b64				cv_r1,	cv_r1,	61;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	3;\n\t"
		"shr.b64				cv_r2,	cv_r2,	61;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	3;\n\t"
		"shr.b64				cv_r3,	cv_r3,	61;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	3;\n\t"
		"shr.b64				cv_r4,	cv_r4,	61;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	3;\n\t"
		"shr.b64				cv_r5,	cv_r5,	61;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	3;\n\t"
		"shr.b64				cv_r6,	cv_r6,	61;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	3;\n\t"
		"shr.b64				cv_r7,	cv_r7,	61;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"

		//MIX(even)
		//rotate_blk(cv_l, 23)
		"shl.b64				tmp0,	cv_l0,	23;\n\t"
		"shr.b64				cv_l0,	cv_l0,	41;\n\t"
		"or.b64					cv_l0,	tmp0,	cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	23;\n\t"
		"shr.b64				cv_l1,	cv_l1,	41;\n\t"
		"or.b64					cv_l1,	tmp0,	cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	23;\n\t"
		"shr.b64				cv_l2,	cv_l2,	41;\n\t"
		"or.b64					cv_l2,	tmp0,	cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	23;\n\t"
		"shr.b64				cv_l3,	cv_l3,	41;\n\t"
		"or.b64					cv_l3,	tmp0,	cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	23;\n\t"
		"shr.b64				cv_l4,	cv_l4,	41;\n\t"
		"or.b64					cv_l4,	tmp0,	cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	23;\n\t"
		"shr.b64				cv_l5,	cv_l5,	41;\n\t"
		"or.b64					cv_l5,	tmp0,	cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	23;\n\t"
		"shr.b64				cv_l6,	cv_l6,	41;\n\t"
		"or.b64					cv_l6,	tmp0,	cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	23;\n\t"
		"shr.b64				cv_l7,	cv_l7,	41;\n\t"
		"or.b64					cv_l7,	tmp0,	cv_l7;\n\t"
		//xor_with_const
		"xor.b64				cv_l0, cv_l0, 0xc3b409b00b130c6d;\n\t"
		"xor.b64				cv_l1, cv_l1, 0x5d6aee6b28fdf090;\n\t"
		"xor.b64				cv_l2, cv_l2, 0x1d425b26172ff6ed;\n\t"
		"xor.b64				cv_l3, cv_l3, 0xcccfd041cdaf03ad;\n\t"
		"xor.b64				cv_l4, cv_l4, 0xfe90c7c790ab6cbf;\n\t"
		"xor.b64				cv_l5, cv_l5, 0xe5af6304c722ca02;\n\t"
		"xor.b64				cv_l6, cv_l6, 0x70f695239999b39e;\n\t"
		"xor.b64				cv_l7, cv_l7, 0x6b8b5b07c844954c;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 59)
		"shl.b64				tmp0,	cv_r0,	59;\n\t"
		"shr.b64				cv_r0,	cv_r0,	5;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	59;\n\t"
		"shr.b64				cv_r1,	cv_r1,	5;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	59;\n\t"
		"shr.b64				cv_r2,	cv_r2,	5;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	59;\n\t"
		"shr.b64				cv_r3,	cv_r3,	5;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	59;\n\t"
		"shr.b64				cv_r4,	cv_r4,	5;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	59;\n\t"
		"shr.b64				cv_r5,	cv_r5,	5;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	59;\n\t"
		"shr.b64				cv_r6,	cv_r6,	5;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	59;\n\t"
		"shr.b64				cv_r7,	cv_r7,	5;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"
		//!MsgExp(odd)
		"mov.b64 	            tmp0, o_l0;\n\t"
		"add.u64				o_l0, e_l0, o_l3;\n\t"
		"add.u64				o_l3, e_l3, o_l1;\n\t"
		"add.u64				o_l1, e_l1, o_l2;\n\t"
		"add.u64				o_l2, e_l2, tmp0;\n\t"
		"mov.b64 	            tmp0, o_l4;\n\t"
		"add.u64				o_l4, e_l4, o_l7;\n\t"
		"add.u64				o_l7, e_l7, o_l6;\n\t"
		"add.u64				o_l6, e_l6, o_l5;\n\t"
		"add.u64				o_l5, e_l5, tmp0;\n\t"
		"mov.b64 	            tmp0, o_r0;\n\t"
		"add.u64				o_r0, e_r0, o_r3;\n\t"
		"add.u64				o_r3, e_r3, o_r1;\n\t"
		"add.u64				o_r1, e_r1, o_r2;\n\t"
		"add.u64				o_r2, e_r2, tmp0;\n\t"
		"mov.b64 	            tmp0, o_r4;\n\t"
		"add.u64				o_r4, e_r4, o_r7;\n\t"
		"add.u64				o_r7, e_r7, o_r6;\n\t"
		"add.u64				o_r6, e_r6, o_r5;\n\t"
		"add.u64				o_r5, e_r5, tmp0;\n\t"
		//!msg_add_odd(cv_l, cv_r, i_state)
		"xor.b64				cv_l0, o_l0, cv_l0;\n\t"
		"xor.b64				cv_l1, o_l1, cv_l1;\n\t"
		"xor.b64				cv_l2, o_l2, cv_l2;\n\t"
		"xor.b64				cv_l3, o_l3, cv_l3;\n\t"
		"xor.b64				cv_l4, o_l4, cv_l4;\n\t"
		"xor.b64				cv_l5, o_l5, cv_l5;\n\t"
		"xor.b64				cv_l6, o_l6, cv_l6;\n\t"
		"xor.b64				cv_l7, o_l7, cv_l7;\n\t"
		"xor.b64				cv_r0, o_r0, cv_r0;\n\t"
		"xor.b64				cv_r1, o_r1, cv_r1;\n\t"
		"xor.b64				cv_r2, o_r2, cv_r2;\n\t"
		"xor.b64				cv_r3, o_r3, cv_r3;\n\t"
		"xor.b64				cv_r4, o_r4, cv_r4;\n\t"
		"xor.b64				cv_r5, o_r5, cv_r5;\n\t"
		"xor.b64				cv_r6, o_r6, cv_r6;\n\t"
		"xor.b64				cv_r7, o_r7, cv_r7;\n\t"
		//!MIX(odd)
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_l, 7)
		"shl.b64				tmp0,	cv_l0,	7;\n\t"
		"shr.b64				cv_l0,	cv_l0,	57;\n\t"
		"or.b64					cv_l0,  tmp0, cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	7;\n\t"
		"shr.b64				cv_l1,	cv_l1,	57;\n\t"
		"or.b64					cv_l1,  tmp0, cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	7;\n\t"
		"shr.b64				cv_l2,	cv_l2,	57;\n\t"
		"or.b64					cv_l2,  tmp0, cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	7;\n\t"
		"shr.b64				cv_l3,	cv_l3,	57;\n\t"
		"or.b64					cv_l3,  tmp0, cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	7;\n\t"
		"shr.b64				cv_l4,	cv_l4,	57;\n\t"
		"or.b64					cv_l4,  tmp0, cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	7;\n\t"
		"shr.b64				cv_l5,	cv_l5,	57;\n\t"
		"or.b64					cv_l5,  tmp0, cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	7;\n\t"
		"shr.b64				cv_l6,	cv_l6,	57;\n\t"
		"or.b64					cv_l6,  tmp0, cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	7;\n\t"
		"shr.b64				cv_l7,	cv_l7,	57;\n\t"
		"or.b64					cv_l7,  tmp0, cv_l7;\n\t"
		//xor with const
		"xor.b64				cv_l0, cv_l0, 0x77bdb9bb1e1f7a30;\n\t"
		"xor.b64				cv_l1, cv_l1, 0xc859599426ee80ed;\n\t"
		"xor.b64				cv_l2, cv_l2, 0x5f9d813d4726e40a;\n\t"
		"xor.b64				cv_l3, cv_l3, 0x9ca0120f7cb2b179;\n\t"
		"xor.b64				cv_l4, cv_l4, 0x8f588f583c182cbd;\n\t"
		"xor.b64				cv_l5, cv_l5, 0x951267cbe9eccce7;\n\t"
		"xor.b64				cv_l6, cv_l6, 0x678bb8bd334d520e;\n\t"
		"xor.b64				cv_l7, cv_l7, 0xf6e662d00cd9e1b7;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 3)
		"shl.b64				tmp0,	cv_r0,	3;\n\t"
		"shr.b64				cv_r0,	cv_r0,	61;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	3;\n\t"
		"shr.b64				cv_r1,	cv_r1,	61;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	3;\n\t"
		"shr.b64				cv_r2,	cv_r2,	61;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	3;\n\t"
		"shr.b64				cv_r3,	cv_r3,	61;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	3;\n\t"
		"shr.b64				cv_r4,	cv_r4,	61;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	3;\n\t"
		"shr.b64				cv_r5,	cv_r5,	61;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	3;\n\t"
		"shr.b64				cv_r6,	cv_r6,	61;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	3;\n\t"
		"shr.b64				cv_r7,	cv_r7,	61;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"

		//MIX(even)
		//rotate_blk(cv_l, 23)
		"shl.b64				tmp0,	cv_l0,	23;\n\t"
		"shr.b64				cv_l0,	cv_l0,	41;\n\t"
		"or.b64					cv_l0,	tmp0,	cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	23;\n\t"
		"shr.b64				cv_l1,	cv_l1,	41;\n\t"
		"or.b64					cv_l1,	tmp0,	cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	23;\n\t"
		"shr.b64				cv_l2,	cv_l2,	41;\n\t"
		"or.b64					cv_l2,	tmp0,	cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	23;\n\t"
		"shr.b64				cv_l3,	cv_l3,	41;\n\t"
		"or.b64					cv_l3,	tmp0,	cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	23;\n\t"
		"shr.b64				cv_l4,	cv_l4,	41;\n\t"
		"or.b64					cv_l4,	tmp0,	cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	23;\n\t"
		"shr.b64				cv_l5,	cv_l5,	41;\n\t"
		"or.b64					cv_l5,	tmp0,	cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	23;\n\t"
		"shr.b64				cv_l6,	cv_l6,	41;\n\t"
		"or.b64					cv_l6,	tmp0,	cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	23;\n\t"
		"shr.b64				cv_l7,	cv_l7,	41;\n\t"
		"or.b64					cv_l7,	tmp0,	cv_l7;\n\t"
		//xor_with_const
		"xor.b64				cv_l0, cv_l0, 0x357774d93d99aaa7;\n\t"
		"xor.b64				cv_l1, cv_l1, 0x21b2edbb156f6eb5;\n\t"
		"xor.b64				cv_l2, cv_l2, 0xfd1ebe846e0aee69;\n\t"
		"xor.b64				cv_l3, cv_l3, 0x3cb2218c2f642b15;\n\t"
		"xor.b64				cv_l4, cv_l4, 0xe7e7e7945444ea4c;\n\t"
		"xor.b64				cv_l5, cv_l5, 0xa77a33b5d6b9b47c;\n\t"
		"xor.b64				cv_l6, cv_l6, 0xf34475f0809f6075;\n\t"
		"xor.b64				cv_l7, cv_l7, 0xdd4932dce6bb99ad;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 59)
		"shl.b64				tmp0,	cv_r0,	59;\n\t"
		"shr.b64				cv_r0,	cv_r0,	5;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	59;\n\t"
		"shr.b64				cv_r1,	cv_r1,	5;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	59;\n\t"
		"shr.b64				cv_r2,	cv_r2,	5;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	59;\n\t"
		"shr.b64				cv_r3,	cv_r3,	5;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	59;\n\t"
		"shr.b64				cv_r4,	cv_r4,	5;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	59;\n\t"
		"shr.b64				cv_r5,	cv_r5,	5;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	59;\n\t"
		"shr.b64				cv_r6,	cv_r6,	5;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	59;\n\t"
		"shr.b64				cv_r7,	cv_r7,	5;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"
		//!MsgExp(odd)
		"mov.b64 	            tmp0, o_l0;\n\t"
		"add.u64				o_l0, e_l0, o_l3;\n\t"
		"add.u64				o_l3, e_l3, o_l1;\n\t"
		"add.u64				o_l1, e_l1, o_l2;\n\t"
		"add.u64				o_l2, e_l2, tmp0;\n\t"
		"mov.b64 	            tmp0, o_l4;\n\t"
		"add.u64				o_l4, e_l4, o_l7;\n\t"
		"add.u64				o_l7, e_l7, o_l6;\n\t"
		"add.u64				o_l6, e_l6, o_l5;\n\t"
		"add.u64				o_l5, e_l5, tmp0;\n\t"
		"mov.b64 	            tmp0, o_r0;\n\t"
		"add.u64				o_r0, e_r0, o_r3;\n\t"
		"add.u64				o_r3, e_r3, o_r1;\n\t"
		"add.u64				o_r1, e_r1, o_r2;\n\t"
		"add.u64				o_r2, e_r2, tmp0;\n\t"
		"mov.b64 	            tmp0, o_r4;\n\t"
		"add.u64				o_r4, e_r4, o_r7;\n\t"
		"add.u64				o_r7, e_r7, o_r6;\n\t"
		"add.u64				o_r6, e_r6, o_r5;\n\t"
		"add.u64				o_r5, e_r5, tmp0;\n\t"
		//!msg_add_odd(cv_l, cv_r, i_state)
		"xor.b64				cv_l0, o_l0, cv_l0;\n\t"
		"xor.b64				cv_l1, o_l1, cv_l1;\n\t"
		"xor.b64				cv_l2, o_l2, cv_l2;\n\t"
		"xor.b64				cv_l3, o_l3, cv_l3;\n\t"
		"xor.b64				cv_l4, o_l4, cv_l4;\n\t"
		"xor.b64				cv_l5, o_l5, cv_l5;\n\t"
		"xor.b64				cv_l6, o_l6, cv_l6;\n\t"
		"xor.b64				cv_l7, o_l7, cv_l7;\n\t"
		"xor.b64				cv_r0, o_r0, cv_r0;\n\t"
		"xor.b64				cv_r1, o_r1, cv_r1;\n\t"
		"xor.b64				cv_r2, o_r2, cv_r2;\n\t"
		"xor.b64				cv_r3, o_r3, cv_r3;\n\t"
		"xor.b64				cv_r4, o_r4, cv_r4;\n\t"
		"xor.b64				cv_r5, o_r5, cv_r5;\n\t"
		"xor.b64				cv_r6, o_r6, cv_r6;\n\t"
		"xor.b64				cv_r7, o_r7, cv_r7;\n\t"
		//!MIX(odd)
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_l, 7)
		"shl.b64				tmp0,	cv_l0,	7;\n\t"
		"shr.b64				cv_l0,	cv_l0,	57;\n\t"
		"or.b64					cv_l0,  tmp0, cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	7;\n\t"
		"shr.b64				cv_l1,	cv_l1,	57;\n\t"
		"or.b64					cv_l1,  tmp0, cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	7;\n\t"
		"shr.b64				cv_l2,	cv_l2,	57;\n\t"
		"or.b64					cv_l2,  tmp0, cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	7;\n\t"
		"shr.b64				cv_l3,	cv_l3,	57;\n\t"
		"or.b64					cv_l3,  tmp0, cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	7;\n\t"
		"shr.b64				cv_l4,	cv_l4,	57;\n\t"
		"or.b64					cv_l4,  tmp0, cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	7;\n\t"
		"shr.b64				cv_l5,	cv_l5,	57;\n\t"
		"or.b64					cv_l5,  tmp0, cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	7;\n\t"
		"shr.b64				cv_l6,	cv_l6,	57;\n\t"
		"or.b64					cv_l6,  tmp0, cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	7;\n\t"
		"shr.b64				cv_l7,	cv_l7,	57;\n\t"
		"or.b64					cv_l7,  tmp0, cv_l7;\n\t"
		//xor with const
		"xor.b64				cv_l0, cv_l0, 0xacec4e16d74451dc;\n\t"
		"xor.b64				cv_l1, cv_l1, 0xd4a0a8d084de23d6;\n\t"
		"xor.b64				cv_l2, cv_l2, 0x1bdd42f278f95866;\n\t"
		"xor.b64				cv_l3, cv_l3, 0xeed3adbb938f4051;\n\t"
		"xor.b64				cv_l4, cv_l4, 0xcfcf7be8992f3733;\n\t"
		"xor.b64				cv_l5, cv_l5, 0x21ade98c906e3123;\n\t"
		"xor.b64				cv_l6, cv_l6, 0x37ba66711fffd668;\n\t"
		"xor.b64				cv_l7, cv_l7, 0x267c0fc3a255478a;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 3)
		"shl.b64				tmp0,	cv_r0,	3;\n\t"
		"shr.b64				cv_r0,	cv_r0,	61;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	3;\n\t"
		"shr.b64				cv_r1,	cv_r1,	61;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	3;\n\t"
		"shr.b64				cv_r2,	cv_r2,	61;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	3;\n\t"
		"shr.b64				cv_r3,	cv_r3,	61;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	3;\n\t"
		"shr.b64				cv_r4,	cv_r4,	61;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	3;\n\t"
		"shr.b64				cv_r5,	cv_r5,	61;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	3;\n\t"
		"shr.b64				cv_r6,	cv_r6,	61;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	3;\n\t"
		"shr.b64				cv_r7,	cv_r7,	61;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"

		//MIX(even)
		//rotate_blk(cv_l, 23)
		"shl.b64				tmp0,	cv_l0,	23;\n\t"
		"shr.b64				cv_l0,	cv_l0,	41;\n\t"
		"or.b64					cv_l0,	tmp0,	cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	23;\n\t"
		"shr.b64				cv_l1,	cv_l1,	41;\n\t"
		"or.b64					cv_l1,	tmp0,	cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	23;\n\t"
		"shr.b64				cv_l2,	cv_l2,	41;\n\t"
		"or.b64					cv_l2,	tmp0,	cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	23;\n\t"
		"shr.b64				cv_l3,	cv_l3,	41;\n\t"
		"or.b64					cv_l3,	tmp0,	cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	23;\n\t"
		"shr.b64				cv_l4,	cv_l4,	41;\n\t"
		"or.b64					cv_l4,	tmp0,	cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	23;\n\t"
		"shr.b64				cv_l5,	cv_l5,	41;\n\t"
		"or.b64					cv_l5,	tmp0,	cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	23;\n\t"
		"shr.b64				cv_l6,	cv_l6,	41;\n\t"
		"or.b64					cv_l6,	tmp0,	cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	23;\n\t"
		"shr.b64				cv_l7,	cv_l7,	41;\n\t"
		"or.b64					cv_l7,	tmp0,	cv_l7;\n\t"
		//xor_with_const
		"xor.b64				cv_l0, cv_l0, 0x993a64ee1b962e88;\n\t"
		"xor.b64				cv_l1, cv_l1, 0x754979556301faaa;\n\t"
		"xor.b64				cv_l2, cv_l2, 0xf920356b7251be81;\n\t"
		"xor.b64				cv_l3, cv_l3, 0xc281694f22cf923f;\n\t"
		"xor.b64				cv_l4, cv_l4, 0x9f4b6481c8666b02;\n\t"
		"xor.b64				cv_l5, cv_l5, 0xcf97761cfe9f5444;\n\t"
		"xor.b64				cv_l6, cv_l6, 0xf220d7911fd63e9f;\n\t"
		"xor.b64				cv_l7, cv_l7, 0xa28bd365f79cd1b0;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 59)
		"shl.b64				tmp0,	cv_r0,	59;\n\t"
		"shr.b64				cv_r0,	cv_r0,	5;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	59;\n\t"
		"shr.b64				cv_r1,	cv_r1,	5;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	59;\n\t"
		"shr.b64				cv_r2,	cv_r2,	5;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	59;\n\t"
		"shr.b64				cv_r3,	cv_r3,	5;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	59;\n\t"
		"shr.b64				cv_r4,	cv_r4,	5;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	59;\n\t"
		"shr.b64				cv_r5,	cv_r5,	5;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	59;\n\t"
		"shr.b64				cv_r6,	cv_r6,	5;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	59;\n\t"
		"shr.b64				cv_r7,	cv_r7,	5;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"
		//!MsgExp(odd)
		"mov.b64 	            tmp0, o_l0;\n\t"
		"add.u64				o_l0, e_l0, o_l3;\n\t"
		"add.u64				o_l3, e_l3, o_l1;\n\t"
		"add.u64				o_l1, e_l1, o_l2;\n\t"
		"add.u64				o_l2, e_l2, tmp0;\n\t"
		"mov.b64 	            tmp0, o_l4;\n\t"
		"add.u64				o_l4, e_l4, o_l7;\n\t"
		"add.u64				o_l7, e_l7, o_l6;\n\t"
		"add.u64				o_l6, e_l6, o_l5;\n\t"
		"add.u64				o_l5, e_l5, tmp0;\n\t"
		"mov.b64 	            tmp0, o_r0;\n\t"
		"add.u64				o_r0, e_r0, o_r3;\n\t"
		"add.u64				o_r3, e_r3, o_r1;\n\t"
		"add.u64				o_r1, e_r1, o_r2;\n\t"
		"add.u64				o_r2, e_r2, tmp0;\n\t"
		"mov.b64 	            tmp0, o_r4;\n\t"
		"add.u64				o_r4, e_r4, o_r7;\n\t"
		"add.u64				o_r7, e_r7, o_r6;\n\t"
		"add.u64				o_r6, e_r6, o_r5;\n\t"
		"add.u64				o_r5, e_r5, tmp0;\n\t"
		//!msg_add_odd(cv_l, cv_r, i_state)
		"xor.b64				cv_l0, o_l0, cv_l0;\n\t"
		"xor.b64				cv_l1, o_l1, cv_l1;\n\t"
		"xor.b64				cv_l2, o_l2, cv_l2;\n\t"
		"xor.b64				cv_l3, o_l3, cv_l3;\n\t"
		"xor.b64				cv_l4, o_l4, cv_l4;\n\t"
		"xor.b64				cv_l5, o_l5, cv_l5;\n\t"
		"xor.b64				cv_l6, o_l6, cv_l6;\n\t"
		"xor.b64				cv_l7, o_l7, cv_l7;\n\t"
		"xor.b64				cv_r0, o_r0, cv_r0;\n\t"
		"xor.b64				cv_r1, o_r1, cv_r1;\n\t"
		"xor.b64				cv_r2, o_r2, cv_r2;\n\t"
		"xor.b64				cv_r3, o_r3, cv_r3;\n\t"
		"xor.b64				cv_r4, o_r4, cv_r4;\n\t"
		"xor.b64				cv_r5, o_r5, cv_r5;\n\t"
		"xor.b64				cv_r6, o_r6, cv_r6;\n\t"
		"xor.b64				cv_r7, o_r7, cv_r7;\n\t"
		//!MIX(odd)
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_l, 7)
		"shl.b64				tmp0,	cv_l0,	7;\n\t"
		"shr.b64				cv_l0,	cv_l0,	57;\n\t"
		"or.b64					cv_l0,  tmp0, cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	7;\n\t"
		"shr.b64				cv_l1,	cv_l1,	57;\n\t"
		"or.b64					cv_l1,  tmp0, cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	7;\n\t"
		"shr.b64				cv_l2,	cv_l2,	57;\n\t"
		"or.b64					cv_l2,  tmp0, cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	7;\n\t"
		"shr.b64				cv_l3,	cv_l3,	57;\n\t"
		"or.b64					cv_l3,  tmp0, cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	7;\n\t"
		"shr.b64				cv_l4,	cv_l4,	57;\n\t"
		"or.b64					cv_l4,  tmp0, cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	7;\n\t"
		"shr.b64				cv_l5,	cv_l5,	57;\n\t"
		"or.b64					cv_l5,  tmp0, cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	7;\n\t"
		"shr.b64				cv_l6,	cv_l6,	57;\n\t"
		"or.b64					cv_l6,  tmp0, cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	7;\n\t"
		"shr.b64				cv_l7,	cv_l7,	57;\n\t"
		"or.b64					cv_l7,  tmp0, cv_l7;\n\t"
		//xor with const
		"xor.b64				cv_l0, cv_l0, 0xd39f5309b1c4b721;\n\t"
		"xor.b64				cv_l1, cv_l1, 0xbec2ceb864fca51f;\n\t"
		"xor.b64				cv_l2, cv_l2, 0x1955a0ddc410407a;\n\t"
		"xor.b64				cv_l3, cv_l3, 0x43eab871f261d201;\n\t"
		"xor.b64				cv_l4, cv_l4, 0xeaafe64a2ed16da1;\n\t"
		"xor.b64				cv_l5, cv_l5, 0x670d931b9df39913;\n\t"
		"xor.b64				cv_l6, cv_l6, 0x12f868b0f614de91;\n\t"
		"xor.b64				cv_l7, cv_l7, 0x2e5f395d946e8252;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 3)
		"shl.b64				tmp0,	cv_r0,	3;\n\t"
		"shr.b64				cv_r0,	cv_r0,	61;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	3;\n\t"
		"shr.b64				cv_r1,	cv_r1,	61;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	3;\n\t"
		"shr.b64				cv_r2,	cv_r2,	61;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	3;\n\t"
		"shr.b64				cv_r3,	cv_r3,	61;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	3;\n\t"
		"shr.b64				cv_r4,	cv_r4,	61;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	3;\n\t"
		"shr.b64				cv_r5,	cv_r5,	61;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	3;\n\t"
		"shr.b64				cv_r6,	cv_r6,	61;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	3;\n\t"
		"shr.b64				cv_r7,	cv_r7,	61;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"

		//MIX(even)
		//rotate_blk(cv_l, 23)
		"shl.b64				tmp0,	cv_l0,	23;\n\t"
		"shr.b64				cv_l0,	cv_l0,	41;\n\t"
		"or.b64					cv_l0,	tmp0,	cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	23;\n\t"
		"shr.b64				cv_l1,	cv_l1,	41;\n\t"
		"or.b64					cv_l1,	tmp0,	cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	23;\n\t"
		"shr.b64				cv_l2,	cv_l2,	41;\n\t"
		"or.b64					cv_l2,	tmp0,	cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	23;\n\t"
		"shr.b64				cv_l3,	cv_l3,	41;\n\t"
		"or.b64					cv_l3,	tmp0,	cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	23;\n\t"
		"shr.b64				cv_l4,	cv_l4,	41;\n\t"
		"or.b64					cv_l4,	tmp0,	cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	23;\n\t"
		"shr.b64				cv_l5,	cv_l5,	41;\n\t"
		"or.b64					cv_l5,	tmp0,	cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	23;\n\t"
		"shr.b64				cv_l6,	cv_l6,	41;\n\t"
		"or.b64					cv_l6,	tmp0,	cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	23;\n\t"
		"shr.b64				cv_l7,	cv_l7,	41;\n\t"
		"or.b64					cv_l7,	tmp0,	cv_l7;\n\t"
		//xor_with_const
		"xor.b64				cv_l0, cv_l0, 0x72f25cbb767bd8f4;\n\t"
		"xor.b64				cv_l1, cv_l1, 0x8191871d61a1c4dd;\n\t"
		"xor.b64				cv_l2, cv_l2, 0x6ef67ea1d450ba93;\n\t"
		"xor.b64				cv_l3, cv_l3, 0x2ea32a645433d344;\n\t"
		"xor.b64				cv_l4, cv_l4, 0x9a963079003f0f8b;\n\t"
		"xor.b64				cv_l5, cv_l5, 0x74a0aeb9918cac7a;\n\t"
		"xor.b64				cv_l6, cv_l6, 0x0b6119a70af36fa3;\n\t"
		"xor.b64				cv_l7, cv_l7, 0x8d9896f202f0d480;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 59)
		"shl.b64				tmp0,	cv_r0,	59;\n\t"
		"shr.b64				cv_r0,	cv_r0,	5;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	59;\n\t"
		"shr.b64				cv_r1,	cv_r1,	5;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	59;\n\t"
		"shr.b64				cv_r2,	cv_r2,	5;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	59;\n\t"
		"shr.b64				cv_r3,	cv_r3,	5;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	59;\n\t"
		"shr.b64				cv_r4,	cv_r4,	5;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	59;\n\t"
		"shr.b64				cv_r5,	cv_r5,	5;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	59;\n\t"
		"shr.b64				cv_r6,	cv_r6,	5;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	59;\n\t"
		"shr.b64				cv_r7,	cv_r7,	5;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"
		//!MsgExp(odd)
		"mov.b64 	            tmp0, o_l0;\n\t"
		"add.u64				o_l0, e_l0, o_l3;\n\t"
		"add.u64				o_l3, e_l3, o_l1;\n\t"
		"add.u64				o_l1, e_l1, o_l2;\n\t"
		"add.u64				o_l2, e_l2, tmp0;\n\t"
		"mov.b64 	            tmp0, o_l4;\n\t"
		"add.u64				o_l4, e_l4, o_l7;\n\t"
		"add.u64				o_l7, e_l7, o_l6;\n\t"
		"add.u64				o_l6, e_l6, o_l5;\n\t"
		"add.u64				o_l5, e_l5, tmp0;\n\t"
		"mov.b64 	            tmp0, o_r0;\n\t"
		"add.u64				o_r0, e_r0, o_r3;\n\t"
		"add.u64				o_r3, e_r3, o_r1;\n\t"
		"add.u64				o_r1, e_r1, o_r2;\n\t"
		"add.u64				o_r2, e_r2, tmp0;\n\t"
		"mov.b64 	            tmp0, o_r4;\n\t"
		"add.u64				o_r4, e_r4, o_r7;\n\t"
		"add.u64				o_r7, e_r7, o_r6;\n\t"
		"add.u64				o_r6, e_r6, o_r5;\n\t"
		"add.u64				o_r5, e_r5, tmp0;\n\t"
		//!msg_add_odd(cv_l, cv_r, i_state)
		"xor.b64				cv_l0, o_l0, cv_l0;\n\t"
		"xor.b64				cv_l1, o_l1, cv_l1;\n\t"
		"xor.b64				cv_l2, o_l2, cv_l2;\n\t"
		"xor.b64				cv_l3, o_l3, cv_l3;\n\t"
		"xor.b64				cv_l4, o_l4, cv_l4;\n\t"
		"xor.b64				cv_l5, o_l5, cv_l5;\n\t"
		"xor.b64				cv_l6, o_l6, cv_l6;\n\t"
		"xor.b64				cv_l7, o_l7, cv_l7;\n\t"
		"xor.b64				cv_r0, o_r0, cv_r0;\n\t"
		"xor.b64				cv_r1, o_r1, cv_r1;\n\t"
		"xor.b64				cv_r2, o_r2, cv_r2;\n\t"
		"xor.b64				cv_r3, o_r3, cv_r3;\n\t"
		"xor.b64				cv_r4, o_r4, cv_r4;\n\t"
		"xor.b64				cv_r5, o_r5, cv_r5;\n\t"
		"xor.b64				cv_r6, o_r6, cv_r6;\n\t"
		"xor.b64				cv_r7, o_r7, cv_r7;\n\t"
		//!MIX(odd)
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_l, 7)
		"shl.b64				tmp0,	cv_l0,	7;\n\t"
		"shr.b64				cv_l0,	cv_l0,	57;\n\t"
		"or.b64					cv_l0,  tmp0, cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	7;\n\t"
		"shr.b64				cv_l1,	cv_l1,	57;\n\t"
		"or.b64					cv_l1,  tmp0, cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	7;\n\t"
		"shr.b64				cv_l2,	cv_l2,	57;\n\t"
		"or.b64					cv_l2,  tmp0, cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	7;\n\t"
		"shr.b64				cv_l3,	cv_l3,	57;\n\t"
		"or.b64					cv_l3,  tmp0, cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	7;\n\t"
		"shr.b64				cv_l4,	cv_l4,	57;\n\t"
		"or.b64					cv_l4,  tmp0, cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	7;\n\t"
		"shr.b64				cv_l5,	cv_l5,	57;\n\t"
		"or.b64					cv_l5,  tmp0, cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	7;\n\t"
		"shr.b64				cv_l6,	cv_l6,	57;\n\t"
		"or.b64					cv_l6,  tmp0, cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	7;\n\t"
		"shr.b64				cv_l7,	cv_l7,	57;\n\t"
		"or.b64					cv_l7,  tmp0, cv_l7;\n\t"
		//xor with const
		"xor.b64				cv_l0, cv_l0, 0x654f1831f254cd66;\n\t"
		"xor.b64				cv_l1, cv_l1, 0x1318a47f0366a25e;\n\t"
		"xor.b64				cv_l2, cv_l2, 0x65752076250b4e01;\n\t"
		"xor.b64				cv_l3, cv_l3, 0xd1cd8eb888071772;\n\t"
		"xor.b64				cv_l4, cv_l4, 0x30c6a9793f4e9b25;\n\t"
		"xor.b64				cv_l5, cv_l5, 0x154f684b1e3926ee;\n\t"
		"xor.b64				cv_l6, cv_l6, 0x6c7ac0b1fe6312ae;\n\t"
		"xor.b64				cv_l7, cv_l7, 0x262f88f4f3c5550d;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 3)
		"shl.b64				tmp0,	cv_r0,	3;\n\t"
		"shr.b64				cv_r0,	cv_r0,	61;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	3;\n\t"
		"shr.b64				cv_r1,	cv_r1,	61;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	3;\n\t"
		"shr.b64				cv_r2,	cv_r2,	61;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	3;\n\t"
		"shr.b64				cv_r3,	cv_r3,	61;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	3;\n\t"
		"shr.b64				cv_r4,	cv_r4,	61;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	3;\n\t"
		"shr.b64				cv_r5,	cv_r5,	61;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	3;\n\t"
		"shr.b64				cv_r6,	cv_r6,	61;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	3;\n\t"
		"shr.b64				cv_r7,	cv_r7,	61;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"

		//MIX(even)
		//rotate_blk(cv_l, 23)
		"shl.b64				tmp0,	cv_l0,	23;\n\t"
		"shr.b64				cv_l0,	cv_l0,	41;\n\t"
		"or.b64					cv_l0,	tmp0,	cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	23;\n\t"
		"shr.b64				cv_l1,	cv_l1,	41;\n\t"
		"or.b64					cv_l1,	tmp0,	cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	23;\n\t"
		"shr.b64				cv_l2,	cv_l2,	41;\n\t"
		"or.b64					cv_l2,	tmp0,	cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	23;\n\t"
		"shr.b64				cv_l3,	cv_l3,	41;\n\t"
		"or.b64					cv_l3,	tmp0,	cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	23;\n\t"
		"shr.b64				cv_l4,	cv_l4,	41;\n\t"
		"or.b64					cv_l4,	tmp0,	cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	23;\n\t"
		"shr.b64				cv_l5,	cv_l5,	41;\n\t"
		"or.b64					cv_l5,	tmp0,	cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	23;\n\t"
		"shr.b64				cv_l6,	cv_l6,	41;\n\t"
		"or.b64					cv_l6,	tmp0,	cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	23;\n\t"
		"shr.b64				cv_l7,	cv_l7,	41;\n\t"
		"or.b64					cv_l7,	tmp0,	cv_l7;\n\t"
		//xor_with_const
		"xor.b64				cv_l0, cv_l0, 0xb4674a24472233cb;\n\t"
		"xor.b64				cv_l1, cv_l1, 0x2bbd23826a090071;\n\t"
		"xor.b64				cv_l2, cv_l2, 0xda95969b30594f66;\n\t"
		"xor.b64				cv_l3, cv_l3, 0x9f5c47408f1e8a43;\n\t"
		"xor.b64				cv_l4, cv_l4, 0xf77022b88de9c055;\n\t"
		"xor.b64				cv_l5, cv_l5, 0x64b7b36957601503;\n\t"
		"xor.b64				cv_l6, cv_l6, 0xe73b72b06175c11a;\n\t"
		"xor.b64				cv_l7, cv_l7, 0x55b87de8b91a6233;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 59)
		"shl.b64				tmp0,	cv_r0,	59;\n\t"
		"shr.b64				cv_r0,	cv_r0,	5;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	59;\n\t"
		"shr.b64				cv_r1,	cv_r1,	5;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	59;\n\t"
		"shr.b64				cv_r2,	cv_r2,	5;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	59;\n\t"
		"shr.b64				cv_r3,	cv_r3,	5;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	59;\n\t"
		"shr.b64				cv_r4,	cv_r4,	5;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	59;\n\t"
		"shr.b64				cv_r5,	cv_r5,	5;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	59;\n\t"
		"shr.b64				cv_r6,	cv_r6,	5;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	59;\n\t"
		"shr.b64				cv_r7,	cv_r7,	5;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"
		//!MsgExp(odd)
		"mov.b64 	            tmp0, o_l0;\n\t"
		"add.u64				o_l0, e_l0, o_l3;\n\t"
		"add.u64				o_l3, e_l3, o_l1;\n\t"
		"add.u64				o_l1, e_l1, o_l2;\n\t"
		"add.u64				o_l2, e_l2, tmp0;\n\t"
		"mov.b64 	            tmp0, o_l4;\n\t"
		"add.u64				o_l4, e_l4, o_l7;\n\t"
		"add.u64				o_l7, e_l7, o_l6;\n\t"
		"add.u64				o_l6, e_l6, o_l5;\n\t"
		"add.u64				o_l5, e_l5, tmp0;\n\t"
		"mov.b64 	            tmp0, o_r0;\n\t"
		"add.u64				o_r0, e_r0, o_r3;\n\t"
		"add.u64				o_r3, e_r3, o_r1;\n\t"
		"add.u64				o_r1, e_r1, o_r2;\n\t"
		"add.u64				o_r2, e_r2, tmp0;\n\t"
		"mov.b64 	            tmp0, o_r4;\n\t"
		"add.u64				o_r4, e_r4, o_r7;\n\t"
		"add.u64				o_r7, e_r7, o_r6;\n\t"
		"add.u64				o_r6, e_r6, o_r5;\n\t"
		"add.u64				o_r5, e_r5, tmp0;\n\t"
		//!msg_add_odd(cv_l, cv_r, i_state)
		"xor.b64				cv_l0, o_l0, cv_l0;\n\t"
		"xor.b64				cv_l1, o_l1, cv_l1;\n\t"
		"xor.b64				cv_l2, o_l2, cv_l2;\n\t"
		"xor.b64				cv_l3, o_l3, cv_l3;\n\t"
		"xor.b64				cv_l4, o_l4, cv_l4;\n\t"
		"xor.b64				cv_l5, o_l5, cv_l5;\n\t"
		"xor.b64				cv_l6, o_l6, cv_l6;\n\t"
		"xor.b64				cv_l7, o_l7, cv_l7;\n\t"
		"xor.b64				cv_r0, o_r0, cv_r0;\n\t"
		"xor.b64				cv_r1, o_r1, cv_r1;\n\t"
		"xor.b64				cv_r2, o_r2, cv_r2;\n\t"
		"xor.b64				cv_r3, o_r3, cv_r3;\n\t"
		"xor.b64				cv_r4, o_r4, cv_r4;\n\t"
		"xor.b64				cv_r5, o_r5, cv_r5;\n\t"
		"xor.b64				cv_r6, o_r6, cv_r6;\n\t"
		"xor.b64				cv_r7, o_r7, cv_r7;\n\t"
		//!MIX(odd)
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_l, 7)
		"shl.b64				tmp0,	cv_l0,	7;\n\t"
		"shr.b64				cv_l0,	cv_l0,	57;\n\t"
		"or.b64					cv_l0,  tmp0, cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	7;\n\t"
		"shr.b64				cv_l1,	cv_l1,	57;\n\t"
		"or.b64					cv_l1,  tmp0, cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	7;\n\t"
		"shr.b64				cv_l2,	cv_l2,	57;\n\t"
		"or.b64					cv_l2,  tmp0, cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	7;\n\t"
		"shr.b64				cv_l3,	cv_l3,	57;\n\t"
		"or.b64					cv_l3,  tmp0, cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	7;\n\t"
		"shr.b64				cv_l4,	cv_l4,	57;\n\t"
		"or.b64					cv_l4,  tmp0, cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	7;\n\t"
		"shr.b64				cv_l5,	cv_l5,	57;\n\t"
		"or.b64					cv_l5,  tmp0, cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	7;\n\t"
		"shr.b64				cv_l6,	cv_l6,	57;\n\t"
		"or.b64					cv_l6,  tmp0, cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	7;\n\t"
		"shr.b64				cv_l7,	cv_l7,	57;\n\t"
		"or.b64					cv_l7,  tmp0, cv_l7;\n\t"
		//xor with const
		"xor.b64				cv_l0, cv_l0, 0x1bb16e6b6955ff7f;\n\t"
		"xor.b64				cv_l1, cv_l1, 0xe8e0a5ec7309719c;\n\t"
		"xor.b64				cv_l2, cv_l2, 0x702c31cb89a8b640;\n\t"
		"xor.b64				cv_l3, cv_l3, 0xfba387cfada8cde2;\n\t"
		"xor.b64				cv_l4, cv_l4, 0x6792db4677aa164c;\n\t"
		"xor.b64				cv_l5, cv_l5, 0x1c6b1cc0b7751867;\n\t"
		"xor.b64				cv_l6, cv_l6, 0x22ae2311d736dc01;\n\t"
		"xor.b64				cv_l7, cv_l7, 0x0e3666a1d37c9588;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 3)
		"shl.b64				tmp0,	cv_r0,	3;\n\t"
		"shr.b64				cv_r0,	cv_r0,	61;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	3;\n\t"
		"shr.b64				cv_r1,	cv_r1,	61;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	3;\n\t"
		"shr.b64				cv_r2,	cv_r2,	61;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	3;\n\t"
		"shr.b64				cv_r3,	cv_r3,	61;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	3;\n\t"
		"shr.b64				cv_r4,	cv_r4,	61;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	3;\n\t"
		"shr.b64				cv_r5,	cv_r5,	61;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	3;\n\t"
		"shr.b64				cv_r6,	cv_r6,	61;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	3;\n\t"
		"shr.b64				cv_r7,	cv_r7,	61;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"

		//MIX(even)
		//rotate_blk(cv_l, 23)
		"shl.b64				tmp0,	cv_l0,	23;\n\t"
		"shr.b64				cv_l0,	cv_l0,	41;\n\t"
		"or.b64					cv_l0,	tmp0,	cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	23;\n\t"
		"shr.b64				cv_l1,	cv_l1,	41;\n\t"
		"or.b64					cv_l1,	tmp0,	cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	23;\n\t"
		"shr.b64				cv_l2,	cv_l2,	41;\n\t"
		"or.b64					cv_l2,	tmp0,	cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	23;\n\t"
		"shr.b64				cv_l3,	cv_l3,	41;\n\t"
		"or.b64					cv_l3,	tmp0,	cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	23;\n\t"
		"shr.b64				cv_l4,	cv_l4,	41;\n\t"
		"or.b64					cv_l4,	tmp0,	cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	23;\n\t"
		"shr.b64				cv_l5,	cv_l5,	41;\n\t"
		"or.b64					cv_l5,	tmp0,	cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	23;\n\t"
		"shr.b64				cv_l6,	cv_l6,	41;\n\t"
		"or.b64					cv_l6,	tmp0,	cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	23;\n\t"
		"shr.b64				cv_l7,	cv_l7,	41;\n\t"
		"or.b64					cv_l7,	tmp0,	cv_l7;\n\t"
		//xor_with_const
		"xor.b64				cv_l0, cv_l0, 0xcd1fd9d4bf557e9a;\n\t"
		"xor.b64				cv_l1, cv_l1, 0xc986925f7c7b0e84;\n\t"
		"xor.b64				cv_l2, cv_l2, 0x9c5dfd55325ef6b0;\n\t"
		"xor.b64				cv_l3, cv_l3, 0x9f2b577d5676b0dd;\n\t"
		"xor.b64				cv_l4, cv_l4, 0xfa6e21be21c062b3;\n\t"
		"xor.b64				cv_l5, cv_l5, 0x8787dd782c8d7f83;\n\t"
		"xor.b64				cv_l6, cv_l6, 0xd0d134e90e12dd23;\n\t"
		"xor.b64				cv_l7, cv_l7, 0x449d087550121d96;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 59)
		"shl.b64				tmp0,	cv_r0,	59;\n\t"
		"shr.b64				cv_r0,	cv_r0,	5;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	59;\n\t"
		"shr.b64				cv_r1,	cv_r1,	5;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	59;\n\t"
		"shr.b64				cv_r2,	cv_r2,	5;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	59;\n\t"
		"shr.b64				cv_r3,	cv_r3,	5;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	59;\n\t"
		"shr.b64				cv_r4,	cv_r4,	5;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	59;\n\t"
		"shr.b64				cv_r5,	cv_r5,	5;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	59;\n\t"
		"shr.b64				cv_r6,	cv_r6,	5;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	59;\n\t"
		"shr.b64				cv_r7,	cv_r7,	5;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"
		//!MsgExp(odd)
		"mov.b64 	            tmp0, o_l0;\n\t"
		"add.u64				o_l0, e_l0, o_l3;\n\t"
		"add.u64				o_l3, e_l3, o_l1;\n\t"
		"add.u64				o_l1, e_l1, o_l2;\n\t"
		"add.u64				o_l2, e_l2, tmp0;\n\t"
		"mov.b64 	            tmp0, o_l4;\n\t"
		"add.u64				o_l4, e_l4, o_l7;\n\t"
		"add.u64				o_l7, e_l7, o_l6;\n\t"
		"add.u64				o_l6, e_l6, o_l5;\n\t"
		"add.u64				o_l5, e_l5, tmp0;\n\t"
		"mov.b64 	            tmp0, o_r0;\n\t"
		"add.u64				o_r0, e_r0, o_r3;\n\t"
		"add.u64				o_r3, e_r3, o_r1;\n\t"
		"add.u64				o_r1, e_r1, o_r2;\n\t"
		"add.u64				o_r2, e_r2, tmp0;\n\t"
		"mov.b64 	            tmp0, o_r4;\n\t"
		"add.u64				o_r4, e_r4, o_r7;\n\t"
		"add.u64				o_r7, e_r7, o_r6;\n\t"
		"add.u64				o_r6, e_r6, o_r5;\n\t"
		"add.u64				o_r5, e_r5, tmp0;\n\t"
		//!msg_add_odd(cv_l, cv_r, i_state)
		"xor.b64				cv_l0, o_l0, cv_l0;\n\t"
		"xor.b64				cv_l1, o_l1, cv_l1;\n\t"
		"xor.b64				cv_l2, o_l2, cv_l2;\n\t"
		"xor.b64				cv_l3, o_l3, cv_l3;\n\t"
		"xor.b64				cv_l4, o_l4, cv_l4;\n\t"
		"xor.b64				cv_l5, o_l5, cv_l5;\n\t"
		"xor.b64				cv_l6, o_l6, cv_l6;\n\t"
		"xor.b64				cv_l7, o_l7, cv_l7;\n\t"
		"xor.b64				cv_r0, o_r0, cv_r0;\n\t"
		"xor.b64				cv_r1, o_r1, cv_r1;\n\t"
		"xor.b64				cv_r2, o_r2, cv_r2;\n\t"
		"xor.b64				cv_r3, o_r3, cv_r3;\n\t"
		"xor.b64				cv_r4, o_r4, cv_r4;\n\t"
		"xor.b64				cv_r5, o_r5, cv_r5;\n\t"
		"xor.b64				cv_r6, o_r6, cv_r6;\n\t"
		"xor.b64				cv_r7, o_r7, cv_r7;\n\t"
		//!MIX(odd)
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_l, 7)
		"shl.b64				tmp0,	cv_l0,	7;\n\t"
		"shr.b64				cv_l0,	cv_l0,	57;\n\t"
		"or.b64					cv_l0,  tmp0, cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	7;\n\t"
		"shr.b64				cv_l1,	cv_l1,	57;\n\t"
		"or.b64					cv_l1,  tmp0, cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	7;\n\t"
		"shr.b64				cv_l2,	cv_l2,	57;\n\t"
		"or.b64					cv_l2,  tmp0, cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	7;\n\t"
		"shr.b64				cv_l3,	cv_l3,	57;\n\t"
		"or.b64					cv_l3,  tmp0, cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	7;\n\t"
		"shr.b64				cv_l4,	cv_l4,	57;\n\t"
		"or.b64					cv_l4,  tmp0, cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	7;\n\t"
		"shr.b64				cv_l5,	cv_l5,	57;\n\t"
		"or.b64					cv_l5,  tmp0, cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	7;\n\t"
		"shr.b64				cv_l6,	cv_l6,	57;\n\t"
		"or.b64					cv_l6,  tmp0, cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	7;\n\t"
		"shr.b64				cv_l7,	cv_l7,	57;\n\t"
		"or.b64					cv_l7,  tmp0, cv_l7;\n\t"
		//xor with const
		"xor.b64				cv_l0, cv_l0, 0xecf9ae9414d41967;\n\t"
		"xor.b64				cv_l1, cv_l1, 0x5018f1dbf789934d;\n\t"
		"xor.b64				cv_l2, cv_l2, 0xfa5b52879155a74c;\n\t"
		"xor.b64				cv_l3, cv_l3, 0xca82d4d3cd278e7c;\n\t"
		"xor.b64				cv_l4, cv_l4, 0x688fdfdfe22316ad;\n\t"
		"xor.b64				cv_l5, cv_l5, 0x0f6555a4ba0d030a;\n\t"
		"xor.b64				cv_l6, cv_l6, 0xa2061df720f000f3;\n\t"
		"xor.b64				cv_l7, cv_l7, 0xe1a57dc5622fb3da;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 3)
		"shl.b64				tmp0,	cv_r0,	3;\n\t"
		"shr.b64				cv_r0,	cv_r0,	61;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	3;\n\t"
		"shr.b64				cv_r1,	cv_r1,	61;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	3;\n\t"
		"shr.b64				cv_r2,	cv_r2,	61;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	3;\n\t"
		"shr.b64				cv_r3,	cv_r3,	61;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	3;\n\t"
		"shr.b64				cv_r4,	cv_r4,	61;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	3;\n\t"
		"shr.b64				cv_r5,	cv_r5,	61;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	3;\n\t"
		"shr.b64				cv_r6,	cv_r6,	61;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	3;\n\t"
		"shr.b64				cv_r7,	cv_r7,	61;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"

		//MIX(even)
		//rotate_blk(cv_l, 23)
		"shl.b64				tmp0,	cv_l0,	23;\n\t"
		"shr.b64				cv_l0,	cv_l0,	41;\n\t"
		"or.b64					cv_l0,	tmp0,	cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	23;\n\t"
		"shr.b64				cv_l1,	cv_l1,	41;\n\t"
		"or.b64					cv_l1,	tmp0,	cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	23;\n\t"
		"shr.b64				cv_l2,	cv_l2,	41;\n\t"
		"or.b64					cv_l2,	tmp0,	cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	23;\n\t"
		"shr.b64				cv_l3,	cv_l3,	41;\n\t"
		"or.b64					cv_l3,	tmp0,	cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	23;\n\t"
		"shr.b64				cv_l4,	cv_l4,	41;\n\t"
		"or.b64					cv_l4,	tmp0,	cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	23;\n\t"
		"shr.b64				cv_l5,	cv_l5,	41;\n\t"
		"or.b64					cv_l5,	tmp0,	cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	23;\n\t"
		"shr.b64				cv_l6,	cv_l6,	41;\n\t"
		"or.b64					cv_l6,	tmp0,	cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	23;\n\t"
		"shr.b64				cv_l7,	cv_l7,	41;\n\t"
		"or.b64					cv_l7,	tmp0,	cv_l7;\n\t"
		//xor_with_const
		"xor.b64				cv_l0, cv_l0, 0xe6a842a8e8ed8153;\n\t"
		"xor.b64				cv_l1, cv_l1, 0x690acdd3811ce09d;\n\t"
		"xor.b64				cv_l2, cv_l2, 0x55adda18e6fcf446;\n\t"
		"xor.b64				cv_l3, cv_l3, 0x4d57a8a0f4b60b46;\n\t"
		"xor.b64				cv_l4, cv_l4, 0xf86fbfc20539c415;\n\t"
		"xor.b64				cv_l5, cv_l5, 0x74bafa5ec7100d19;\n\t"
		"xor.b64				cv_l6, cv_l6, 0xa824151810f0f495;\n\t"
		"xor.b64				cv_l7, cv_l7, 0x8723432791e38ebb;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 59)
		"shl.b64				tmp0,	cv_r0,	59;\n\t"
		"shr.b64				cv_r0,	cv_r0,	5;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	59;\n\t"
		"shr.b64				cv_r1,	cv_r1,	5;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	59;\n\t"
		"shr.b64				cv_r2,	cv_r2,	5;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	59;\n\t"
		"shr.b64				cv_r3,	cv_r3,	5;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	59;\n\t"
		"shr.b64				cv_r4,	cv_r4,	5;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	59;\n\t"
		"shr.b64				cv_r5,	cv_r5,	5;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	59;\n\t"
		"shr.b64				cv_r6,	cv_r6,	5;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	59;\n\t"
		"shr.b64				cv_r7,	cv_r7,	5;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"
		//!MsgExp(odd)
		"mov.b64 	            tmp0, o_l0;\n\t"
		"add.u64				o_l0, e_l0, o_l3;\n\t"
		"add.u64				o_l3, e_l3, o_l1;\n\t"
		"add.u64				o_l1, e_l1, o_l2;\n\t"
		"add.u64				o_l2, e_l2, tmp0;\n\t"
		"mov.b64 	            tmp0, o_l4;\n\t"
		"add.u64				o_l4, e_l4, o_l7;\n\t"
		"add.u64				o_l7, e_l7, o_l6;\n\t"
		"add.u64				o_l6, e_l6, o_l5;\n\t"
		"add.u64				o_l5, e_l5, tmp0;\n\t"
		"mov.b64 	            tmp0, o_r0;\n\t"
		"add.u64				o_r0, e_r0, o_r3;\n\t"
		"add.u64				o_r3, e_r3, o_r1;\n\t"
		"add.u64				o_r1, e_r1, o_r2;\n\t"
		"add.u64				o_r2, e_r2, tmp0;\n\t"
		"mov.b64 	            tmp0, o_r4;\n\t"
		"add.u64				o_r4, e_r4, o_r7;\n\t"
		"add.u64				o_r7, e_r7, o_r6;\n\t"
		"add.u64				o_r6, e_r6, o_r5;\n\t"
		"add.u64				o_r5, e_r5, tmp0;\n\t"
		//!msg_add_odd(cv_l, cv_r, i_state)
		"xor.b64				cv_l0, o_l0, cv_l0;\n\t"
		"xor.b64				cv_l1, o_l1, cv_l1;\n\t"
		"xor.b64				cv_l2, o_l2, cv_l2;\n\t"
		"xor.b64				cv_l3, o_l3, cv_l3;\n\t"
		"xor.b64				cv_l4, o_l4, cv_l4;\n\t"
		"xor.b64				cv_l5, o_l5, cv_l5;\n\t"
		"xor.b64				cv_l6, o_l6, cv_l6;\n\t"
		"xor.b64				cv_l7, o_l7, cv_l7;\n\t"
		"xor.b64				cv_r0, o_r0, cv_r0;\n\t"
		"xor.b64				cv_r1, o_r1, cv_r1;\n\t"
		"xor.b64				cv_r2, o_r2, cv_r2;\n\t"
		"xor.b64				cv_r3, o_r3, cv_r3;\n\t"
		"xor.b64				cv_r4, o_r4, cv_r4;\n\t"
		"xor.b64				cv_r5, o_r5, cv_r5;\n\t"
		"xor.b64				cv_r6, o_r6, cv_r6;\n\t"
		"xor.b64				cv_r7, o_r7, cv_r7;\n\t"
		//!MIX(odd)
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_l, 7)
		"shl.b64				tmp0,	cv_l0,	7;\n\t"
		"shr.b64				cv_l0,	cv_l0,	57;\n\t"
		"or.b64					cv_l0,  tmp0, cv_l0;\n\t"
		"shl.b64				tmp0,	cv_l1,	7;\n\t"
		"shr.b64				cv_l1,	cv_l1,	57;\n\t"
		"or.b64					cv_l1,  tmp0, cv_l1;\n\t"
		"shl.b64				tmp0,	cv_l2,	7;\n\t"
		"shr.b64				cv_l2,	cv_l2,	57;\n\t"
		"or.b64					cv_l2,  tmp0, cv_l2;\n\t"
		"shl.b64				tmp0,	cv_l3,	7;\n\t"
		"shr.b64				cv_l3,	cv_l3,	57;\n\t"
		"or.b64					cv_l3,  tmp0, cv_l3;\n\t"
		"shl.b64				tmp0,	cv_l4,	7;\n\t"
		"shr.b64				cv_l4,	cv_l4,	57;\n\t"
		"or.b64					cv_l4,  tmp0, cv_l4;\n\t"
		"shl.b64				tmp0,	cv_l5,	7;\n\t"
		"shr.b64				cv_l5,	cv_l5,	57;\n\t"
		"or.b64					cv_l5,  tmp0, cv_l5;\n\t"
		"shl.b64				tmp0,	cv_l6,	7;\n\t"
		"shr.b64				cv_l6,	cv_l6,	57;\n\t"
		"or.b64					cv_l6,  tmp0, cv_l6;\n\t"
		"shl.b64				tmp0,	cv_l7,	7;\n\t"
		"shr.b64				cv_l7,	cv_l7,	57;\n\t"
		"or.b64					cv_l7,  tmp0, cv_l7;\n\t"
		//xor with const
		"xor.b64				cv_l0, cv_l0, 0x8eeaeb91d66ed539;\n\t"
		"xor.b64				cv_l1, cv_l1, 0x73d8a1549dfd7e06;\n\t"
		"xor.b64				cv_l2, cv_l2, 0x0387f2ffe3f13a9b;\n\t"
		"xor.b64				cv_l3, cv_l3, 0xa5004995aac15193;\n\t"
		"xor.b64				cv_l4, cv_l4, 0x682f81c73efdda0d;\n\t"
		"xor.b64				cv_l5, cv_l5, 0x2fb55925d71d268d;\n\t"
		"xor.b64				cv_l6, cv_l6, 0xcc392d2901e58a3d;\n\t"
		"xor.b64				cv_l7, cv_l7, 0xaa666ab975724a42;\n\t"
		//add_blk(cv_r, cv_l)
		"add.u64				cv_r0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_r1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_r2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_r3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_r4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_r5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_r6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_r7, cv_l7, cv_r7;\n\t"
		//rotate_blk(cv_r, 3)
		"shl.b64				tmp0,	cv_r0,	3;\n\t"
		"shr.b64				cv_r0,	cv_r0,	61;\n\t"
		"or.b64					cv_r0,	tmp0,	cv_r0;\n\t"
		"shl.b64				tmp0,	cv_r1,	3;\n\t"
		"shr.b64				cv_r1,	cv_r1,	61;\n\t"
		"or.b64					cv_r1,	tmp0,	cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	3;\n\t"
		"shr.b64				cv_r2,	cv_r2,	61;\n\t"
		"or.b64					cv_r2,	tmp0,	cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	3;\n\t"
		"shr.b64				cv_r3,	cv_r3,	61;\n\t"
		"or.b64					cv_r3,	tmp0,	cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	3;\n\t"
		"shr.b64				cv_r4,	cv_r4,	61;\n\t"
		"or.b64					cv_r4,	tmp0,	cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	3;\n\t"
		"shr.b64				cv_r5,	cv_r5,	61;\n\t"
		"or.b64					cv_r5,	tmp0,	cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	3;\n\t"
		"shr.b64				cv_r6,	cv_r6,	61;\n\t"
		"or.b64					cv_r6,	tmp0,	cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	3;\n\t"
		"shr.b64				cv_r7,	cv_r7,	61;\n\t"
		"or.b64					cv_r7,	tmp0,	cv_r7;\n\t"
		//add_blk(cv_l, cv_r)
		"add.u64				cv_l0, cv_l0, cv_r0;\n\t"
		"add.u64				cv_l1, cv_l1, cv_r1;\n\t"
		"add.u64				cv_l2, cv_l2, cv_r2;\n\t"
		"add.u64				cv_l3, cv_l3, cv_r3;\n\t"
		"add.u64				cv_l4, cv_l4, cv_r4;\n\t"
		"add.u64				cv_l5, cv_l5, cv_r5;\n\t"
		"add.u64				cv_l6, cv_l6, cv_r6;\n\t"
		"add.u64				cv_l7, cv_l7, cv_r7;\n\t"
		//rotate_msg_gamma(cv_r)
		"shl.b64				tmp0,	cv_r1,	16;\n\t"
		"shr.b64				cv_r1,	cv_r1,	48;\n\t"
		"or.b64					cv_r1,  tmp0, cv_r1;\n\t"
		"shl.b64				tmp0,	cv_r2,	32;\n\t"
		"shr.b64				cv_r2,	cv_r2,	32;\n\t"
		"or.b64					cv_r2,  tmp0, cv_r2;\n\t"
		"shl.b64				tmp0,	cv_r3,	48;\n\t"
		"shr.b64				cv_r3,	cv_r3,	16;\n\t"
		"or.b64					cv_r3,  tmp0, cv_r3;\n\t"
		"shl.b64				tmp0,	cv_r4,	8;\n\t"
		"shr.b64				cv_r4,	cv_r4,	56;\n\t"
		"or.b64					cv_r4,  tmp0, cv_r4;\n\t"
		"shl.b64				tmp0,	cv_r5,	24;\n\t"
		"shr.b64				cv_r5,	cv_r5,	40;\n\t"
		"or.b64					cv_r5,  tmp0, cv_r5;\n\t"
		"shl.b64				tmp0,	cv_r6,	40;\n\t"
		"shr.b64				cv_r6,	cv_r6,	24;\n\t"
		"or.b64					cv_r6,  tmp0, cv_r6;\n\t"
		"shl.b64				tmp0,	cv_r7,	56;\n\t"
		"shr.b64				cv_r7,	cv_r7,	8;\n\t"
		"or.b64					cv_r7,  tmp0, cv_r7;\n\t"
		//!word_perm(cv_l, cv_r)
		"mov.u64 	            tmp0, cv_l0;\n\t"
		"mov.u64 	            cv_l0, cv_l6;\n\t"
		"mov.u64 	            cv_l6, cv_r6;\n\t"
		"mov.u64 	            cv_r6, cv_r2;\n\t"
		"mov.u64 	            cv_r2, cv_l1;\n\t"
		"mov.u64 	            cv_l1, cv_l4;\n\t"
		"mov.u64 	            cv_l4, cv_r4;\n\t"
		"mov.u64 	            cv_r4, cv_r0;\n\t"
		"mov.u64 	            cv_r0, cv_l2;\n\t"
		"mov.u64 	            cv_l2, cv_l5;\n\t"
		"mov.u64 	            cv_l5, cv_r7;\n\t"
		"mov.u64 	            cv_r7, cv_r1;\n\t"
		"mov.u64 	            cv_r1, tmp0;\n\t"
		"mov.u64 	            tmp0, cv_l3;\n\t"
		"mov.u64 	            cv_l3, cv_l7;\n\t"
		"mov.u64 	            cv_l7, cv_r5;\n\t"
		"mov.u64 	            cv_r5, cv_r3;\n\t"
		"mov.u64 	            cv_r3, tmp0;\n\t"

		//!msg_exp_even
		"mov.b64 	            tmp0, e_l0;\n\t"
		"add.u64				e_l0, o_l0, e_l3;\n\t"
		"add.u64				e_l3, o_l3, e_l1;\n\t"
		"add.u64				e_l1, o_l1, e_l2;\n\t"
		"add.u64				e_l2, o_l2, tmp0;\n\t"
		"mov.b64 	            tmp0, e_l4;\n\t"
		"add.u64				e_l4, o_l4, e_l7;\n\t"
		"add.u64				e_l7, o_l7, e_l6;\n\t"
		"add.u64				e_l6, o_l6, e_l5;\n\t"
		"add.u64				e_l5, o_l5, tmp0;\n\t"
		"mov.b64 	            tmp0, e_r0;\n\t"
		"add.u64				e_r0, o_r0, e_r3;\n\t"
		"add.u64				e_r3, o_r3, e_r1;\n\t"
		"add.u64				e_r1, o_r1, e_r2;\n\t"
		"add.u64				e_r2, o_r2, tmp0;\n\t"
		"mov.b64 	            tmp0, e_r4;\n\t"
		"add.u64				e_r4, o_r4, e_r7;\n\t"
		"add.u64				e_r7, o_r7, e_r6;\n\t"
		"add.u64				e_r6, o_r6, e_r5;\n\t"
		"add.u64				e_r5, o_r5, tmp0;\n\t"

		//! msg_add_even(i_state)
		"xor.b64				cv_l0, e_l0, cv_l0;\n\t"
		"xor.b64				cv_l1, e_l1, cv_l1;\n\t"
		"xor.b64				cv_l2, e_l2, cv_l2;\n\t"
		"xor.b64				cv_l3, e_l3, cv_l3;\n\t"
		"xor.b64				cv_l4, e_l4, cv_l4;\n\t"
		"xor.b64				cv_l5, e_l5, cv_l5;\n\t"
		"xor.b64				cv_l6, e_l6, cv_l6;\n\t"
		"xor.b64				cv_l7, e_l7, cv_l7;\n\t"
		"xor.b64				cv_r0, e_r0, cv_r0;\n\t"
		"xor.b64				cv_r1, e_r1, cv_r1;\n\t"
		"xor.b64				cv_r2, e_r2, cv_r2;\n\t"
		"xor.b64				cv_r3, e_r3, cv_r3;\n\t"
		"xor.b64				cv_r4, e_r4, cv_r4;\n\t"
		"xor.b64				cv_r5, e_r5, cv_r5;\n\t"
		"xor.b64				cv_r6, e_r6, cv_r6;\n\t"
		"xor.b64				cv_r7, e_r7, cv_r7;\n\t"
		"mov.b64 	            %0,  cv_l0;\n\t"
		"mov.b64 	            %1,  cv_l1;\n\t"
		"mov.b64 	            %2,  cv_l2;\n\t"
		"mov.b64 	            %3,  cv_l3;\n\t"
		"mov.b64 	            %4,  cv_l4;\n\t"
		"mov.b64 	            %5,  cv_l5;\n\t"
		"mov.b64 	            %6,  cv_l6;\n\t"
		"mov.b64 	            %7,  cv_l7;\n\t"

		"mov.b64 	            %8,  cv_r0;\n\t"
		"mov.b64 	            %9,  cv_r1;\n\t"
		"mov.b64 	            %10,  cv_r2;\n\t"
		"mov.b64 	            %11,  cv_r3;\n\t"
		"mov.b64 	            %12,  cv_r4;\n\t"
		"mov.b64 	            %13,  cv_r5;\n\t"
		"mov.b64 	            %14,  cv_r6;\n\t"
		"mov.b64 	            %15,  cv_r7;\n\t"

		"}"
		:	"+l"(hash[0]), "+l"(hash[1]), "+l"(hash[2]), "+l"(hash[3]), "+l"(hash[4]), "+l"(hash[5]), "+l"(hash[6]), "+l"(hash[7]),
		"+l"(hash[8]), "+l"(hash[9]), "+l"(hash[10]), "+l"(hash[11]), "+l"(hash[12]), "+l"(hash[13]), "+l"(hash[14]), "+l"(hash[15])
		: "l"(hash[0]), "l"(hash[1]), "l"(hash[2]), "l"(hash[3]), "l"(hash[4]), "l"(hash[5]), "l"(hash[6]), "l"(hash[7]),
		"l"(hash[8]), "l"(hash[9]), "l"(hash[10]), "l"(hash[11]), "l"(hash[12]), "l"(hash[13]), "l"(hash[14]), "l"(hash[15])
		"l"(state[0]), "l"(state[1]), "l"(state[2]), "l"(state[3]), "l"(state[4]), "l"(state[5]), "l"(state[6]), "l"(state[7]),
		"l"(state[8]), "l"(state[9]), "l"(state[10]), "l"(state[11]), "l"(state[12]), "l"(state[13]), "l"(state[14]), "l"(state[15]),
		"l"(state[16]), "l"(state[17]), "l"(state[18]), "l"(state[19]), "l"(state[20]), "l"(state[21]), "l"(state[22]), "l"(state[23]),
		"l"(state[24]), "l"(state[25]), "l"(state[26]), "l"(state[27]), "l"(state[28]), "l"(state[29]), "l"(state[30]), "l"(state[31])
	);
}

__device__ void lsh512_final_core(uint64_t* hash_val) {
	hash_val[0] ^= hash_val[8];
	hash_val[1] ^= hash_val[9];
	hash_val[2] ^= hash_val[10];
	hash_val[3] ^= hash_val[11];
	hash_val[4] ^= hash_val[12];
	hash_val[5] ^= hash_val[13];
	hash_val[6] ^= hash_val[14];
	hash_val[7] ^= hash_val[15];

}
__device__ void lsh512_init(LSH512_info* info) {
	for (int i = 0; i < LSH_BLOCK_BYTE_LEN; i++)
		info->sv_pt[i] = 0;
	info->remain_byte_len = 0;

	info->hash_val[0] = 0xadd50f3c7f07094e;
	info->hash_val[1] = 0xe3f3cee8f9418a4f;
	info->hash_val[2] = 0xb527ecde5b3d0ae9;
	info->hash_val[3] = 0x2ef6dec68076f501;
	info->hash_val[4] = 0x8cb994cae5aca216;
	info->hash_val[5] = 0xfbb9eae4bba48cc7;
	info->hash_val[6] = 0x650a526174725fea;
	info->hash_val[7] = 0x1f9a61a73f8d8085;

	info->hash_val[8] = 0xb6607378173b539b;
	info->hash_val[9] = 0x1bc99853b0c0b9ed;
	info->hash_val[10] = 0xdf727fc19b182d47;
	info->hash_val[11] = 0xdbef360cf893a457;
	info->hash_val[12] = 0x4981f5e570147e80;
	info->hash_val[13] = 0xd00c4490ca7d3e30;
	info->hash_val[14] = 0x5d73940c0e4ae1ec;
	info->hash_val[15] = 0x894085e2edb2d819;
}

//test parameters
#define LSH_PT_SIZE		128
#define LSH_HASH_SIZE	64
#define streams			32
__device__ void lsh512_update(LSH512_info* info, uint8_t* pt, uint32_t ptbytelen) {
	uint32_t i, t = 0;
	uint32_t pt_len = ptbytelen;
	uint32_t pt_remain_len = info->remain_byte_len;
	uint8_t test_sv_pt[LSH_PT_SIZE] = { 0, };

	for (i = 0; i < LSH_PT_SIZE; i++) {
		test_sv_pt[i] = pt[i];
	}
	i = 0;

	if (pt_len + pt_remain_len < LSH_BLOCK_BYTE_LEN) {
		memcpy(info->sv_pt + pt_remain_len, test_sv_pt, pt_len);
		info->remain_byte_len += ptbytelen;
		return;
	}


	while (pt_len + pt_remain_len >= LSH_BLOCK_BYTE_LEN) {
		memcpy(info->sv_pt, test_sv_pt + i * LSH_BLOCK_BYTE_LEN, LSH_BLOCK_BYTE_LEN);
		lsh512_core((uint64_t*)info->sv_pt, info->hash_val);
		i++;
		pt_len -= (LSH_BLOCK_BYTE_LEN - pt_remain_len);
		pt_remain_len = 0;
	}

	memcpy(info->sv_pt, test_sv_pt + i * LSH_BLOCK_BYTE_LEN, pt_len);
	info->remain_byte_len = pt_len;
}

__device__ void lsh512_final(LSH512_info* info, uint8_t* sv_hashval) {
	uint32_t pt_remain_len = info->remain_byte_len;
	info->sv_pt[pt_remain_len] = 0x80;
	memset(info->sv_pt + pt_remain_len + 1, 0, LSH_BLOCK_BYTE_LEN - pt_remain_len - 1);
	lsh512_core((uint64_t*)info->sv_pt, info->hash_val);
	lsh512_final_core(info->hash_val);
	memcpy(sv_hashval, info->hash_val, LSH_HASH_BYTE_LEN);
}


__global__ void cuda_lsh512(uint8_t* pt, uint8_t* hash) {

	uint64_t tid_index = (blockDim.x * blockIdx.x) + threadIdx.x;
	uint64_t memory_index = (gridDim.x * blockDim.x);

	uint8_t buffer[LSH_PT_SIZE] = { 0, };
	uint8_t tmp[64] = { 0, };


	//ptx
	//LSH512_info info;
	//lsh512_init(&info);
	//lsh512_update(&info, pt + LSH_PT_SIZE * tid_index, LSH_PT_SIZE);
	//lsh512_final(&info, hash + LSH_HASH_SIZE * tid_index);


	//ptx + coalesced memory

	for (int i = 0; i < LSH_PT_SIZE; i++) {
		buffer[i] = pt[tid_index + i * memory_index];
	}

	LSH512_info info;
	lsh512_init(&info);
	lsh512_update(&info, buffer, LSH_PT_SIZE);
	lsh512_final(&info, tmp);


	for (int i = 0; i < 64; i++) {
		hash[tid_index + i * memory_index] = tmp[i];
	}

}

void ptx_performance_test(uint32_t blocksize, uint32_t threadsize) {
	uint8_t* cpu_pt = NULL;
	uint8_t* cpu_ha = NULL;
	uint8_t* gpu_pt = NULL;
	uint8_t* gpu_ha = NULL;

	cudaEvent_t start, stop;
	cudaError err;
	float elapsed_time_ms = 0.0f;

	cpu_pt = (uint8_t*)malloc(sizeof(uint8_t) * blocksize * threadsize * LSH_PT_SIZE);
	if (cpu_pt == NULL) {
		printf("cpu_pt malloc is fail\n");
		return;
	}
	cpu_ha = (uint8_t*)malloc(sizeof(uint8_t) * blocksize * threadsize * LSH_HASH_SIZE);
	if (cpu_pt == NULL) {
		printf("cpu_pt malloc is fail\n");
		return;
	}
	err = cudaMalloc((void**)&gpu_pt, sizeof(uint8_t) * blocksize * threadsize * LSH_PT_SIZE);
	if (err != cudaSuccess) {
		printf("gpu_pt malloc faile\n");
		return;
	}
	err = cudaMalloc((void**)&gpu_ha, sizeof(uint8_t) * blocksize * threadsize * LSH_HASH_SIZE);
	if (err != cudaSuccess) {
		printf("gpu_ha malloc faile\n");
		return;
	}

	for (int i = 0; i < blocksize * threadsize * LSH_PT_SIZE; i++) {
		cpu_pt[i] = ((i * i + i) * i + i) & 0xff;
	}

	err = cudaMemcpy(gpu_pt, cpu_pt, sizeof(uint8_t) * blocksize * threadsize * LSH_PT_SIZE, cudaMemcpyHostToDevice);
	if (err != cudaSuccess) {
		printf("cudaMemcpy(cpu_pt -> gpu_pt) is fail\n");
		return;
	}

	cudaEventCreate(&start);
	cudaEventCreate(&stop);
	cudaEventRecord(start, 0);

	for (int x = 0; x < 1000; x++) {
		cudaMemcpy(gpu_pt, cpu_pt, sizeof(uint8_t) * blocksize * threadsize * LSH_PT_SIZE, cudaMemcpyHostToDevice);
		cuda_lsh512 << <blocksize, threadsize >> > (gpu_pt, gpu_ha);
		cudaMemcpy(cpu_ha, gpu_ha, sizeof(uint8_t) * blocksize * threadsize * LSH_HASH_SIZE, cudaMemcpyDeviceToHost);
	}
	cudaEventRecord(stop, 0);
	cudaDeviceSynchronize();
	cudaEventSynchronize(start);
	cudaEventSynchronize(stop);
	cudaEventElapsedTime(&elapsed_time_ms, start, stop);

	elapsed_time_ms = elapsed_time_ms / 1000;
	elapsed_time_ms = 1000 / elapsed_time_ms;
	elapsed_time_ms = blocksize * threadsize * elapsed_time_ms;
	elapsed_time_ms /= 1000;
	elapsed_time_ms /= 1000;

	printf("operation/sec (%d, %d) = %4.2fMH/s\n", blocksize, threadsize, elapsed_time_ms);
	printf("%02X\n", cpu_ha[0]);
	cudaFree(gpu_pt);
	cudaFree(gpu_ha);
	free(cpu_pt);
	free(cpu_ha);
}

void cudastream_test(uint32_t blocksize, uint32_t threadsize) {
	uint64_t pt_size = blocksize * threadsize * LSH_PT_SIZE;
	uint64_t ha_size = blocksize * threadsize * LSH_HASH_SIZE;
	cudaStream_t S[streams];

	cudaEvent_t start, stop;
	float elapsed_time_ms = 0.0f;

#if 1
	uint8_t* pt0 = NULL;
	uint8_t* pt1 = NULL;
	uint8_t* pt2 = NULL;
	uint8_t* pt3 = NULL;
	uint8_t* pt4 = NULL;
	uint8_t* pt5 = NULL;
	uint8_t* pt6 = NULL;
	uint8_t* pt7 = NULL;
	uint8_t* pt8 = NULL;
	uint8_t* pt9 = NULL;
	uint8_t* pt10 = NULL;
	uint8_t* pt11 = NULL;
	uint8_t* pt12 = NULL;
	uint8_t* pt13 = NULL;
	uint8_t* pt14 = NULL;
	uint8_t* pt15 = NULL;
	uint8_t* pt16 = NULL;
	uint8_t* pt17 = NULL;
	uint8_t* pt18 = NULL;
	uint8_t* pt19 = NULL;
	uint8_t* pt20 = NULL;
	uint8_t* pt21 = NULL;
	uint8_t* pt22 = NULL;
	uint8_t* pt23 = NULL;
	uint8_t* pt24 = NULL;
	uint8_t* pt25 = NULL;
	uint8_t* pt26 = NULL;
	uint8_t* pt27 = NULL;
	uint8_t* pt28 = NULL;
	uint8_t* pt29 = NULL;
	uint8_t* pt30 = NULL;
	uint8_t* pt31 = NULL;

	uint8_t* ha0 = NULL;
	uint8_t* ha1 = NULL;
	uint8_t* ha2 = NULL;
	uint8_t* ha3 = NULL;
	uint8_t* ha4 = NULL;
	uint8_t* ha5 = NULL;
	uint8_t* ha6 = NULL;
	uint8_t* ha7 = NULL;
	uint8_t* ha8 = NULL;
	uint8_t* ha9 = NULL;
	uint8_t* ha10 = NULL;
	uint8_t* ha11 = NULL;
	uint8_t* ha12 = NULL;
	uint8_t* ha13 = NULL;
	uint8_t* ha14 = NULL;
	uint8_t* ha15 = NULL;
	uint8_t* ha16 = NULL;
	uint8_t* ha17 = NULL;
	uint8_t* ha18 = NULL;
	uint8_t* ha19 = NULL;
	uint8_t* ha20 = NULL;
	uint8_t* ha21 = NULL;
	uint8_t* ha22 = NULL;
	uint8_t* ha23 = NULL;
	uint8_t* ha24 = NULL;
	uint8_t* ha25 = NULL;
	uint8_t* ha26 = NULL;
	uint8_t* ha27 = NULL;
	uint8_t* ha28 = NULL;
	uint8_t* ha29 = NULL;
	uint8_t* ha30 = NULL;
	uint8_t* ha31 = NULL;

	cudaHostAlloc((void**)&pt0, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt1, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt2, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt3, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt4, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt5, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt6, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt7, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt8, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt9, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt10, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt11, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt12, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt13, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt14, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt15, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt16, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt17, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt18, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt19, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt20, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt21, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt22, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt23, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt24, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt25, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt26, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt27, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt28, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt29, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt30, pt_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&pt31, pt_size, cudaHostAllocDefault);

	cudaHostAlloc((void**)&ha0, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha1, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha2, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha3, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha4, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha5, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha6, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha7, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha8, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha9, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha10, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha11, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha12, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha13, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha14, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha15, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha16, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha17, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha18, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha19, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha20, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha21, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha22, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha23, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha24, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha25, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha26, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha27, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha28, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha29, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha30, ha_size, cudaHostAllocDefault);
	cudaHostAlloc((void**)&ha31, ha_size, cudaHostAllocDefault);
#endif

#if 1
	uint8_t* gpu_pt0 = NULL;
	uint8_t* gpu_pt1 = NULL;
	uint8_t* gpu_pt2 = NULL;
	uint8_t* gpu_pt3 = NULL;
	uint8_t* gpu_pt4 = NULL;
	uint8_t* gpu_pt5 = NULL;
	uint8_t* gpu_pt6 = NULL;
	uint8_t* gpu_pt7 = NULL;
	uint8_t* gpu_pt8 = NULL;
	uint8_t* gpu_pt9 = NULL;
	uint8_t* gpu_pt10 = NULL;
	uint8_t* gpu_pt11 = NULL;
	uint8_t* gpu_pt12 = NULL;
	uint8_t* gpu_pt13 = NULL;
	uint8_t* gpu_pt14 = NULL;
	uint8_t* gpu_pt15 = NULL;
	uint8_t* gpu_pt16 = NULL;
	uint8_t* gpu_pt17 = NULL;
	uint8_t* gpu_pt18 = NULL;
	uint8_t* gpu_pt19 = NULL;
	uint8_t* gpu_pt20 = NULL;
	uint8_t* gpu_pt21 = NULL;
	uint8_t* gpu_pt22 = NULL;
	uint8_t* gpu_pt23 = NULL;
	uint8_t* gpu_pt24 = NULL;
	uint8_t* gpu_pt25 = NULL;
	uint8_t* gpu_pt26 = NULL;
	uint8_t* gpu_pt27 = NULL;
	uint8_t* gpu_pt28 = NULL;
	uint8_t* gpu_pt29 = NULL;
	uint8_t* gpu_pt30 = NULL;
	uint8_t* gpu_pt31 = NULL;

	uint8_t* gpu_ha0 = NULL;
	uint8_t* gpu_ha1 = NULL;
	uint8_t* gpu_ha2 = NULL;
	uint8_t* gpu_ha3 = NULL;
	uint8_t* gpu_ha4 = NULL;
	uint8_t* gpu_ha5 = NULL;
	uint8_t* gpu_ha6 = NULL;
	uint8_t* gpu_ha7 = NULL;
	uint8_t* gpu_ha8 = NULL;
	uint8_t* gpu_ha9 = NULL;
	uint8_t* gpu_ha10 = NULL;
	uint8_t* gpu_ha11 = NULL;
	uint8_t* gpu_ha12 = NULL;
	uint8_t* gpu_ha13 = NULL;
	uint8_t* gpu_ha14 = NULL;
	uint8_t* gpu_ha15 = NULL;
	uint8_t* gpu_ha16 = NULL;
	uint8_t* gpu_ha17 = NULL;
	uint8_t* gpu_ha18 = NULL;
	uint8_t* gpu_ha19 = NULL;
	uint8_t* gpu_ha20 = NULL;
	uint8_t* gpu_ha21 = NULL;
	uint8_t* gpu_ha22 = NULL;
	uint8_t* gpu_ha23 = NULL;
	uint8_t* gpu_ha24 = NULL;
	uint8_t* gpu_ha25 = NULL;
	uint8_t* gpu_ha26 = NULL;
	uint8_t* gpu_ha27 = NULL;
	uint8_t* gpu_ha28 = NULL;
	uint8_t* gpu_ha29 = NULL;
	uint8_t* gpu_ha30 = NULL;
	uint8_t* gpu_ha31 = NULL;

	cudaMalloc((void**)&gpu_pt0, pt_size);
	cudaMalloc((void**)&gpu_pt1, pt_size);
	cudaMalloc((void**)&gpu_pt2, pt_size);
	cudaMalloc((void**)&gpu_pt3, pt_size);
	cudaMalloc((void**)&gpu_pt4, pt_size);
	cudaMalloc((void**)&gpu_pt5, pt_size);
	cudaMalloc((void**)&gpu_pt6, pt_size);
	cudaMalloc((void**)&gpu_pt7, pt_size);
	cudaMalloc((void**)&gpu_pt8, pt_size);
	cudaMalloc((void**)&gpu_pt9, pt_size);
	cudaMalloc((void**)&gpu_pt10, pt_size);
	cudaMalloc((void**)&gpu_pt11, pt_size);
	cudaMalloc((void**)&gpu_pt12, pt_size);
	cudaMalloc((void**)&gpu_pt13, pt_size);
	cudaMalloc((void**)&gpu_pt14, pt_size);
	cudaMalloc((void**)&gpu_pt15, pt_size);
	cudaMalloc((void**)&gpu_pt16, pt_size);
	cudaMalloc((void**)&gpu_pt17, pt_size);
	cudaMalloc((void**)&gpu_pt18, pt_size);
	cudaMalloc((void**)&gpu_pt19, pt_size);
	cudaMalloc((void**)&gpu_pt20, pt_size);
	cudaMalloc((void**)&gpu_pt21, pt_size);
	cudaMalloc((void**)&gpu_pt22, pt_size);
	cudaMalloc((void**)&gpu_pt23, pt_size);
	cudaMalloc((void**)&gpu_pt24, pt_size);
	cudaMalloc((void**)&gpu_pt25, pt_size);
	cudaMalloc((void**)&gpu_pt26, pt_size);
	cudaMalloc((void**)&gpu_pt27, pt_size);
	cudaMalloc((void**)&gpu_pt28, pt_size);
	cudaMalloc((void**)&gpu_pt29, pt_size);
	cudaMalloc((void**)&gpu_pt30, pt_size);
	cudaMalloc((void**)&gpu_pt31, pt_size);

	cudaMalloc((void**)&gpu_ha0, ha_size);
	cudaMalloc((void**)&gpu_ha1, ha_size);
	cudaMalloc((void**)&gpu_ha2, ha_size);
	cudaMalloc((void**)&gpu_ha3, ha_size);
	cudaMalloc((void**)&gpu_ha4, ha_size);
	cudaMalloc((void**)&gpu_ha5, ha_size);
	cudaMalloc((void**)&gpu_ha6, ha_size);
	cudaMalloc((void**)&gpu_ha7, ha_size);
	cudaMalloc((void**)&gpu_ha8, ha_size);
	cudaMalloc((void**)&gpu_ha9, ha_size);
	cudaMalloc((void**)&gpu_ha10, ha_size);
	cudaMalloc((void**)&gpu_ha11, ha_size);
	cudaMalloc((void**)&gpu_ha12, ha_size);
	cudaMalloc((void**)&gpu_ha13, ha_size);
	cudaMalloc((void**)&gpu_ha14, ha_size);
	cudaMalloc((void**)&gpu_ha15, ha_size);
	cudaMalloc((void**)&gpu_ha16, ha_size);
	cudaMalloc((void**)&gpu_ha17, ha_size);
	cudaMalloc((void**)&gpu_ha18, ha_size);
	cudaMalloc((void**)&gpu_ha19, ha_size);
	cudaMalloc((void**)&gpu_ha20, ha_size);
	cudaMalloc((void**)&gpu_ha21, ha_size);
	cudaMalloc((void**)&gpu_ha22, ha_size);
	cudaMalloc((void**)&gpu_ha23, ha_size);
	cudaMalloc((void**)&gpu_ha24, ha_size);
	cudaMalloc((void**)&gpu_ha25, ha_size);
	cudaMalloc((void**)&gpu_ha26, ha_size);
	cudaMalloc((void**)&gpu_ha27, ha_size);
	cudaMalloc((void**)&gpu_ha28, ha_size);
	cudaMalloc((void**)&gpu_ha29, ha_size);
	cudaMalloc((void**)&gpu_ha30, ha_size);
	cudaMalloc((void**)&gpu_ha31, ha_size);
#endif

#if 1
	memset(pt0, 0, pt_size);
	memset(pt1, 1, pt_size);
	memset(pt2, 2, pt_size);
	memset(pt3, 3, pt_size);
	memset(pt4, 4, pt_size);
	memset(pt5, 5, pt_size);
	memset(pt6, 6, pt_size);
	memset(pt7, 7, pt_size);
	memset(pt8, 8, pt_size);
	memset(pt9, 9, pt_size);
	memset(pt10, 10, pt_size);
	memset(pt11, 11, pt_size);
	memset(pt12, 12, pt_size);
	memset(pt13, 13, pt_size);
	memset(pt14, 14, pt_size);
	memset(pt15, 15, pt_size);
	memset(pt16, 16, pt_size);
	memset(pt17, 17, pt_size);
	memset(pt18, 18, pt_size);
	memset(pt19, 19, pt_size);
	memset(pt20, 20, pt_size);
	memset(pt21, 21, pt_size);
	memset(pt22, 22, pt_size);
	memset(pt23, 23, pt_size);
	//memset(pt24, 24, pt_size);
	//memset(pt25, 25, pt_size);
	//memset(pt26, 26, pt_size);
	//memset(pt27, 27, pt_size);
	//memset(pt28, 28, pt_size);
	//memset(pt29, 29, pt_size);
	//memset(pt30, 30, pt_size);
	//memset(pt31, 0, pt_size);

	cudaStreamCreate(&S[0]);
	cudaStreamCreate(&S[1]);
	cudaStreamCreate(&S[2]);
	cudaStreamCreate(&S[3]);
	cudaStreamCreate(&S[4]);
	cudaStreamCreate(&S[5]);
	cudaStreamCreate(&S[6]);
	cudaStreamCreate(&S[7]);
	cudaStreamCreate(&S[8]);
	cudaStreamCreate(&S[9]);
	cudaStreamCreate(&S[10]);
	cudaStreamCreate(&S[11]);
	cudaStreamCreate(&S[12]);
	cudaStreamCreate(&S[13]);
	cudaStreamCreate(&S[14]);
	cudaStreamCreate(&S[15]);
	cudaStreamCreate(&S[16]);
	cudaStreamCreate(&S[17]);
	cudaStreamCreate(&S[18]);
	cudaStreamCreate(&S[19]);
	cudaStreamCreate(&S[20]);
	cudaStreamCreate(&S[21]);
	cudaStreamCreate(&S[22]);
	cudaStreamCreate(&S[23]);
	//cudaStreamCreate(&S[24]);
	//cudaStreamCreate(&S[25]);
	//cudaStreamCreate(&S[26]);
	//cudaStreamCreate(&S[27]);
	//cudaStreamCreate(&S[28]);
	//cudaStreamCreate(&S[29]);
	//cudaStreamCreate(&S[30]);
	//cudaStreamCreate(&S[31]);
#endif

#if 1
	cudaEventCreate(&start);
	cudaEventCreate(&stop);
	cudaEventRecord(start, 0);

	for (int i = 0; i < 100; i++) {
		cudaMemcpyAsync(gpu_pt0, pt0, pt_size, cudaMemcpyHostToDevice, S[0]);
		cuda_lsh512 << <blocksize, threadsize, 0, S[0] >> > (gpu_pt0, gpu_ha0);
		cudaMemcpyAsync(ha0, gpu_ha0, ha_size, cudaMemcpyDeviceToHost, S[0]);

		cudaMemcpyAsync(gpu_pt1, pt1, pt_size, cudaMemcpyHostToDevice, S[1]);
		cuda_lsh512 << <blocksize, threadsize, 0, S[1] >> > (gpu_pt1, gpu_ha1);
		cudaMemcpyAsync(ha1, gpu_ha1, ha_size, cudaMemcpyDeviceToHost, S[1]);

		cudaMemcpyAsync(gpu_pt2, pt2, pt_size, cudaMemcpyHostToDevice, S[2]);
		cuda_lsh512 << <blocksize, threadsize, 0, S[2] >> > (gpu_pt2, gpu_ha2);
		cudaMemcpyAsync(ha2, gpu_ha2, ha_size, cudaMemcpyDeviceToHost, S[2]);

		cudaMemcpyAsync(gpu_pt3, pt3, pt_size, cudaMemcpyHostToDevice, S[3]);
		cuda_lsh512 << <blocksize, threadsize, 0, S[3] >> > (gpu_pt3, gpu_ha3);
		cudaMemcpyAsync(ha3, gpu_ha3, ha_size, cudaMemcpyDeviceToHost, S[3]);

		cudaMemcpyAsync(gpu_pt4, pt4, pt_size, cudaMemcpyHostToDevice, S[4]);
		cuda_lsh512 << <blocksize, threadsize, 0, S[4] >> > (gpu_pt4, gpu_ha4);
		cudaMemcpyAsync(ha4, gpu_ha4, ha_size, cudaMemcpyDeviceToHost, S[4]);

		cudaMemcpyAsync(gpu_pt5, pt5, pt_size, cudaMemcpyHostToDevice, S[5]);
		cuda_lsh512 << <blocksize, threadsize, 0, S[5] >> > (gpu_pt5, gpu_ha5);
		cudaMemcpyAsync(ha5, gpu_ha5, ha_size, cudaMemcpyDeviceToHost, S[5]);

		cudaMemcpyAsync(gpu_pt6, pt6, pt_size, cudaMemcpyHostToDevice, S[6]);
		cuda_lsh512 << <blocksize, threadsize, 0, S[6] >> > (gpu_pt6, gpu_ha6);
		cudaMemcpyAsync(ha6, gpu_ha6, ha_size, cudaMemcpyDeviceToHost, S[6]);

		cudaMemcpyAsync(gpu_pt7, pt7, pt_size, cudaMemcpyHostToDevice, S[7]);
		cuda_lsh512 << <blocksize, threadsize, 0, S[7] >> > (gpu_pt7, gpu_ha7);
		cudaMemcpyAsync(ha7, gpu_ha7, ha_size, cudaMemcpyDeviceToHost, S[7]);

		cudaMemcpyAsync(gpu_pt8, pt8, pt_size, cudaMemcpyHostToDevice, S[8]);
		cuda_lsh512 << <blocksize, threadsize, 0, S[8] >> > (gpu_pt8, gpu_ha8);
		cudaMemcpyAsync(ha8, gpu_ha8, ha_size, cudaMemcpyDeviceToHost, S[8]);

		cudaMemcpyAsync(gpu_pt9, pt9, pt_size, cudaMemcpyHostToDevice, S[9]);
		cuda_lsh512 << <blocksize, threadsize, 0, S[9] >> > (gpu_pt9, gpu_ha9);
		cudaMemcpyAsync(ha9, gpu_ha9, ha_size, cudaMemcpyDeviceToHost, S[9]);

		cudaMemcpyAsync(gpu_pt10, pt10, pt_size, cudaMemcpyHostToDevice, S[10]);
		cuda_lsh512 << <blocksize, threadsize, 0, S[10] >> > (gpu_pt10, gpu_ha10);
		cudaMemcpyAsync(ha10, gpu_ha10, ha_size, cudaMemcpyDeviceToHost, S[10]);

		cudaMemcpyAsync(gpu_pt11, pt11, pt_size, cudaMemcpyHostToDevice, S[11]);
		cuda_lsh512 << <blocksize, threadsize, 0, S[11] >> > (gpu_pt11, gpu_ha11);
		cudaMemcpyAsync(ha11, gpu_ha11, ha_size, cudaMemcpyDeviceToHost, S[11]);

		cudaMemcpyAsync(gpu_pt12, pt12, pt_size, cudaMemcpyHostToDevice, S[12]);
		cuda_lsh512 << <blocksize, threadsize, 0, S[12] >> > (gpu_pt12, gpu_ha12);
		cudaMemcpyAsync(ha12, gpu_ha12, ha_size, cudaMemcpyDeviceToHost, S[12]);

		cudaMemcpyAsync(gpu_pt13, pt13, pt_size, cudaMemcpyHostToDevice, S[13]);
		cuda_lsh512 << <blocksize, threadsize, 0, S[13] >> > (gpu_pt13, gpu_ha13);
		cudaMemcpyAsync(ha13, gpu_ha13, ha_size, cudaMemcpyDeviceToHost, S[13]);

		cudaMemcpyAsync(gpu_pt14, pt14, pt_size, cudaMemcpyHostToDevice, S[14]);
		cuda_lsh512 << <blocksize, threadsize, 0, S[14] >> > (gpu_pt14, gpu_ha14);
		cudaMemcpyAsync(ha14, gpu_ha14, ha_size, cudaMemcpyDeviceToHost, S[14]);

		cudaMemcpyAsync(gpu_pt15, pt15, pt_size, cudaMemcpyHostToDevice, S[15]);
		cuda_lsh512 << <blocksize, threadsize, 0, S[15] >> > (gpu_pt15, gpu_ha15);
		cudaMemcpyAsync(ha15, gpu_ha15, ha_size, cudaMemcpyDeviceToHost, S[15]);

		cudaMemcpyAsync(gpu_pt16, pt16, pt_size, cudaMemcpyHostToDevice, S[16]);
		cuda_lsh512 << <blocksize, threadsize, 0, S[16] >> > (gpu_pt16, gpu_ha16);
		cudaMemcpyAsync(ha16, gpu_ha16, ha_size, cudaMemcpyDeviceToHost, S[16]);

		cudaMemcpyAsync(gpu_pt17, pt17, pt_size, cudaMemcpyHostToDevice, S[17]);
		cuda_lsh512 << <blocksize, threadsize, 0, S[17] >> > (gpu_pt17, gpu_ha17);
		cudaMemcpyAsync(ha17, gpu_ha17, ha_size, cudaMemcpyDeviceToHost, S[17]);

		cudaMemcpyAsync(gpu_pt18, pt18, pt_size, cudaMemcpyHostToDevice, S[18]);
		cuda_lsh512 << <blocksize, threadsize, 0, S[18] >> > (gpu_pt18, gpu_ha18);
		cudaMemcpyAsync(ha18, gpu_ha18, ha_size, cudaMemcpyDeviceToHost, S[18]);

		cudaMemcpyAsync(gpu_pt19, pt19, pt_size, cudaMemcpyHostToDevice, S[19]);
		cuda_lsh512 << <blocksize, threadsize, 0, S[19] >> > (gpu_pt19, gpu_ha19);
		cudaMemcpyAsync(ha19, gpu_ha19, ha_size, cudaMemcpyDeviceToHost, S[19]);

		cudaMemcpyAsync(gpu_pt20, pt20, pt_size, cudaMemcpyHostToDevice, S[20]);
		cuda_lsh512 << <blocksize, threadsize, 0, S[20] >> > (gpu_pt20, gpu_ha20);
		cudaMemcpyAsync(ha20, gpu_ha20, ha_size, cudaMemcpyDeviceToHost, S[20]);

		cudaMemcpyAsync(gpu_pt21, pt21, pt_size, cudaMemcpyHostToDevice, S[21]);
		cuda_lsh512 << <blocksize, threadsize, 0, S[21] >> > (gpu_pt21, gpu_ha21);
		cudaMemcpyAsync(ha21, gpu_ha21, ha_size, cudaMemcpyDeviceToHost, S[21]);

		cudaMemcpyAsync(gpu_pt22, pt22, pt_size, cudaMemcpyHostToDevice, S[22]);
		cuda_lsh512 << <blocksize, threadsize, 0, S[22] >> > (gpu_pt22, gpu_ha22);
		cudaMemcpyAsync(ha22, gpu_ha22, ha_size, cudaMemcpyDeviceToHost, S[22]);

		cudaMemcpyAsync(gpu_pt23, pt23, pt_size, cudaMemcpyHostToDevice, S[23]);
		cuda_lsh512 << <blocksize, threadsize, 0, S[23] >> > (gpu_pt23, gpu_ha23);
		cudaMemcpyAsync(ha23, gpu_ha23, ha_size, cudaMemcpyDeviceToHost, S[23]);

		//cudaMemcpyAsync(gpu_pt24, pt24, pt_size, cudaMemcpyHostToDevice, S[24]);
		//cuda_lsh512 << <blocksize, threadsize, 0, S[24] >> > (gpu_pt24, gpu_ha24);
		//cudaMemcpyAsync(ha24, gpu_ha24, ha_size, cudaMemcpyDeviceToHost, S[24]);

		//cudaMemcpyAsync(gpu_pt25, pt25, pt_size, cudaMemcpyHostToDevice, S[25]);
		//cuda_lsh512 << <blocksize, threadsize, 0, S[25] >> > (gpu_pt25, gpu_ha25);
		//cudaMemcpyAsync(ha25, gpu_ha25, ha_size, cudaMemcpyDeviceToHost, S[25]);

		//cudaMemcpyAsync(gpu_pt26, pt26, pt_size, cudaMemcpyHostToDevice, S[26]);
		//cuda_lsh512 << <blocksize, threadsize, 0, S[26] >> > (gpu_pt26, gpu_ha26);
		//cudaMemcpyAsync(ha26, gpu_ha26, ha_size, cudaMemcpyDeviceToHost, S[26]);

		//cudaMemcpyAsync(gpu_pt27, pt27, pt_size, cudaMemcpyHostToDevice, S[27]);
		//cuda_lsh512 << <blocksize, threadsize, 0, S[27] >> > (gpu_pt27, gpu_ha27);
		//cudaMemcpyAsync(ha27, gpu_ha27, ha_size, cudaMemcpyDeviceToHost, S[27]);

		//cudaMemcpyAsync(gpu_pt28, pt28, pt_size, cudaMemcpyHostToDevice, S[28]);
		//cuda_lsh512 << <blocksize, threadsize, 0, S[28] >> > (gpu_pt28, gpu_ha28);
		//cudaMemcpyAsync(ha28, gpu_ha28, ha_size, cudaMemcpyDeviceToHost, S[28]);

		//cudaMemcpyAsync(gpu_pt29, pt29, pt_size, cudaMemcpyHostToDevice, S[29]);
		//cuda_lsh512 << <blocksize, threadsize, 0, S[29] >> > (gpu_pt29, gpu_ha29);
		//cudaMemcpyAsync(ha29, gpu_ha29, ha_size, cudaMemcpyDeviceToHost, S[29]);

		//cudaMemcpyAsync(gpu_pt30, pt30, pt_size, cudaMemcpyHostToDevice, S[30]);
		//cuda_lsh512 << <blocksize, threadsize, 0, S[30] >> > (gpu_pt30, gpu_ha30);
		//cudaMemcpyAsync(ha30, gpu_ha30, ha_size, cudaMemcpyDeviceToHost, S[30]);

		//cudaMemcpyAsync(gpu_pt31, pt31, pt_size, cudaMemcpyHostToDevice, S[31]);
		//cuda_lsh512 << <blocksize, threadsize, 0, S[31] >> > (gpu_pt31, gpu_ha31);
		//cudaMemcpyAsync(ha31, gpu_ha31, ha_size, cudaMemcpyDeviceToHost, S[31]);

		cudaStreamSynchronize(S[0]);
		cudaStreamSynchronize(S[1]);
		cudaStreamSynchronize(S[2]);
		cudaStreamSynchronize(S[3]);
		cudaStreamSynchronize(S[4]);
		cudaStreamSynchronize(S[5]);
		cudaStreamSynchronize(S[6]);
		cudaStreamSynchronize(S[7]);
		cudaStreamSynchronize(S[8]);
		cudaStreamSynchronize(S[9]);
		cudaStreamSynchronize(S[10]);
		cudaStreamSynchronize(S[11]);
		cudaStreamSynchronize(S[12]);
		cudaStreamSynchronize(S[13]);
		cudaStreamSynchronize(S[14]);
		cudaStreamSynchronize(S[15]);
		cudaStreamSynchronize(S[16]);
		cudaStreamSynchronize(S[17]);
		cudaStreamSynchronize(S[18]);
		cudaStreamSynchronize(S[19]);
		cudaStreamSynchronize(S[20]);
		cudaStreamSynchronize(S[21]);
		cudaStreamSynchronize(S[22]);
		cudaStreamSynchronize(S[23]);
		//cudaStreamSynchronize(S[24]);
		//cudaStreamSynchronize(S[25]);
		//cudaStreamSynchronize(S[26]);
		//cudaStreamSynchronize(S[27]);
		//cudaStreamSynchronize(S[28]);
		//cudaStreamSynchronize(S[29]);
		//cudaStreamSynchronize(S[30]);
		//cudaStreamSynchronize(S[31]);
	}
	cudaEventRecord(stop, 0);
	cudaDeviceSynchronize();
	cudaEventSynchronize(start);
	cudaEventSynchronize(stop);
	cudaEventElapsedTime(&elapsed_time_ms, start, stop);

	elapsed_time_ms = elapsed_time_ms / 100;
	elapsed_time_ms /= 24;
	elapsed_time_ms = 1000 / elapsed_time_ms;
	elapsed_time_ms = blocksize * threadsize * elapsed_time_ms;
	elapsed_time_ms /= 1000;
	elapsed_time_ms /= 1000;
	printf("operation time (%d, %d) = %4.2fMH/s\n", blocksize, threadsize, elapsed_time_ms);
	printf("%02X \n", ha31[0]);
	cudaStreamDestroy(S[0]);
	cudaStreamDestroy(S[1]);
	cudaStreamDestroy(S[2]);
	cudaStreamDestroy(S[3]);
	cudaStreamDestroy(S[4]);
	cudaStreamDestroy(S[5]);
	cudaStreamDestroy(S[6]);
	cudaStreamDestroy(S[7]);
	cudaStreamDestroy(S[8]);
	cudaStreamDestroy(S[9]);
	cudaStreamDestroy(S[10]);
	cudaStreamDestroy(S[11]);
	cudaStreamDestroy(S[12]);
	cudaStreamDestroy(S[13]);
	cudaStreamDestroy(S[14]);
	cudaStreamDestroy(S[15]);
	cudaStreamDestroy(S[16]);
	cudaStreamDestroy(S[17]);
	cudaStreamDestroy(S[18]);
	cudaStreamDestroy(S[19]);
	cudaStreamDestroy(S[20]);
	cudaStreamDestroy(S[21]);
	cudaStreamDestroy(S[22]);
	cudaStreamDestroy(S[23]);
	//cudaStreamDestroy(S[24]);
	//cudaStreamDestroy(S[25]);
	//cudaStreamDestroy(S[26]);
	//cudaStreamDestroy(S[27]);
	//cudaStreamDestroy(S[28]);
	//cudaStreamDestroy(S[29]);
	//cudaStreamDestroy(S[30]);
	//cudaStreamDestroy(S[31]);
#endif
	cudaFree(gpu_pt0);
	cudaFree(gpu_pt1);
	cudaFree(gpu_pt2);
	cudaFree(gpu_pt3);
	cudaFree(gpu_pt4);
	cudaFree(gpu_pt5);
	cudaFree(gpu_pt6);
	cudaFree(gpu_pt7);
	cudaFree(gpu_pt8);
	cudaFree(gpu_pt9);
	cudaFree(gpu_pt10);
	cudaFree(gpu_pt11);
	cudaFree(gpu_pt12);
	cudaFree(gpu_pt13);
	cudaFree(gpu_pt14);
	cudaFree(gpu_pt15);
	cudaFree(gpu_pt16);
	cudaFree(gpu_pt17);
	cudaFree(gpu_pt18);
	cudaFree(gpu_pt19);
	cudaFree(gpu_pt20);
	cudaFree(gpu_pt21);
	cudaFree(gpu_pt22);
	cudaFree(gpu_pt23);
	//cudaFree(gpu_pt24);
	//cudaFree(gpu_pt25);
	//cudaFree(gpu_pt26);
	//cudaFree(gpu_pt27);
	//cudaFree(gpu_pt28);
	//cudaFree(gpu_pt29);
	//cudaFree(gpu_pt30);
	//cudaFree(gpu_pt31);

	cudaFree(gpu_ha0);
	cudaFree(gpu_ha1);
	cudaFree(gpu_ha2);
	cudaFree(gpu_ha3);
	cudaFree(gpu_ha4);
	cudaFree(gpu_ha5);
	cudaFree(gpu_ha6);
	cudaFree(gpu_ha7);
	cudaFree(gpu_ha8);
	cudaFree(gpu_ha9);
	cudaFree(gpu_ha10);
	cudaFree(gpu_ha11);
	cudaFree(gpu_ha12);
	cudaFree(gpu_ha13);
	cudaFree(gpu_ha14);
	cudaFree(gpu_ha15);
	cudaFree(gpu_ha16);
	cudaFree(gpu_ha17);
	cudaFree(gpu_ha18);
	cudaFree(gpu_ha19);
	cudaFree(gpu_ha20);
	cudaFree(gpu_ha21);
	cudaFree(gpu_ha22);
	cudaFree(gpu_ha23);
	//cudaFree(gpu_ha24);
	//cudaFree(gpu_ha25);
	//cudaFree(gpu_ha26);
	//cudaFree(gpu_ha27);
	//cudaFree(gpu_ha28);
	//cudaFree(gpu_ha29);
	//cudaFree(gpu_ha30);
	//cudaFree(gpu_ha31);

	cudaFreeHost(pt0);
	cudaFreeHost(pt1);
	cudaFreeHost(pt2);
	cudaFreeHost(pt3);
	cudaFreeHost(pt4);
	cudaFreeHost(pt5);
	cudaFreeHost(pt6);
	cudaFreeHost(pt7);
	cudaFreeHost(pt8);
	cudaFreeHost(pt9);
	cudaFreeHost(pt10);
	cudaFreeHost(pt11);
	cudaFreeHost(pt12);
	cudaFreeHost(pt13);
	cudaFreeHost(pt14);
	cudaFreeHost(pt15);
	cudaFreeHost(pt16);
	cudaFreeHost(pt17);
	cudaFreeHost(pt18);
	cudaFreeHost(pt19);
	cudaFreeHost(pt20);
	cudaFreeHost(pt21);
	cudaFreeHost(pt22);
	cudaFreeHost(pt23);
	//cudaFreeHost(pt24);
	//cudaFreeHost(pt25);
	//cudaFreeHost(pt26);
	//cudaFreeHost(pt27);
	//cudaFreeHost(pt28);
	//cudaFreeHost(pt29);
	//cudaFreeHost(pt30);
	//cudaFreeHost(pt31);

	cudaFreeHost(ha0);
	cudaFreeHost(ha1);
	cudaFreeHost(ha2);
	cudaFreeHost(ha3);
	cudaFreeHost(ha4);
	cudaFreeHost(ha5);
	cudaFreeHost(ha6);
	cudaFreeHost(ha7);
	cudaFreeHost(ha8);
	cudaFreeHost(ha9);
	cudaFreeHost(ha10);
	cudaFreeHost(ha11);
	cudaFreeHost(ha12);
	cudaFreeHost(ha13);
	cudaFreeHost(ha14);
	cudaFreeHost(ha15);
	cudaFreeHost(ha16);
	cudaFreeHost(ha17);
	cudaFreeHost(ha18);
	cudaFreeHost(ha19);
	cudaFreeHost(ha20);
	cudaFreeHost(ha21);
	cudaFreeHost(ha22);
	cudaFreeHost(ha23);
	//cudaFreeHost(ha24);
	//cudaFreeHost(ha25);
	//cudaFreeHost(ha26);
	//cudaFreeHost(ha27);
	//cudaFreeHost(ha28);
	//cudaFreeHost(ha29);
	//cudaFreeHost(ha30);
	//cudaFreeHost(ha31);
}

int main() {
	printf("main function start\n");
	uint32_t block_value[17] = { 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768, 65536 };
	uint32_t thread_value[15] = { 1, 2, 4, 8, 16, 32, 64, 128, 256, 384, 512, 640, 768, 896, 1024 };
	cudastream_test(4096, 128);

	/*for (int j = 6; j < 16; j++) {
		cudastream_test(block_value[j], 128);
	}*/
	return 0;
}