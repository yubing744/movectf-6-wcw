module ctf_wcw::test_ctf { 
    use ctf::random;
    use ctf::hero::{Self, Hero};
    use ctf::adventure::{slay_boar, slay_boar_king};
    use sui::tx_context::TxContext;
    use ctf_wcw::randomx;

    fun to_level2(hero: &mut Hero, ctx: &mut TxContext) {
        while (hero::experience(hero) < 100) {
            slay_boar(hero, ctx);
        };

        hero::level_up(hero);
    }

    fun kill_king(hero: &mut Hero, ctx: &mut TxContext) {
        while (hero::stamina(hero) > 2) {
            slay_boar_king(hero, ctx);
        }
    }

    public entry fun find_box(hero: &mut Hero, ctx: &mut TxContext) {
        to_level2(hero, ctx);
        kill_king(hero, ctx);
    }

    /// test random
    public fun rand_u64_range(low: u64, high: u64, ctx: &mut TxContext): u64 {
        random::rand_u64_range(low, high, ctx)
    }

    public fun rand_to(target: u64, ctx: &mut TxContext) {
        let count = 0u64;
        let rand = rand_u64_range(0, 100, ctx);

        while (rand != target) {
            rand = rand_u64_range(0, 100, ctx);
            count = count + 1;
        };

        while (count > 0) {
            rand_u64_range(0, 100, ctx);
            count = count - 1;
        };
    }

    #[test]
    public fun test_rand_to() {
         use sui::test_scenario;

         // create test address representing game admin
         let admin = @0xBABE;

         // first transaction to emulate module initialization
         let scenario_val = test_scenario::begin(admin);
         let scenario = &mut scenario_val;

         let rand1 = randomx::rand_u64_range(0, 0, 100, test_scenario::ctx(scenario));
         let rand2 = rand_u64_range(0, 100, test_scenario::ctx(scenario));
         assert!(rand1 == rand2, 1);

        test_scenario::end(scenario_val);
    }
}