module ctf_wcw::test_ctf { 
    use ctf::hero::{Self, Hero};
    use ctf::adventure::{slay_boar, slay_boar_king};
    use ctf::inventory::{Self, TreasuryBox};
    use sui::tx_context::TxContext;

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

    public entry fun try_get_treasury_box(hero: &mut Hero, ctx: &mut TxContext) {
        to_level2(hero, ctx);
        kill_king(hero, ctx);
    }

    public entry fun get_flag(box: TreasuryBox, ctx: &mut TxContext) {
        inventory::get_flag(box, ctx);
    }
}