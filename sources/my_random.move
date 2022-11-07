// SPDX-License-Identifier: Apache-2.0
// Based on: https://github.com/starcoinorg/starcoin-framework-commons/blob/main/sources/PseudoRandom.move

/// @title pseudorandom
/// @notice A pseudo random module on-chain.
/// @dev Warning: 
/// The random mechanism in smart contracts is different from 
/// that in traditional programming languages. The value generated 
/// by random is predictable to Miners, so it can only be used in 
/// simple scenarios where Miners have no incentive to cheat. If 
/// large amounts of money are involved, DO NOT USE THIS MODULE to 
/// generate random numbers; try a more secure way.
module ctf_wcw::randomx {
    use std::hash;
    use std::vector;
    use sui::bcs;
    use sui::tx_context::TxContext;
    
    const ERR_HIGH_ARG_GREATER_THAN_LOW_ARG: u64 = 101;

    fun new_object_uid(next_object_id: u64): vector<u8> {
        let id_bytes = bcs::to_bytes(&next_object_id);
        let xhash: vector<u8> = hash::sha3_256(id_bytes);

        let out: vector<u8> = vector::empty<u8>();
        let i = 0u64;
        while (i < 20) {
          vector::push_back<u8>(&mut out, *vector::borrow(&xhash, i));
          i = i + 1;
        };

        out
    }

    fun seed(next_object_id: u64, ctx: &mut TxContext): vector<u8> {
        let ctx_bytes = bcs::to_bytes(ctx);
        let uid_bytes: vector<u8> = new_object_uid(next_object_id);
        let info: vector<u8> = vector::empty<u8>();
        vector::append<u8>(&mut info, ctx_bytes);
        vector::append<u8>(&mut info, uid_bytes);

        let hash: vector<u8> = hash::sha3_256(info);
        hash
    }

    fun bytes_to_u64(bytes: vector<u8>): u64 {
        let value = 0u64;
        let i = 0u64;
        while (i < 8) {
            value = value | ((*vector::borrow(&bytes, i) as u64) << ((8 * (7 - i)) as u8));
            i = i + 1;
        };
        return value
    }

    /// Generate a random u64
    fun rand_u64_with_seed(_seed: vector<u8>): u64 {
        bytes_to_u64(_seed)
    }

    /// Generate a random integer range in [low, high).
    fun rand_u64_range_with_seed(_seed: vector<u8>, low: u64, high: u64): u64 {
        assert!(high > low, ERR_HIGH_ARG_GREATER_THAN_LOW_ARG);
        let value = rand_u64_with_seed(_seed);
        (value % (high - low)) + low
    }

    /// Generate a random u64
    public fun rand_u64(next_object_id: u64, ctx: &mut TxContext): u64 {
        rand_u64_with_seed(seed(next_object_id, ctx))
    }

    /// Generate a random integer range in [low, high).
    public fun rand_u64_range(next_object_id: u64, low: u64, high: u64, ctx: &mut TxContext): u64 {
        rand_u64_range_with_seed(seed(next_object_id, ctx), low, high)
    }
}
