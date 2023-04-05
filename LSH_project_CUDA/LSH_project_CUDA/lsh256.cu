#include "lsh256.cuh"

__device__ void lsh256_core(uint32_t* state, uint32_t* hash) {

	//LOAD_MSG_BLK
	asm(".reg.b32               e_l<8>;");
	asm(".reg.b32               e_r<8>;");
	asm(".reg.b32               o_l<8>;");
	asm(".reg.b32               o_r<8>;");

	asm(".reg.b32				cv_l<8>;");
	asm(".reg.b32				cv_r<8>;");
	asm(".reg.b32				tmp<1>;");

	asm("mov.b32 	            cv_l0,        %0;"		:: "r"(hash[0]));
	asm("mov.b32 	            cv_l1,        %0;"		:: "r"(hash[1]));
	asm("mov.b32 	            cv_l2,        %0;"		:: "r"(hash[2]));
	asm("mov.b32 	            cv_l3,        %0;"		:: "r"(hash[3]));
	asm("mov.b32 	            cv_l4,        %0;"		:: "r"(hash[4]));
	asm("mov.b32 	            cv_l5,        %0;"		:: "r"(hash[5]));
	asm("mov.b32 	            cv_l6,        %0;"		:: "r"(hash[6]));
	asm("mov.b32 	            cv_l7,        %0;"		:: "r"(hash[7]));

	asm("mov.b32 	            cv_r0,        %0;"		:: "r"(hash[8]));
	asm("mov.b32 	            cv_r1,        %0;"		:: "r"(hash[9]));
	asm("mov.b32 	            cv_r2,        %0;"		:: "r"(hash[10]));
	asm("mov.b32 	            cv_r3,        %0;"		:: "r"(hash[11]));
	asm("mov.b32 	            cv_r4,        %0;"		:: "r"(hash[12]));
	asm("mov.b32 	            cv_r5,        %0;"		:: "r"(hash[13]));
	asm("mov.b32 	            cv_r6,        %0;"		:: "r"(hash[14]));
	asm("mov.b32 	            cv_r7,        %0;"		:: "r"(hash[15]));

	asm("mov.b32 	            e_l0,        %0;"		:: "r"(state[0]));
	asm("mov.b32 	            e_l1,        %0;"		:: "r"(state[1]));
	asm("mov.b32 	            e_l2,        %0;"		:: "r"(state[2]));
	asm("mov.b32 	            e_l3,        %0;"		:: "r"(state[3]));
	asm("mov.b32 	            e_l4,        %0;"		:: "r"(state[4]));
	asm("mov.b32 	            e_l5,        %0;"		:: "r"(state[5]));
	asm("mov.b32 	            e_l6,        %0;"		:: "r"(state[6]));
	asm("mov.b32 	            e_l7,        %0;"		:: "r"(state[7]));

	asm("mov.b32 	            e_r0,       %0;"		:: "r"(state[8]));
	asm("mov.b32 	            e_r1,       %0;"		:: "r"(state[9]));
	asm("mov.b32 	            e_r2,       %0;"		:: "r"(state[10]));
	asm("mov.b32 	            e_r3,       %0;"		:: "r"(state[11]));
	asm("mov.b32 	            e_r4,       %0;"		:: "r"(state[12]));
	asm("mov.b32 	            e_r5,       %0;"		:: "r"(state[13]));
	asm("mov.b32 	            e_r6,       %0;"		:: "r"(state[14]));
	asm("mov.b32 	            e_r7,       %0;"		:: "r"(state[15]));


	asm("mov.b32 	            o_l0,       %0;"		:: "r"(state[16]));
	asm("mov.b32 	            o_l1,       %0;"		:: "r"(state[17]));
	asm("mov.b32 	            o_l2,       %0;"		:: "r"(state[18]));
	asm("mov.b32 	            o_l3,       %0;"		:: "r"(state[19]));
	asm("mov.b32 	            o_l4,       %0;"		:: "r"(state[20]));
	asm("mov.b32 	            o_l5,       %0;"		:: "r"(state[21]));
	asm("mov.b32 	            o_l6,       %0;"		:: "r"(state[22]));
	asm("mov.b32 	            o_l7,       %0;"		:: "r"(state[23]));

	asm("mov.b32 	            o_r0,       %0;"		:: "r"(state[24]));
	asm("mov.b32 	            o_r1,       %0;"		:: "r"(state[25]));
	asm("mov.b32 	            o_r2,       %0;"		:: "r"(state[26]));
	asm("mov.b32 	            o_r3,       %0;"		:: "r"(state[27]));
	asm("mov.b32 	            o_r4,       %0;"		:: "r"(state[28]));
	asm("mov.b32 	            o_r5,       %0;"		:: "r"(state[29]));
	asm("mov.b32 	            o_r6,       %0;"		:: "r"(state[30]));
	asm("mov.b32 	            o_r7,       %0;"		:: "r"(state[31]));

	//! MSG_ADD_EVEN
	//cv_l part
	asm("xor.b32				cv_l0, e_l0, cv_l0;");
	asm("xor.b32				cv_l1, e_l1, cv_l1;");
	asm("xor.b32				cv_l2, e_l2, cv_l2;");
	asm("xor.b32				cv_l3, e_l3, cv_l3;");
	asm("xor.b32				cv_l4, e_l4, cv_l4;");
	asm("xor.b32				cv_l5, e_l5, cv_l5;");
	asm("xor.b32				cv_l6, e_l6, cv_l6;");
	asm("xor.b32				cv_l7, e_l7, cv_l7;");
	//cv_r part
	asm("xor.b32				cv_r0, e_r0, cv_r0;");
	asm("xor.b32				cv_r1, e_r1, cv_r1;");
	asm("xor.b32				cv_r2, e_r2, cv_r2;");
	asm("xor.b32				cv_r3, e_r3, cv_r3;");
	asm("xor.b32				cv_r4, e_r4, cv_r4;");
	asm("xor.b32				cv_r5, e_r5, cv_r5;");
	asm("xor.b32				cv_r6, e_r6, cv_r6;");
	asm("xor.b32				cv_r7, e_r7, cv_r7;");
	//!MIX(0)
	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_blk(cv_l, 29)
	asm("shf.l.wrap.b32         cv_l0, cv_l0, cv_l0, 29;");
	asm("shf.l.wrap.b32         cv_l1, cv_l1, cv_l1, 29;");
	asm("shf.l.wrap.b32         cv_l2, cv_l2, cv_l2, 29;");
	asm("shf.l.wrap.b32         cv_l3, cv_l3, cv_l3, 29;");
	asm("shf.l.wrap.b32         cv_l4, cv_l4, cv_l4, 29;");
	asm("shf.l.wrap.b32         cv_l5, cv_l5, cv_l5, 29;");
	asm("shf.l.wrap.b32         cv_l6, cv_l6, cv_l6, 29;");
	asm("shf.l.wrap.b32         cv_l7, cv_l7, cv_l7, 29;");

	//xor_with_const
	asm("xor.b32				cv_l0, cv_l0, 0x917caf90;");
	asm("xor.b32				cv_l1, cv_l1, 0x6c1b10a2;");
	asm("xor.b32				cv_l2, cv_l2, 0x6f352943;");
	asm("xor.b32				cv_l3, cv_l3, 0xcf778243;");
	asm("xor.b32				cv_l4, cv_l4, 0x2ceb7472;");
	asm("xor.b32				cv_l5, cv_l5, 0x29e96ff2;");
	asm("xor.b32				cv_l6, cv_l6, 0x8a9ba428;");
	asm("xor.b32				cv_l7, cv_l7, 0x2eeb2642;");

	//add_blk(cv_r, cv_l)
	asm("add.u32				cv_r0, cv_l0, cv_r0;");
	asm("add.u32				cv_r1, cv_l1, cv_r1;");
	asm("add.u32				cv_r2, cv_l2, cv_r2;");
	asm("add.u32				cv_r3, cv_l3, cv_r3;");
	asm("add.u32				cv_r4, cv_l4, cv_r4;");
	asm("add.u32				cv_r5, cv_l5, cv_r5;");
	asm("add.u32				cv_r6, cv_l6, cv_r6;");
	asm("add.u32				cv_r7, cv_l7, cv_r7;");

	//rotate_blk(cv_r, 1)
	asm("shf.l.wrap.b32         cv_r0, cv_r0, cv_r0, 1;");
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 1;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 1;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 1;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 1;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 1;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 1;");
	asm("shf.l.wrap.b32         cv_r7, cv_r7, cv_r7, 1;");

	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_msg_gmma(cv_r)
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 8;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 16;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 24;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 24;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 16;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 8;");

	//!word_perm(cv_l, cv_r)
	asm("mov.b32 	            tmp0, cv_l0;");
	asm("mov.b32 	            cv_l0, cv_l6;");
	asm("mov.b32 	            cv_l6, cv_r6;");
	asm("mov.b32 	            cv_r6, cv_r2;");
	asm("mov.b32 	            cv_r2, cv_l1;");
	asm("mov.b32 	            cv_l1, cv_l4;");
	asm("mov.b32 	            cv_l4, cv_r4;");
	asm("mov.b32 	            cv_r4, cv_r0;");
	asm("mov.b32 	            cv_r0, cv_l2;");
	asm("mov.b32 	            cv_l2, cv_l5;");
	asm("mov.b32 	            cv_l5, cv_r7;");
	asm("mov.b32 	            cv_r7, cv_r1;");
	asm("mov.b32 	            cv_r1, tmp0;");
	asm("mov.b32 	            tmp0, cv_l3;");
	asm("mov.b32 	            cv_l3, cv_l7;");
	asm("mov.b32 	            cv_l7, cv_r5;");
	asm("mov.b32 	            cv_r5, cv_r3;");
	asm("mov.b32 	            cv_r3, tmp0;");

	//!msg_add_odd(cv_l, cv_r, i_state)
	//cv_l part
	asm("xor.b32				cv_l0, o_l0, cv_l0;");
	asm("xor.b32				cv_l1, o_l1, cv_l1;");
	asm("xor.b32				cv_l2, o_l2, cv_l2;");
	asm("xor.b32				cv_l3, o_l3, cv_l3;");
	asm("xor.b32				cv_l4, o_l4, cv_l4;");
	asm("xor.b32				cv_l5, o_l5, cv_l5;");
	asm("xor.b32				cv_l6, o_l6, cv_l6;");
	asm("xor.b32				cv_l7, o_l7, cv_l7;");
	//cv_r part
	asm("xor.b32				cv_r0, o_r0, cv_r0;");
	asm("xor.b32				cv_r1, o_r1, cv_r1;");
	asm("xor.b32				cv_r2, o_r2, cv_r2;");
	asm("xor.b32				cv_r3, o_r3, cv_r3;");
	asm("xor.b32				cv_r4, o_r4, cv_r4;");
	asm("xor.b32				cv_r5, o_r5, cv_r5;");
	asm("xor.b32				cv_r6, o_r6, cv_r6;");
	asm("xor.b32				cv_r7, o_r7, cv_r7;");

	//!MIX(1)
	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_blk(cv_l, 5)
	asm("shf.l.wrap.b32         cv_l0, cv_l0, cv_l0, 5;");
	asm("shf.l.wrap.b32         cv_l1, cv_l1, cv_l1, 5;");
	asm("shf.l.wrap.b32         cv_l2, cv_l2, cv_l2, 5;");
	asm("shf.l.wrap.b32         cv_l3, cv_l3, cv_l3, 5;");
	asm("shf.l.wrap.b32         cv_l4, cv_l4, cv_l4, 5;");
	asm("shf.l.wrap.b32         cv_l5, cv_l5, cv_l5, 5;");
	asm("shf.l.wrap.b32         cv_l6, cv_l6, cv_l6, 5;");
	asm("shf.l.wrap.b32         cv_l7, cv_l7, cv_l7, 5;");

	//xor_with_const(cv_l, const_v)
	asm("xor.b32				cv_l0, cv_l0, 0x0e2c4021;");
	asm("xor.b32				cv_l1, cv_l1, 0x872bb30e;");
	asm("xor.b32				cv_l2, cv_l2, 0xa45e6cb2;");
	asm("xor.b32				cv_l3, cv_l3, 0x46f9c612;");
	asm("xor.b32				cv_l4, cv_l4, 0x185fe69e;");
	asm("xor.b32				cv_l5, cv_l5, 0x1359621b;");
	asm("xor.b32				cv_l6, cv_l6, 0x263fccb2;");
	asm("xor.b32				cv_l7, cv_l7, 0x1a116870;");

	//add_blk(cv_r, cv_l)
	asm("add.u32				cv_r0, cv_l0, cv_r0;");
	asm("add.u32				cv_r1, cv_l1, cv_r1;");
	asm("add.u32				cv_r2, cv_l2, cv_r2;");
	asm("add.u32				cv_r3, cv_l3, cv_r3;");
	asm("add.u32				cv_r4, cv_l4, cv_r4;");
	asm("add.u32				cv_r5, cv_l5, cv_r5;");
	asm("add.u32				cv_r6, cv_l6, cv_r6;");
	asm("add.u32				cv_r7, cv_l7, cv_r7;");

	//rotate_blk(cv_r, 17)
	asm("shf.l.wrap.b32         cv_r0, cv_r0, cv_r0, 17;");
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 17;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 17;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 17;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 17;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 17;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 17;");
	asm("shf.l.wrap.b32         cv_r7, cv_r7, cv_r7, 17;");

	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_msg_gmma(cv_r)
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 8;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 16;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 24;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 24;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 16;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 8;");

	//!word_perm(cv_l, cv_r)
	asm("mov.b32 	            tmp0, cv_l0;");
	asm("mov.b32 	            cv_l0, cv_l6;");
	asm("mov.b32 	            cv_l6, cv_r6;");
	asm("mov.b32 	            cv_r6, cv_r2;");
	asm("mov.b32 	            cv_r2, cv_l1;");
	asm("mov.b32 	            cv_l1, cv_l4;");
	asm("mov.b32 	            cv_l4, cv_r4;");
	asm("mov.b32 	            cv_r4, cv_r0;");
	asm("mov.b32 	            cv_r0, cv_l2;");
	asm("mov.b32 	            cv_l2, cv_l5;");
	asm("mov.b32 	            cv_l5, cv_r7;");
	asm("mov.b32 	            cv_r7, cv_r1;");
	asm("mov.b32 	            cv_r1, tmp0;");
	asm("mov.b32 	            tmp0, cv_l3;");
	asm("mov.b32 	            cv_l3, cv_l7;");
	asm("mov.b32 	            cv_l7, cv_r5;");
	asm("mov.b32 	            cv_r5, cv_r3;");
	asm("mov.b32 	            cv_r3, tmp0;");

	//loop (1)
	//msg_exp_even(i_state)
	asm("mov.b32 	            tmp0, e_l0;");
	asm("add.u32				e_l0, o_l0, e_l3;");
	asm("add.u32				e_l3, o_l3, e_l1;");
	asm("add.u32				e_l1, o_l1, e_l2;");
	asm("add.u32				e_l2, o_l2, tmp0;");

	asm("mov.b32 	            tmp0, e_l4;");
	asm("add.u32				e_l4, o_l4, e_l7;");
	asm("add.u32				e_l7, o_l7, e_l6;");
	asm("add.u32				e_l6, o_l6, e_l5;");
	asm("add.u32				e_l5, o_l5, tmp0;");

	asm("mov.b32 	            tmp0, e_r0;");
	asm("add.u32				e_r0, o_r0, e_r3;");
	asm("add.u32				e_r3, o_r3, e_r1;");
	asm("add.u32				e_r1, o_r1, e_r2;");
	asm("add.u32				e_r2, o_r2, tmp0;");

	asm("mov.b32 	            tmp0, e_r4;");
	asm("add.u32				e_r4, o_r4, e_r7;");
	asm("add.u32				e_r7, o_r7, e_r6;");
	asm("add.u32				e_r6, o_r6, e_r5;");
	asm("add.u32				e_r5, o_r5, tmp0;");

	//! msg_add_even(i_state)
	asm("xor.b32				cv_l0, e_l0, cv_l0;");
	asm("xor.b32				cv_l1, e_l1, cv_l1;");
	asm("xor.b32				cv_l2, e_l2, cv_l2;");
	asm("xor.b32				cv_l3, e_l3, cv_l3;");
	asm("xor.b32				cv_l4, e_l4, cv_l4;");
	asm("xor.b32				cv_l5, e_l5, cv_l5;");
	asm("xor.b32				cv_l6, e_l6, cv_l6;");
	asm("xor.b32				cv_l7, e_l7, cv_l7;");
	asm("xor.b32				cv_r0, e_r0, cv_r0;");
	asm("xor.b32				cv_r1, e_r1, cv_r1;");
	asm("xor.b32				cv_r2, e_r2, cv_r2;");
	asm("xor.b32				cv_r3, e_r3, cv_r3;");
	asm("xor.b32				cv_r4, e_r4, cv_r4;");
	asm("xor.b32				cv_r5, e_r5, cv_r5;");
	asm("xor.b32				cv_r6, e_r6, cv_r6;");
	asm("xor.b32				cv_r7, e_r7, cv_r7;");

	//!MIX(2)
	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_blk(cv_l, 29)
	asm("shf.l.wrap.b32         cv_l0, cv_l0, cv_l0, 29;");
	asm("shf.l.wrap.b32         cv_l1, cv_l1, cv_l1, 29;");
	asm("shf.l.wrap.b32         cv_l2, cv_l2, cv_l2, 29;");
	asm("shf.l.wrap.b32         cv_l3, cv_l3, cv_l3, 29;");
	asm("shf.l.wrap.b32         cv_l4, cv_l4, cv_l4, 29;");
	asm("shf.l.wrap.b32         cv_l5, cv_l5, cv_l5, 29;");
	asm("shf.l.wrap.b32         cv_l6, cv_l6, cv_l6, 29;");
	asm("shf.l.wrap.b32         cv_l7, cv_l7, cv_l7, 29;");

	//xor_with_const
	asm("xor.b32				cv_l0, cv_l0, 0x3a6c612f;");
	asm("xor.b32				cv_l1, cv_l1, 0xb2dec195;");
	asm("xor.b32				cv_l2, cv_l2, 0x02cb1f56;");
	asm("xor.b32				cv_l3, cv_l3, 0x40bfd858;");
	asm("xor.b32				cv_l4, cv_l4, 0x784684b6;");
	asm("xor.b32				cv_l5, cv_l5, 0x6cbb7d2e;");
	asm("xor.b32				cv_l6, cv_l6, 0x660c7ed8;");
	asm("xor.b32				cv_l7, cv_l7, 0x2b79d88a;");

	//add_blk(cv_r, cv_l)
	asm("add.u32				cv_r0, cv_l0, cv_r0;");
	asm("add.u32				cv_r1, cv_l1, cv_r1;");
	asm("add.u32				cv_r2, cv_l2, cv_r2;");
	asm("add.u32				cv_r3, cv_l3, cv_r3;");
	asm("add.u32				cv_r4, cv_l4, cv_r4;");
	asm("add.u32				cv_r5, cv_l5, cv_r5;");
	asm("add.u32				cv_r6, cv_l6, cv_r6;");
	asm("add.u32				cv_r7, cv_l7, cv_r7;");

	//rotate_blk(cv_r, 1)
	asm("shf.l.wrap.b32         cv_r0, cv_r0, cv_r0, 1;");
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 1;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 1;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 1;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 1;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 1;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 1;");
	asm("shf.l.wrap.b32         cv_r7, cv_r7, cv_r7, 1;");

	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_msg_gmma(cv_r)
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 8;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 16;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 24;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 24;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 16;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 8;");

	//!word_perm(cv_l, cv_r)
	asm("mov.b32 	            tmp0, cv_l0;");
	asm("mov.b32 	            cv_l0, cv_l6;");
	asm("mov.b32 	            cv_l6, cv_r6;");
	asm("mov.b32 	            cv_r6, cv_r2;");
	asm("mov.b32 	            cv_r2, cv_l1;");
	asm("mov.b32 	            cv_l1, cv_l4;");
	asm("mov.b32 	            cv_l4, cv_r4;");
	asm("mov.b32 	            cv_r4, cv_r0;");
	asm("mov.b32 	            cv_r0, cv_l2;");
	asm("mov.b32 	            cv_l2, cv_l5;");
	asm("mov.b32 	            cv_l5, cv_r7;");
	asm("mov.b32 	            cv_r7, cv_r1;");
	asm("mov.b32 	            cv_r1, tmp0;");
	asm("mov.b32 	            tmp0, cv_l3;");
	asm("mov.b32 	            cv_l3, cv_l7;");
	asm("mov.b32 	            cv_l7, cv_r5;");
	asm("mov.b32 	            cv_r5, cv_r3;");
	asm("mov.b32 	            cv_r3, tmp0;");

	//!msg_exp_odd(i_state)
	asm("mov.b32 	            tmp0, o_l0;");
	asm("add.u32				o_l0, e_l0, o_l3;");
	asm("add.u32				o_l3, e_l3, o_l1;");
	asm("add.u32				o_l1, e_l1, o_l2;");
	asm("add.u32				o_l2, e_l2, tmp0;");

	asm("mov.b32 	            tmp0, o_l4;");
	asm("add.u32				o_l4, e_l4, o_l7;");
	asm("add.u32				o_l7, e_l7, o_l6;");
	asm("add.u32				o_l6, e_l6, o_l5;");
	asm("add.u32				o_l5, e_l5, tmp0;");

	asm("mov.b32 	            tmp0, o_r0;");
	asm("add.u32				o_r0, e_r0, o_r3;");
	asm("add.u32				o_r3, e_r3, o_r1;");
	asm("add.u32				o_r1, e_r1, o_r2;");
	asm("add.u32				o_r2, e_r2, tmp0;");

	asm("mov.b32 	            tmp0, o_r4;");
	asm("add.u32				o_r4, e_r4, o_r7;");
	asm("add.u32				o_r7, e_r7, o_r6;");
	asm("add.u32				o_r6, e_r6, o_r5;");
	asm("add.u32				o_r5, e_r5, tmp0;");

	//!msg_add_odd(cv_l, cv_r, i_state)
	//cv_l part
	asm("xor.b32				cv_l0, o_l0, cv_l0;");
	asm("xor.b32				cv_l1, o_l1, cv_l1;");
	asm("xor.b32				cv_l2, o_l2, cv_l2;");
	asm("xor.b32				cv_l3, o_l3, cv_l3;");
	asm("xor.b32				cv_l4, o_l4, cv_l4;");
	asm("xor.b32				cv_l5, o_l5, cv_l5;");
	asm("xor.b32				cv_l6, o_l6, cv_l6;");
	asm("xor.b32				cv_l7, o_l7, cv_l7;");
	//cv_r part
	asm("xor.b32				cv_r0, o_r0, cv_r0;");
	asm("xor.b32				cv_r1, o_r1, cv_r1;");
	asm("xor.b32				cv_r2, o_r2, cv_r2;");
	asm("xor.b32				cv_r3, o_r3, cv_r3;");
	asm("xor.b32				cv_r4, o_r4, cv_r4;");
	asm("xor.b32				cv_r5, o_r5, cv_r5;");
	asm("xor.b32				cv_r6, o_r6, cv_r6;");
	asm("xor.b32				cv_r7, o_r7, cv_r7;");

	//!MIX(4)
	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_blk(cv_l, 5)
	asm("shf.l.wrap.b32         cv_l0, cv_l0, cv_l0, 5;");
	asm("shf.l.wrap.b32         cv_l1, cv_l1, cv_l1, 5;");
	asm("shf.l.wrap.b32         cv_l2, cv_l2, cv_l2, 5;");
	asm("shf.l.wrap.b32         cv_l3, cv_l3, cv_l3, 5;");
	asm("shf.l.wrap.b32         cv_l4, cv_l4, cv_l4, 5;");
	asm("shf.l.wrap.b32         cv_l5, cv_l5, cv_l5, 5;");
	asm("shf.l.wrap.b32         cv_l6, cv_l6, cv_l6, 5;");
	asm("shf.l.wrap.b32         cv_l7, cv_l7, cv_l7, 5;");

	//xor_with_const(cv_l, const_v)
	asm("xor.b32				cv_l0, cv_l0, 0xa6cd9069;");
	asm("xor.b32				cv_l1, cv_l1, 0x91a05747;");
	asm("xor.b32				cv_l2, cv_l2, 0xcdea7558;");
	asm("xor.b32				cv_l3, cv_l3, 0x00983098;");
	asm("xor.b32				cv_l4, cv_l4, 0xbecb3b2e;");
	asm("xor.b32				cv_l5, cv_l5, 0x2838ab9a;");
	asm("xor.b32				cv_l6, cv_l6, 0x728b573e;");
	asm("xor.b32				cv_l7, cv_l7, 0xa55262b5;");

	//add_blk(cv_r, cv_l)
	asm("add.u32				cv_r0, cv_l0, cv_r0;");
	asm("add.u32				cv_r1, cv_l1, cv_r1;");
	asm("add.u32				cv_r2, cv_l2, cv_r2;");
	asm("add.u32				cv_r3, cv_l3, cv_r3;");
	asm("add.u32				cv_r4, cv_l4, cv_r4;");
	asm("add.u32				cv_r5, cv_l5, cv_r5;");
	asm("add.u32				cv_r6, cv_l6, cv_r6;");
	asm("add.u32				cv_r7, cv_l7, cv_r7;");

	//rotate_blk(cv_r, 17)
	asm("shf.l.wrap.b32         cv_r0, cv_r0, cv_r0, 17;");
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 17;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 17;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 17;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 17;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 17;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 17;");
	asm("shf.l.wrap.b32         cv_r7, cv_r7, cv_r7, 17;");

	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_msg_gmma(cv_r)
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 8;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 16;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 24;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 24;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 16;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 8;");

	//!word_perm(cv_l, cv_r)
	asm("mov.b32 	            tmp0, cv_l0;");
	asm("mov.b32 	            cv_l0, cv_l6;");
	asm("mov.b32 	            cv_l6, cv_r6;");
	asm("mov.b32 	            cv_r6, cv_r2;");
	asm("mov.b32 	            cv_r2, cv_l1;");
	asm("mov.b32 	            cv_l1, cv_l4;");
	asm("mov.b32 	            cv_l4, cv_r4;");
	asm("mov.b32 	            cv_r4, cv_r0;");
	asm("mov.b32 	            cv_r0, cv_l2;");
	asm("mov.b32 	            cv_l2, cv_l5;");
	asm("mov.b32 	            cv_l5, cv_r7;");
	asm("mov.b32 	            cv_r7, cv_r1;");
	asm("mov.b32 	            cv_r1, tmp0;");
	asm("mov.b32 	            tmp0, cv_l3;");
	asm("mov.b32 	            cv_l3, cv_l7;");
	asm("mov.b32 	            cv_l7, cv_r5;");
	asm("mov.b32 	            cv_r5, cv_r3;");
	asm("mov.b32 	            cv_r3, tmp0;");


	//loop (2)
	//msg_exp_even(i_state)
	asm("mov.b32 	            tmp0, e_l0;");
	asm("add.u32				e_l0, o_l0, e_l3;");
	asm("add.u32				e_l3, o_l3, e_l1;");
	asm("add.u32				e_l1, o_l1, e_l2;");
	asm("add.u32				e_l2, o_l2, tmp0;");

	asm("mov.b32 	            tmp0, e_l4;");
	asm("add.u32				e_l4, o_l4, e_l7;");
	asm("add.u32				e_l7, o_l7, e_l6;");
	asm("add.u32				e_l6, o_l6, e_l5;");
	asm("add.u32				e_l5, o_l5, tmp0;");

	asm("mov.b32 	            tmp0, e_r0;");
	asm("add.u32				e_r0, o_r0, e_r3;");
	asm("add.u32				e_r3, o_r3, e_r1;");
	asm("add.u32				e_r1, o_r1, e_r2;");
	asm("add.u32				e_r2, o_r2, tmp0;");

	asm("mov.b32 	            tmp0, e_r4;");
	asm("add.u32				e_r4, o_r4, e_r7;");
	asm("add.u32				e_r7, o_r7, e_r6;");
	asm("add.u32				e_r6, o_r6, e_r5;");
	asm("add.u32				e_r5, o_r5, tmp0;");

	//! msg_add_even(i_state)
	asm("xor.b32				cv_l0, e_l0, cv_l0;");
	asm("xor.b32				cv_l1, e_l1, cv_l1;");
	asm("xor.b32				cv_l2, e_l2, cv_l2;");
	asm("xor.b32				cv_l3, e_l3, cv_l3;");
	asm("xor.b32				cv_l4, e_l4, cv_l4;");
	asm("xor.b32				cv_l5, e_l5, cv_l5;");
	asm("xor.b32				cv_l6, e_l6, cv_l6;");
	asm("xor.b32				cv_l7, e_l7, cv_l7;");
	asm("xor.b32				cv_r0, e_r0, cv_r0;");
	asm("xor.b32				cv_r1, e_r1, cv_r1;");
	asm("xor.b32				cv_r2, e_r2, cv_r2;");
	asm("xor.b32				cv_r3, e_r3, cv_r3;");
	asm("xor.b32				cv_r4, e_r4, cv_r4;");
	asm("xor.b32				cv_r5, e_r5, cv_r5;");
	asm("xor.b32				cv_r6, e_r6, cv_r6;");
	asm("xor.b32				cv_r7, e_r7, cv_r7;");

	//!MIX(2)
	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_blk(cv_l, 29)
	asm("shf.l.wrap.b32         cv_l0, cv_l0, cv_l0, 29;");
	asm("shf.l.wrap.b32         cv_l1, cv_l1, cv_l1, 29;");
	asm("shf.l.wrap.b32         cv_l2, cv_l2, cv_l2, 29;");
	asm("shf.l.wrap.b32         cv_l3, cv_l3, cv_l3, 29;");
	asm("shf.l.wrap.b32         cv_l4, cv_l4, cv_l4, 29;");
	asm("shf.l.wrap.b32         cv_l5, cv_l5, cv_l5, 29;");
	asm("shf.l.wrap.b32         cv_l6, cv_l6, cv_l6, 29;");
	asm("shf.l.wrap.b32         cv_l7, cv_l7, cv_l7, 29;");

	//xor_with_const
	asm("xor.b32				cv_l0, cv_l0, 0x745dfa0f;");
	asm("xor.b32				cv_l1, cv_l1, 0x31f79ed8;");
	asm("xor.b32				cv_l2, cv_l2, 0xb85fce25;");
	asm("xor.b32				cv_l3, cv_l3, 0x98c8c898;");
	asm("xor.b32				cv_l4, cv_l4, 0x8a0669ec;");
	asm("xor.b32				cv_l5, cv_l5, 0x60e445c2;");
	asm("xor.b32				cv_l6, cv_l6, 0xfde295b0;");
	asm("xor.b32				cv_l7, cv_l7, 0xf7b5185a;");

	//add_blk(cv_r, cv_l)
	asm("add.u32				cv_r0, cv_l0, cv_r0;");
	asm("add.u32				cv_r1, cv_l1, cv_r1;");
	asm("add.u32				cv_r2, cv_l2, cv_r2;");
	asm("add.u32				cv_r3, cv_l3, cv_r3;");
	asm("add.u32				cv_r4, cv_l4, cv_r4;");
	asm("add.u32				cv_r5, cv_l5, cv_r5;");
	asm("add.u32				cv_r6, cv_l6, cv_r6;");
	asm("add.u32				cv_r7, cv_l7, cv_r7;");

	//rotate_blk(cv_r, 1)
	asm("shf.l.wrap.b32         cv_r0, cv_r0, cv_r0, 1;");
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 1;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 1;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 1;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 1;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 1;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 1;");
	asm("shf.l.wrap.b32         cv_r7, cv_r7, cv_r7, 1;");

	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_msg_gmma(cv_r)
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 8;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 16;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 24;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 24;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 16;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 8;");

	//!word_perm(cv_l, cv_r)
	asm("mov.b32 	            tmp0, cv_l0;");
	asm("mov.b32 	            cv_l0, cv_l6;");
	asm("mov.b32 	            cv_l6, cv_r6;");
	asm("mov.b32 	            cv_r6, cv_r2;");
	asm("mov.b32 	            cv_r2, cv_l1;");
	asm("mov.b32 	            cv_l1, cv_l4;");
	asm("mov.b32 	            cv_l4, cv_r4;");
	asm("mov.b32 	            cv_r4, cv_r0;");
	asm("mov.b32 	            cv_r0, cv_l2;");
	asm("mov.b32 	            cv_l2, cv_l5;");
	asm("mov.b32 	            cv_l5, cv_r7;");
	asm("mov.b32 	            cv_r7, cv_r1;");
	asm("mov.b32 	            cv_r1, tmp0;");
	asm("mov.b32 	            tmp0, cv_l3;");
	asm("mov.b32 	            cv_l3, cv_l7;");
	asm("mov.b32 	            cv_l7, cv_r5;");
	asm("mov.b32 	            cv_r5, cv_r3;");
	asm("mov.b32 	            cv_r3, tmp0;");

	//!msg_exp_odd(i_state)
	asm("mov.b32 	            tmp0, o_l0;");
	asm("add.u32				o_l0, e_l0, o_l3;");
	asm("add.u32				o_l3, e_l3, o_l1;");
	asm("add.u32				o_l1, e_l1, o_l2;");
	asm("add.u32				o_l2, e_l2, tmp0;");

	asm("mov.b32 	            tmp0, o_l4;");
	asm("add.u32				o_l4, e_l4, o_l7;");
	asm("add.u32				o_l7, e_l7, o_l6;");
	asm("add.u32				o_l6, e_l6, o_l5;");
	asm("add.u32				o_l5, e_l5, tmp0;");

	asm("mov.b32 	            tmp0, o_r0;");
	asm("add.u32				o_r0, e_r0, o_r3;");
	asm("add.u32				o_r3, e_r3, o_r1;");
	asm("add.u32				o_r1, e_r1, o_r2;");
	asm("add.u32				o_r2, e_r2, tmp0;");

	asm("mov.b32 	            tmp0, o_r4;");
	asm("add.u32				o_r4, e_r4, o_r7;");
	asm("add.u32				o_r7, e_r7, o_r6;");
	asm("add.u32				o_r6, e_r6, o_r5;");
	asm("add.u32				o_r5, e_r5, tmp0;");

	//!msg_add_odd(cv_l, cv_r, i_state)
	//cv_l part
	asm("xor.b32				cv_l0, o_l0, cv_l0;");
	asm("xor.b32				cv_l1, o_l1, cv_l1;");
	asm("xor.b32				cv_l2, o_l2, cv_l2;");
	asm("xor.b32				cv_l3, o_l3, cv_l3;");
	asm("xor.b32				cv_l4, o_l4, cv_l4;");
	asm("xor.b32				cv_l5, o_l5, cv_l5;");
	asm("xor.b32				cv_l6, o_l6, cv_l6;");
	asm("xor.b32				cv_l7, o_l7, cv_l7;");
	//cv_r part
	asm("xor.b32				cv_r0, o_r0, cv_r0;");
	asm("xor.b32				cv_r1, o_r1, cv_r1;");
	asm("xor.b32				cv_r2, o_r2, cv_r2;");
	asm("xor.b32				cv_r3, o_r3, cv_r3;");
	asm("xor.b32				cv_r4, o_r4, cv_r4;");
	asm("xor.b32				cv_r5, o_r5, cv_r5;");
	asm("xor.b32				cv_r6, o_r6, cv_r6;");
	asm("xor.b32				cv_r7, o_r7, cv_r7;");

	//!MIX(4)
	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_blk(cv_l, 5)
	asm("shf.l.wrap.b32         cv_l0, cv_l0, cv_l0, 5;");
	asm("shf.l.wrap.b32         cv_l1, cv_l1, cv_l1, 5;");
	asm("shf.l.wrap.b32         cv_l2, cv_l2, cv_l2, 5;");
	asm("shf.l.wrap.b32         cv_l3, cv_l3, cv_l3, 5;");
	asm("shf.l.wrap.b32         cv_l4, cv_l4, cv_l4, 5;");
	asm("shf.l.wrap.b32         cv_l5, cv_l5, cv_l5, 5;");
	asm("shf.l.wrap.b32         cv_l6, cv_l6, cv_l6, 5;");
	asm("shf.l.wrap.b32         cv_l7, cv_l7, cv_l7, 5;");

	//xor_with_const(cv_l, const_v)
	asm("xor.b32				cv_l0, cv_l0, 0xd2580983;");
	asm("xor.b32				cv_l1, cv_l1, 0x29967709;");
	asm("xor.b32				cv_l2, cv_l2, 0x182df3dd;");
	asm("xor.b32				cv_l3, cv_l3, 0x61916130;");
	asm("xor.b32				cv_l4, cv_l4, 0x90705676;");
	asm("xor.b32				cv_l5, cv_l5, 0x452a0822;");
	asm("xor.b32				cv_l6, cv_l6, 0xe07846ad;");
	asm("xor.b32				cv_l7, cv_l7, 0xaccd7351;");

	//add_blk(cv_r, cv_l)
	asm("add.u32				cv_r0, cv_l0, cv_r0;");
	asm("add.u32				cv_r1, cv_l1, cv_r1;");
	asm("add.u32				cv_r2, cv_l2, cv_r2;");
	asm("add.u32				cv_r3, cv_l3, cv_r3;");
	asm("add.u32				cv_r4, cv_l4, cv_r4;");
	asm("add.u32				cv_r5, cv_l5, cv_r5;");
	asm("add.u32				cv_r6, cv_l6, cv_r6;");
	asm("add.u32				cv_r7, cv_l7, cv_r7;");

	//rotate_blk(cv_r, 17)
	asm("shf.l.wrap.b32         cv_r0, cv_r0, cv_r0, 17;");
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 17;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 17;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 17;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 17;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 17;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 17;");
	asm("shf.l.wrap.b32         cv_r7, cv_r7, cv_r7, 17;");

	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_msg_gmma(cv_r)
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 8;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 16;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 24;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 24;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 16;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 8;");

	//!word_perm(cv_l, cv_r)
	asm("mov.b32 	            tmp0, cv_l0;");
	asm("mov.b32 	            cv_l0, cv_l6;");
	asm("mov.b32 	            cv_l6, cv_r6;");
	asm("mov.b32 	            cv_r6, cv_r2;");
	asm("mov.b32 	            cv_r2, cv_l1;");
	asm("mov.b32 	            cv_l1, cv_l4;");
	asm("mov.b32 	            cv_l4, cv_r4;");
	asm("mov.b32 	            cv_r4, cv_r0;");
	asm("mov.b32 	            cv_r0, cv_l2;");
	asm("mov.b32 	            cv_l2, cv_l5;");
	asm("mov.b32 	            cv_l5, cv_r7;");
	asm("mov.b32 	            cv_r7, cv_r1;");
	asm("mov.b32 	            cv_r1, tmp0;");
	asm("mov.b32 	            tmp0, cv_l3;");
	asm("mov.b32 	            cv_l3, cv_l7;");
	asm("mov.b32 	            cv_l7, cv_r5;");
	asm("mov.b32 	            cv_r5, cv_r3;");
	asm("mov.b32 	            cv_r3, tmp0;");


	//loop (3)
	//msg_exp_even(i_state)
	asm("mov.b32 	            tmp0, e_l0;");
	asm("add.u32				e_l0, o_l0, e_l3;");
	asm("add.u32				e_l3, o_l3, e_l1;");
	asm("add.u32				e_l1, o_l1, e_l2;");
	asm("add.u32				e_l2, o_l2, tmp0;");

	asm("mov.b32 	            tmp0, e_l4;");
	asm("add.u32				e_l4, o_l4, e_l7;");
	asm("add.u32				e_l7, o_l7, e_l6;");
	asm("add.u32				e_l6, o_l6, e_l5;");
	asm("add.u32				e_l5, o_l5, tmp0;");

	asm("mov.b32 	            tmp0, e_r0;");
	asm("add.u32				e_r0, o_r0, e_r3;");
	asm("add.u32				e_r3, o_r3, e_r1;");
	asm("add.u32				e_r1, o_r1, e_r2;");
	asm("add.u32				e_r2, o_r2, tmp0;");

	asm("mov.b32 	            tmp0, e_r4;");
	asm("add.u32				e_r4, o_r4, e_r7;");
	asm("add.u32				e_r7, o_r7, e_r6;");
	asm("add.u32				e_r6, o_r6, e_r5;");
	asm("add.u32				e_r5, o_r5, tmp0;");

	//! msg_add_even(i_state)
	asm("xor.b32				cv_l0, e_l0, cv_l0;");
	asm("xor.b32				cv_l1, e_l1, cv_l1;");
	asm("xor.b32				cv_l2, e_l2, cv_l2;");
	asm("xor.b32				cv_l3, e_l3, cv_l3;");
	asm("xor.b32				cv_l4, e_l4, cv_l4;");
	asm("xor.b32				cv_l5, e_l5, cv_l5;");
	asm("xor.b32				cv_l6, e_l6, cv_l6;");
	asm("xor.b32				cv_l7, e_l7, cv_l7;");
	asm("xor.b32				cv_r0, e_r0, cv_r0;");
	asm("xor.b32				cv_r1, e_r1, cv_r1;");
	asm("xor.b32				cv_r2, e_r2, cv_r2;");
	asm("xor.b32				cv_r3, e_r3, cv_r3;");
	asm("xor.b32				cv_r4, e_r4, cv_r4;");
	asm("xor.b32				cv_r5, e_r5, cv_r5;");
	asm("xor.b32				cv_r6, e_r6, cv_r6;");
	asm("xor.b32				cv_r7, e_r7, cv_r7;");

	//!MIX(2)
	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_blk(cv_l, 29)
	asm("shf.l.wrap.b32         cv_l0, cv_l0, cv_l0, 29;");
	asm("shf.l.wrap.b32         cv_l1, cv_l1, cv_l1, 29;");
	asm("shf.l.wrap.b32         cv_l2, cv_l2, cv_l2, 29;");
	asm("shf.l.wrap.b32         cv_l3, cv_l3, cv_l3, 29;");
	asm("shf.l.wrap.b32         cv_l4, cv_l4, cv_l4, 29;");
	asm("shf.l.wrap.b32         cv_l5, cv_l5, cv_l5, 29;");
	asm("shf.l.wrap.b32         cv_l6, cv_l6, cv_l6, 29;");
	asm("shf.l.wrap.b32         cv_l7, cv_l7, cv_l7, 29;");

	//xor_with_const
	asm("xor.b32				cv_l0, cv_l0, 0x2a618d55;");
	asm("xor.b32				cv_l1, cv_l1, 0xc00d8032;");
	asm("xor.b32				cv_l2, cv_l2, 0x4621d0f5;");
	asm("xor.b32				cv_l3, cv_l3, 0xf2f29191;");
	asm("xor.b32				cv_l4, cv_l4, 0x00c6cd06;");
	asm("xor.b32				cv_l5, cv_l5, 0x6f322a67;");
	asm("xor.b32				cv_l6, cv_l6, 0x58bef48d;");
	asm("xor.b32				cv_l7, cv_l7, 0x7a40c4fd;");

	//add_blk(cv_r, cv_l)
	asm("add.u32				cv_r0, cv_l0, cv_r0;");
	asm("add.u32				cv_r1, cv_l1, cv_r1;");
	asm("add.u32				cv_r2, cv_l2, cv_r2;");
	asm("add.u32				cv_r3, cv_l3, cv_r3;");
	asm("add.u32				cv_r4, cv_l4, cv_r4;");
	asm("add.u32				cv_r5, cv_l5, cv_r5;");
	asm("add.u32				cv_r6, cv_l6, cv_r6;");
	asm("add.u32				cv_r7, cv_l7, cv_r7;");

	//rotate_blk(cv_r, 1)
	asm("shf.l.wrap.b32         cv_r0, cv_r0, cv_r0, 1;");
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 1;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 1;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 1;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 1;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 1;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 1;");
	asm("shf.l.wrap.b32         cv_r7, cv_r7, cv_r7, 1;");

	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_msg_gmma(cv_r)
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 8;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 16;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 24;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 24;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 16;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 8;");

	//!word_perm(cv_l, cv_r)
	asm("mov.b32 	            tmp0, cv_l0;");
	asm("mov.b32 	            cv_l0, cv_l6;");
	asm("mov.b32 	            cv_l6, cv_r6;");
	asm("mov.b32 	            cv_r6, cv_r2;");
	asm("mov.b32 	            cv_r2, cv_l1;");
	asm("mov.b32 	            cv_l1, cv_l4;");
	asm("mov.b32 	            cv_l4, cv_r4;");
	asm("mov.b32 	            cv_r4, cv_r0;");
	asm("mov.b32 	            cv_r0, cv_l2;");
	asm("mov.b32 	            cv_l2, cv_l5;");
	asm("mov.b32 	            cv_l5, cv_r7;");
	asm("mov.b32 	            cv_r7, cv_r1;");
	asm("mov.b32 	            cv_r1, tmp0;");
	asm("mov.b32 	            tmp0, cv_l3;");
	asm("mov.b32 	            cv_l3, cv_l7;");
	asm("mov.b32 	            cv_l7, cv_r5;");
	asm("mov.b32 	            cv_r5, cv_r3;");
	asm("mov.b32 	            cv_r3, tmp0;");

	//!msg_exp_odd(i_state)
	asm("mov.b32 	            tmp0, o_l0;");
	asm("add.u32				o_l0, e_l0, o_l3;");
	asm("add.u32				o_l3, e_l3, o_l1;");
	asm("add.u32				o_l1, e_l1, o_l2;");
	asm("add.u32				o_l2, e_l2, tmp0;");

	asm("mov.b32 	            tmp0, o_l4;");
	asm("add.u32				o_l4, e_l4, o_l7;");
	asm("add.u32				o_l7, e_l7, o_l6;");
	asm("add.u32				o_l6, e_l6, o_l5;");
	asm("add.u32				o_l5, e_l5, tmp0;");

	asm("mov.b32 	            tmp0, o_r0;");
	asm("add.u32				o_r0, e_r0, o_r3;");
	asm("add.u32				o_r3, e_r3, o_r1;");
	asm("add.u32				o_r1, e_r1, o_r2;");
	asm("add.u32				o_r2, e_r2, tmp0;");

	asm("mov.b32 	            tmp0, o_r4;");
	asm("add.u32				o_r4, e_r4, o_r7;");
	asm("add.u32				o_r7, e_r7, o_r6;");
	asm("add.u32				o_r6, e_r6, o_r5;");
	asm("add.u32				o_r5, e_r5, tmp0;");

	//!msg_add_odd(cv_l, cv_r, i_state)
	//cv_l part
	asm("xor.b32				cv_l0, o_l0, cv_l0;");
	asm("xor.b32				cv_l1, o_l1, cv_l1;");
	asm("xor.b32				cv_l2, o_l2, cv_l2;");
	asm("xor.b32				cv_l3, o_l3, cv_l3;");
	asm("xor.b32				cv_l4, o_l4, cv_l4;");
	asm("xor.b32				cv_l5, o_l5, cv_l5;");
	asm("xor.b32				cv_l6, o_l6, cv_l6;");
	asm("xor.b32				cv_l7, o_l7, cv_l7;");
	//cv_r part
	asm("xor.b32				cv_r0, o_r0, cv_r0;");
	asm("xor.b32				cv_r1, o_r1, cv_r1;");
	asm("xor.b32				cv_r2, o_r2, cv_r2;");
	asm("xor.b32				cv_r3, o_r3, cv_r3;");
	asm("xor.b32				cv_r4, o_r4, cv_r4;");
	asm("xor.b32				cv_r5, o_r5, cv_r5;");
	asm("xor.b32				cv_r6, o_r6, cv_r6;");
	asm("xor.b32				cv_r7, o_r7, cv_r7;");

	//!MIX(4)
	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_blk(cv_l, 5)
	asm("shf.l.wrap.b32         cv_l0, cv_l0, cv_l0, 5;");
	asm("shf.l.wrap.b32         cv_l1, cv_l1, cv_l1, 5;");
	asm("shf.l.wrap.b32         cv_l2, cv_l2, cv_l2, 5;");
	asm("shf.l.wrap.b32         cv_l3, cv_l3, cv_l3, 5;");
	asm("shf.l.wrap.b32         cv_l4, cv_l4, cv_l4, 5;");
	asm("shf.l.wrap.b32         cv_l5, cv_l5, cv_l5, 5;");
	asm("shf.l.wrap.b32         cv_l6, cv_l6, cv_l6, 5;");
	asm("shf.l.wrap.b32         cv_l7, cv_l7, cv_l7, 5;");

	//xor_with_const(cv_l, const_v)
	asm("xor.b32				cv_l0, cv_l0, 0x8beee27f;");
	asm("xor.b32				cv_l1, cv_l1, 0xcd8db2f2;");
	asm("xor.b32				cv_l2, cv_l2, 0x67f2c63b;");
	asm("xor.b32				cv_l3, cv_l3, 0xe5842383;");
	asm("xor.b32				cv_l4, cv_l4, 0xc793d306;");
	asm("xor.b32				cv_l5, cv_l5, 0xa15c91d6;");
	asm("xor.b32				cv_l6, cv_l6, 0x17b381e5;");
	asm("xor.b32				cv_l7, cv_l7, 0xbb05c277;");

	//add_blk(cv_r, cv_l)
	asm("add.u32				cv_r0, cv_l0, cv_r0;");
	asm("add.u32				cv_r1, cv_l1, cv_r1;");
	asm("add.u32				cv_r2, cv_l2, cv_r2;");
	asm("add.u32				cv_r3, cv_l3, cv_r3;");
	asm("add.u32				cv_r4, cv_l4, cv_r4;");
	asm("add.u32				cv_r5, cv_l5, cv_r5;");
	asm("add.u32				cv_r6, cv_l6, cv_r6;");
	asm("add.u32				cv_r7, cv_l7, cv_r7;");

	//rotate_blk(cv_r, 17)
	asm("shf.l.wrap.b32         cv_r0, cv_r0, cv_r0, 17;");
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 17;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 17;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 17;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 17;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 17;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 17;");
	asm("shf.l.wrap.b32         cv_r7, cv_r7, cv_r7, 17;");

	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_msg_gmma(cv_r)
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 8;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 16;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 24;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 24;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 16;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 8;");

	//!word_perm(cv_l, cv_r)
	asm("mov.b32 	            tmp0, cv_l0;");
	asm("mov.b32 	            cv_l0, cv_l6;");
	asm("mov.b32 	            cv_l6, cv_r6;");
	asm("mov.b32 	            cv_r6, cv_r2;");
	asm("mov.b32 	            cv_r2, cv_l1;");
	asm("mov.b32 	            cv_l1, cv_l4;");
	asm("mov.b32 	            cv_l4, cv_r4;");
	asm("mov.b32 	            cv_r4, cv_r0;");
	asm("mov.b32 	            cv_r0, cv_l2;");
	asm("mov.b32 	            cv_l2, cv_l5;");
	asm("mov.b32 	            cv_l5, cv_r7;");
	asm("mov.b32 	            cv_r7, cv_r1;");
	asm("mov.b32 	            cv_r1, tmp0;");
	asm("mov.b32 	            tmp0, cv_l3;");
	asm("mov.b32 	            cv_l3, cv_l7;");
	asm("mov.b32 	            cv_l7, cv_r5;");
	asm("mov.b32 	            cv_r5, cv_r3;");
	asm("mov.b32 	            cv_r3, tmp0;");



	//loop (4)
	//msg_exp_even(i_state)
	asm("mov.b32 	            tmp0, e_l0;");
	asm("add.u32				e_l0, o_l0, e_l3;");
	asm("add.u32				e_l3, o_l3, e_l1;");
	asm("add.u32				e_l1, o_l1, e_l2;");
	asm("add.u32				e_l2, o_l2, tmp0;");

	asm("mov.b32 	            tmp0, e_l4;");
	asm("add.u32				e_l4, o_l4, e_l7;");
	asm("add.u32				e_l7, o_l7, e_l6;");
	asm("add.u32				e_l6, o_l6, e_l5;");
	asm("add.u32				e_l5, o_l5, tmp0;");

	asm("mov.b32 	            tmp0, e_r0;");
	asm("add.u32				e_r0, o_r0, e_r3;");
	asm("add.u32				e_r3, o_r3, e_r1;");
	asm("add.u32				e_r1, o_r1, e_r2;");
	asm("add.u32				e_r2, o_r2, tmp0;");

	asm("mov.b32 	            tmp0, e_r4;");
	asm("add.u32				e_r4, o_r4, e_r7;");
	asm("add.u32				e_r7, o_r7, e_r6;");
	asm("add.u32				e_r6, o_r6, e_r5;");
	asm("add.u32				e_r5, o_r5, tmp0;");

	//! msg_add_even(i_state)
	asm("xor.b32				cv_l0, e_l0, cv_l0;");
	asm("xor.b32				cv_l1, e_l1, cv_l1;");
	asm("xor.b32				cv_l2, e_l2, cv_l2;");
	asm("xor.b32				cv_l3, e_l3, cv_l3;");
	asm("xor.b32				cv_l4, e_l4, cv_l4;");
	asm("xor.b32				cv_l5, e_l5, cv_l5;");
	asm("xor.b32				cv_l6, e_l6, cv_l6;");
	asm("xor.b32				cv_l7, e_l7, cv_l7;");
	asm("xor.b32				cv_r0, e_r0, cv_r0;");
	asm("xor.b32				cv_r1, e_r1, cv_r1;");
	asm("xor.b32				cv_r2, e_r2, cv_r2;");
	asm("xor.b32				cv_r3, e_r3, cv_r3;");
	asm("xor.b32				cv_r4, e_r4, cv_r4;");
	asm("xor.b32				cv_r5, e_r5, cv_r5;");
	asm("xor.b32				cv_r6, e_r6, cv_r6;");
	asm("xor.b32				cv_r7, e_r7, cv_r7;");

	//!MIX(2)
	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_blk(cv_l, 29)
	asm("shf.l.wrap.b32         cv_l0, cv_l0, cv_l0, 29;");
	asm("shf.l.wrap.b32         cv_l1, cv_l1, cv_l1, 29;");
	asm("shf.l.wrap.b32         cv_l2, cv_l2, cv_l2, 29;");
	asm("shf.l.wrap.b32         cv_l3, cv_l3, cv_l3, 29;");
	asm("shf.l.wrap.b32         cv_l4, cv_l4, cv_l4, 29;");
	asm("shf.l.wrap.b32         cv_l5, cv_l5, cv_l5, 29;");
	asm("shf.l.wrap.b32         cv_l6, cv_l6, cv_l6, 29;");
	asm("shf.l.wrap.b32         cv_l7, cv_l7, cv_l7, 29;");

	//xor_with_const
	asm("xor.b32				cv_l0, cv_l0, 0x7ad1620a;");
	asm("xor.b32				cv_l1, cv_l1, 0x5b40a5bf;");
	asm("xor.b32				cv_l2, cv_l2, 0x5ab901a2;");
	asm("xor.b32				cv_l3, cv_l3, 0x69a7a768;");
	asm("xor.b32				cv_l4, cv_l4, 0x5b66d9cd;");
	asm("xor.b32				cv_l5, cv_l5, 0xfdee6877;");
	asm("xor.b32				cv_l6, cv_l6, 0xcb3566fc;");
	asm("xor.b32				cv_l7, cv_l7, 0xc0c83a32;");

	//add_blk(cv_r, cv_l)
	asm("add.u32				cv_r0, cv_l0, cv_r0;");
	asm("add.u32				cv_r1, cv_l1, cv_r1;");
	asm("add.u32				cv_r2, cv_l2, cv_r2;");
	asm("add.u32				cv_r3, cv_l3, cv_r3;");
	asm("add.u32				cv_r4, cv_l4, cv_r4;");
	asm("add.u32				cv_r5, cv_l5, cv_r5;");
	asm("add.u32				cv_r6, cv_l6, cv_r6;");
	asm("add.u32				cv_r7, cv_l7, cv_r7;");

	//rotate_blk(cv_r, 1)
	asm("shf.l.wrap.b32         cv_r0, cv_r0, cv_r0, 1;");
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 1;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 1;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 1;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 1;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 1;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 1;");
	asm("shf.l.wrap.b32         cv_r7, cv_r7, cv_r7, 1;");

	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_msg_gmma(cv_r)
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 8;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 16;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 24;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 24;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 16;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 8;");

	//!word_perm(cv_l, cv_r)
	asm("mov.b32 	            tmp0, cv_l0;");
	asm("mov.b32 	            cv_l0, cv_l6;");
	asm("mov.b32 	            cv_l6, cv_r6;");
	asm("mov.b32 	            cv_r6, cv_r2;");
	asm("mov.b32 	            cv_r2, cv_l1;");
	asm("mov.b32 	            cv_l1, cv_l4;");
	asm("mov.b32 	            cv_l4, cv_r4;");
	asm("mov.b32 	            cv_r4, cv_r0;");
	asm("mov.b32 	            cv_r0, cv_l2;");
	asm("mov.b32 	            cv_l2, cv_l5;");
	asm("mov.b32 	            cv_l5, cv_r7;");
	asm("mov.b32 	            cv_r7, cv_r1;");
	asm("mov.b32 	            cv_r1, tmp0;");
	asm("mov.b32 	            tmp0, cv_l3;");
	asm("mov.b32 	            cv_l3, cv_l7;");
	asm("mov.b32 	            cv_l7, cv_r5;");
	asm("mov.b32 	            cv_r5, cv_r3;");
	asm("mov.b32 	            cv_r3, tmp0;");

	//!msg_exp_odd(i_state)
	asm("mov.b32 	            tmp0, o_l0;");
	asm("add.u32				o_l0, e_l0, o_l3;");
	asm("add.u32				o_l3, e_l3, o_l1;");
	asm("add.u32				o_l1, e_l1, o_l2;");
	asm("add.u32				o_l2, e_l2, tmp0;");

	asm("mov.b32 	            tmp0, o_l4;");
	asm("add.u32				o_l4, e_l4, o_l7;");
	asm("add.u32				o_l7, e_l7, o_l6;");
	asm("add.u32				o_l6, e_l6, o_l5;");
	asm("add.u32				o_l5, e_l5, tmp0;");

	asm("mov.b32 	            tmp0, o_r0;");
	asm("add.u32				o_r0, e_r0, o_r3;");
	asm("add.u32				o_r3, e_r3, o_r1;");
	asm("add.u32				o_r1, e_r1, o_r2;");
	asm("add.u32				o_r2, e_r2, tmp0;");

	asm("mov.b32 	            tmp0, o_r4;");
	asm("add.u32				o_r4, e_r4, o_r7;");
	asm("add.u32				o_r7, e_r7, o_r6;");
	asm("add.u32				o_r6, e_r6, o_r5;");
	asm("add.u32				o_r5, e_r5, tmp0;");

	//!msg_add_odd(cv_l, cv_r, i_state)
	//cv_l part
	asm("xor.b32				cv_l0, o_l0, cv_l0;");
	asm("xor.b32				cv_l1, o_l1, cv_l1;");
	asm("xor.b32				cv_l2, o_l2, cv_l2;");
	asm("xor.b32				cv_l3, o_l3, cv_l3;");
	asm("xor.b32				cv_l4, o_l4, cv_l4;");
	asm("xor.b32				cv_l5, o_l5, cv_l5;");
	asm("xor.b32				cv_l6, o_l6, cv_l6;");
	asm("xor.b32				cv_l7, o_l7, cv_l7;");
	//cv_r part
	asm("xor.b32				cv_r0, o_r0, cv_r0;");
	asm("xor.b32				cv_r1, o_r1, cv_r1;");
	asm("xor.b32				cv_r2, o_r2, cv_r2;");
	asm("xor.b32				cv_r3, o_r3, cv_r3;");
	asm("xor.b32				cv_r4, o_r4, cv_r4;");
	asm("xor.b32				cv_r5, o_r5, cv_r5;");
	asm("xor.b32				cv_r6, o_r6, cv_r6;");
	asm("xor.b32				cv_r7, o_r7, cv_r7;");

	//!MIX(4)
	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_blk(cv_l, 5)
	asm("shf.l.wrap.b32         cv_l0, cv_l0, cv_l0, 5;");
	asm("shf.l.wrap.b32         cv_l1, cv_l1, cv_l1, 5;");
	asm("shf.l.wrap.b32         cv_l2, cv_l2, cv_l2, 5;");
	asm("shf.l.wrap.b32         cv_l3, cv_l3, cv_l3, 5;");
	asm("shf.l.wrap.b32         cv_l4, cv_l4, cv_l4, 5;");
	asm("shf.l.wrap.b32         cv_l5, cv_l5, cv_l5, 5;");
	asm("shf.l.wrap.b32         cv_l6, cv_l6, cv_l6, 5;");
	asm("shf.l.wrap.b32         cv_l7, cv_l7, cv_l7, 5;");

	//xor_with_const(cv_l, const_v)
	asm("xor.b32				cv_l0, cv_l0, 0x4c336c84;");
	asm("xor.b32				cv_l1, cv_l1, 0x9be6651a;");
	asm("xor.b32				cv_l2, cv_l2, 0x13baa3fc;");
	asm("xor.b32				cv_l3, cv_l3, 0x114f0fd1;");
	asm("xor.b32				cv_l4, cv_l4, 0xc240a728;");
	asm("xor.b32				cv_l5, cv_l5, 0xec56e074;");
	asm("xor.b32				cv_l6, cv_l6, 0x009c63c7;");
	asm("xor.b32				cv_l7, cv_l7, 0x89026cf2;");

	//add_blk(cv_r, cv_l)
	asm("add.u32				cv_r0, cv_l0, cv_r0;");
	asm("add.u32				cv_r1, cv_l1, cv_r1;");
	asm("add.u32				cv_r2, cv_l2, cv_r2;");
	asm("add.u32				cv_r3, cv_l3, cv_r3;");
	asm("add.u32				cv_r4, cv_l4, cv_r4;");
	asm("add.u32				cv_r5, cv_l5, cv_r5;");
	asm("add.u32				cv_r6, cv_l6, cv_r6;");
	asm("add.u32				cv_r7, cv_l7, cv_r7;");

	//rotate_blk(cv_r, 17)
	asm("shf.l.wrap.b32         cv_r0, cv_r0, cv_r0, 17;");
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 17;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 17;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 17;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 17;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 17;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 17;");
	asm("shf.l.wrap.b32         cv_r7, cv_r7, cv_r7, 17;");

	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_msg_gmma(cv_r)
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 8;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 16;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 24;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 24;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 16;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 8;");

	//!word_perm(cv_l, cv_r)
	asm("mov.b32 	            tmp0, cv_l0;");
	asm("mov.b32 	            cv_l0, cv_l6;");
	asm("mov.b32 	            cv_l6, cv_r6;");
	asm("mov.b32 	            cv_r6, cv_r2;");
	asm("mov.b32 	            cv_r2, cv_l1;");
	asm("mov.b32 	            cv_l1, cv_l4;");
	asm("mov.b32 	            cv_l4, cv_r4;");
	asm("mov.b32 	            cv_r4, cv_r0;");
	asm("mov.b32 	            cv_r0, cv_l2;");
	asm("mov.b32 	            cv_l2, cv_l5;");
	asm("mov.b32 	            cv_l5, cv_r7;");
	asm("mov.b32 	            cv_r7, cv_r1;");
	asm("mov.b32 	            cv_r1, tmp0;");
	asm("mov.b32 	            tmp0, cv_l3;");
	asm("mov.b32 	            cv_l3, cv_l7;");
	asm("mov.b32 	            cv_l7, cv_r5;");
	asm("mov.b32 	            cv_r5, cv_r3;");
	asm("mov.b32 	            cv_r3, tmp0;");


	//loop (5)
	//msg_exp_even(i_state)
	asm("mov.b32 	            tmp0, e_l0;");
	asm("add.u32				e_l0, o_l0, e_l3;");
	asm("add.u32				e_l3, o_l3, e_l1;");
	asm("add.u32				e_l1, o_l1, e_l2;");
	asm("add.u32				e_l2, o_l2, tmp0;");

	asm("mov.b32 	            tmp0, e_l4;");
	asm("add.u32				e_l4, o_l4, e_l7;");
	asm("add.u32				e_l7, o_l7, e_l6;");
	asm("add.u32				e_l6, o_l6, e_l5;");
	asm("add.u32				e_l5, o_l5, tmp0;");

	asm("mov.b32 	            tmp0, e_r0;");
	asm("add.u32				e_r0, o_r0, e_r3;");
	asm("add.u32				e_r3, o_r3, e_r1;");
	asm("add.u32				e_r1, o_r1, e_r2;");
	asm("add.u32				e_r2, o_r2, tmp0;");

	asm("mov.b32 	            tmp0, e_r4;");
	asm("add.u32				e_r4, o_r4, e_r7;");
	asm("add.u32				e_r7, o_r7, e_r6;");
	asm("add.u32				e_r6, o_r6, e_r5;");
	asm("add.u32				e_r5, o_r5, tmp0;");

	//! msg_add_even(i_state)
	asm("xor.b32				cv_l0, e_l0, cv_l0;");
	asm("xor.b32				cv_l1, e_l1, cv_l1;");
	asm("xor.b32				cv_l2, e_l2, cv_l2;");
	asm("xor.b32				cv_l3, e_l3, cv_l3;");
	asm("xor.b32				cv_l4, e_l4, cv_l4;");
	asm("xor.b32				cv_l5, e_l5, cv_l5;");
	asm("xor.b32				cv_l6, e_l6, cv_l6;");
	asm("xor.b32				cv_l7, e_l7, cv_l7;");
	asm("xor.b32				cv_r0, e_r0, cv_r0;");
	asm("xor.b32				cv_r1, e_r1, cv_r1;");
	asm("xor.b32				cv_r2, e_r2, cv_r2;");
	asm("xor.b32				cv_r3, e_r3, cv_r3;");
	asm("xor.b32				cv_r4, e_r4, cv_r4;");
	asm("xor.b32				cv_r5, e_r5, cv_r5;");
	asm("xor.b32				cv_r6, e_r6, cv_r6;");
	asm("xor.b32				cv_r7, e_r7, cv_r7;");

	//!MIX(2)
	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_blk(cv_l, 29)
	asm("shf.l.wrap.b32         cv_l0, cv_l0, cv_l0, 29;");
	asm("shf.l.wrap.b32         cv_l1, cv_l1, cv_l1, 29;");
	asm("shf.l.wrap.b32         cv_l2, cv_l2, cv_l2, 29;");
	asm("shf.l.wrap.b32         cv_l3, cv_l3, cv_l3, 29;");
	asm("shf.l.wrap.b32         cv_l4, cv_l4, cv_l4, 29;");
	asm("shf.l.wrap.b32         cv_l5, cv_l5, cv_l5, 29;");
	asm("shf.l.wrap.b32         cv_l6, cv_l6, cv_l6, 29;");
	asm("shf.l.wrap.b32         cv_l7, cv_l7, cv_l7, 29;");

	//xor_with_const
	asm("xor.b32				cv_l0, cv_l0, 0x7f9ff0d0;");
	asm("xor.b32				cv_l1, cv_l1, 0x824b7fb5;");
	asm("xor.b32				cv_l2, cv_l2, 0xce5ea00f;");
	asm("xor.b32				cv_l3, cv_l3, 0x605ee0e2;");
	asm("xor.b32				cv_l4, cv_l4, 0x02e7cfea;");
	asm("xor.b32				cv_l5, cv_l5, 0x43375560;");
	asm("xor.b32				cv_l6, cv_l6, 0x9d002ac7;");
	asm("xor.b32				cv_l7, cv_l7, 0x8b6f5f7b;");

	//add_blk(cv_r, cv_l)
	asm("add.u32				cv_r0, cv_l0, cv_r0;");
	asm("add.u32				cv_r1, cv_l1, cv_r1;");
	asm("add.u32				cv_r2, cv_l2, cv_r2;");
	asm("add.u32				cv_r3, cv_l3, cv_r3;");
	asm("add.u32				cv_r4, cv_l4, cv_r4;");
	asm("add.u32				cv_r5, cv_l5, cv_r5;");
	asm("add.u32				cv_r6, cv_l6, cv_r6;");
	asm("add.u32				cv_r7, cv_l7, cv_r7;");

	//rotate_blk(cv_r, 1)
	asm("shf.l.wrap.b32         cv_r0, cv_r0, cv_r0, 1;");
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 1;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 1;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 1;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 1;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 1;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 1;");
	asm("shf.l.wrap.b32         cv_r7, cv_r7, cv_r7, 1;");

	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_msg_gmma(cv_r)
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 8;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 16;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 24;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 24;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 16;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 8;");

	//!word_perm(cv_l, cv_r)
	asm("mov.b32 	            tmp0, cv_l0;");
	asm("mov.b32 	            cv_l0, cv_l6;");
	asm("mov.b32 	            cv_l6, cv_r6;");
	asm("mov.b32 	            cv_r6, cv_r2;");
	asm("mov.b32 	            cv_r2, cv_l1;");
	asm("mov.b32 	            cv_l1, cv_l4;");
	asm("mov.b32 	            cv_l4, cv_r4;");
	asm("mov.b32 	            cv_r4, cv_r0;");
	asm("mov.b32 	            cv_r0, cv_l2;");
	asm("mov.b32 	            cv_l2, cv_l5;");
	asm("mov.b32 	            cv_l5, cv_r7;");
	asm("mov.b32 	            cv_r7, cv_r1;");
	asm("mov.b32 	            cv_r1, tmp0;");
	asm("mov.b32 	            tmp0, cv_l3;");
	asm("mov.b32 	            cv_l3, cv_l7;");
	asm("mov.b32 	            cv_l7, cv_r5;");
	asm("mov.b32 	            cv_r5, cv_r3;");
	asm("mov.b32 	            cv_r3, tmp0;");

	//!msg_exp_odd(i_state)
	asm("mov.b32 	            tmp0, o_l0;");
	asm("add.u32				o_l0, e_l0, o_l3;");
	asm("add.u32				o_l3, e_l3, o_l1;");
	asm("add.u32				o_l1, e_l1, o_l2;");
	asm("add.u32				o_l2, e_l2, tmp0;");

	asm("mov.b32 	            tmp0, o_l4;");
	asm("add.u32				o_l4, e_l4, o_l7;");
	asm("add.u32				o_l7, e_l7, o_l6;");
	asm("add.u32				o_l6, e_l6, o_l5;");
	asm("add.u32				o_l5, e_l5, tmp0;");

	asm("mov.b32 	            tmp0, o_r0;");
	asm("add.u32				o_r0, e_r0, o_r3;");
	asm("add.u32				o_r3, e_r3, o_r1;");
	asm("add.u32				o_r1, e_r1, o_r2;");
	asm("add.u32				o_r2, e_r2, tmp0;");

	asm("mov.b32 	            tmp0, o_r4;");
	asm("add.u32				o_r4, e_r4, o_r7;");
	asm("add.u32				o_r7, e_r7, o_r6;");
	asm("add.u32				o_r6, e_r6, o_r5;");
	asm("add.u32				o_r5, e_r5, tmp0;");

	//!msg_add_odd(cv_l, cv_r, i_state)
	//cv_l part
	asm("xor.b32				cv_l0, o_l0, cv_l0;");
	asm("xor.b32				cv_l1, o_l1, cv_l1;");
	asm("xor.b32				cv_l2, o_l2, cv_l2;");
	asm("xor.b32				cv_l3, o_l3, cv_l3;");
	asm("xor.b32				cv_l4, o_l4, cv_l4;");
	asm("xor.b32				cv_l5, o_l5, cv_l5;");
	asm("xor.b32				cv_l6, o_l6, cv_l6;");
	asm("xor.b32				cv_l7, o_l7, cv_l7;");
	//cv_r part
	asm("xor.b32				cv_r0, o_r0, cv_r0;");
	asm("xor.b32				cv_r1, o_r1, cv_r1;");
	asm("xor.b32				cv_r2, o_r2, cv_r2;");
	asm("xor.b32				cv_r3, o_r3, cv_r3;");
	asm("xor.b32				cv_r4, o_r4, cv_r4;");
	asm("xor.b32				cv_r5, o_r5, cv_r5;");
	asm("xor.b32				cv_r6, o_r6, cv_r6;");
	asm("xor.b32				cv_r7, o_r7, cv_r7;");

	//!MIX(4)
	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_blk(cv_l, 5)
	asm("shf.l.wrap.b32         cv_l0, cv_l0, cv_l0, 5;");
	asm("shf.l.wrap.b32         cv_l1, cv_l1, cv_l1, 5;");
	asm("shf.l.wrap.b32         cv_l2, cv_l2, cv_l2, 5;");
	asm("shf.l.wrap.b32         cv_l3, cv_l3, cv_l3, 5;");
	asm("shf.l.wrap.b32         cv_l4, cv_l4, cv_l4, 5;");
	asm("shf.l.wrap.b32         cv_l5, cv_l5, cv_l5, 5;");
	asm("shf.l.wrap.b32         cv_l6, cv_l6, cv_l6, 5;");
	asm("shf.l.wrap.b32         cv_l7, cv_l7, cv_l7, 5;");

	//xor_with_const(cv_l, const_v)
	asm("xor.b32				cv_l0, cv_l0, 0x1f90c14f;");
	asm("xor.b32				cv_l1, cv_l1, 0xcdcb3537;");
	asm("xor.b32				cv_l2, cv_l2, 0x2cfeafdd;");
	asm("xor.b32				cv_l3, cv_l3, 0xbf3fc342;");
	asm("xor.b32				cv_l4, cv_l4, 0xeab7b9ec;");
	asm("xor.b32				cv_l5, cv_l5, 0x7a8cb5a3;");
	asm("xor.b32				cv_l6, cv_l6, 0x9d2af264;");
	asm("xor.b32				cv_l7, cv_l7, 0xfacedb06;");

	//add_blk(cv_r, cv_l)
	asm("add.u32				cv_r0, cv_l0, cv_r0;");
	asm("add.u32				cv_r1, cv_l1, cv_r1;");
	asm("add.u32				cv_r2, cv_l2, cv_r2;");
	asm("add.u32				cv_r3, cv_l3, cv_r3;");
	asm("add.u32				cv_r4, cv_l4, cv_r4;");
	asm("add.u32				cv_r5, cv_l5, cv_r5;");
	asm("add.u32				cv_r6, cv_l6, cv_r6;");
	asm("add.u32				cv_r7, cv_l7, cv_r7;");

	//rotate_blk(cv_r, 17)
	asm("shf.l.wrap.b32         cv_r0, cv_r0, cv_r0, 17;");
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 17;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 17;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 17;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 17;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 17;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 17;");
	asm("shf.l.wrap.b32         cv_r7, cv_r7, cv_r7, 17;");

	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_msg_gmma(cv_r)
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 8;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 16;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 24;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 24;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 16;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 8;");

	//!word_perm(cv_l, cv_r)
	asm("mov.b32 	            tmp0, cv_l0;");
	asm("mov.b32 	            cv_l0, cv_l6;");
	asm("mov.b32 	            cv_l6, cv_r6;");
	asm("mov.b32 	            cv_r6, cv_r2;");
	asm("mov.b32 	            cv_r2, cv_l1;");
	asm("mov.b32 	            cv_l1, cv_l4;");
	asm("mov.b32 	            cv_l4, cv_r4;");
	asm("mov.b32 	            cv_r4, cv_r0;");
	asm("mov.b32 	            cv_r0, cv_l2;");
	asm("mov.b32 	            cv_l2, cv_l5;");
	asm("mov.b32 	            cv_l5, cv_r7;");
	asm("mov.b32 	            cv_r7, cv_r1;");
	asm("mov.b32 	            cv_r1, tmp0;");
	asm("mov.b32 	            tmp0, cv_l3;");
	asm("mov.b32 	            cv_l3, cv_l7;");
	asm("mov.b32 	            cv_l7, cv_r5;");
	asm("mov.b32 	            cv_r5, cv_r3;");
	asm("mov.b32 	            cv_r3, tmp0;");


	//loop (6)
	//msg_exp_even(i_state)
	asm("mov.b32 	            tmp0, e_l0;");
	asm("add.u32				e_l0, o_l0, e_l3;");
	asm("add.u32				e_l3, o_l3, e_l1;");
	asm("add.u32				e_l1, o_l1, e_l2;");
	asm("add.u32				e_l2, o_l2, tmp0;");

	asm("mov.b32 	            tmp0, e_l4;");
	asm("add.u32				e_l4, o_l4, e_l7;");
	asm("add.u32				e_l7, o_l7, e_l6;");
	asm("add.u32				e_l6, o_l6, e_l5;");
	asm("add.u32				e_l5, o_l5, tmp0;");

	asm("mov.b32 	            tmp0, e_r0;");
	asm("add.u32				e_r0, o_r0, e_r3;");
	asm("add.u32				e_r3, o_r3, e_r1;");
	asm("add.u32				e_r1, o_r1, e_r2;");
	asm("add.u32				e_r2, o_r2, tmp0;");

	asm("mov.b32 	            tmp0, e_r4;");
	asm("add.u32				e_r4, o_r4, e_r7;");
	asm("add.u32				e_r7, o_r7, e_r6;");
	asm("add.u32				e_r6, o_r6, e_r5;");
	asm("add.u32				e_r5, o_r5, tmp0;");

	//! msg_add_even(i_state)
	asm("xor.b32				cv_l0, e_l0, cv_l0;");
	asm("xor.b32				cv_l1, e_l1, cv_l1;");
	asm("xor.b32				cv_l2, e_l2, cv_l2;");
	asm("xor.b32				cv_l3, e_l3, cv_l3;");
	asm("xor.b32				cv_l4, e_l4, cv_l4;");
	asm("xor.b32				cv_l5, e_l5, cv_l5;");
	asm("xor.b32				cv_l6, e_l6, cv_l6;");
	asm("xor.b32				cv_l7, e_l7, cv_l7;");
	asm("xor.b32				cv_r0, e_r0, cv_r0;");
	asm("xor.b32				cv_r1, e_r1, cv_r1;");
	asm("xor.b32				cv_r2, e_r2, cv_r2;");
	asm("xor.b32				cv_r3, e_r3, cv_r3;");
	asm("xor.b32				cv_r4, e_r4, cv_r4;");
	asm("xor.b32				cv_r5, e_r5, cv_r5;");
	asm("xor.b32				cv_r6, e_r6, cv_r6;");
	asm("xor.b32				cv_r7, e_r7, cv_r7;");

	//!MIX(2)
	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_blk(cv_l, 29)
	asm("shf.l.wrap.b32         cv_l0, cv_l0, cv_l0, 29;");
	asm("shf.l.wrap.b32         cv_l1, cv_l1, cv_l1, 29;");
	asm("shf.l.wrap.b32         cv_l2, cv_l2, cv_l2, 29;");
	asm("shf.l.wrap.b32         cv_l3, cv_l3, cv_l3, 29;");
	asm("shf.l.wrap.b32         cv_l4, cv_l4, cv_l4, 29;");
	asm("shf.l.wrap.b32         cv_l5, cv_l5, cv_l5, 29;");
	asm("shf.l.wrap.b32         cv_l6, cv_l6, cv_l6, 29;");
	asm("shf.l.wrap.b32         cv_l7, cv_l7, cv_l7, 29;");

	//xor_with_const
	asm("xor.b32				cv_l0, cv_l0, 0xb052106e;");
	asm("xor.b32				cv_l1, cv_l1, 0x99006d04;");
	asm("xor.b32				cv_l2, cv_l2, 0x2bae8d09;");
	asm("xor.b32				cv_l3, cv_l3, 0xff030601;");
	asm("xor.b32				cv_l4, cv_l4, 0xa271a6d6;");
	asm("xor.b32				cv_l5, cv_l5, 0x0742591d;");
	asm("xor.b32				cv_l6, cv_l6, 0xc81d5701;");
	asm("xor.b32				cv_l7, cv_l7, 0xc9a9e200;");

	//add_blk(cv_r, cv_l)
	asm("add.u32				cv_r0, cv_l0, cv_r0;");
	asm("add.u32				cv_r1, cv_l1, cv_r1;");
	asm("add.u32				cv_r2, cv_l2, cv_r2;");
	asm("add.u32				cv_r3, cv_l3, cv_r3;");
	asm("add.u32				cv_r4, cv_l4, cv_r4;");
	asm("add.u32				cv_r5, cv_l5, cv_r5;");
	asm("add.u32				cv_r6, cv_l6, cv_r6;");
	asm("add.u32				cv_r7, cv_l7, cv_r7;");

	//rotate_blk(cv_r, 1)
	asm("shf.l.wrap.b32         cv_r0, cv_r0, cv_r0, 1;");
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 1;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 1;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 1;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 1;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 1;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 1;");
	asm("shf.l.wrap.b32         cv_r7, cv_r7, cv_r7, 1;");

	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_msg_gmma(cv_r)
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 8;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 16;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 24;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 24;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 16;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 8;");

	//!word_perm(cv_l, cv_r)
	asm("mov.b32 	            tmp0, cv_l0;");
	asm("mov.b32 	            cv_l0, cv_l6;");
	asm("mov.b32 	            cv_l6, cv_r6;");
	asm("mov.b32 	            cv_r6, cv_r2;");
	asm("mov.b32 	            cv_r2, cv_l1;");
	asm("mov.b32 	            cv_l1, cv_l4;");
	asm("mov.b32 	            cv_l4, cv_r4;");
	asm("mov.b32 	            cv_r4, cv_r0;");
	asm("mov.b32 	            cv_r0, cv_l2;");
	asm("mov.b32 	            cv_l2, cv_l5;");
	asm("mov.b32 	            cv_l5, cv_r7;");
	asm("mov.b32 	            cv_r7, cv_r1;");
	asm("mov.b32 	            cv_r1, tmp0;");
	asm("mov.b32 	            tmp0, cv_l3;");
	asm("mov.b32 	            cv_l3, cv_l7;");
	asm("mov.b32 	            cv_l7, cv_r5;");
	asm("mov.b32 	            cv_r5, cv_r3;");
	asm("mov.b32 	            cv_r3, tmp0;");

	//!msg_exp_odd(i_state)
	asm("mov.b32 	            tmp0, o_l0;");
	asm("add.u32				o_l0, e_l0, o_l3;");
	asm("add.u32				o_l3, e_l3, o_l1;");
	asm("add.u32				o_l1, e_l1, o_l2;");
	asm("add.u32				o_l2, e_l2, tmp0;");

	asm("mov.b32 	            tmp0, o_l4;");
	asm("add.u32				o_l4, e_l4, o_l7;");
	asm("add.u32				o_l7, e_l7, o_l6;");
	asm("add.u32				o_l6, e_l6, o_l5;");
	asm("add.u32				o_l5, e_l5, tmp0;");

	asm("mov.b32 	            tmp0, o_r0;");
	asm("add.u32				o_r0, e_r0, o_r3;");
	asm("add.u32				o_r3, e_r3, o_r1;");
	asm("add.u32				o_r1, e_r1, o_r2;");
	asm("add.u32				o_r2, e_r2, tmp0;");

	asm("mov.b32 	            tmp0, o_r4;");
	asm("add.u32				o_r4, e_r4, o_r7;");
	asm("add.u32				o_r7, e_r7, o_r6;");
	asm("add.u32				o_r6, e_r6, o_r5;");
	asm("add.u32				o_r5, e_r5, tmp0;");

	//!msg_add_odd(cv_l, cv_r, i_state)
	//cv_l part
	asm("xor.b32				cv_l0, o_l0, cv_l0;");
	asm("xor.b32				cv_l1, o_l1, cv_l1;");
	asm("xor.b32				cv_l2, o_l2, cv_l2;");
	asm("xor.b32				cv_l3, o_l3, cv_l3;");
	asm("xor.b32				cv_l4, o_l4, cv_l4;");
	asm("xor.b32				cv_l5, o_l5, cv_l5;");
	asm("xor.b32				cv_l6, o_l6, cv_l6;");
	asm("xor.b32				cv_l7, o_l7, cv_l7;");
	//cv_r part
	asm("xor.b32				cv_r0, o_r0, cv_r0;");
	asm("xor.b32				cv_r1, o_r1, cv_r1;");
	asm("xor.b32				cv_r2, o_r2, cv_r2;");
	asm("xor.b32				cv_r3, o_r3, cv_r3;");
	asm("xor.b32				cv_r4, o_r4, cv_r4;");
	asm("xor.b32				cv_r5, o_r5, cv_r5;");
	asm("xor.b32				cv_r6, o_r6, cv_r6;");
	asm("xor.b32				cv_r7, o_r7, cv_r7;");

	//!MIX(4)
	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_blk(cv_l, 5)
	asm("shf.l.wrap.b32         cv_l0, cv_l0, cv_l0, 5;");
	asm("shf.l.wrap.b32         cv_l1, cv_l1, cv_l1, 5;");
	asm("shf.l.wrap.b32         cv_l2, cv_l2, cv_l2, 5;");
	asm("shf.l.wrap.b32         cv_l3, cv_l3, cv_l3, 5;");
	asm("shf.l.wrap.b32         cv_l4, cv_l4, cv_l4, 5;");
	asm("shf.l.wrap.b32         cv_l5, cv_l5, cv_l5, 5;");
	asm("shf.l.wrap.b32         cv_l6, cv_l6, cv_l6, 5;");
	asm("shf.l.wrap.b32         cv_l7, cv_l7, cv_l7, 5;");

	//xor_with_const(cv_l, const_v)
	asm("xor.b32				cv_l0, cv_l0, 0x02627f1e;");
	asm("xor.b32				cv_l1, cv_l1, 0x996d719d;");
	asm("xor.b32				cv_l2, cv_l2, 0xda3b9634;");
	asm("xor.b32				cv_l3, cv_l3, 0x02090800;");
	asm("xor.b32				cv_l4, cv_l4, 0x14187d78;");
	asm("xor.b32				cv_l5, cv_l5, 0x499b7624;");
	asm("xor.b32				cv_l6, cv_l6, 0xe57458c9;");
	asm("xor.b32				cv_l7, cv_l7, 0x738be2c9;");

	//add_blk(cv_r, cv_l)
	asm("add.u32				cv_r0, cv_l0, cv_r0;");
	asm("add.u32				cv_r1, cv_l1, cv_r1;");
	asm("add.u32				cv_r2, cv_l2, cv_r2;");
	asm("add.u32				cv_r3, cv_l3, cv_r3;");
	asm("add.u32				cv_r4, cv_l4, cv_r4;");
	asm("add.u32				cv_r5, cv_l5, cv_r5;");
	asm("add.u32				cv_r6, cv_l6, cv_r6;");
	asm("add.u32				cv_r7, cv_l7, cv_r7;");

	//rotate_blk(cv_r, 17)
	asm("shf.l.wrap.b32         cv_r0, cv_r0, cv_r0, 17;");
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 17;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 17;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 17;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 17;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 17;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 17;");
	asm("shf.l.wrap.b32         cv_r7, cv_r7, cv_r7, 17;");

	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_msg_gmma(cv_r)
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 8;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 16;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 24;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 24;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 16;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 8;");

	//!word_perm(cv_l, cv_r)
	asm("mov.b32 	            tmp0, cv_l0;");
	asm("mov.b32 	            cv_l0, cv_l6;");
	asm("mov.b32 	            cv_l6, cv_r6;");
	asm("mov.b32 	            cv_r6, cv_r2;");
	asm("mov.b32 	            cv_r2, cv_l1;");
	asm("mov.b32 	            cv_l1, cv_l4;");
	asm("mov.b32 	            cv_l4, cv_r4;");
	asm("mov.b32 	            cv_r4, cv_r0;");
	asm("mov.b32 	            cv_r0, cv_l2;");
	asm("mov.b32 	            cv_l2, cv_l5;");
	asm("mov.b32 	            cv_l5, cv_r7;");
	asm("mov.b32 	            cv_r7, cv_r1;");
	asm("mov.b32 	            cv_r1, tmp0;");
	asm("mov.b32 	            tmp0, cv_l3;");
	asm("mov.b32 	            cv_l3, cv_l7;");
	asm("mov.b32 	            cv_l7, cv_r5;");
	asm("mov.b32 	            cv_r5, cv_r3;");
	asm("mov.b32 	            cv_r3, tmp0;");

	//loop (7)
	//msg_exp_even(i_state)
	asm("mov.b32 	            tmp0, e_l0;");
	asm("add.u32				e_l0, o_l0, e_l3;");
	asm("add.u32				e_l3, o_l3, e_l1;");
	asm("add.u32				e_l1, o_l1, e_l2;");
	asm("add.u32				e_l2, o_l2, tmp0;");

	asm("mov.b32 	            tmp0, e_l4;");
	asm("add.u32				e_l4, o_l4, e_l7;");
	asm("add.u32				e_l7, o_l7, e_l6;");
	asm("add.u32				e_l6, o_l6, e_l5;");
	asm("add.u32				e_l5, o_l5, tmp0;");

	asm("mov.b32 	            tmp0, e_r0;");
	asm("add.u32				e_r0, o_r0, e_r3;");
	asm("add.u32				e_r3, o_r3, e_r1;");
	asm("add.u32				e_r1, o_r1, e_r2;");
	asm("add.u32				e_r2, o_r2, tmp0;");

	asm("mov.b32 	            tmp0, e_r4;");
	asm("add.u32				e_r4, o_r4, e_r7;");
	asm("add.u32				e_r7, o_r7, e_r6;");
	asm("add.u32				e_r6, o_r6, e_r5;");
	asm("add.u32				e_r5, o_r5, tmp0;");

	//! msg_add_even(i_state)
	asm("xor.b32				cv_l0, e_l0, cv_l0;");
	asm("xor.b32				cv_l1, e_l1, cv_l1;");
	asm("xor.b32				cv_l2, e_l2, cv_l2;");
	asm("xor.b32				cv_l3, e_l3, cv_l3;");
	asm("xor.b32				cv_l4, e_l4, cv_l4;");
	asm("xor.b32				cv_l5, e_l5, cv_l5;");
	asm("xor.b32				cv_l6, e_l6, cv_l6;");
	asm("xor.b32				cv_l7, e_l7, cv_l7;");
	asm("xor.b32				cv_r0, e_r0, cv_r0;");
	asm("xor.b32				cv_r1, e_r1, cv_r1;");
	asm("xor.b32				cv_r2, e_r2, cv_r2;");
	asm("xor.b32				cv_r3, e_r3, cv_r3;");
	asm("xor.b32				cv_r4, e_r4, cv_r4;");
	asm("xor.b32				cv_r5, e_r5, cv_r5;");
	asm("xor.b32				cv_r6, e_r6, cv_r6;");
	asm("xor.b32				cv_r7, e_r7, cv_r7;");

	//!MIX(2)
	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_blk(cv_l, 29)
	asm("shf.l.wrap.b32         cv_l0, cv_l0, cv_l0, 29;");
	asm("shf.l.wrap.b32         cv_l1, cv_l1, cv_l1, 29;");
	asm("shf.l.wrap.b32         cv_l2, cv_l2, cv_l2, 29;");
	asm("shf.l.wrap.b32         cv_l3, cv_l3, cv_l3, 29;");
	asm("shf.l.wrap.b32         cv_l4, cv_l4, cv_l4, 29;");
	asm("shf.l.wrap.b32         cv_l5, cv_l5, cv_l5, 29;");
	asm("shf.l.wrap.b32         cv_l6, cv_l6, cv_l6, 29;");
	asm("shf.l.wrap.b32         cv_l7, cv_l7, cv_l7, 29;");

	//xor_with_const
	asm("xor.b32				cv_l0, cv_l0, 0x64e19d20;");
	asm("xor.b32				cv_l1, cv_l1, 0x06df0f36;");
	asm("xor.b32				cv_l2, cv_l2, 0x15d1cb0e;");
	asm("xor.b32				cv_l3, cv_l3, 0x0b110802;");
	asm("xor.b32				cv_l4, cv_l4, 0x2c95f58c;");
	asm("xor.b32				cv_l5, cv_l5, 0xe5119a6d;");
	asm("xor.b32				cv_l6, cv_l6, 0x59cd22ae;");
	asm("xor.b32				cv_l7, cv_l7, 0xff6eac3c;");

	//add_blk(cv_r, cv_l)
	asm("add.u32				cv_r0, cv_l0, cv_r0;");
	asm("add.u32				cv_r1, cv_l1, cv_r1;");
	asm("add.u32				cv_r2, cv_l2, cv_r2;");
	asm("add.u32				cv_r3, cv_l3, cv_r3;");
	asm("add.u32				cv_r4, cv_l4, cv_r4;");
	asm("add.u32				cv_r5, cv_l5, cv_r5;");
	asm("add.u32				cv_r6, cv_l6, cv_r6;");
	asm("add.u32				cv_r7, cv_l7, cv_r7;");

	//rotate_blk(cv_r, 1)
	asm("shf.l.wrap.b32         cv_r0, cv_r0, cv_r0, 1;");
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 1;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 1;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 1;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 1;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 1;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 1;");
	asm("shf.l.wrap.b32         cv_r7, cv_r7, cv_r7, 1;");

	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_msg_gmma(cv_r)
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 8;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 16;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 24;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 24;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 16;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 8;");

	//!word_perm(cv_l, cv_r)
	asm("mov.b32 	            tmp0, cv_l0;");
	asm("mov.b32 	            cv_l0, cv_l6;");
	asm("mov.b32 	            cv_l6, cv_r6;");
	asm("mov.b32 	            cv_r6, cv_r2;");
	asm("mov.b32 	            cv_r2, cv_l1;");
	asm("mov.b32 	            cv_l1, cv_l4;");
	asm("mov.b32 	            cv_l4, cv_r4;");
	asm("mov.b32 	            cv_r4, cv_r0;");
	asm("mov.b32 	            cv_r0, cv_l2;");
	asm("mov.b32 	            cv_l2, cv_l5;");
	asm("mov.b32 	            cv_l5, cv_r7;");
	asm("mov.b32 	            cv_r7, cv_r1;");
	asm("mov.b32 	            cv_r1, tmp0;");
	asm("mov.b32 	            tmp0, cv_l3;");
	asm("mov.b32 	            cv_l3, cv_l7;");
	asm("mov.b32 	            cv_l7, cv_r5;");
	asm("mov.b32 	            cv_r5, cv_r3;");
	asm("mov.b32 	            cv_r3, tmp0;");

	//!msg_exp_odd(i_state)
	asm("mov.b32 	            tmp0, o_l0;");
	asm("add.u32				o_l0, e_l0, o_l3;");
	asm("add.u32				o_l3, e_l3, o_l1;");
	asm("add.u32				o_l1, e_l1, o_l2;");
	asm("add.u32				o_l2, e_l2, tmp0;");

	asm("mov.b32 	            tmp0, o_l4;");
	asm("add.u32				o_l4, e_l4, o_l7;");
	asm("add.u32				o_l7, e_l7, o_l6;");
	asm("add.u32				o_l6, e_l6, o_l5;");
	asm("add.u32				o_l5, e_l5, tmp0;");

	asm("mov.b32 	            tmp0, o_r0;");
	asm("add.u32				o_r0, e_r0, o_r3;");
	asm("add.u32				o_r3, e_r3, o_r1;");
	asm("add.u32				o_r1, e_r1, o_r2;");
	asm("add.u32				o_r2, e_r2, tmp0;");

	asm("mov.b32 	            tmp0, o_r4;");
	asm("add.u32				o_r4, e_r4, o_r7;");
	asm("add.u32				o_r7, e_r7, o_r6;");
	asm("add.u32				o_r6, e_r6, o_r5;");
	asm("add.u32				o_r5, e_r5, tmp0;");

	//!msg_add_odd(cv_l, cv_r, i_state)
	//cv_l part
	asm("xor.b32				cv_l0, o_l0, cv_l0;");
	asm("xor.b32				cv_l1, o_l1, cv_l1;");
	asm("xor.b32				cv_l2, o_l2, cv_l2;");
	asm("xor.b32				cv_l3, o_l3, cv_l3;");
	asm("xor.b32				cv_l4, o_l4, cv_l4;");
	asm("xor.b32				cv_l5, o_l5, cv_l5;");
	asm("xor.b32				cv_l6, o_l6, cv_l6;");
	asm("xor.b32				cv_l7, o_l7, cv_l7;");
	//cv_r part
	asm("xor.b32				cv_r0, o_r0, cv_r0;");
	asm("xor.b32				cv_r1, o_r1, cv_r1;");
	asm("xor.b32				cv_r2, o_r2, cv_r2;");
	asm("xor.b32				cv_r3, o_r3, cv_r3;");
	asm("xor.b32				cv_r4, o_r4, cv_r4;");
	asm("xor.b32				cv_r5, o_r5, cv_r5;");
	asm("xor.b32				cv_r6, o_r6, cv_r6;");
	asm("xor.b32				cv_r7, o_r7, cv_r7;");

	//!MIX(4)
	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_blk(cv_l, 5)
	asm("shf.l.wrap.b32         cv_l0, cv_l0, cv_l0, 5;");
	asm("shf.l.wrap.b32         cv_l1, cv_l1, cv_l1, 5;");
	asm("shf.l.wrap.b32         cv_l2, cv_l2, cv_l2, 5;");
	asm("shf.l.wrap.b32         cv_l3, cv_l3, cv_l3, 5;");
	asm("shf.l.wrap.b32         cv_l4, cv_l4, cv_l4, 5;");
	asm("shf.l.wrap.b32         cv_l5, cv_l5, cv_l5, 5;");
	asm("shf.l.wrap.b32         cv_l6, cv_l6, cv_l6, 5;");
	asm("shf.l.wrap.b32         cv_l7, cv_l7, cv_l7, 5;");

	//xor_with_const(cv_l, const_v)
	asm("xor.b32				cv_l0, cv_l0, 0x467ebd84;");
	asm("xor.b32				cv_l1, cv_l1, 0xe5ee453c;");
	asm("xor.b32				cv_l2, cv_l2, 0xe79cd923;");
	asm("xor.b32				cv_l3, cv_l3, 0x1c190a0d;");
	asm("xor.b32				cv_l4, cv_l4, 0xc28b81b8;");
	asm("xor.b32				cv_l5, cv_l5, 0xf6ac0852;");
	asm("xor.b32				cv_l6, cv_l6, 0x26efd107;");
	asm("xor.b32				cv_l7, cv_l7, 0x6e1ae93b;");

	//add_blk(cv_r, cv_l)
	asm("add.u32				cv_r0, cv_l0, cv_r0;");
	asm("add.u32				cv_r1, cv_l1, cv_r1;");
	asm("add.u32				cv_r2, cv_l2, cv_r2;");
	asm("add.u32				cv_r3, cv_l3, cv_r3;");
	asm("add.u32				cv_r4, cv_l4, cv_r4;");
	asm("add.u32				cv_r5, cv_l5, cv_r5;");
	asm("add.u32				cv_r6, cv_l6, cv_r6;");
	asm("add.u32				cv_r7, cv_l7, cv_r7;");

	//rotate_blk(cv_r, 17)
	asm("shf.l.wrap.b32         cv_r0, cv_r0, cv_r0, 17;");
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 17;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 17;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 17;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 17;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 17;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 17;");
	asm("shf.l.wrap.b32         cv_r7, cv_r7, cv_r7, 17;");

	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_msg_gmma(cv_r)
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 8;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 16;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 24;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 24;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 16;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 8;");

	//!word_perm(cv_l, cv_r)
	asm("mov.b32 	            tmp0, cv_l0;");
	asm("mov.b32 	            cv_l0, cv_l6;");
	asm("mov.b32 	            cv_l6, cv_r6;");
	asm("mov.b32 	            cv_r6, cv_r2;");
	asm("mov.b32 	            cv_r2, cv_l1;");
	asm("mov.b32 	            cv_l1, cv_l4;");
	asm("mov.b32 	            cv_l4, cv_r4;");
	asm("mov.b32 	            cv_r4, cv_r0;");
	asm("mov.b32 	            cv_r0, cv_l2;");
	asm("mov.b32 	            cv_l2, cv_l5;");
	asm("mov.b32 	            cv_l5, cv_r7;");
	asm("mov.b32 	            cv_r7, cv_r1;");
	asm("mov.b32 	            cv_r1, tmp0;");
	asm("mov.b32 	            tmp0, cv_l3;");
	asm("mov.b32 	            cv_l3, cv_l7;");
	asm("mov.b32 	            cv_l7, cv_r5;");
	asm("mov.b32 	            cv_r5, cv_r3;");
	asm("mov.b32 	            cv_r3, tmp0;");


	//loop (8)
	//msg_exp_even(i_state)
	asm("mov.b32 	            tmp0, e_l0;");
	asm("add.u32				e_l0, o_l0, e_l3;");
	asm("add.u32				e_l3, o_l3, e_l1;");
	asm("add.u32				e_l1, o_l1, e_l2;");
	asm("add.u32				e_l2, o_l2, tmp0;");

	asm("mov.b32 	            tmp0, e_l4;");
	asm("add.u32				e_l4, o_l4, e_l7;");
	asm("add.u32				e_l7, o_l7, e_l6;");
	asm("add.u32				e_l6, o_l6, e_l5;");
	asm("add.u32				e_l5, o_l5, tmp0;");

	asm("mov.b32 	            tmp0, e_r0;");
	asm("add.u32				e_r0, o_r0, e_r3;");
	asm("add.u32				e_r3, o_r3, e_r1;");
	asm("add.u32				e_r1, o_r1, e_r2;");
	asm("add.u32				e_r2, o_r2, tmp0;");

	asm("mov.b32 	            tmp0, e_r4;");
	asm("add.u32				e_r4, o_r4, e_r7;");
	asm("add.u32				e_r7, o_r7, e_r6;");
	asm("add.u32				e_r6, o_r6, e_r5;");
	asm("add.u32				e_r5, o_r5, tmp0;");

	//! msg_add_even(i_state)
	asm("xor.b32				cv_l0, e_l0, cv_l0;");
	asm("xor.b32				cv_l1, e_l1, cv_l1;");
	asm("xor.b32				cv_l2, e_l2, cv_l2;");
	asm("xor.b32				cv_l3, e_l3, cv_l3;");
	asm("xor.b32				cv_l4, e_l4, cv_l4;");
	asm("xor.b32				cv_l5, e_l5, cv_l5;");
	asm("xor.b32				cv_l6, e_l6, cv_l6;");
	asm("xor.b32				cv_l7, e_l7, cv_l7;");
	asm("xor.b32				cv_r0, e_r0, cv_r0;");
	asm("xor.b32				cv_r1, e_r1, cv_r1;");
	asm("xor.b32				cv_r2, e_r2, cv_r2;");
	asm("xor.b32				cv_r3, e_r3, cv_r3;");
	asm("xor.b32				cv_r4, e_r4, cv_r4;");
	asm("xor.b32				cv_r5, e_r5, cv_r5;");
	asm("xor.b32				cv_r6, e_r6, cv_r6;");
	asm("xor.b32				cv_r7, e_r7, cv_r7;");

	//!MIX(2)
	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_blk(cv_l, 29)
	asm("shf.l.wrap.b32         cv_l0, cv_l0, cv_l0, 29;");
	asm("shf.l.wrap.b32         cv_l1, cv_l1, cv_l1, 29;");
	asm("shf.l.wrap.b32         cv_l2, cv_l2, cv_l2, 29;");
	asm("shf.l.wrap.b32         cv_l3, cv_l3, cv_l3, 29;");
	asm("shf.l.wrap.b32         cv_l4, cv_l4, cv_l4, 29;");
	asm("shf.l.wrap.b32         cv_l5, cv_l5, cv_l5, 29;");
	asm("shf.l.wrap.b32         cv_l6, cv_l6, cv_l6, 29;");
	asm("shf.l.wrap.b32         cv_l7, cv_l7, cv_l7, 29;");

	//xor_with_const
	asm("xor.b32				cv_l0, cv_l0, 0xc53c41ca;");
	asm("xor.b32				cv_l1, cv_l1, 0xd4338221;");
	asm("xor.b32				cv_l2, cv_l2, 0x8475fd0a;");
	asm("xor.b32				cv_l3, cv_l3, 0x35231729;");
	asm("xor.b32				cv_l4, cv_l4, 0x4e0d3a7a;");
	asm("xor.b32				cv_l5, cv_l5, 0xa2b45b48;");
	asm("xor.b32				cv_l6, cv_l6, 0x16c0d82d;");
	asm("xor.b32				cv_l7, cv_l7, 0x890424a9;");

	//add_blk(cv_r, cv_l)
	asm("add.u32				cv_r0, cv_l0, cv_r0;");
	asm("add.u32				cv_r1, cv_l1, cv_r1;");
	asm("add.u32				cv_r2, cv_l2, cv_r2;");
	asm("add.u32				cv_r3, cv_l3, cv_r3;");
	asm("add.u32				cv_r4, cv_l4, cv_r4;");
	asm("add.u32				cv_r5, cv_l5, cv_r5;");
	asm("add.u32				cv_r6, cv_l6, cv_r6;");
	asm("add.u32				cv_r7, cv_l7, cv_r7;");

	//rotate_blk(cv_r, 1)
	asm("shf.l.wrap.b32         cv_r0, cv_r0, cv_r0, 1;");
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 1;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 1;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 1;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 1;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 1;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 1;");
	asm("shf.l.wrap.b32         cv_r7, cv_r7, cv_r7, 1;");

	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_msg_gmma(cv_r)
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 8;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 16;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 24;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 24;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 16;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 8;");

	//!word_perm(cv_l, cv_r)
	asm("mov.b32 	            tmp0, cv_l0;");
	asm("mov.b32 	            cv_l0, cv_l6;");
	asm("mov.b32 	            cv_l6, cv_r6;");
	asm("mov.b32 	            cv_r6, cv_r2;");
	asm("mov.b32 	            cv_r2, cv_l1;");
	asm("mov.b32 	            cv_l1, cv_l4;");
	asm("mov.b32 	            cv_l4, cv_r4;");
	asm("mov.b32 	            cv_r4, cv_r0;");
	asm("mov.b32 	            cv_r0, cv_l2;");
	asm("mov.b32 	            cv_l2, cv_l5;");
	asm("mov.b32 	            cv_l5, cv_r7;");
	asm("mov.b32 	            cv_r7, cv_r1;");
	asm("mov.b32 	            cv_r1, tmp0;");
	asm("mov.b32 	            tmp0, cv_l3;");
	asm("mov.b32 	            cv_l3, cv_l7;");
	asm("mov.b32 	            cv_l7, cv_r5;");
	asm("mov.b32 	            cv_r5, cv_r3;");
	asm("mov.b32 	            cv_r3, tmp0;");

	//!msg_exp_odd(i_state)
	asm("mov.b32 	            tmp0, o_l0;");
	asm("add.u32				o_l0, e_l0, o_l3;");
	asm("add.u32				o_l3, e_l3, o_l1;");
	asm("add.u32				o_l1, e_l1, o_l2;");
	asm("add.u32				o_l2, e_l2, tmp0;");

	asm("mov.b32 	            tmp0, o_l4;");
	asm("add.u32				o_l4, e_l4, o_l7;");
	asm("add.u32				o_l7, e_l7, o_l6;");
	asm("add.u32				o_l6, e_l6, o_l5;");
	asm("add.u32				o_l5, e_l5, tmp0;");

	asm("mov.b32 	            tmp0, o_r0;");
	asm("add.u32				o_r0, e_r0, o_r3;");
	asm("add.u32				o_r3, e_r3, o_r1;");
	asm("add.u32				o_r1, e_r1, o_r2;");
	asm("add.u32				o_r2, e_r2, tmp0;");

	asm("mov.b32 	            tmp0, o_r4;");
	asm("add.u32				o_r4, e_r4, o_r7;");
	asm("add.u32				o_r7, e_r7, o_r6;");
	asm("add.u32				o_r6, e_r6, o_r5;");
	asm("add.u32				o_r5, e_r5, tmp0;");

	//!msg_add_odd(cv_l, cv_r, i_state)
	//cv_l part
	asm("xor.b32				cv_l0, o_l0, cv_l0;");
	asm("xor.b32				cv_l1, o_l1, cv_l1;");
	asm("xor.b32				cv_l2, o_l2, cv_l2;");
	asm("xor.b32				cv_l3, o_l3, cv_l3;");
	asm("xor.b32				cv_l4, o_l4, cv_l4;");
	asm("xor.b32				cv_l5, o_l5, cv_l5;");
	asm("xor.b32				cv_l6, o_l6, cv_l6;");
	asm("xor.b32				cv_l7, o_l7, cv_l7;");
	//cv_r part
	asm("xor.b32				cv_r0, o_r0, cv_r0;");
	asm("xor.b32				cv_r1, o_r1, cv_r1;");
	asm("xor.b32				cv_r2, o_r2, cv_r2;");
	asm("xor.b32				cv_r3, o_r3, cv_r3;");
	asm("xor.b32				cv_r4, o_r4, cv_r4;");
	asm("xor.b32				cv_r5, o_r5, cv_r5;");
	asm("xor.b32				cv_r6, o_r6, cv_r6;");
	asm("xor.b32				cv_r7, o_r7, cv_r7;");

	//!MIX(4)
	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_blk(cv_l, 5)
	asm("shf.l.wrap.b32         cv_l0, cv_l0, cv_l0, 5;");
	asm("shf.l.wrap.b32         cv_l1, cv_l1, cv_l1, 5;");
	asm("shf.l.wrap.b32         cv_l2, cv_l2, cv_l2, 5;");
	asm("shf.l.wrap.b32         cv_l3, cv_l3, cv_l3, 5;");
	asm("shf.l.wrap.b32         cv_l4, cv_l4, cv_l4, 5;");
	asm("shf.l.wrap.b32         cv_l5, cv_l5, cv_l5, 5;");
	asm("shf.l.wrap.b32         cv_l6, cv_l6, cv_l6, 5;");
	asm("shf.l.wrap.b32         cv_l7, cv_l7, cv_l7, 5;");

	//xor_with_const(cv_l, const_v)
	asm("xor.b32				cv_l0, cv_l0, 0x017e0c8f;");
	asm("xor.b32				cv_l1, cv_l1, 0x07b5a3f5;");
	asm("xor.b32				cv_l2, cv_l2, 0xfa73078e;");
	asm("xor.b32				cv_l3, cv_l3, 0x583a405e;");
	asm("xor.b32				cv_l4, cv_l4, 0x5b47b4c8;");
	asm("xor.b32				cv_l5, cv_l5, 0x570fa3ea;");
	asm("xor.b32				cv_l6, cv_l6, 0xd7990543;");
	asm("xor.b32				cv_l7, cv_l7, 0x8d28ce32;");

	//add_blk(cv_r, cv_l)
	asm("add.u32				cv_r0, cv_l0, cv_r0;");
	asm("add.u32				cv_r1, cv_l1, cv_r1;");
	asm("add.u32				cv_r2, cv_l2, cv_r2;");
	asm("add.u32				cv_r3, cv_l3, cv_r3;");
	asm("add.u32				cv_r4, cv_l4, cv_r4;");
	asm("add.u32				cv_r5, cv_l5, cv_r5;");
	asm("add.u32				cv_r6, cv_l6, cv_r6;");
	asm("add.u32				cv_r7, cv_l7, cv_r7;");

	//rotate_blk(cv_r, 17)
	asm("shf.l.wrap.b32         cv_r0, cv_r0, cv_r0, 17;");
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 17;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 17;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 17;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 17;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 17;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 17;");
	asm("shf.l.wrap.b32         cv_r7, cv_r7, cv_r7, 17;");

	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_msg_gmma(cv_r)
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 8;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 16;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 24;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 24;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 16;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 8;");

	//!word_perm(cv_l, cv_r)
	asm("mov.b32 	            tmp0, cv_l0;");
	asm("mov.b32 	            cv_l0, cv_l6;");
	asm("mov.b32 	            cv_l6, cv_r6;");
	asm("mov.b32 	            cv_r6, cv_r2;");
	asm("mov.b32 	            cv_r2, cv_l1;");
	asm("mov.b32 	            cv_l1, cv_l4;");
	asm("mov.b32 	            cv_l4, cv_r4;");
	asm("mov.b32 	            cv_r4, cv_r0;");
	asm("mov.b32 	            cv_r0, cv_l2;");
	asm("mov.b32 	            cv_l2, cv_l5;");
	asm("mov.b32 	            cv_l5, cv_r7;");
	asm("mov.b32 	            cv_r7, cv_r1;");
	asm("mov.b32 	            cv_r1, tmp0;");
	asm("mov.b32 	            tmp0, cv_l3;");
	asm("mov.b32 	            cv_l3, cv_l7;");
	asm("mov.b32 	            cv_l7, cv_r5;");
	asm("mov.b32 	            cv_r5, cv_r3;");
	asm("mov.b32 	            cv_r3, tmp0;");


	//loop (9)
	//msg_exp_even(i_state)
	asm("mov.b32 	            tmp0, e_l0;");
	asm("add.u32				e_l0, o_l0, e_l3;");
	asm("add.u32				e_l3, o_l3, e_l1;");
	asm("add.u32				e_l1, o_l1, e_l2;");
	asm("add.u32				e_l2, o_l2, tmp0;");

	asm("mov.b32 	            tmp0, e_l4;");
	asm("add.u32				e_l4, o_l4, e_l7;");
	asm("add.u32				e_l7, o_l7, e_l6;");
	asm("add.u32				e_l6, o_l6, e_l5;");
	asm("add.u32				e_l5, o_l5, tmp0;");

	asm("mov.b32 	            tmp0, e_r0;");
	asm("add.u32				e_r0, o_r0, e_r3;");
	asm("add.u32				e_r3, o_r3, e_r1;");
	asm("add.u32				e_r1, o_r1, e_r2;");
	asm("add.u32				e_r2, o_r2, tmp0;");

	asm("mov.b32 	            tmp0, e_r4;");
	asm("add.u32				e_r4, o_r4, e_r7;");
	asm("add.u32				e_r7, o_r7, e_r6;");
	asm("add.u32				e_r6, o_r6, e_r5;");
	asm("add.u32				e_r5, o_r5, tmp0;");

	//! msg_add_even(i_state)
	asm("xor.b32				cv_l0, e_l0, cv_l0;");
	asm("xor.b32				cv_l1, e_l1, cv_l1;");
	asm("xor.b32				cv_l2, e_l2, cv_l2;");
	asm("xor.b32				cv_l3, e_l3, cv_l3;");
	asm("xor.b32				cv_l4, e_l4, cv_l4;");
	asm("xor.b32				cv_l5, e_l5, cv_l5;");
	asm("xor.b32				cv_l6, e_l6, cv_l6;");
	asm("xor.b32				cv_l7, e_l7, cv_l7;");
	asm("xor.b32				cv_r0, e_r0, cv_r0;");
	asm("xor.b32				cv_r1, e_r1, cv_r1;");
	asm("xor.b32				cv_r2, e_r2, cv_r2;");
	asm("xor.b32				cv_r3, e_r3, cv_r3;");
	asm("xor.b32				cv_r4, e_r4, cv_r4;");
	asm("xor.b32				cv_r5, e_r5, cv_r5;");
	asm("xor.b32				cv_r6, e_r6, cv_r6;");
	asm("xor.b32				cv_r7, e_r7, cv_r7;");

	//!MIX(2)
	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_blk(cv_l, 29)
	asm("shf.l.wrap.b32         cv_l0, cv_l0, cv_l0, 29;");
	asm("shf.l.wrap.b32         cv_l1, cv_l1, cv_l1, 29;");
	asm("shf.l.wrap.b32         cv_l2, cv_l2, cv_l2, 29;");
	asm("shf.l.wrap.b32         cv_l3, cv_l3, cv_l3, 29;");
	asm("shf.l.wrap.b32         cv_l4, cv_l4, cv_l4, 29;");
	asm("shf.l.wrap.b32         cv_l5, cv_l5, cv_l5, 29;");
	asm("shf.l.wrap.b32         cv_l6, cv_l6, cv_l6, 29;");
	asm("shf.l.wrap.b32         cv_l7, cv_l7, cv_l7, 29;");

	//xor_with_const
	asm("xor.b32				cv_l0, cv_l0, 0x7f8a9b90;");
	asm("xor.b32				cv_l1, cv_l1, 0xbd5998fc;");
	asm("xor.b32				cv_l2, cv_l2, 0x6d7a9688;");
	asm("xor.b32				cv_l3, cv_l3, 0x927a9eb6;");
	asm("xor.b32				cv_l4, cv_l4, 0xa2fc7d23;");
	asm("xor.b32				cv_l5, cv_l5, 0x66b38e41;");
	asm("xor.b32				cv_l6, cv_l6, 0x709e491a;");
	asm("xor.b32				cv_l7, cv_l7, 0xb5f700bf;");

	//add_blk(cv_r, cv_l)
	asm("add.u32				cv_r0, cv_l0, cv_r0;");
	asm("add.u32				cv_r1, cv_l1, cv_r1;");
	asm("add.u32				cv_r2, cv_l2, cv_r2;");
	asm("add.u32				cv_r3, cv_l3, cv_r3;");
	asm("add.u32				cv_r4, cv_l4, cv_r4;");
	asm("add.u32				cv_r5, cv_l5, cv_r5;");
	asm("add.u32				cv_r6, cv_l6, cv_r6;");
	asm("add.u32				cv_r7, cv_l7, cv_r7;");

	//rotate_blk(cv_r, 1)
	asm("shf.l.wrap.b32         cv_r0, cv_r0, cv_r0, 1;");
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 1;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 1;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 1;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 1;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 1;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 1;");
	asm("shf.l.wrap.b32         cv_r7, cv_r7, cv_r7, 1;");

	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_msg_gmma(cv_r)
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 8;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 16;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 24;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 24;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 16;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 8;");

	//!word_perm(cv_l, cv_r)
	asm("mov.b32 	            tmp0, cv_l0;");
	asm("mov.b32 	            cv_l0, cv_l6;");
	asm("mov.b32 	            cv_l6, cv_r6;");
	asm("mov.b32 	            cv_r6, cv_r2;");
	asm("mov.b32 	            cv_r2, cv_l1;");
	asm("mov.b32 	            cv_l1, cv_l4;");
	asm("mov.b32 	            cv_l4, cv_r4;");
	asm("mov.b32 	            cv_r4, cv_r0;");
	asm("mov.b32 	            cv_r0, cv_l2;");
	asm("mov.b32 	            cv_l2, cv_l5;");
	asm("mov.b32 	            cv_l5, cv_r7;");
	asm("mov.b32 	            cv_r7, cv_r1;");
	asm("mov.b32 	            cv_r1, tmp0;");
	asm("mov.b32 	            tmp0, cv_l3;");
	asm("mov.b32 	            cv_l3, cv_l7;");
	asm("mov.b32 	            cv_l7, cv_r5;");
	asm("mov.b32 	            cv_r5, cv_r3;");
	asm("mov.b32 	            cv_r3, tmp0;");

	//!msg_exp_odd(i_state)
	asm("mov.b32 	            tmp0, o_l0;");
	asm("add.u32				o_l0, e_l0, o_l3;");
	asm("add.u32				o_l3, e_l3, o_l1;");
	asm("add.u32				o_l1, e_l1, o_l2;");
	asm("add.u32				o_l2, e_l2, tmp0;");

	asm("mov.b32 	            tmp0, o_l4;");
	asm("add.u32				o_l4, e_l4, o_l7;");
	asm("add.u32				o_l7, e_l7, o_l6;");
	asm("add.u32				o_l6, e_l6, o_l5;");
	asm("add.u32				o_l5, e_l5, tmp0;");

	asm("mov.b32 	            tmp0, o_r0;");
	asm("add.u32				o_r0, e_r0, o_r3;");
	asm("add.u32				o_r3, e_r3, o_r1;");
	asm("add.u32				o_r1, e_r1, o_r2;");
	asm("add.u32				o_r2, e_r2, tmp0;");

	asm("mov.b32 	            tmp0, o_r4;");
	asm("add.u32				o_r4, e_r4, o_r7;");
	asm("add.u32				o_r7, e_r7, o_r6;");
	asm("add.u32				o_r6, e_r6, o_r5;");
	asm("add.u32				o_r5, e_r5, tmp0;");

	//!msg_add_odd(cv_l, cv_r, i_state)
	//cv_l part
	asm("xor.b32				cv_l0, o_l0, cv_l0;");
	asm("xor.b32				cv_l1, o_l1, cv_l1;");
	asm("xor.b32				cv_l2, o_l2, cv_l2;");
	asm("xor.b32				cv_l3, o_l3, cv_l3;");
	asm("xor.b32				cv_l4, o_l4, cv_l4;");
	asm("xor.b32				cv_l5, o_l5, cv_l5;");
	asm("xor.b32				cv_l6, o_l6, cv_l6;");
	asm("xor.b32				cv_l7, o_l7, cv_l7;");
	//cv_r part
	asm("xor.b32				cv_r0, o_r0, cv_r0;");
	asm("xor.b32				cv_r1, o_r1, cv_r1;");
	asm("xor.b32				cv_r2, o_r2, cv_r2;");
	asm("xor.b32				cv_r3, o_r3, cv_r3;");
	asm("xor.b32				cv_r4, o_r4, cv_r4;");
	asm("xor.b32				cv_r5, o_r5, cv_r5;");
	asm("xor.b32				cv_r6, o_r6, cv_r6;");
	asm("xor.b32				cv_r7, o_r7, cv_r7;");

	//!MIX(4)
	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_blk(cv_l, 5)
	asm("shf.l.wrap.b32         cv_l0, cv_l0, cv_l0, 5;");
	asm("shf.l.wrap.b32         cv_l1, cv_l1, cv_l1, 5;");
	asm("shf.l.wrap.b32         cv_l2, cv_l2, cv_l2, 5;");
	asm("shf.l.wrap.b32         cv_l3, cv_l3, cv_l3, 5;");
	asm("shf.l.wrap.b32         cv_l4, cv_l4, cv_l4, 5;");
	asm("shf.l.wrap.b32         cv_l5, cv_l5, cv_l5, 5;");
	asm("shf.l.wrap.b32         cv_l6, cv_l6, cv_l6, 5;");
	asm("shf.l.wrap.b32         cv_l7, cv_l7, cv_l7, 5;");

	//xor_with_const(cv_l, const_v)
	asm("xor.b32				cv_l0, cv_l0, 0x0a262c0f;");
	asm("xor.b32				cv_l1, cv_l1, 0x16f295b9;");
	asm("xor.b32				cv_l2, cv_l2, 0xe8111ef5;");
	asm("xor.b32				cv_l3, cv_l3, 0x0d195548;");
	asm("xor.b32				cv_l4, cv_l4, 0x9f79a0c5;");
	asm("xor.b32				cv_l5, cv_l5, 0x1a41cfa7;");
	asm("xor.b32				cv_l6, cv_l6, 0x0ee7638a;");
	asm("xor.b32				cv_l7, cv_l7, 0xacf7c074;");

	//add_blk(cv_r, cv_l)
	asm("add.u32				cv_r0, cv_l0, cv_r0;");
	asm("add.u32				cv_r1, cv_l1, cv_r1;");
	asm("add.u32				cv_r2, cv_l2, cv_r2;");
	asm("add.u32				cv_r3, cv_l3, cv_r3;");
	asm("add.u32				cv_r4, cv_l4, cv_r4;");
	asm("add.u32				cv_r5, cv_l5, cv_r5;");
	asm("add.u32				cv_r6, cv_l6, cv_r6;");
	asm("add.u32				cv_r7, cv_l7, cv_r7;");

	//rotate_blk(cv_r, 17)
	asm("shf.l.wrap.b32         cv_r0, cv_r0, cv_r0, 17;");
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 17;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 17;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 17;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 17;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 17;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 17;");
	asm("shf.l.wrap.b32         cv_r7, cv_r7, cv_r7, 17;");

	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_msg_gmma(cv_r)
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 8;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 16;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 24;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 24;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 16;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 8;");

	//!word_perm(cv_l, cv_r)
	asm("mov.b32 	            tmp0, cv_l0;");
	asm("mov.b32 	            cv_l0, cv_l6;");
	asm("mov.b32 	            cv_l6, cv_r6;");
	asm("mov.b32 	            cv_r6, cv_r2;");
	asm("mov.b32 	            cv_r2, cv_l1;");
	asm("mov.b32 	            cv_l1, cv_l4;");
	asm("mov.b32 	            cv_l4, cv_r4;");
	asm("mov.b32 	            cv_r4, cv_r0;");
	asm("mov.b32 	            cv_r0, cv_l2;");
	asm("mov.b32 	            cv_l2, cv_l5;");
	asm("mov.b32 	            cv_l5, cv_r7;");
	asm("mov.b32 	            cv_r7, cv_r1;");
	asm("mov.b32 	            cv_r1, tmp0;");
	asm("mov.b32 	            tmp0, cv_l3;");
	asm("mov.b32 	            cv_l3, cv_l7;");
	asm("mov.b32 	            cv_l7, cv_r5;");
	asm("mov.b32 	            cv_r5, cv_r3;");
	asm("mov.b32 	            cv_r3, tmp0;");

	//loop (10)
	//msg_exp_even(i_state)
	asm("mov.b32 	            tmp0, e_l0;");
	asm("add.u32				e_l0, o_l0, e_l3;");
	asm("add.u32				e_l3, o_l3, e_l1;");
	asm("add.u32				e_l1, o_l1, e_l2;");
	asm("add.u32				e_l2, o_l2, tmp0;");

	asm("mov.b32 	            tmp0, e_l4;");
	asm("add.u32				e_l4, o_l4, e_l7;");
	asm("add.u32				e_l7, o_l7, e_l6;");
	asm("add.u32				e_l6, o_l6, e_l5;");
	asm("add.u32				e_l5, o_l5, tmp0;");

	asm("mov.b32 	            tmp0, e_r0;");
	asm("add.u32				e_r0, o_r0, e_r3;");
	asm("add.u32				e_r3, o_r3, e_r1;");
	asm("add.u32				e_r1, o_r1, e_r2;");
	asm("add.u32				e_r2, o_r2, tmp0;");

	asm("mov.b32 	            tmp0, e_r4;");
	asm("add.u32				e_r4, o_r4, e_r7;");
	asm("add.u32				e_r7, o_r7, e_r6;");
	asm("add.u32				e_r6, o_r6, e_r5;");
	asm("add.u32				e_r5, o_r5, tmp0;");

	//! msg_add_even(i_state)
	asm("xor.b32				cv_l0, e_l0, cv_l0;");
	asm("xor.b32				cv_l1, e_l1, cv_l1;");
	asm("xor.b32				cv_l2, e_l2, cv_l2;");
	asm("xor.b32				cv_l3, e_l3, cv_l3;");
	asm("xor.b32				cv_l4, e_l4, cv_l4;");
	asm("xor.b32				cv_l5, e_l5, cv_l5;");
	asm("xor.b32				cv_l6, e_l6, cv_l6;");
	asm("xor.b32				cv_l7, e_l7, cv_l7;");
	asm("xor.b32				cv_r0, e_r0, cv_r0;");
	asm("xor.b32				cv_r1, e_r1, cv_r1;");
	asm("xor.b32				cv_r2, e_r2, cv_r2;");
	asm("xor.b32				cv_r3, e_r3, cv_r3;");
	asm("xor.b32				cv_r4, e_r4, cv_r4;");
	asm("xor.b32				cv_r5, e_r5, cv_r5;");
	asm("xor.b32				cv_r6, e_r6, cv_r6;");
	asm("xor.b32				cv_r7, e_r7, cv_r7;");

	//!MIX(2)
	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_blk(cv_l, 29)
	asm("shf.l.wrap.b32         cv_l0, cv_l0, cv_l0, 29;");
	asm("shf.l.wrap.b32         cv_l1, cv_l1, cv_l1, 29;");
	asm("shf.l.wrap.b32         cv_l2, cv_l2, cv_l2, 29;");
	asm("shf.l.wrap.b32         cv_l3, cv_l3, cv_l3, 29;");
	asm("shf.l.wrap.b32         cv_l4, cv_l4, cv_l4, 29;");
	asm("shf.l.wrap.b32         cv_l5, cv_l5, cv_l5, 29;");
	asm("shf.l.wrap.b32         cv_l6, cv_l6, cv_l6, 29;");
	asm("shf.l.wrap.b32         cv_l7, cv_l7, cv_l7, 29;");

	//xor_with_const
	asm("xor.b32				cv_l0, cv_l0, 0x30523b19;");
	asm("xor.b32				cv_l1, cv_l1, 0x09884ecf;");
	asm("xor.b32				cv_l2, cv_l2, 0xf93014dd;");
	asm("xor.b32				cv_l3, cv_l3, 0x266e9d55;");
	asm("xor.b32				cv_l4, cv_l4, 0x191a6664;");
	asm("xor.b32				cv_l5, cv_l5, 0x5c1176c1;");
	asm("xor.b32				cv_l6, cv_l6, 0xf64aed98;");
	asm("xor.b32				cv_l7, cv_l7, 0xa4b83520;");

	//add_blk(cv_r, cv_l)
	asm("add.u32				cv_r0, cv_l0, cv_r0;");
	asm("add.u32				cv_r1, cv_l1, cv_r1;");
	asm("add.u32				cv_r2, cv_l2, cv_r2;");
	asm("add.u32				cv_r3, cv_l3, cv_r3;");
	asm("add.u32				cv_r4, cv_l4, cv_r4;");
	asm("add.u32				cv_r5, cv_l5, cv_r5;");
	asm("add.u32				cv_r6, cv_l6, cv_r6;");
	asm("add.u32				cv_r7, cv_l7, cv_r7;");

	//rotate_blk(cv_r, 1)
	asm("shf.l.wrap.b32         cv_r0, cv_r0, cv_r0, 1;");
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 1;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 1;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 1;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 1;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 1;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 1;");
	asm("shf.l.wrap.b32         cv_r7, cv_r7, cv_r7, 1;");

	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_msg_gmma(cv_r)
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 8;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 16;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 24;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 24;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 16;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 8;");

	//!word_perm(cv_l, cv_r)
	asm("mov.b32 	            tmp0, cv_l0;");
	asm("mov.b32 	            cv_l0, cv_l6;");
	asm("mov.b32 	            cv_l6, cv_r6;");
	asm("mov.b32 	            cv_r6, cv_r2;");
	asm("mov.b32 	            cv_r2, cv_l1;");
	asm("mov.b32 	            cv_l1, cv_l4;");
	asm("mov.b32 	            cv_l4, cv_r4;");
	asm("mov.b32 	            cv_r4, cv_r0;");
	asm("mov.b32 	            cv_r0, cv_l2;");
	asm("mov.b32 	            cv_l2, cv_l5;");
	asm("mov.b32 	            cv_l5, cv_r7;");
	asm("mov.b32 	            cv_r7, cv_r1;");
	asm("mov.b32 	            cv_r1, tmp0;");
	asm("mov.b32 	            tmp0, cv_l3;");
	asm("mov.b32 	            cv_l3, cv_l7;");
	asm("mov.b32 	            cv_l7, cv_r5;");
	asm("mov.b32 	            cv_r5, cv_r3;");
	asm("mov.b32 	            cv_r3, tmp0;");

	//!msg_exp_odd(i_state)
	asm("mov.b32 	            tmp0, o_l0;");
	asm("add.u32				o_l0, e_l0, o_l3;");
	asm("add.u32				o_l3, e_l3, o_l1;");
	asm("add.u32				o_l1, e_l1, o_l2;");
	asm("add.u32				o_l2, e_l2, tmp0;");

	asm("mov.b32 	            tmp0, o_l4;");
	asm("add.u32				o_l4, e_l4, o_l7;");
	asm("add.u32				o_l7, e_l7, o_l6;");
	asm("add.u32				o_l6, e_l6, o_l5;");
	asm("add.u32				o_l5, e_l5, tmp0;");

	asm("mov.b32 	            tmp0, o_r0;");
	asm("add.u32				o_r0, e_r0, o_r3;");
	asm("add.u32				o_r3, e_r3, o_r1;");
	asm("add.u32				o_r1, e_r1, o_r2;");
	asm("add.u32				o_r2, e_r2, tmp0;");

	asm("mov.b32 	            tmp0, o_r4;");
	asm("add.u32				o_r4, e_r4, o_r7;");
	asm("add.u32				o_r7, e_r7, o_r6;");
	asm("add.u32				o_r6, e_r6, o_r5;");
	asm("add.u32				o_r5, e_r5, tmp0;");

	//!msg_add_odd(cv_l, cv_r, i_state)
	//cv_l part
	asm("xor.b32				cv_l0, o_l0, cv_l0;");
	asm("xor.b32				cv_l1, o_l1, cv_l1;");
	asm("xor.b32				cv_l2, o_l2, cv_l2;");
	asm("xor.b32				cv_l3, o_l3, cv_l3;");
	asm("xor.b32				cv_l4, o_l4, cv_l4;");
	asm("xor.b32				cv_l5, o_l5, cv_l5;");
	asm("xor.b32				cv_l6, o_l6, cv_l6;");
	asm("xor.b32				cv_l7, o_l7, cv_l7;");
	//cv_r part
	asm("xor.b32				cv_r0, o_r0, cv_r0;");
	asm("xor.b32				cv_r1, o_r1, cv_r1;");
	asm("xor.b32				cv_r2, o_r2, cv_r2;");
	asm("xor.b32				cv_r3, o_r3, cv_r3;");
	asm("xor.b32				cv_r4, o_r4, cv_r4;");
	asm("xor.b32				cv_r5, o_r5, cv_r5;");
	asm("xor.b32				cv_r6, o_r6, cv_r6;");
	asm("xor.b32				cv_r7, o_r7, cv_r7;");

	//!MIX(4)
	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_blk(cv_l, 5)
	asm("shf.l.wrap.b32         cv_l0, cv_l0, cv_l0, 5;");
	asm("shf.l.wrap.b32         cv_l1, cv_l1, cv_l1, 5;");
	asm("shf.l.wrap.b32         cv_l2, cv_l2, cv_l2, 5;");
	asm("shf.l.wrap.b32         cv_l3, cv_l3, cv_l3, 5;");
	asm("shf.l.wrap.b32         cv_l4, cv_l4, cv_l4, 5;");
	asm("shf.l.wrap.b32         cv_l5, cv_l5, cv_l5, 5;");
	asm("shf.l.wrap.b32         cv_l6, cv_l6, cv_l6, 5;");
	asm("shf.l.wrap.b32         cv_l7, cv_l7, cv_l7, 5;");

	//xor_with_const(cv_l, const_v)
	asm("xor.b32				cv_l0, cv_l0, 0x828d5449;");
	asm("xor.b32				cv_l1, cv_l1, 0x91d71dd8;");
	asm("xor.b32				cv_l2, cv_l2, 0x2944f2d6;");
	asm("xor.b32				cv_l3, cv_l3, 0x950bf27b;");
	asm("xor.b32				cv_l4, cv_l4, 0x3380ca7d;");
	asm("xor.b32				cv_l5, cv_l5, 0x6d88381d;");
	asm("xor.b32				cv_l6, cv_l6, 0x4138868e;");
	asm("xor.b32				cv_l7, cv_l7, 0x5ced55c4;");

	//add_blk(cv_r, cv_l)
	asm("add.u32				cv_r0, cv_l0, cv_r0;");
	asm("add.u32				cv_r1, cv_l1, cv_r1;");
	asm("add.u32				cv_r2, cv_l2, cv_r2;");
	asm("add.u32				cv_r3, cv_l3, cv_r3;");
	asm("add.u32				cv_r4, cv_l4, cv_r4;");
	asm("add.u32				cv_r5, cv_l5, cv_r5;");
	asm("add.u32				cv_r6, cv_l6, cv_r6;");
	asm("add.u32				cv_r7, cv_l7, cv_r7;");

	//rotate_blk(cv_r, 17)
	asm("shf.l.wrap.b32         cv_r0, cv_r0, cv_r0, 17;");
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 17;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 17;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 17;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 17;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 17;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 17;");
	asm("shf.l.wrap.b32         cv_r7, cv_r7, cv_r7, 17;");

	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_msg_gmma(cv_r)
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 8;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 16;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 24;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 24;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 16;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 8;");

	//!word_perm(cv_l, cv_r)
	asm("mov.b32 	            tmp0, cv_l0;");
	asm("mov.b32 	            cv_l0, cv_l6;");
	asm("mov.b32 	            cv_l6, cv_r6;");
	asm("mov.b32 	            cv_r6, cv_r2;");
	asm("mov.b32 	            cv_r2, cv_l1;");
	asm("mov.b32 	            cv_l1, cv_l4;");
	asm("mov.b32 	            cv_l4, cv_r4;");
	asm("mov.b32 	            cv_r4, cv_r0;");
	asm("mov.b32 	            cv_r0, cv_l2;");
	asm("mov.b32 	            cv_l2, cv_l5;");
	asm("mov.b32 	            cv_l5, cv_r7;");
	asm("mov.b32 	            cv_r7, cv_r1;");
	asm("mov.b32 	            cv_r1, tmp0;");
	asm("mov.b32 	            tmp0, cv_l3;");
	asm("mov.b32 	            cv_l3, cv_l7;");
	asm("mov.b32 	            cv_l7, cv_r5;");
	asm("mov.b32 	            cv_r5, cv_r3;");
	asm("mov.b32 	            cv_r3, tmp0;");

	//loop (11)
	//msg_exp_even(i_state)
	asm("mov.b32 	            tmp0, e_l0;");
	asm("add.u32				e_l0, o_l0, e_l3;");
	asm("add.u32				e_l3, o_l3, e_l1;");
	asm("add.u32				e_l1, o_l1, e_l2;");
	asm("add.u32				e_l2, o_l2, tmp0;");

	asm("mov.b32 	            tmp0, e_l4;");
	asm("add.u32				e_l4, o_l4, e_l7;");
	asm("add.u32				e_l7, o_l7, e_l6;");
	asm("add.u32				e_l6, o_l6, e_l5;");
	asm("add.u32				e_l5, o_l5, tmp0;");

	asm("mov.b32 	            tmp0, e_r0;");
	asm("add.u32				e_r0, o_r0, e_r3;");
	asm("add.u32				e_r3, o_r3, e_r1;");
	asm("add.u32				e_r1, o_r1, e_r2;");
	asm("add.u32				e_r2, o_r2, tmp0;");

	asm("mov.b32 	            tmp0, e_r4;");
	asm("add.u32				e_r4, o_r4, e_r7;");
	asm("add.u32				e_r7, o_r7, e_r6;");
	asm("add.u32				e_r6, o_r6, e_r5;");
	asm("add.u32				e_r5, o_r5, tmp0;");

	//! msg_add_even(i_state)
	asm("xor.b32				cv_l0, e_l0, cv_l0;");
	asm("xor.b32				cv_l1, e_l1, cv_l1;");
	asm("xor.b32				cv_l2, e_l2, cv_l2;");
	asm("xor.b32				cv_l3, e_l3, cv_l3;");
	asm("xor.b32				cv_l4, e_l4, cv_l4;");
	asm("xor.b32				cv_l5, e_l5, cv_l5;");
	asm("xor.b32				cv_l6, e_l6, cv_l6;");
	asm("xor.b32				cv_l7, e_l7, cv_l7;");
	asm("xor.b32				cv_r0, e_r0, cv_r0;");
	asm("xor.b32				cv_r1, e_r1, cv_r1;");
	asm("xor.b32				cv_r2, e_r2, cv_r2;");
	asm("xor.b32				cv_r3, e_r3, cv_r3;");
	asm("xor.b32				cv_r4, e_r4, cv_r4;");
	asm("xor.b32				cv_r5, e_r5, cv_r5;");
	asm("xor.b32				cv_r6, e_r6, cv_r6;");
	asm("xor.b32				cv_r7, e_r7, cv_r7;");

	//!MIX(2)
	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_blk(cv_l, 29)
	asm("shf.l.wrap.b32         cv_l0, cv_l0, cv_l0, 29;");
	asm("shf.l.wrap.b32         cv_l1, cv_l1, cv_l1, 29;");
	asm("shf.l.wrap.b32         cv_l2, cv_l2, cv_l2, 29;");
	asm("shf.l.wrap.b32         cv_l3, cv_l3, cv_l3, 29;");
	asm("shf.l.wrap.b32         cv_l4, cv_l4, cv_l4, 29;");
	asm("shf.l.wrap.b32         cv_l5, cv_l5, cv_l5, 29;");
	asm("shf.l.wrap.b32         cv_l6, cv_l6, cv_l6, 29;");
	asm("shf.l.wrap.b32         cv_l7, cv_l7, cv_l7, 29;");

	//xor_with_const
	asm("xor.b32				cv_l0, cv_l0, 0x0fe19dcb;");
	asm("xor.b32				cv_l1, cv_l1, 0x68f4f669;");
	asm("xor.b32				cv_l2, cv_l2, 0x6e37c8ff;");
	asm("xor.b32				cv_l3, cv_l3, 0xa0fe6e10;");
	asm("xor.b32				cv_l4, cv_l4, 0xb44b47b0;");
	asm("xor.b32				cv_l5, cv_l5, 0xf5c0558a;");
	asm("xor.b32				cv_l6, cv_l6, 0x79bf14cf;");
	asm("xor.b32				cv_l7, cv_l7, 0x4a431a20;");

	//add_blk(cv_r, cv_l)
	asm("add.u32				cv_r0, cv_l0, cv_r0;");
	asm("add.u32				cv_r1, cv_l1, cv_r1;");
	asm("add.u32				cv_r2, cv_l2, cv_r2;");
	asm("add.u32				cv_r3, cv_l3, cv_r3;");
	asm("add.u32				cv_r4, cv_l4, cv_r4;");
	asm("add.u32				cv_r5, cv_l5, cv_r5;");
	asm("add.u32				cv_r6, cv_l6, cv_r6;");
	asm("add.u32				cv_r7, cv_l7, cv_r7;");

	//rotate_blk(cv_r, 1)
	asm("shf.l.wrap.b32         cv_r0, cv_r0, cv_r0, 1;");
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 1;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 1;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 1;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 1;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 1;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 1;");
	asm("shf.l.wrap.b32         cv_r7, cv_r7, cv_r7, 1;");

	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_msg_gmma(cv_r)
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 8;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 16;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 24;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 24;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 16;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 8;");

	//!word_perm(cv_l, cv_r)
	asm("mov.b32 	            tmp0, cv_l0;");
	asm("mov.b32 	            cv_l0, cv_l6;");
	asm("mov.b32 	            cv_l6, cv_r6;");
	asm("mov.b32 	            cv_r6, cv_r2;");
	asm("mov.b32 	            cv_r2, cv_l1;");
	asm("mov.b32 	            cv_l1, cv_l4;");
	asm("mov.b32 	            cv_l4, cv_r4;");
	asm("mov.b32 	            cv_r4, cv_r0;");
	asm("mov.b32 	            cv_r0, cv_l2;");
	asm("mov.b32 	            cv_l2, cv_l5;");
	asm("mov.b32 	            cv_l5, cv_r7;");
	asm("mov.b32 	            cv_r7, cv_r1;");
	asm("mov.b32 	            cv_r1, tmp0;");
	asm("mov.b32 	            tmp0, cv_l3;");
	asm("mov.b32 	            cv_l3, cv_l7;");
	asm("mov.b32 	            cv_l7, cv_r5;");
	asm("mov.b32 	            cv_r5, cv_r3;");
	asm("mov.b32 	            cv_r3, tmp0;");

	//!msg_exp_odd(i_state)
	asm("mov.b32 	            tmp0, o_l0;");
	asm("add.u32				o_l0, e_l0, o_l3;");
	asm("add.u32				o_l3, e_l3, o_l1;");
	asm("add.u32				o_l1, e_l1, o_l2;");
	asm("add.u32				o_l2, e_l2, tmp0;");

	asm("mov.b32 	            tmp0, o_l4;");
	asm("add.u32				o_l4, e_l4, o_l7;");
	asm("add.u32				o_l7, e_l7, o_l6;");
	asm("add.u32				o_l6, e_l6, o_l5;");
	asm("add.u32				o_l5, e_l5, tmp0;");

	asm("mov.b32 	            tmp0, o_r0;");
	asm("add.u32				o_r0, e_r0, o_r3;");
	asm("add.u32				o_r3, e_r3, o_r1;");
	asm("add.u32				o_r1, e_r1, o_r2;");
	asm("add.u32				o_r2, e_r2, tmp0;");

	asm("mov.b32 	            tmp0, o_r4;");
	asm("add.u32				o_r4, e_r4, o_r7;");
	asm("add.u32				o_r7, e_r7, o_r6;");
	asm("add.u32				o_r6, e_r6, o_r5;");
	asm("add.u32				o_r5, e_r5, tmp0;");

	//!msg_add_odd(cv_l, cv_r, i_state)
	//cv_l part
	asm("xor.b32				cv_l0, o_l0, cv_l0;");
	asm("xor.b32				cv_l1, o_l1, cv_l1;");
	asm("xor.b32				cv_l2, o_l2, cv_l2;");
	asm("xor.b32				cv_l3, o_l3, cv_l3;");
	asm("xor.b32				cv_l4, o_l4, cv_l4;");
	asm("xor.b32				cv_l5, o_l5, cv_l5;");
	asm("xor.b32				cv_l6, o_l6, cv_l6;");
	asm("xor.b32				cv_l7, o_l7, cv_l7;");
	//cv_r part
	asm("xor.b32				cv_r0, o_r0, cv_r0;");
	asm("xor.b32				cv_r1, o_r1, cv_r1;");
	asm("xor.b32				cv_r2, o_r2, cv_r2;");
	asm("xor.b32				cv_r3, o_r3, cv_r3;");
	asm("xor.b32				cv_r4, o_r4, cv_r4;");
	asm("xor.b32				cv_r5, o_r5, cv_r5;");
	asm("xor.b32				cv_r6, o_r6, cv_r6;");
	asm("xor.b32				cv_r7, o_r7, cv_r7;");

	//!MIX(4)
	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_blk(cv_l, 5)
	asm("shf.l.wrap.b32         cv_l0, cv_l0, cv_l0, 5;");
	asm("shf.l.wrap.b32         cv_l1, cv_l1, cv_l1, 5;");
	asm("shf.l.wrap.b32         cv_l2, cv_l2, cv_l2, 5;");
	asm("shf.l.wrap.b32         cv_l3, cv_l3, cv_l3, 5;");
	asm("shf.l.wrap.b32         cv_l4, cv_l4, cv_l4, 5;");
	asm("shf.l.wrap.b32         cv_l5, cv_l5, cv_l5, 5;");
	asm("shf.l.wrap.b32         cv_l6, cv_l6, cv_l6, 5;");
	asm("shf.l.wrap.b32         cv_l7, cv_l7, cv_l7, 5;");

	//xor_with_const(cv_l, const_v)
	asm("xor.b32				cv_l0, cv_l0, 0xf17f68da;");
	asm("xor.b32				cv_l1, cv_l1, 0x5deb5fd1;");
	asm("xor.b32				cv_l2, cv_l2, 0xa600c86d;");
	asm("xor.b32				cv_l3, cv_l3, 0x9f6c7eb0;");
	asm("xor.b32				cv_l4, cv_l4, 0xff92f864;");
	asm("xor.b32				cv_l5, cv_l5, 0xb615e07f;");
	asm("xor.b32				cv_l6, cv_l6, 0x38d3e448;");
	asm("xor.b32				cv_l7, cv_l7, 0x8d5d3a6a;");

	//add_blk(cv_r, cv_l)
	asm("add.u32				cv_r0, cv_l0, cv_r0;");
	asm("add.u32				cv_r1, cv_l1, cv_r1;");
	asm("add.u32				cv_r2, cv_l2, cv_r2;");
	asm("add.u32				cv_r3, cv_l3, cv_r3;");
	asm("add.u32				cv_r4, cv_l4, cv_r4;");
	asm("add.u32				cv_r5, cv_l5, cv_r5;");
	asm("add.u32				cv_r6, cv_l6, cv_r6;");
	asm("add.u32				cv_r7, cv_l7, cv_r7;");

	//rotate_blk(cv_r, 17)
	asm("shf.l.wrap.b32         cv_r0, cv_r0, cv_r0, 17;");
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 17;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 17;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 17;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 17;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 17;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 17;");
	asm("shf.l.wrap.b32         cv_r7, cv_r7, cv_r7, 17;");

	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_msg_gmma(cv_r)
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 8;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 16;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 24;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 24;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 16;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 8;");

	//!word_perm(cv_l, cv_r)
	asm("mov.b32 	            tmp0, cv_l0;");
	asm("mov.b32 	            cv_l0, cv_l6;");
	asm("mov.b32 	            cv_l6, cv_r6;");
	asm("mov.b32 	            cv_r6, cv_r2;");
	asm("mov.b32 	            cv_r2, cv_l1;");
	asm("mov.b32 	            cv_l1, cv_l4;");
	asm("mov.b32 	            cv_l4, cv_r4;");
	asm("mov.b32 	            cv_r4, cv_r0;");
	asm("mov.b32 	            cv_r0, cv_l2;");
	asm("mov.b32 	            cv_l2, cv_l5;");
	asm("mov.b32 	            cv_l5, cv_r7;");
	asm("mov.b32 	            cv_r7, cv_r1;");
	asm("mov.b32 	            cv_r1, tmp0;");
	asm("mov.b32 	            tmp0, cv_l3;");
	asm("mov.b32 	            cv_l3, cv_l7;");
	asm("mov.b32 	            cv_l7, cv_r5;");
	asm("mov.b32 	            cv_r5, cv_r3;");
	asm("mov.b32 	            cv_r3, tmp0;");

	//loop (12)
	//msg_exp_even(i_state)
	asm("mov.b32 	            tmp0, e_l0;");
	asm("add.u32				e_l0, o_l0, e_l3;");
	asm("add.u32				e_l3, o_l3, e_l1;");
	asm("add.u32				e_l1, o_l1, e_l2;");
	asm("add.u32				e_l2, o_l2, tmp0;");

	asm("mov.b32 	            tmp0, e_l4;");
	asm("add.u32				e_l4, o_l4, e_l7;");
	asm("add.u32				e_l7, o_l7, e_l6;");
	asm("add.u32				e_l6, o_l6, e_l5;");
	asm("add.u32				e_l5, o_l5, tmp0;");

	asm("mov.b32 	            tmp0, e_r0;");
	asm("add.u32				e_r0, o_r0, e_r3;");
	asm("add.u32				e_r3, o_r3, e_r1;");
	asm("add.u32				e_r1, o_r1, e_r2;");
	asm("add.u32				e_r2, o_r2, tmp0;");

	asm("mov.b32 	            tmp0, e_r4;");
	asm("add.u32				e_r4, o_r4, e_r7;");
	asm("add.u32				e_r7, o_r7, e_r6;");
	asm("add.u32				e_r6, o_r6, e_r5;");
	asm("add.u32				e_r5, o_r5, tmp0;");

	//! msg_add_even(i_state)
	asm("xor.b32				cv_l0, e_l0, cv_l0;");
	asm("xor.b32				cv_l1, e_l1, cv_l1;");
	asm("xor.b32				cv_l2, e_l2, cv_l2;");
	asm("xor.b32				cv_l3, e_l3, cv_l3;");
	asm("xor.b32				cv_l4, e_l4, cv_l4;");
	asm("xor.b32				cv_l5, e_l5, cv_l5;");
	asm("xor.b32				cv_l6, e_l6, cv_l6;");
	asm("xor.b32				cv_l7, e_l7, cv_l7;");
	asm("xor.b32				cv_r0, e_r0, cv_r0;");
	asm("xor.b32				cv_r1, e_r1, cv_r1;");
	asm("xor.b32				cv_r2, e_r2, cv_r2;");
	asm("xor.b32				cv_r3, e_r3, cv_r3;");
	asm("xor.b32				cv_r4, e_r4, cv_r4;");
	asm("xor.b32				cv_r5, e_r5, cv_r5;");
	asm("xor.b32				cv_r6, e_r6, cv_r6;");
	asm("xor.b32				cv_r7, e_r7, cv_r7;");

	//!MIX(2)
	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_blk(cv_l, 29)
	asm("shf.l.wrap.b32         cv_l0, cv_l0, cv_l0, 29;");
	asm("shf.l.wrap.b32         cv_l1, cv_l1, cv_l1, 29;");
	asm("shf.l.wrap.b32         cv_l2, cv_l2, cv_l2, 29;");
	asm("shf.l.wrap.b32         cv_l3, cv_l3, cv_l3, 29;");
	asm("shf.l.wrap.b32         cv_l4, cv_l4, cv_l4, 29;");
	asm("shf.l.wrap.b32         cv_l5, cv_l5, cv_l5, 29;");
	asm("shf.l.wrap.b32         cv_l6, cv_l6, cv_l6, 29;");
	asm("shf.l.wrap.b32         cv_l7, cv_l7, cv_l7, 29;");

	//xor_with_const
	asm("xor.b32				cv_l0, cv_l0, 0x70e843cb;");
	asm("xor.b32				cv_l1, cv_l1, 0x494b312e;");
	asm("xor.b32				cv_l2, cv_l2, 0xa6c93613;");
	asm("xor.b32				cv_l3, cv_l3, 0x0beb2f4f;");
	asm("xor.b32				cv_l4, cv_l4, 0x928b5d63;");
	asm("xor.b32				cv_l5, cv_l5, 0xcbf66035;");
	asm("xor.b32				cv_l6, cv_l6, 0x0cb82c80;");
	asm("xor.b32				cv_l7, cv_l7, 0xea97a4f7;");

	//add_blk(cv_r, cv_l)
	asm("add.u32				cv_r0, cv_l0, cv_r0;");
	asm("add.u32				cv_r1, cv_l1, cv_r1;");
	asm("add.u32				cv_r2, cv_l2, cv_r2;");
	asm("add.u32				cv_r3, cv_l3, cv_r3;");
	asm("add.u32				cv_r4, cv_l4, cv_r4;");
	asm("add.u32				cv_r5, cv_l5, cv_r5;");
	asm("add.u32				cv_r6, cv_l6, cv_r6;");
	asm("add.u32				cv_r7, cv_l7, cv_r7;");

	//rotate_blk(cv_r, 1)
	asm("shf.l.wrap.b32         cv_r0, cv_r0, cv_r0, 1;");
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 1;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 1;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 1;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 1;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 1;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 1;");
	asm("shf.l.wrap.b32         cv_r7, cv_r7, cv_r7, 1;");

	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_msg_gmma(cv_r)
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 8;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 16;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 24;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 24;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 16;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 8;");

	//!word_perm(cv_l, cv_r)
	asm("mov.b32 	            tmp0, cv_l0;");
	asm("mov.b32 	            cv_l0, cv_l6;");
	asm("mov.b32 	            cv_l6, cv_r6;");
	asm("mov.b32 	            cv_r6, cv_r2;");
	asm("mov.b32 	            cv_r2, cv_l1;");
	asm("mov.b32 	            cv_l1, cv_l4;");
	asm("mov.b32 	            cv_l4, cv_r4;");
	asm("mov.b32 	            cv_r4, cv_r0;");
	asm("mov.b32 	            cv_r0, cv_l2;");
	asm("mov.b32 	            cv_l2, cv_l5;");
	asm("mov.b32 	            cv_l5, cv_r7;");
	asm("mov.b32 	            cv_r7, cv_r1;");
	asm("mov.b32 	            cv_r1, tmp0;");
	asm("mov.b32 	            tmp0, cv_l3;");
	asm("mov.b32 	            cv_l3, cv_l7;");
	asm("mov.b32 	            cv_l7, cv_r5;");
	asm("mov.b32 	            cv_r5, cv_r3;");
	asm("mov.b32 	            cv_r3, tmp0;");

	//!msg_exp_odd(i_state)
	asm("mov.b32 	            tmp0, o_l0;");
	asm("add.u32				o_l0, e_l0, o_l3;");
	asm("add.u32				o_l3, e_l3, o_l1;");
	asm("add.u32				o_l1, e_l1, o_l2;");
	asm("add.u32				o_l2, e_l2, tmp0;");

	asm("mov.b32 	            tmp0, o_l4;");
	asm("add.u32				o_l4, e_l4, o_l7;");
	asm("add.u32				o_l7, e_l7, o_l6;");
	asm("add.u32				o_l6, e_l6, o_l5;");
	asm("add.u32				o_l5, e_l5, tmp0;");

	asm("mov.b32 	            tmp0, o_r0;");
	asm("add.u32				o_r0, e_r0, o_r3;");
	asm("add.u32				o_r3, e_r3, o_r1;");
	asm("add.u32				o_r1, e_r1, o_r2;");
	asm("add.u32				o_r2, e_r2, tmp0;");

	asm("mov.b32 	            tmp0, o_r4;");
	asm("add.u32				o_r4, e_r4, o_r7;");
	asm("add.u32				o_r7, e_r7, o_r6;");
	asm("add.u32				o_r6, e_r6, o_r5;");
	asm("add.u32				o_r5, e_r5, tmp0;");

	//!msg_add_odd(cv_l, cv_r, i_state)
	//cv_l part
	asm("xor.b32				cv_l0, o_l0, cv_l0;");
	asm("xor.b32				cv_l1, o_l1, cv_l1;");
	asm("xor.b32				cv_l2, o_l2, cv_l2;");
	asm("xor.b32				cv_l3, o_l3, cv_l3;");
	asm("xor.b32				cv_l4, o_l4, cv_l4;");
	asm("xor.b32				cv_l5, o_l5, cv_l5;");
	asm("xor.b32				cv_l6, o_l6, cv_l6;");
	asm("xor.b32				cv_l7, o_l7, cv_l7;");
	//cv_r part
	asm("xor.b32				cv_r0, o_r0, cv_r0;");
	asm("xor.b32				cv_r1, o_r1, cv_r1;");
	asm("xor.b32				cv_r2, o_r2, cv_r2;");
	asm("xor.b32				cv_r3, o_r3, cv_r3;");
	asm("xor.b32				cv_r4, o_r4, cv_r4;");
	asm("xor.b32				cv_r5, o_r5, cv_r5;");
	asm("xor.b32				cv_r6, o_r6, cv_r6;");
	asm("xor.b32				cv_r7, o_r7, cv_r7;");

	//!MIX(4)
	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_blk(cv_l, 5)
	asm("shf.l.wrap.b32         cv_l0, cv_l0, cv_l0, 5;");
	asm("shf.l.wrap.b32         cv_l1, cv_l1, cv_l1, 5;");
	asm("shf.l.wrap.b32         cv_l2, cv_l2, cv_l2, 5;");
	asm("shf.l.wrap.b32         cv_l3, cv_l3, cv_l3, 5;");
	asm("shf.l.wrap.b32         cv_l4, cv_l4, cv_l4, 5;");
	asm("shf.l.wrap.b32         cv_l5, cv_l5, cv_l5, 5;");
	asm("shf.l.wrap.b32         cv_l6, cv_l6, cv_l6, 5;");
	asm("shf.l.wrap.b32         cv_l7, cv_l7, cv_l7, 5;");

	//xor_with_const(cv_l, const_v)
	asm("xor.b32				cv_l0, cv_l0, 0x592c0f3b;");
	asm("xor.b32				cv_l1, cv_l1, 0x947c5f77;");
	asm("xor.b32				cv_l2, cv_l2, 0x6fff49b9;");
	asm("xor.b32				cv_l3, cv_l3, 0xf71a7e5a;");
	asm("xor.b32				cv_l4, cv_l4, 0x1de8c0f5;");
	asm("xor.b32				cv_l5, cv_l5, 0xc2569600;");
	asm("xor.b32				cv_l6, cv_l6, 0xc4e4ac8c;");
	asm("xor.b32				cv_l7, cv_l7, 0x823c9ce1;");

	//add_blk(cv_r, cv_l)
	asm("add.u32				cv_r0, cv_l0, cv_r0;");
	asm("add.u32				cv_r1, cv_l1, cv_r1;");
	asm("add.u32				cv_r2, cv_l2, cv_r2;");
	asm("add.u32				cv_r3, cv_l3, cv_r3;");
	asm("add.u32				cv_r4, cv_l4, cv_r4;");
	asm("add.u32				cv_r5, cv_l5, cv_r5;");
	asm("add.u32				cv_r6, cv_l6, cv_r6;");
	asm("add.u32				cv_r7, cv_l7, cv_r7;");

	//rotate_blk(cv_r, 17)
	asm("shf.l.wrap.b32         cv_r0, cv_r0, cv_r0, 17;");
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 17;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 17;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 17;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 17;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 17;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 17;");
	asm("shf.l.wrap.b32         cv_r7, cv_r7, cv_r7, 17;");

	//add_blk(cv_l, cv_r)
	asm("add.u32				cv_l0, cv_l0, cv_r0;");
	asm("add.u32				cv_l1, cv_l1, cv_r1;");
	asm("add.u32				cv_l2, cv_l2, cv_r2;");
	asm("add.u32				cv_l3, cv_l3, cv_r3;");
	asm("add.u32				cv_l4, cv_l4, cv_r4;");
	asm("add.u32				cv_l5, cv_l5, cv_r5;");
	asm("add.u32				cv_l6, cv_l6, cv_r6;");
	asm("add.u32				cv_l7, cv_l7, cv_r7;");

	//rotate_msg_gmma(cv_r)
	asm("shf.l.wrap.b32         cv_r1, cv_r1, cv_r1, 8;");
	asm("shf.l.wrap.b32         cv_r2, cv_r2, cv_r2, 16;");
	asm("shf.l.wrap.b32         cv_r3, cv_r3, cv_r3, 24;");
	asm("shf.l.wrap.b32         cv_r4, cv_r4, cv_r4, 24;");
	asm("shf.l.wrap.b32         cv_r5, cv_r5, cv_r5, 16;");
	asm("shf.l.wrap.b32         cv_r6, cv_r6, cv_r6, 8;");

	//!word_perm(cv_l, cv_r)
	asm("mov.b32 	            tmp0, cv_l0;");
	asm("mov.b32 	            cv_l0, cv_l6;");
	asm("mov.b32 	            cv_l6, cv_r6;");
	asm("mov.b32 	            cv_r6, cv_r2;");
	asm("mov.b32 	            cv_r2, cv_l1;");
	asm("mov.b32 	            cv_l1, cv_l4;");
	asm("mov.b32 	            cv_l4, cv_r4;");
	asm("mov.b32 	            cv_r4, cv_r0;");
	asm("mov.b32 	            cv_r0, cv_l2;");
	asm("mov.b32 	            cv_l2, cv_l5;");
	asm("mov.b32 	            cv_l5, cv_r7;");
	asm("mov.b32 	            cv_r7, cv_r1;");
	asm("mov.b32 	            cv_r1, tmp0;");
	asm("mov.b32 	            tmp0, cv_l3;");
	asm("mov.b32 	            cv_l3, cv_l7;");
	asm("mov.b32 	            cv_l7, cv_r5;");
	asm("mov.b32 	            cv_r5, cv_r3;");
	asm("mov.b32 	            cv_r3, tmp0;");
	//loop end

	//msg_exp_even(i_state)
	asm("mov.b32 	            tmp0, e_l0;");
	asm("add.u32				e_l0, o_l0, e_l3;");
	asm("add.u32				e_l3, o_l3, e_l1;");
	asm("add.u32				e_l1, o_l1, e_l2;");
	asm("add.u32				e_l2, o_l2, tmp0;");

	asm("mov.b32 	            tmp0, e_l4;");
	asm("add.u32				e_l4, o_l4, e_l7;");
	asm("add.u32				e_l7, o_l7, e_l6;");
	asm("add.u32				e_l6, o_l6, e_l5;");
	asm("add.u32				e_l5, o_l5, tmp0;");

	asm("mov.b32 	            tmp0, e_r0;");
	asm("add.u32				e_r0, o_r0, e_r3;");
	asm("add.u32				e_r3, o_r3, e_r1;");
	asm("add.u32				e_r1, o_r1, e_r2;");
	asm("add.u32				e_r2, o_r2, tmp0;");

	asm("mov.b32 	            tmp0, e_r4;");
	asm("add.u32				e_r4, o_r4, e_r7;");
	asm("add.u32				e_r7, o_r7, e_r6;");
	asm("add.u32				e_r6, o_r6, e_r5;");
	asm("add.u32				e_r5, o_r5, tmp0;");

	//msg_add_even(cv_l, cv_r, i_state)
	asm("xor.b32				cv_l0, e_l0, cv_l0;");
	asm("xor.b32				cv_l1, e_l1, cv_l1;");
	asm("xor.b32				cv_l2, e_l2, cv_l2;");
	asm("xor.b32				cv_l3, e_l3, cv_l3;");
	asm("xor.b32				cv_l4, e_l4, cv_l4;");
	asm("xor.b32				cv_l5, e_l5, cv_l5;");
	asm("xor.b32				cv_l6, e_l6, cv_l6;");
	asm("xor.b32				cv_l7, e_l7, cv_l7;");
	asm("xor.b32				cv_r0, e_r0, cv_r0;");
	asm("xor.b32				cv_r1, e_r1, cv_r1;");
	asm("xor.b32				cv_r2, e_r2, cv_r2;");
	asm("xor.b32				cv_r3, e_r3, cv_r3;");
	asm("xor.b32				cv_r4, e_r4, cv_r4;");
	asm("xor.b32				cv_r5, e_r5, cv_r5;");
	asm("xor.b32				cv_r6, e_r6, cv_r6;");
	asm("xor.b32				cv_r7, e_r7, cv_r7;");

	//data push
	asm("mov.b32 	            %0,  cv_l0;": "+r"(hash[0]));
	asm("mov.b32 	            %0,  cv_l1;": "+r"(hash[1]));
	asm("mov.b32 	            %0,  cv_l2;": "+r"(hash[2]));
	asm("mov.b32 	            %0,  cv_l3;": "+r"(hash[3]));
	asm("mov.b32 	            %0,  cv_l4;": "+r"(hash[4]));
	asm("mov.b32 	            %0,  cv_l5;": "+r"(hash[5]));
	asm("mov.b32 	            %0,  cv_l6;": "+r"(hash[6]));
	asm("mov.b32 	            %0,  cv_l7;": "+r"(hash[7]));

	asm("mov.b32 	            %0,  cv_r0;": "+r"(hash[8]));
	asm("mov.b32 	            %0,  cv_r1;": "+r"(hash[9]));
	asm("mov.b32 	            %0,  cv_r2;": "+r"(hash[10]));
	asm("mov.b32 	            %0,  cv_r3;": "+r"(hash[11]));
	asm("mov.b32 	            %0,  cv_r4;": "+r"(hash[12]));
	asm("mov.b32 	            %0,  cv_r5;": "+r"(hash[13]));
	asm("mov.b32 	            %0,  cv_r6;": "+r"(hash[14]));
	asm("mov.b32 	            %0,  cv_r7;": "+r"(hash[15]));

}
__device__ void lsh256_final_core(uint32_t* hash_val) {
	asm("xor.b32				%0, %1, %2;": "+r"(hash_val[0]) : "r"(hash_val[0]), "r"(hash_val[8]));
	asm("xor.b32				%0, %1, %2;": "+r"(hash_val[1]) : "r"(hash_val[1]), "r"(hash_val[9]));
	asm("xor.b32				%0, %1, %2;": "+r"(hash_val[2]) : "r"(hash_val[2]), "r"(hash_val[10]));
	asm("xor.b32				%0, %1, %2;": "+r"(hash_val[3]) : "r"(hash_val[3]), "r"(hash_val[11]));
	asm("xor.b32				%0, %1, %2;": "+r"(hash_val[4]) : "r"(hash_val[4]), "r"(hash_val[12]));
	asm("xor.b32				%0, %1, %2;": "+r"(hash_val[5]) : "r"(hash_val[5]), "r"(hash_val[13]));
	asm("xor.b32				%0, %1, %2;": "+r"(hash_val[6]) : "r"(hash_val[6]), "r"(hash_val[14]));
	asm("xor.b32				%0, %1, %2;": "+r"(hash_val[7]) : "r"(hash_val[7]), "r"(hash_val[15]));
}
__device__ void lsh256_init(LSH256_info* info) {
	for (int i = 0; i < LSH_BLOCK_BYTE_LEN; i++)
		info->sv_pt[i] = 0;
	info->remain_byte_len = 0;

	info->hash_val[0] = 0x46a10f1f;
	info->hash_val[1] = 0xfddce486;
	info->hash_val[2] = 0xb41443a8;
	info->hash_val[3] = 0x198e6b9d;
	info->hash_val[4] = 0x3304388d;
	info->hash_val[5] = 0xb0f5a3c7;
	info->hash_val[6] = 0xb36061c4;
	info->hash_val[7] = 0x7adbd553;

	info->hash_val[8] = 0x105d5378;
	info->hash_val[9] = 0x2f74de54;
	info->hash_val[10] = 0x5c2f2d95;
	info->hash_val[11] = 0xf2553fbe;
	info->hash_val[12] = 0x8051357a;
	info->hash_val[13] = 0x138668c8;
	info->hash_val[14] = 0x47aa4484;
	info->hash_val[15] = 0xe01afb41;
}
__device__ void lsh256_update(LSH256_info* info, uint8_t* pt, uint32_t ptbytelen) {
	uint32_t i, t = 0;
	uint32_t pt_len = ptbytelen;
	uint32_t pt_remain_len = info->remain_byte_len;

	if (pt_len + pt_remain_len < LSH_BLOCK_BYTE_LEN) {
		memcpy(info->sv_pt, pt, pt_len);
		info->remain_byte_len += ptbytelen;
		return;
	}
	while (pt_len + pt_remain_len <= LSH_BLOCK_BYTE_LEN) {
		memcpy(info->sv_pt, pt, LSH_BLOCK_BYTE_LEN);
		lsh256_core((uint32_t*)pt, info->hash_val);
		pt += LSH_BLOCK_BYTE_LEN;
		pt_len -= (LSH_BLOCK_BYTE_LEN - pt_remain_len);
		pt_remain_len = 0;
	}
	memcpy(info->sv_pt, pt, pt_len);
	info->remain_byte_len = pt_len;
}
__device__ void lsh256_final(LSH256_info* info, uint8_t* sv_hashval) {
	uint32_t pt_remain_len = info->remain_byte_len;
	info->sv_pt[pt_remain_len] = 0x80;
	memset(info->sv_pt + pt_remain_len + 1, 0, LSH_BLOCK_BYTE_LEN - pt_remain_len - 1);
	lsh256_core((uint32_t*)info->sv_pt, info->hash_val);
	lsh256_final_core(info->hash_val);
	memcpy(sv_hashval, info->hash_val, LSH_HASH_BYTE_LEN);
}

__global__ void cuda_lsh256(uint8_t* pt, uint32_t* ptlen, uint8_t* hash) {

	LSH256_info info;
	lsh256_init(&info);
	lsh256_update(&info, pt, ptlen[0]);
	lsh256_final(&info, hash);
}

//void main() {
//
//	cuda_lsh256 << <1, 1 >> > ();
//	return;
//}
