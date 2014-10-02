package src {
    import flash.system.fscommand;
    public class Base_Pokemon {
    // private:
        private var Species:int; // not a const b/c of evolution
		private var   Type_1:int,
                      Type_2:int;
        private var Gender:Boolean;
        
        private var level:int;
        private var experience:Number,
                    experience_to_level:Number;
        private var is_player:Boolean;
        // mod (battle) stats
        private var m_attack:int,
                    m_defense:int,
                    m_spec_att:int,
                    m_spec_def:int,
                    m_speed:int;
        // base stats
        private var attack:int,
                    defense:int,
                    spec_att:int,
                    spec_def:int,
                    speed:int,
                    max_health:int,
                    curr_health:int;
        private var hex:Boolean;
        private var iv_health:int,
                    iv_attack:int,
                    iv_defense:int,
                    iv_spec_att:int,
                    iv_spec_def:int,
                    iv_speed:int;
        private var ev_health:int,
                    ev_attack:int,
                    ev_defense:int,
                    ev_spec_att:int,
                    ev_spec_def:int,
                    ev_speed:int;
        private var amt_ev_tot:int;
        private var base_health:int,
                    base_attack:int,
                    base_defense:int,
                    base_spec_att:int,
                    base_spec_def:int,
                    base_speed:int;
        private var name:String;
        
        private var stage:int;
        
        private var move_set:Array; // array of Moves
        
        private var item_cool_down:int;
        
        private var paralysis:int = 0;
        
        private var binded_turns:Array = [ 0, 0, 0, 0, 0 ];
        private var binded_damage:Array = [ 0, 0, 0, 0, 0 ];
        private var binded_effect:Array = [ 0, 0, 0, 0, 0 ];
        
        private var last_move:int;
        
        private var evade:int;
        private var accuracy:int;
        private static const Item_Cool_Down_Max:int = 60*20;
        
        private var Dead:Boolean,
                    Dead_Timer:int;
	// public:
        public function Base_Pokemon(Poke_ID:int = -1, Stage:int = 0, IS_player:Boolean = true, start_lvl:int = 1, prev_stage_pok:Base_Pokemon = null) {
            if ( Poke_ID == -1 ) return;
            is_player = IS_player;
            // start_level can only > 1 if is_player != 1.
            stage = Stage;
            
            if ( start_lvl > 1 && is_player == 1 )
                trace("Start Level is over 1 on player creation in function Base_Pokemon(...)");
            if ( prev_stage_pok != null ) { // note that this can only happen to player botomon
                level = 1;
                experience = 0;
                experience_to_level = 100 * Level_Stage.Stage_Player_Mult[stage];
                
                //iv_health = Screen.Random_Range(iv_health, Level_Stage.Stage_Player_Mult[stage]);
                //iv_attack = Screen.Random_Range(iv_attack, Level_Stage.Stage_Player_Mult[stage]);
                //iv_defense = Screen.Random_Range(iv_defense, Level_Stage.Stage_Player_Mult[stage]);
                //iv_spec_att = Screen.Random_Range(iv_spec_att, Level_Stage.Stage_Player_Mult[stage]);
                //iv_spec_def = Screen.Random_Range(iv_spec_def, Level_Stage.Stage_Player_Mult[stage]);
                //iv_speed = Screen.Random_Range(iv_speed, Level_Stage.Stage_Player_Mult[stage]);
                
                return;
            }
            
            level = 1;
                
            // todo: get name 
            name = "Temp";
            
            Species = Poke_ID;
            Type_1 = Base_Pokemon_Stats.Poke_Type_1[Poke_ID];
            Type_2 = Base_Pokemon_Stats.Poke_Type_2[Poke_ID];
            Gender = Boolean(Screen.Random_Range(0, 1));
            experience = 0;
            experience_to_level = 50 + Math.floor(Number(5 * level*level*level) / Number(4) * Number(Level_Stage.Stage_Player_Mult[stage]));
            
            ev_health   = 0;
            ev_attack   = 0;
            ev_defense  = 0;
            ev_spec_att = 0;
            ev_spec_def = 0;
            ev_speed    = 0;
            
            amt_ev_tot = 0;
            
            iv_health   = Screen.Random_Range(4,15 - (Number(!is_player)*5) + 5*Number(Screen.current_area == 0)) * Level_Stage.Stage_Player_Mult[stage];
            iv_attack   = Screen.Random_Range(4,15 - (Number(!is_player)*5) + 5*Number(Screen.current_area == 0)) * Level_Stage.Stage_Player_Mult[stage];
            iv_defense  = Screen.Random_Range(4,15 - (Number(!is_player)*5) + 5*Number(Screen.current_area == 0)) * Level_Stage.Stage_Player_Mult[stage];
            iv_spec_att = Screen.Random_Range(4,15 - (Number(!is_player)*5) + 5*Number(Screen.current_area == 0)) * Level_Stage.Stage_Player_Mult[stage];
            iv_spec_def = Screen.Random_Range(4,15 - (Number(!is_player)*5) + 5*Number(Screen.current_area == 0)) * Level_Stage.Stage_Player_Mult[stage];
            iv_speed    = Screen.Random_Range(7,10) * Level_Stage.Stage_Player_Mult[stage];
            base_health = 62- 2*Number((!is_player) && (Screen.current_area == 0));;
            base_attack = 61 - 1*Number((!is_player) && (Screen.current_area == 0));
            base_defense = 61- 1*Number((!is_player) && (Screen.current_area == 0));;
            base_spec_att = 61- 1*Number((!is_player) && (Screen.current_area == 0));;
            base_spec_def = 61- 1*Number((!is_player) && (Screen.current_area == 0));;
            base_speed = 61- 1*Number((!is_player) && (Screen.current_area == 0));;
            if ( !is_player )
                trace("IV_SPEEDIV_SPEEDIV_SPEEDIV_SPEEDIV_SPEEDIV_SPEEDIV_SPEEDIV_SPEEDIV_SPEEDIV_SPEEDIV_SPEEDIV_SPEEDIV_SPEEDIV_SPEEDIV_SPEEDIV_SPEED:" + iv_speed);
            Refresh_Static_Stats();
            
            if ( is_player ) {
                max_health *= Level_Stage.Stage_Player_Mult[stage];
                attack     *= Level_Stage.Stage_Player_Mult[stage];
                defense    *= Level_Stage.Stage_Player_Mult[stage];
                spec_att   *= Level_Stage.Stage_Player_Mult[stage];
                spec_def   *= Level_Stage.Stage_Player_Mult[stage];
                speed      *= Level_Stage.Stage_Player_Mult[stage];
            } else {
                max_health *= Level_Stage.Stage_Enemy_Mult[stage];
                attack     *= Level_Stage.Stage_Enemy_Mult[stage];
                defense    *= Level_Stage.Stage_Enemy_Mult[stage];
                spec_att   *= Level_Stage.Stage_Enemy_Mult[stage];
                spec_def   *= Level_Stage.Stage_Enemy_Mult[stage];
                speed      *= Level_Stage.Stage_Enemy_Mult[stage];
            }
            // regular set variables
            curr_health = max_health

            Dead = 0;
            Dead_Timer = 0;
            evade = 100;
            item_cool_down = 0;
            last_move = 0;
            move_set = [ null, null, null ];
            if ( !is_player ) {
                for ( var i : int = 0; i != 3; ++ i ) {
                    var mov_id : int = -1;
                    do { // generate possible move ids based on previous ones
                        mov_id = Screen.Random_Range(0, Move_Info.Names.length - 2); // - 2 b/c top is null
                        if ( move_set[0] != null ) if ( Move(move_set[0]).Move_ID == mov_id ) mov_id = -1;
                        if ( move_set[1] != null ) if ( Move(move_set[1]).Move_ID == mov_id ) mov_id = -1;
                        if ( move_set[2] != null ) if ( Move(move_set[2]).Move_ID == mov_id ) mov_id = -1;
                        // banned moves from bot enemies
                        for ( var z : int = 0; z != Move_Info.Names.length - 2; ++ z )
                            if ( ( Move_Info.Names[z] == "Copy" && z == mov_id ) ||
                                 ( Move_Info.Names[z] == "Enrichen" && z == mov_id ) ) mov_id = -1;
                        
                    } while ( mov_id == -1 );
                    
                    this.move_set[i] = new Move(mov_id,
                                           Area.R_Curr_Area_Stage(),
                                           Screen.Random_Range(0, Base_Pokemon_Stats.Type_None-1));
                }
                name = Base_Pokemon_Stats.Poke_Name[Species];
                while ( level < start_lvl ) {
                    var i : int = level;
                    Level();
                    if ( i == level ) break;// reached limit
                }
            }
            Refresh_Effect_Count();
            curr_health = max_health;
        }
        public function Reroll_Stats() {
            iv_health   = Screen.Random_Range(4,15 - (Number(!is_player)*5) + 5*Number(Screen.current_area == 0)) * Level_Stage.Stage_Player_Mult[stage];
            iv_attack   = Screen.Random_Range(4,15 - (Number(!is_player)*5) + 5*Number(Screen.current_area == 0)) * Level_Stage.Stage_Player_Mult[stage];
            iv_defense  = Screen.Random_Range(4,15 - (Number(!is_player)*5) + 5*Number(Screen.current_area == 0)) * Level_Stage.Stage_Player_Mult[stage];
            iv_spec_att = Screen.Random_Range(4,15 - (Number(!is_player)*5) + 5*Number(Screen.current_area == 0)) * Level_Stage.Stage_Player_Mult[stage];
            iv_spec_def = Screen.Random_Range(4,15 - (Number(!is_player)*5) + 5*Number(Screen.current_area == 0)) * Level_Stage.Stage_Player_Mult[stage];
            iv_speed    = Screen.Random_Range(7, 10) * Level_Stage.Stage_Player_Mult[stage];
            Refresh_Static_Stats();
        }
        public function Refresh_Static_Stats() {
            Refresh_Battle_Stats(0);

            if ( is_player ) {
                max_health = Base_Pokemon_Stats.R_HP_Info(level, iv_health, base_health, !is_player)
                    * Level_Stage.Stage_Player_Mult[stage] ;
                attack   = Base_Pokemon_Stats.R_Stat_Info(level, iv_attack, base_attack)
                    * Level_Stage.Stage_Player_Mult[stage];
                defense  = Base_Pokemon_Stats.R_Stat_Info(level, iv_defense, base_defense)
                    * Level_Stage.Stage_Player_Mult[stage];
                spec_att = Base_Pokemon_Stats.R_Stat_Info(level, iv_spec_att, base_spec_att)
                    * Level_Stage.Stage_Player_Mult[stage];
                spec_def = Base_Pokemon_Stats.R_Stat_Info(level, iv_spec_def, base_spec_def)
                    * Level_Stage.Stage_Player_Mult[stage];
                speed    = Base_Pokemon_Stats.R_Stat_Info(level, iv_speed, base_speed)
                    * Level_Stage.Stage_Player_Mult[stage];
            } else {
                max_health = Base_Pokemon_Stats.R_HP_Info(level, iv_health, base_health, !is_player)
                    * Level_Stage.Stage_Enemy_Mult[stage];
                attack   = Base_Pokemon_Stats.R_Stat_Info(level, iv_attack, base_attack)
                    * Level_Stage.Stage_Enemy_Mult[stage];
                defense  = Base_Pokemon_Stats.R_Stat_Info(level, iv_defense, base_defense)
                    * Level_Stage.Stage_Enemy_Mult[stage];
                spec_att = Base_Pokemon_Stats.R_Stat_Info(level, iv_spec_att, base_spec_att)
                    * Level_Stage.Stage_Enemy_Mult[stage];
                spec_def = Base_Pokemon_Stats.R_Stat_Info(level, iv_spec_def, base_spec_def)
                    * Level_Stage.Stage_Enemy_Mult[stage];
                speed    = Base_Pokemon_Stats.R_Stat_Info(level, iv_speed, base_speed)
                    * Level_Stage.Stage_Enemy_Mult[stage];
            }
            
            experience_to_level = (50 + Math.floor(Number(5 * level*level*level) / Number(4) * Number(Level_Stage.Stage_Player_Mult[stage])));
            attack += m_attack;
            defense += m_defense;
            spec_att += m_spec_att;
            spec_def += m_spec_def;
            speed += m_speed;
        }
        // used for bosses only!
        public function Bossify ():void {
            // get type 1 and type 2
            Gender = Base_Pokemon_Stats.Male;
            iv_attack = iv_defense = iv_health = iv_spec_att = iv_spec_def = 15;
            iv_speed = 10;
            Refresh_Static_Stats();
            curr_health = max_health;
            if ( Base_Pokemon_Stats.Poke_Type_1[Base_Pokemon_Stats.Poke_Type_1.length - 1] == Base_Pokemon_Stats.Type_None ) {
                Base_Pokemon_Stats.Poke_Type_1[Base_Pokemon_Stats.Poke_Type_1.length - 1] = Screen.Random_Range(1, Base_Pokemon_Stats.Type_None-1);
                do {
                    Base_Pokemon_Stats.Poke_Type_2[Base_Pokemon_Stats.Poke_Type_1.length - 1] =
                        Screen.Random_Range(1, Base_Pokemon_Stats.Type_None-1);
                } while ( Base_Pokemon_Stats.Poke_Type_2[Base_Pokemon_Stats.Poke_Type_1.length - 1] ==
                          Base_Pokemon_Stats.Poke_Type_1[Base_Pokemon_Stats.Poke_Type_1.length - 1] );
            }
            
            move_set = new Array(); // boss gets ALL moves :-]
            for ( var i : int = 0; i != Move_Info.Names.length - 2; ++ i ) {
                if ( Move_Info.Names[i] == "Copy" || Move_Info.Names[i] == "Enrichen" ) continue;
                move_set.push(new Move(i, stage));
            }
        }
        
        // if move already exists in slot, puts it in store
        // if no slot is found, item is put back in store
        public function Learn_Move(mov:Move, slot:int = -1):Boolean {
            if ( mov.Move_Stage < stage ) {
                Screen.Text_Store_Results.push("Move's stage is too low for botomon!");
                return false;
            }
            trace("Learning move");
            if ( slot > 3 ) {
                Screen.Text_Store_Results.push("Three moves already equipped, use 1-3!");
                Clear_Item_Timer();
                return false;
            }
            if ( mov.Move_Stage > stage ) {
                Screen.Text_Store_Results.push("Move trying to equip is too high of stage!");
                Clear_Item_Timer();
                return false; // move is too high level for botomon
            }
            for ( var i : int = 0; i != 3; ++ i ) // botomon can't have multiple moves
                if ( move_set[i] != null ) {
                    if ( Move(move_set[i]).Move_ID == mov.Move_ID ) {
                        Screen.Text_Store_Results.push("Botomon can't have identical moves!");
                        Clear_Item_Timer();
                        return false;
                    }
                }
            if ( slot == -1 ) {
                trace("Finding key to apply to");
                if ( move_set[2] == null ) slot = 2;
                if ( move_set[1] == null ) slot = 1;
                if ( move_set[0] == null ) slot = 0;
                if ( slot == -1 )
                    trace("All moves are already applied. Will still try to find key");
                if ( Screen.Keyboard_Keys[Screen.K_1] == 1 ) slot = 0;
                if ( Screen.Keyboard_Keys[Screen.K_2] == 1 ) slot = 1;
                if ( Screen.Keyboard_Keys[Screen.K_3] == 1 ) slot = 2;
                if ( slot == -1 ) { // nothing could be found, add item back to store
                    Screen.Text_Store_Results.push("All moves equipped, use 1-3!");
                    Clear_Item_Timer();
                    return false;
                }
            }
            var t_mov:Move = Move(move_set[slot]);
            move_set[slot] = mov;
            if ( t_mov != null )
                Screen.Add_Item_Inventory_Move(t_mov);
            return true;
        }
        
        public function Apply_Modifier(x:int):Boolean {
            // you are /required/ to use keys for application
            var slot : int = -1;
            if ( Screen.Keyboard_Keys[Screen.K_1] == 1 ) slot = 0;
            if ( Screen.Keyboard_Keys[Screen.K_2] == 1 ) slot = 1;
            if ( Screen.Keyboard_Keys[Screen.K_3] == 1 ) slot = 2;
            
            if ( slot == -1 ) {
                Screen.Text_Store_Results.push("Need to press 1-3 to use mod!");
                Clear_Item_Timer();
                return false;
            }
            Screen.Text_Store_Results.push("Modifier " + Base_Pokemon_Stats.R_Type_To_String(x) +
                                           " applied to move " + Move_Info.Names[Move(move_set[slot]).Move_ID]);
            if ( move_set[slot] == null ) {
                Screen.Text_Store_Results.push("Slot " + slot + " has no move!");
                Clear_Item_Timer();
                return false;
            }
            else {
                if ( Move(move_set[slot]).Move_Type != 0 )
                    Screen.Add_Item_Inventory(new Item(58 + Move(move_set[slot]).Move_Type));
                Move(move_set[slot]).Move_Type = x;
                return true;
            }
        }
        public function R_Name():String {
            return name;
        }
        public function R_Gender():Boolean {
            return Gender;
        }
        public function R_Stage():int {
            return stage;
        }
        public function R_Level():int {
            return level;
        }
        public function R_Max_Health():Number {
            return max_health;
        }
        public function R_Curr_Health():Number {
            return curr_health;
        }
		public function R_Curr_Exp():Number {
			return experience;
		}
		public function R_Exp_To_Level():Number {
			return experience_to_level;
		}
        public function Set_Health(x:int):void {
            if ( x > max_health ) x = max_health;
            curr_health = Math.floor(x);
        }
        public function Add_Health(x:int):void {
            Set_Health(curr_health + x);
        }
        public function R_Attack():int {
            return attack;
        }
        public function R_Defense():int {
            return defense;
        }
        public function R_Spec_Att():int {
            return spec_att;
        }
        public function R_Spec_Def():int {
            return spec_def;
        }
        public function R_Speed():int {
            return speed;
        }
        public function Add_Attack_EV():Boolean {
            if ( amt_ev_tot < 2 ) {
                ++base_attack;
                ++amt_ev_tot;
                return true;
            }
            return false;
        }
        public function Add_Spec_Att_EV():Boolean {
            if ( amt_ev_tot < 2 ) {
                ++base_spec_att;
                ++amt_ev_tot;
                return true;
            }
            return false;
        }
        public function Add_Defense_EV():Boolean {
            if ( amt_ev_tot < 2 ) {
                ++base_defense;
                ++amt_ev_tot;
                return true;
            }
            return false;
        }
        public function Add_Spec_Def_EV():Boolean {
            if ( amt_ev_tot < 2 ) {
                ++base_spec_def;
                ++amt_ev_tot;
                return true;
            }
            return false;
        }
        public function Add_Speed_EV():Boolean {
            if ( amt_ev_tot < 2 ) {
                ++base_speed;
                ++amt_ev_tot;
                return true;
            }
            return false;
        }
        public function Add_Health_EV():Boolean {
            if ( amt_ev_tot < 2 ) {
                ++base_health;
                ++amt_ev_tot;
                return true;
            }
            return false;
        }
        public function R_Tot_Ev() { return amt_ev_tot; }
        public function R_Hexed():Boolean {
            return hex;
        }
        public function Hex():void {
            hex = 1;
        }
        public function R_Value():int {
            // equate value
            return Math.floor (
                   Math.pow( Number(iv_attack * 2 + iv_defense * 2 + iv_health * 2 + iv_spec_att * 2 + iv_spec_def * 2 + iv_speed * 3)
                        / Number(Math.floor(3.0 * Level_Stage.Stage_Player_Mult[stage])) + 
                     Number(attack * 6 + defense * 6 + max_health * 4 + spec_att * 6 + spec_def * 6 + speed * 8  + level * 3)
                        / Number(Math.floor(1.5*Level_Stage.Stage_Player_Mult[stage]))
                   , 1 + (.25 * (level / 50)))
                   * Level_Stage.Stage_Player_Mult[stage] / 25 * (1 +int(!is_player)*.5) - (int(is_player)*6)
                  );
        }
        public function R_Move_Set():Array {
            return move_set;
        }
        public function R_Species_ID():int {
            return Species;
        }
        // returns if on then next stage (after hitting level 101)
        public function Add_Experience(x:Number):Boolean {
            experience += x;
            experience = Math.floor(experience);
            var lvled:Boolean = 0;
            if ( this == Screen.trainer_curr_pokemon )
                if ( stage >= Screen.current_stage_level ) {
                    Screen.pokemon_in_bank.push(this);
                    Screen.trainer_curr_pokemon = null;
                }
                
            while ( experience >= experience_to_level ) {
                var i : int = level;
                if ( Level() ) return 1; // if pokemon
                if ( level == i ) // hit cap
                    break;
            }
            return 0;
        }
        public function Level():Boolean {
            if ( level == 99 && stage == Screen.current_stage_level && is_player ) return false;
            if ( is_player ) {
                // highest level
                var t_level:int = 0;
                for ( var i : int = 0; i != stage; ++ i )
                    t_level += 100;
                t_level += level;
                if ( t_level > Screen.highest_level_botomon ) {
                    Screen.highest_level_botomon = t_level;
                }
            }
            if ( is_player )
                Screen.Text_User_Results.push(Screen.session_time + ": " + name + " has leveled to " + (level+1));
            base_health += Math.ceil(Number(ev_health));
            base_attack += Math.ceil(Number(ev_attack));
            base_defense += Math.ceil(Number(ev_defense));
            base_spec_att += Math.ceil(Number(ev_spec_att));
            base_spec_def += Math.ceil(Number(ev_spec_def));
            base_speed += Math.ceil(Number(ev_speed));
            amt_ev_tot = ev_health = ev_attack = ev_defense = ev_spec_att = ev_spec_def = ev_speed = 0;
            
            ++level;
            
            experience -= experience_to_level;
            experience_to_level =(50 + Math.floor(Number(5 * level*level*level) / Number(4) * Number(Level_Stage.Stage_Player_Mult[stage])));
            
            Refresh_Static_Stats();
            curr_health = max_health;
            if ( level > 99 && is_player && stage != 62 ) {
                level = 1;
                ++stage;
                Refresh_Static_Stats();
                for ( var i : int = 0; i != 3; ++ i )
                    Remove_Move(i);
                experience_to_level =(50 + Math.floor(Number(5 * level*level*level) / Number(4) * Number(Level_Stage.Stage_Player_Mult[stage])));
                Screen.Text_User_Results.push(Screen.session_time + ": " + name + "'s stage has increased to " + stage + "!");
                return 1;
            }
            return 0;
        }


        public function Remove_Move(x:int) {
            if ( move_set[x] == null ) return;
            Screen.Add_Item_Inventory_Move(move_set[x]);
            move_set[x] = null;
        }

        // in battle stats (resets after battle is finished)
        public function R_Evade():int {
            return evade;
        }
        public function R_Accuracy():int {
            return accuracy;
        }
        public function Mod_Evade(x:int):void {
            evade = x;
        }
        public function Mod_Accuracy(x:int):void {
            accuracy = x;
        }
        public function Mod_Attack(x:int):Boolean {
            if ( attack + x * 10 < Number(attack - m_attack) * .75 || 
                 attack + x*10 > Number(attack - m_attack) * 1.25 ) return 0;
            m_attack += x;
            attack += x;
            return 1;
        }
        public function Mod_Spec_Att(x:int):Boolean {
            if ( spec_att + x < Number(spec_att - m_spec_att) * .75 ||
                 spec_att + x > Number(spec_att - m_spec_att) * 1.25 ) return 0;
            m_spec_att += x;
            spec_att += x;
            return 1;
        }
        public function Mod_Defense(x:int):Boolean {
            if ( defense + x < Number(defense - m_defense) * .75 ||
                 defense + x > Number(defense - m_defense) * 1.25 ) return 0;
            m_defense += x;
            defense += x;
            return 1;
        }
        public function Mod_Spec_Def(x:int ):Boolean {
            if ( spec_def + x < Number(spec_def - m_spec_def) * .75 ||
                 spec_def + x > Number(spec_def - m_spec_def) * 1.25 ) return 0;
            m_spec_def += x;
            spec_def += x;
            return 1;
        }
        public function Mod_Speed(x:int):Boolean {
            if ( speed + x < Number(speed - m_speed) * .8 ||
                 speed + x > Number(speed - m_speed) * 1.25 ) return 0;
            m_spec_def += x;
            spec_def += x;
            return 1;
        }
        public function Clear_Item_Timer():void {
            item_cool_down = 0;
        }
        public function Refresh_Effect_Count():void {
            for ( var i:int = 0; i != 5; ++ i )
                if ( binded_effect[i] != 0 ) {
                    if ( --binded_turns[i] <= 0 ) {
                        binded_damage[i] = 0;
                        binded_turns[i] = 0;
                        binded_effect[i] = -1;
                    }
                }
        }
        public function Bind_Damage_Per_Turn(turns:int, dmg:int, eff:int):void {
            for ( var i : int = 0; i != 1000; ++ i ) 
                trace("BIND DAMAGE PER TURN: " + eff + " is the mod for " + " turns " + turns + " at " + dmg + " dmg");
            if ( Screen.fighting_final_boss && !is_player )
                dmg *= .5;
            if ( dmg <= 0 ) dmg = 1;
            binded_effect[eff] = eff;
            binded_damage[eff] = dmg;
            binded_turns[eff] = turns;
        }
        public function Set_Name(x:String) {
            name = x;
        }
        public function R_Status_Effects():Array {
            return binded_effect;
        }
        public function R_Status_Effects_Damage():Array {
            return binded_damage;
        }
        public function R_Last_Move():int {
            return last_move;
        }
        public function Set_Last_Move(x:int):void {
            last_move = x;
        }
        // called at finish and start of a battle
        public function Refresh_Battle_Stats(Clear_M:Boolean = true):void {
            attack -= m_attack;
            defense -= m_defense;
            spec_att -= m_spec_att;
            spec_def -= m_spec_def;
            speed -= m_speed;
            if ( Clear_M ) {
                m_attack = 0;
                m_defense = 0;
                m_spec_att = 0;
                m_spec_def = 0;
                m_speed = 0;
            }
            
            paralysis = 0;
            for ( var i : int = 0; i != binded_damage.length; ++ i ) {
                binded_damage[i] = 0;
                binded_effect[i] = 0;
                binded_turns[i] = 0;
            }
        }
        
        public function R_Paralyzed():int {
            return paralysis
        }
        
        public function Neg_Paralysis() { --paralysis; }
        public function Paralyze():void {
            paralysis = 2;
        }
        
        public function Item_Timer_Reset(fighting_enemy:Boolean):void {
            item_cool_down = 600 - (580*int(!fighting_enemy)) + (200*Number(Screen.fighting_final_boss));
        }
        public function Refresh_Item_Timer():void {
            if ( item_cool_down > 0 )
                --item_cool_down;
        }
        public function R_Item_Timer_Frac():int {
            return int(100*(Number(item_cool_down)/Number(600)))
        }
        public function R_Item_Timer_Good():Boolean {
            return (item_cool_down > 0);
        }
        
        public function Kill():void {
            Refresh_Battle_Stats();
            Dead = 1;
            Dead_Timer = Screen.Max_Dead_Timer - (Screen.Max_Dead_Timer*.9)*(1 - Screen.R_Curr_Area()/Area.Amt_Of_Base_Stages);
        }
        public function R_Is_Enemy():Boolean {
            return !(is_player);
        }
        public function R_Is_Dead():Boolean {
            return Dead;
        }
        public function R_Dead_Timer():int {
            return Dead_Timer;
        }
        public function Ref_Dead_Timer():void {
            --Dead_Timer;
        }
        public function Resurrect(x:Number):void {
            Set_Health(x);
            Dead_Timer = 0;
            Dead = 0;
        }
        public function Export_Information():Base_Pokemon_Loader {
            var x:Base_Pokemon_Loader = new Base_Pokemon_Loader();
            x.Species = Species;
            x.Type_1 = Type_1;
            x.Type_2 = Type_2;
            x.Gender = Gender;
                    
            x.level = level;
            x.experience = experience;
            x.experience_to_level = experience_to_level;
            x.is_player = is_player;
                    // mod (battle) stats
            x.m_attack = m_attack;
            x.m_defense = m_defense;
            x.m_spec_att = m_spec_att;
            x.m_spec_def = m_spec_def;
            x.m_speed = m_speed;
                    // base stats
            x.attack = attack;
            x.defense = defense;
            x.spec_att = spec_att;
            x.spec_def = spec_def;
            x.speed = speed;
            x.max_health = max_health;
            x.curr_health = curr_health;
            x.hex = hex;
            x.iv_health = iv_health;
            x.iv_attack = iv_attack;
            x.iv_defense = iv_defense;
            x.iv_spec_att = iv_spec_att;
            x.iv_spec_def = iv_spec_def;
            x.iv_speed = iv_speed;
            x.ev_health = ev_health;
            x.ev_attack = ev_attack;
            x.ev_defense = ev_defense;
            x.ev_spec_att = ev_spec_att;
            x.ev_spec_def = ev_spec_def;
            x.ev_speed = ev_speed;
            x.amt_ev_tot = amt_ev_tot;
            x.base_health = base_health;
            x.base_attack = base_attack;
            x.base_defense = base_defense;
            x.base_spec_att = base_spec_att;
            x.base_spec_def = base_spec_def;
            x.base_speed = base_speed;
            x.name = name;
                    
            x.stage = stage;
                    
            x.move_set = move_set;
                    
            x.item_cool_down = item_cool_down;
                    
            x.paralysis = paralysis;
                    
            x.binded_turns = binded_turns;
            x.binded_damage = binded_damage;
            x.binded_effect = binded_effect;
                    
            x.last_move = last_move;
                    
            x.evade = evade;
            x.accuracy = accuracy;
                    
            x.Dead = Dead;
            x.Dead_Timer = Dead_Timer;
            return x;
        }
        public function Import_Information(Species_:int, 
                                            Type_1_:int, 
                                            Type_2_:int, 
                                            Gender_:Boolean, 
                                                    
                                            level_:int, 
                                            experience_:Number, 
                                            experience_to_level_:Number, 
                                            is_player_:Boolean, 
                                                    // mod (battle) stats
                                            m_attack_:int, 
                                            m_defense_:int, 
                                            m_spec_att_:int, 
                                            m_spec_def_:int, 
                                            m_speed_:int, 
                                                    // base stats
                                            attack_:int, 
                                            defense_:int, 
                                            spec_att_:int, 
                                            spec_def_:int, 
                                            speed_:int, 
                                            max_health_:int, 
                                            curr_health_:int, 
                                            hex_:Boolean, 
                                            iv_health_:int, 
                                            iv_attack_:int, 
                                            iv_defense_:int, 
                                            iv_spec_att_:int, 
                                            iv_spec_def_:int, 
                                            iv_speed_:int, 
                                            ev_health_:int, 
                                            ev_attack_:int, 
                                            ev_defense_:int, 
                                            ev_spec_att_:int, 
                                            ev_spec_def_:int, 
                                            ev_speed_:int, 
                                            amt_ev_tot_:int, 
                                            base_health_:int, 
                                            base_attack_:int, 
                                            base_defense_:int, 
                                            base_spec_att_:int, 
                                            base_spec_def_:int, 
                                            base_speed_:int, 
                                            name_:String, 
                                                    
                                            stage_:int, 
                                                    
                                            move_set_:Array, 
                                                    
                                            item_cool_down_:int, 
                                                    
                                            paralysis_:int, 
                                                    
                                            binded_turns_:Array, 
                                            binded_damage_:Array, 
                                            binded_effect_:Array, 
                                                    
                                            last_move_:int, 
                                                    
                                            evade_:int, 
                                            accuracy_:int, 
                                                    
                                            Dead_:Boolean, 
                                            Dead_Timer_:int) {
            Species = Species_;
            Type_1 = Type_1_;
            Type_2 = Type_2_;
            Gender = Gender_;
                    
            level = level_;
            experience = experience_;
            experience_to_level = experience_to_level_;
            is_player = is_player_;
                    // mod (battle) stats
            m_attack = m_attack_;
            m_defense = m_defense_;
            m_spec_att = m_spec_att_;
            m_spec_def = m_spec_def_;
            m_speed = m_speed_;
                    // base stats
            attack = attack_;
            defense = defense_;
            spec_att = spec_att_;
            spec_def = spec_def_;
            speed = speed_;
            max_health = max_health_;
            curr_health = curr_health_;
            hex = hex_;
            iv_health = iv_health_;
            iv_attack = iv_attack_;
            iv_defense = iv_defense_;
            iv_spec_att = iv_spec_att_;
            iv_spec_def = iv_spec_def_;
            iv_speed = iv_speed_;
            ev_health = ev_health_;
            ev_attack = ev_attack_;
            ev_defense = ev_defense_;
            ev_spec_att = ev_spec_att_;
            ev_spec_def = ev_spec_def_;
            ev_speed = ev_speed_;
            amt_ev_tot = amt_ev_tot_;
            base_health = base_health_;
            base_attack = base_attack_;
            base_defense = base_defense_;
            base_spec_att = base_spec_att_;
            base_spec_def = base_spec_def_;
            base_speed = base_speed_;
            name = name_;
                    
            stage = stage_;
                    
            move_set = move_set_;
                    
            item_cool_down = item_cool_down_;
                    
            paralysis = paralysis_;
                    
            binded_turns = binded_turns_;
            binded_damage = binded_damage_;
            binded_effect = binded_effect_;
                    
            last_move = last_move_;
                    
            evade = evade_;
            accuracy = accuracy_;
                    
            Dead = Dead_;
            Dead_Timer = Dead_Timer_;
        }
    }
}