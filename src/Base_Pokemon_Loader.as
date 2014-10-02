package src {
    public class Base_Pokemon_Loader {
        public var Species:int; // not a const b/c of evolution
		public var   Type_1:int,
                      Type_2:int;
        public var Gender:Boolean;
        
        public var level:int;
        public var experience:Number,
                    experience_to_level:Number;
        public var is_player:Boolean;
        // mod (battle) stats
        public var m_attack:int,
                    m_defense:int,
                    m_spec_att:int,
                    m_spec_def:int,
                    m_speed:int;
        // base stats
        public var attack:int,
                    defense:int,
                    spec_att:int,
                    spec_def:int,
                    speed:int,
                    max_health:int,
                    curr_health:int;
        public var hex:Boolean;
        public var iv_health:int,
                    iv_attack:int,
                    iv_defense:int,
                    iv_spec_att:int,
                    iv_spec_def:int,
                    iv_speed:int;
        public var ev_health:int,
                    ev_attack:int,
                    ev_defense:int,
                    ev_spec_att:int,
                    ev_spec_def:int,
                    ev_speed:int;
        public var amt_ev_tot:int;
        public var base_health:int,
                    base_attack:int,
                    base_defense:int,
                    base_spec_att:int,
                    base_spec_def:int,
                    base_speed:int;
        public var name:String;
        
        public var stage:int;
        
        public var move_set:Array; // array of Moves
        
        public var item_cool_down:int;
        
        public var paralysis:int = 0;
        
        public var binded_turns:Array = [ 0, 0, 0, 0, 0 ];
        public var binded_damage:Array = [ 0, 0, 0, 0, 0 ];
        public var binded_effect:Array = [ 0, 0, 0, 0, 0 ];
        
        public var last_move:int;
        
        public var evade:int;
        public var accuracy:int;
        public static const Item_Cool_Down_Max:int = 60*20;
        
        public var Dead:Boolean,
                    Dead_Timer:int;
        public function Base_Pokemon_Loader() {
            
        }
        public function New():Base_Pokemon {
            var x:Base_Pokemon = new Base_Pokemon(0, 0);
            x.Import_Information(Species, 
                                Type_1, 
                                Type_2, 
                                Gender, 
                                        
                                level, 
                                experience, 
                                experience_to_level, 
                                is_player, 
                                        // mod (battle) stats
                                m_attack, 
                                m_defense, 
                                m_spec_att, 
                                m_spec_def, 
                                m_speed, 
                                        // base stats
                                attack, 
                                defense, 
                                spec_att, 
                                spec_def, 
                                speed, 
                                max_health, 
                                curr_health, 
                                hex, 
                                iv_health, 
                                iv_attack, 
                                iv_defense, 
                                iv_spec_att, 
                                iv_spec_def, 
                                iv_speed, 
                                ev_health, 
                                ev_attack, 
                                ev_defense, 
                                ev_spec_att, 
                                ev_spec_def, 
                                ev_speed, 
                                amt_ev_tot, 
                                base_health, 
                                base_attack, 
                                base_defense, 
                                base_spec_att, 
                                base_spec_def, 
                                base_speed, 
                                name, 
                                        
                                stage, 
                                        
                                move_set, 
                                        
                                item_cool_down, 
                                        
                                paralysis, 
                                        
                                binded_turns, 
                                binded_damage, 
                                binded_effect, 
                                        
                                last_move, 
                                        
                                evade, 
                                accuracy, 
                                        
                                Dead, 
                               Dead_Timer);
            return x;
        }
    }

}