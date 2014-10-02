package src {
    import flash.net.registerClassAlias;
    public class Save_Helper {
        public function Save_Helper() {
            flash.net.registerClassAlias("src.Save_Helper", Save_Helper);
        }
        public var poke_player:Array;
        public var poke_enemy:Array;
        public var trainer_curr_pokemon:Base_Pokemon_Loader;
        public var pokemon_in_bank:Array;
        public var inventory_items:Array;
        public var store_items:Array;
        public var final_boss:Base_Pokemon_Loader;
        public var breeding_pokemon:Array;
    }
}