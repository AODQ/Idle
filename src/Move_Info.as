package src {
    import flash.display.MovieClip;
    public class Move_Info {
        public static const Effect_Freeze:int = 1, // 0 is set for none
                            Effect_Burn:int = 2,
                            Effect_Poison:int = 3,
                            Effect_Normal:int = 4;
    
        public static const Names:Array = [
            "Pound", "Kick", "Bite", "Blast",
            "Flame Breath", "Flame Thrower", "Flame Kick", "Flame Fury",
            "Ice Breath", "Freezer", "Ice Kick", "Ice Fury",
            "Poison Needle", "Poison Slam", "Poison Bite", "Poison Gas",
            "Paralyze",
            "Burn",
            "Bind", "Multi-Bind",
            "Sand Blind", "Needle Blind",
            "Multi-Hit", "Multi-Kick", "Instant Punches",
            "Double-Edge", "Masochistic Fury",
            "Boiling Spit", "Lava Smeer", // --Def
            "Enrichen", // increases enemy's stats
            "Kick To The Bozak",
            "Growl", "Roar", // --Attack
            "Meditate", // ++attack
            "Harden", // ++defense
            "Sing", // sleep enemy
            "Vampyric Leach", "Vampyric Drain",
            "Quicksand Beam", "Soften Ground", // slow speed
            "Copy", // does opponent's last move'
            "Rock Storm", // may hit 5 to 10 has 10% def.bind if 10 hit, 10% att.bind if 5 hit
            "NULL" // NULL could also be <0 I guess
        ];
        
        
        
        
        public static const Chance : Array = [
            //"Pound", "Kick", "Bite", "Blast",
            80, 70, 60, 50,
            //"Flame Breath", "Flame Thrower", "Flame Kick", "Flame Fury",
            80, 70, 60, 50,
            //"Ice Breath", "Freezer", "Ice Kick", "Ice Fury",
            80, 70, 60, 50,
            //"Poison Needle", "Poison Slam", "Poison Bite", "Poison Gas",
            80, 70, 60, 50,
            //"Paralyze",
            50,
            //"Burn",
            70,
            //"Bind", "Multi-Bind",
            70, 60,
            //"Sand Blind", "Needle Blind",
            90, 60,
            //"Multi-Hit", "Multi-Kick", "Instant Punches",
            80, 60, 40,
            //"Double-Edge", "Masochistic Fury",
            100, 100,
            //"Boiling Spit", "Lava Smeer", // --Def
            80, 60,
            //"Enrichen", "Kick_To_The_Bozak",
            40, 60,
            //"Growl", "Roar", // --Attack
            80, 60,
            //"Meditate", // ++attack
            100,
            //"Harden", // ++defense
            100,
            //"Sing", // sleep enemy
            50,
            //"Vampyric Leach", "Vampyric Drain",
            80, 60,
            //"Quicksand Beam", "Soften Ground", // slow speed
            80, 60,
            //"Copy", // does opponent's last move'
            100,
            //"Rock Storm", // may hit 5 to 10 has 10% def.bind if 10 hit, 10% att.bind if 5 hit
            70
        ];
        public static const Power : Array = [ 
            //"Pound", "Kick", "Bite", "Blast",
            9, 11, 12, 13,
            //"Flame Breath", "Flame Thrower", "Flame Kick", "Flame Fury",
            6, 7, 8, 10,
            //"Ice Breath", "Freezer", "Ice Kick", "Ice Fury",
            6, 7, 8, 10,
            //"Poison Needle", "Poison Slam", "Poison Bite", "Poison Gas",
            6, 7, 8, 10,
            //"Paralyze",
            0,
            //"Burn",
            0,
            //"Bind", "Multi-Bind",
            6, 8,
            //"Sand Blind", "Needle Blind",
            0, 0,
            //"Multi-Hit", "Multi-Kick", "Instant Punches",
            .5, .5, .5,
            //"Double-Edge", "Masochistic Fury",
            15, 30,
            //"Boiling Spit", "Lava Smeer", // --Def
            0, 0,
            //"Enrichen", "Kick_To_The_Bozak",
            0, 10,
            //"Growl", "Roar", // --Attack
            0, 0,
            //"Meditate", // ++attack
            0,
            //"Harden", // ++defense
            0,
            //"Sing", // sleep enemy
            0,
            //"Vampyric Leach", "Vampyric Drain",
            9, 12,
            //"Quicksand Beam", "Soften Ground", // slow speed
            0, 0,
            //"Copy", // does opponent's last move'
            0,
            //"Rock Storm", // may hit 5 to 10 has 10% def.bind if 10 hit, 10% att.bind if 5 hit
            0,
            //"NULL" // NULL could also be <0 I guess
        
            ];
        
        public static const Move_Info_Damage:int = 0,
                            Move_Info_Heal:int = 1,
                             Move_Info_Crit:int = 2,
                            Move_Info_Miss:int = 3,
                            Move_Info_Move:int = 4;
                            
        // returns an array of 5 (Damage Dealt, Damage Healed, Critical(bool), miss (1=miss), move). Applies affect
        // on pokemon. Includes grabbing the move set and pseudo randomizing which
        // move to perform
        public static function Perform_Move(att:Base_Pokemon, def:Base_Pokemon):Array {
            var move_set:Array = att.R_Move_Set();
            var highest_move:int = -1;
                        
            var poss_movs:Array = new Array(); // collect all move IDs and then pick a random one from the IDs to use as highest
            for ( var i:int = 0; i != move_set.length; ++ i )
                if ( move_set[i] != null ) poss_movs.push(i);
            if ( poss_movs.length == 0 ) { return [0]; }
            if ( att.R_Level() > 9 || att.R_Stage() > 0 )
                switch ( poss_movs.length ) {
                    case 0: return [0]; 
                    case 1:
                        if ( Screen.Random_Range(0, 100) > 50 ) return [1];
                    case 2:
                        if ( Screen.Random_Range(0, 100) > 75 ) return [1];
                    default: break;
                }
            highest_move = poss_movs[Screen.Random_Range(0, poss_movs.length)];
            trace("POSSIBLE MOVES: " + poss_movs.length);
            
            // now that the pre-reqs are done and the move is picked, the real bulk of code is performed
            var final_info:Array = [ 0, 0, 0, 0, 0 ];
            var temp_arr:Array = R_Base_Move(att, def, move_set[highest_move]); // get base_move information (crit/dmg)
            
            final_info[0] = temp_arr[0]; // dmg
            final_info[1] = temp_arr[1]; // healed
            final_info[2] = temp_arr[2]; // crit
            final_info[3] = temp_arr[3]; // missed
            final_info[4] = Move(move_set[highest_move]);
            if ( !final_info[3] )
                if ( final_info[0] > Screen.highest_damage )
                    Screen.highest_damage = final_info[0];
            trace("Selected move: " + Move_Info.Names[Move(final_info[4]).Move_ID]);
            return final_info;
        }
        private static function Call_Move(att:Base_Pokemon, def:Base_Pokemon, mov:Move, final_info:Array):Array {
            switch ( mov.Move_ID ) {
                case  0: return Pound(att, def, final_info);
                case  1: return Kick(att, def, final_info);
                case  2: return Bite(att, def, final_info);
                case  3: return Blast(att, def, final_info);

                case  4: return Flame_Breath(att, def, final_info);
                case  5: return Flame_Thrower(att, def, final_info);
                case  6: return Flame_Kick(att, def, final_info);
                case  7: return Flame_Fury(att, def, final_info);

                case  8: return Ice_Breath(att, def, final_info);
                case  9: return Freezer(att, def, final_info);
                case 10: return Ice_Kick(att, def, final_info);
                case 11: return Ice_Fury(att, def, final_info);

                case 12: return (att, def, final_info);
                case 13: return Poison_Slam(att, def, final_info);
                case 14: return Poison_Bite(att, def, final_info);
                case 15: return Poison_Gas(att, def, final_info);

                case 16: return Paralyze(att, def, final_info);

                case 17: return Burn(att, def, final_info);

                case 18: return Bind(att, def, final_info);
                case 19: return Multi_Bind(att, def, final_info);

                case 20: return Sand_Blind(att, def, final_info);
                case 21: return Needle_Blind(att, def, final_info);

                case 22: return Multi_Hit(att, def, final_info, mov.Move_Type);
                case 23: return Multi_Kick(att, def, final_info, mov.Move_Type);
                case 24: return Instant_Punches(att, def, final_info, mov.Move_Type);

                case 25: return Double_Edge(att, def, final_info);
                case 26: return Masochistic_Fury(att, def, final_info);

                case 27: return Boiling_Spit(att, def, final_info);
                case 28: return Lava_Smeer(att, def, final_info);

                case 29: return Enrichen(att, def, final_info);
                
                case 30: return Kick_To_The_Bozak(att, def, final_info);

                case 31: return Growl(att, def, final_info);
                case 32: return Roar(att, def, final_info);

                case 33: return Meditate(att, def, final_info);

                case 34: return Harden(att, def, final_info);

                case 35: return Sing(att, def, final_info);

                case 36: return Vampyric_Leach(att, def, final_info);
                case 37: return Vampyric_Drain(att, def, final_info);

                case 38: return Quicksand_Beam(att, def, final_info);
                case 39: return Soften_Ground(att, def, final_info);

                case 40: return Copy(att, def, final_info);

                case 41: return Rock_Storm(att, def, final_info, mov.Move_Type);
                default: //error
                    trace("ERROR!\nERROR!\nERROR!\nERROR!\nERROR!\nMove ID not found! Move id: " + mov.Move_ID
                        + " Does not exist!");
                    return new Array[0, 0, 1];
            }
        }
        // base attack move (returns damage dealt, if crit'd, if missed)
        private static function R_Base_Move(att:Base_Pokemon, def:Base_Pokemon, mov:Move):Array {
            // get if miss or not
            var miss_chance_player:int = Screen.Random_Range(Number(Chance[mov.Move_ID]) / 2, Number(Chance[mov.Move_ID]) + Number(att.R_Accuracy()) / 2);
            var miss_chance_enemy:int = Screen.Random_Range(Number(def.R_Evade()) / 4, def.R_Evade());
            trace("MISS CHANCE PLAYER: " + miss_chance_player);
            trace("MISS CHANCE ENEMY:  " + miss_chance_enemy);
            var missed:Boolean;
            
            missed = 1;
            if ( miss_chance_player > miss_chance_enemy ) missed = 0;
                                                             
            var move_mod:Number = 1;
            if ( Base_Pokemon_Stats.Poke_Type_1[att.R_Species_ID()] == mov.Move_Type )
                move_mod += 1;
            if ( Base_Pokemon_Stats.Poke_Type_2[att.R_Species_ID()] == mov.Move_Type )
                move_mod += 1;

            if ( Base_Pokemon_Stats.Compare_Types(Base_Pokemon_Stats.Poke_Type_1[def.R_Species_ID()], mov.Move_Type)
                                        == Base_Pokemon_Stats.Type_Effect_Doub )
                move_mod += .5;
            if ( Base_Pokemon_Stats.Compare_Types(Base_Pokemon_Stats.Poke_Type_1[def.R_Species_ID()], mov.Move_Type)
                                        == Base_Pokemon_Stats.Type_Effect_Half )
                move_mod -= .5;
                
            if ( Base_Pokemon_Stats.Compare_Types(Base_Pokemon_Stats.Poke_Type_1[def.R_Species_ID()], mov.Move_Type)
                                        == Base_Pokemon_Stats.Type_Effect_Doub )
                move_mod += .5;
            if ( Base_Pokemon_Stats.Compare_Types(Base_Pokemon_Stats.Poke_Type_1[def.R_Species_ID()], mov.Move_Type)
                                        == Base_Pokemon_Stats.Type_Effect_Half )
                move_mod -= .5;
             
            trace("Base Damage Stats");
            var base_damage:Number = (Move_Info.Power[mov.Move_ID] * (1 + att.R_Level() / 50));
            var tt = ((Number(att.R_Attack() * 1.0) / Number(def.R_Defense() * 1.0))*(att.R_Level()/75));
            if ( tt < .75 ) tt = .75;
            if ( tt > 0 ) tt = 1 + tt / 1000;
            if ( tt > 2 ) tt = 2;
            base_damage *= tt;
            base_damage += Move_Info.Power[mov.Move_ID] * ((Number(att.R_Attack() * 1.0) / Number(def.R_Defense() * 1.0)))*.5;
            trace(base_damage);
            base_damage *= .2 + (.8 * (def.R_Level()/100))
            trace(base_damage);
            trace(base_damage);
            var critical:int = Screen.Random_Range(0, 100) < 10?2:1;
            base_damage *= critical;
            trace(base_damage);
            base_damage *= Number(Screen.Random_Range(70000, 100000) / 75000);
            base_damage *= move_mod;
            trace(base_damage);
            var info:Array = new Array();
            info.push(
                Math.ceil(base_damage)
                );
            info.push(0); // health
            info.push(critical);
            info.push(missed);
            // move
            info.push(Move(mov));
            // perform special move properties
            
            info.push(mov.Move_Stage);
            info.push(Boolean(att.R_Name() == "BOT"));
            if ( !info[3] ) // if not missed
                info = Call_Move(att, def, mov, info);
            info.pop();
            
            if ( att.R_Name() == "BOT" ) {
                info[0] *= Level_Stage.Stage_Enemy_Mult[mov.Move_Stage];
                info[1] *= Level_Stage.Stage_Enemy_Mult[mov.Move_Stage];
            } else {
                info[0] *= Level_Stage.Stage_Player_Mult[mov.Move_Stage];
                info[1] *= Level_Stage.Stage_Player_Mult[mov.Move_Stage];
            }
            info[0] = Math.floor(info[0]);
            info[1] = Math.floor(info[1]);
            return info;
        }

        // moves

        private static function Pound(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            return info;
        } 
        private static function Kick(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            return info;
        } 
        private static function Bite(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            return info;
        } 
        private static function Blast(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            return info;
        }
        
        private static function Flame_Breath(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            // 20% chance of burning opponent
            var rand:int = Screen.Random_Range(0, 100);
            if ( rand > 80 ) {// burn opponent
                def.Bind_Damage_Per_Turn(3, 2 + .2 * att.R_Level() * (att.R_Spec_Att() / def.R_Spec_Att()),
                                         Move_Info.Effect_Burn);
                Screen.special_fight_effect = def.R_Name() + " has been burned!";
            }
            return info;
        } 
        private static function Flame_Thrower(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            // 20% chance of burning opponent
            var rand:int = Screen.Random_Range(0, 100);
            if ( rand > 80 ) { // burn opponent 
                def.Bind_Damage_Per_Turn(3, 2 + .2 * att.R_Level() * (att.R_Spec_Att() / def.R_Spec_Att()),
                                         Move_Info.Effect_Burn);
                Screen.special_fight_effect = def.R_Name() + " has been burned!";
            }
            return info;
        } 
        private static function Flame_Kick(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            // 20% chance of burning opponent
            var rand:int = Screen.Random_Range(0, 100);
            if ( rand > 80 ) {// burn opponent
                def.Bind_Damage_Per_Turn(4, 2 + .2 * att.R_Level() * (att.R_Spec_Att() / def.R_Spec_Att()),
                                         Move_Info.Effect_Burn);
                Screen.special_fight_effect = def.R_Name() + " has been burned!";
            }
            return info;
        } 
        private static function Flame_Fury(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            // 20% chance of burning opponent
            var rand:int = Screen.Random_Range(0, 100);
            if ( rand > 80 ) { // burn opponent
                def.Bind_Damage_Per_Turn(3, 2 + .2 * att.R_Level() * (att.R_Spec_Att() / def.R_Spec_Att()),
                                         Move_Info.Effect_Burn);
                Screen.special_fight_effect = def.R_Name() + " has been burned!";
            }
            return info;
        }
                    
        private static function Ice_Breath(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            // 20% chance of freezing opponent
            var rand:int = Screen.Random_Range(0, 100);
            if ( rand > 80 ) { // freeze opponent
                def.Bind_Damage_Per_Turn(3, 2 + .2 * att.R_Level() * (att.R_Spec_Att() / def.R_Spec_Att()),
                                         Move_Info.Effect_Freeze);
                Screen.special_fight_effect = def.R_Name() + " has been frozen!";
            }
            return info;
        } 
        private static function Freezer(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            // 20% chance of freezing opponent
            var rand:int = Screen.Random_Range(0, 100);
            if ( rand > 80 ) { // freeze opponent
                def.Bind_Damage_Per_Turn(3, 2 + .2 * att.R_Level() * (att.R_Spec_Att() / def.R_Spec_Att()),
                                         Move_Info.Effect_Freeze);
                Screen.special_fight_effect = def.R_Name() + " has been frozen!";
            }
            return info;
        } 
        private static function Ice_Kick(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            // 20% chance of freezing opponent
            var rand:int = Screen.Random_Range(0, 100);
            if ( rand > 80 ) { // freeze opponent
                def.Bind_Damage_Per_Turn(3, 2 + .2 * att.R_Level() * (att.R_Spec_Att() / def.R_Spec_Att()),
                                         Move_Info.Effect_Freeze);
                Screen.special_fight_effect = def.R_Name() + " has been frozen!";
            }
            return info;
        } 
        private static function Ice_Fury(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            // 20% chance of freezing opponent
            var rand:int = Screen.Random_Range(0, 100);
            if ( rand > 80 ) { // freeze opponent
                def.Bind_Damage_Per_Turn(3, 2 + .2 * att.R_Level() * (att.R_Spec_Att() / def.R_Spec_Att()),
                                         Move_Info.Effect_Freeze);
                Screen.special_fight_effect = def.R_Name() + " has been frozen!";
            }
            return info;
        }
                    
        private static function Poison_Needle(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            // 20% chance of poisoning opponent
            var rand:int = Screen.Random_Range(0, 100);
            if ( rand > 80 ) { // poison opponent
                def.Bind_Damage_Per_Turn(3, 2 + .2 * att.R_Level() * (att.R_Spec_Att() / def.R_Spec_Att()),
                                         Move_Info.Effect_Poison);
                Screen.special_fight_effect = def.R_Name() + " has been poisoned!";
                for ( var i : int = 0; i != 10000; ++ i )
                    trace(Screen.special_fight_effect);
            }
            return info;
        } 
        private static function Poison_Slam(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            // 20% chance of poisoning opponent
            var rand:int = Screen.Random_Range(0, 100);
            if ( rand > 80 ) { // poison opponent
                def.Bind_Damage_Per_Turn(3, 2 + .2 * att.R_Level() * (att.R_Spec_Att() / def.R_Spec_Att()),
                                         Move_Info.Effect_Poison);
                Screen.special_fight_effect = def.R_Name() + " has been poisoned!";
            }
            return info;
        } 
        private static function Poison_Bite(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            // 20% chance of poisoning opponent
            var rand:int = Screen.Random_Range(0, 100);
            if ( rand > 80 ) { // poison opponent
                def.Bind_Damage_Per_Turn(3, 2 + .2 * att.R_Level() * (att.R_Spec_Att() / def.R_Spec_Att()),
                                         Move_Info.Effect_Poison);
                Screen.special_fight_effect = def.R_Name() +  " has been poisoned!";
            }
            return info;
        } 
        private static function Poison_Gas(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            // 20% chance of poisoning opponent
            var rand:int = Screen.Random_Range(0, 100);
            if ( rand > 80 ) { // poison opponent
                def.Bind_Damage_Per_Turn(3, 2 + .2 * att.R_Level() * (att.R_Spec_Att() / def.R_Spec_Att()),
                                         Move_Info.Effect_Poison);
                Screen.special_fight_effect = def.R_Name() + " has been poisoned!";
            }
            return info;
        }
                    
        private static function Paralyze(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            // 10% chance of paralyzing opponent
            var rand:int = Screen.Random_Range(0, 100);
            if ( rand > 90 ) {
                def.Paralyze();
                Screen.Text_Move_Results.push(Screen.session_time + ": " + def.R_Name() + " has been paralyzed by " + att.R_Name()+ "!");
            } else
                Screen.Text_Move_Results.push(Screen.session_time + ": " + att.R_Name() + "'s paralysis failed!");
            return info;
        }
                    
        private static function Burn(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            // 80% chance of burning opponent
            var rand:int = Screen.Random_Range(0, 100);
            if ( rand > 20 ) { // burn opponent
                def.Bind_Damage_Per_Turn(4, 2 + .2 * att.R_Level() * (att.R_Spec_Att() / def.R_Spec_Att()),
                                         Move_Info.Effect_Burn);
                Screen.special_fight_effect = def.R_Name() + " has been burned!";
                Screen.Text_Move_Results.push(Screen.session_time + ": " + def.R_Name() + " has been burned by " + att.R_Name()+ "!");
            } else
                Screen.Text_Move_Results.push(Screen.session_time + ": " + att.R_Name() + "'s burn failed!");
            return info;
        }
                    
        private static function Bind(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            // deal damage for 2-5 turns
            var rand:int = Screen.Random_Range(0, 100);
            var times = rand < 100 ? (rand < 64 ? (rand < 24 ? (rand < 12 ? 5 : 4) : 3) : 2) : 2;
            def.Bind_Damage_Per_Turn(times, times * (def.R_Is_Enemy()?Level_Stage.Stage_Enemy_Mult[Move(info[4]).Move_Stage]:
                                                         Level_Stage.Stage_Player_Mult[Move(info[4]).Move_Stage]),
                                     Move_Info.Effect_Normal);
            Screen.special_fight_effect = def.R_Name() + " has been bound for " + times + " turns!";
            return info;
        } 
        private static function Multi_Bind(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            // deal damage and paralyze for 1-3 turns
            var rand:int = Screen.Random_Range(0, 100);
            var times = rand < 60 ? (rand < 20 ? (rand < 5 ? 3 : 2) : 1) : 0;
            if ( times > 0 ) {
                def.Bind_Damage_Per_Turn(times, 2 + .2 * att.R_Level() * (att.R_Spec_Att() / def.R_Spec_Att()),
                                         Move_Info.Effect_Normal);
            }
            return info;
        }
                    
        private static function Sand_Blind(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            // decrease spec att var by 1
            if ( def.Mod_Spec_Att( -2+att.R_Level()/5) != 0 )
                Screen.Text_Move_Results.push(def.R_Name() + "'s special attack has decreased");
            else
                Screen.Text_Move_Results.push(att.R_Name() + "'s sand blind has no effect");
            return info;
        } 
        private static function Needle_Blind(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            // decrease sp def var by 1
            if ( def.Mod_Spec_Def( -2+att.R_Level()/5) != 0 )
                Screen.Text_Move_Results.push(def.R_Name() + "'s special defense has decreased");
            else
                Screen.Text_Move_Results.push(att.R_Name() + "'s needle blind has no effect");
            return info;
        }
        private static function Multi_Hit(att:Base_Pokemon, def:Base_Pokemon, info:Array, type:int ):Array {
            // deal 2-5 times per use
            var rand:int = Screen.Random_Range(0, 100);
            var times = rand < 100 ? (rand < 64 ? (rand < 24 ? (rand < 12 ? 5 : 4) : 3) : 2) : 2;
            // grab damage dealt by performing move multiple times
            for ( var i : int = 0; i != times; ++ i )
                info[0] += R_Base_Move(att, def, new Move(1, Move(info[4]).Move_Stage, type))[0];
            info[0] = Math.floor(Number(info[0]) / Number(3));
            return info;
        } 
        private static function Multi_Kick(att:Base_Pokemon, def:Base_Pokemon, info:Array, type:int ):Array {
            // deal 2-5 times per use
            var rand:int = Screen.Random_Range(0, 100);
            var times = rand < 100 ? (rand < 64 ? (rand < 24 ? (rand < 12 ? 5 : 4) : 3) : 2) : 2;
            // grab damage dealt by performing move multiple times
            for ( var i : int = 0; i != times; ++ i )
                info[0] += R_Base_Move(att, def, new Move(3, Move(info[4]).Move_Stage, type))[0];
            info[0] = Math.floor(Number(info[0]) / Number(3));
            return info;
        }
        private static function Instant_Punches(att:Base_Pokemon, def:Base_Pokemon, info:Array, type:int ):Array {
            // deal 2-5 times per use
            var rand:int = Screen.Random_Range(0, 100);
            var times = rand < 100 ? (rand < 64 ? (rand < 24 ? (rand < 12 ? 5 : 4) : 3) : 2) : 2;
            // grab damage dealt by performing move multiple times
            for ( var i : int = 0; i != times; ++ i )
                info[0] += R_Base_Move(att, def, new Move(3, Move(info[4]).Move_Stage, type))[0];
            info[0] = Math.floor(Number(info[0]) / Number(3));
            return info;
        }
        private static function Rock_Storm(att:Base_Pokemon, def:Base_Pokemon, info:Array, type:int ):Array {
            // deal 5-10 times per use
            var rand:int = Screen.Random_Range(0, 100);
            var times = rand < 90 ? (rand < 70? (rand < 50 ? (rand < 30 ? (rand < 10 ? 5 : 4) : 3) : 2) : 1) : 0;
            // grab damage dealt by performing move multiple times
            for ( var i : int = 0; i != 5+times; ++ i )
                info[0] += R_Base_Move(att, def, new Move(1, Move(info[4]).Move_Stage, type))[0];
            if ( rand < 10 ) {
                def.Bind_Damage_Per_Turn(3,2 + .2 * att.R_Level() * (att.R_Spec_Att() / def.R_Spec_Att()),
                                         Move_Info.Effect_Normal);
                Screen.special_fight_effect = def.R_Name() + " has been bound";
            }
            if ( rand >= 90 ) {
                att.Bind_Damage_Per_Turn(3, 2 + .2 * att.R_Level() * (att.R_Spec_Att() / def.R_Spec_Att()),
                                         Move_Info.Effect_Normal);
                Screen.special_fight_effect = att.R_Name() + " has been bound";
            }
            info[0] = Math.floor(info[0] / 4);
            return info;
        }
                    
        private static function Double_Edge(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            // 40% damage to self
            info[1] = Math.floor(Number(info[0]) * -.30);
            info[1] = Math.floor(info[1]);
            Screen.special_fight_effect = att.R_Name() + " inflicted " + -1*info[1] + " damage on self";
            return info;
        } 
        private static function Masochistic_Fury(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            // 70% damage to self
            info[1] = Math.floor(Number(info[0]) * -.70);
            info[1] = Math.floor(info[1]);
            Screen.special_fight_effect = att.R_Name() + " inflicted " + -1*info[1] + " damage on self";
            return info;
        }
                    
        private static function Boiling_Spit(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            if ( def.Mod_Defense( -1+att.R_Level()/5) != 0 )
                Screen.Text_Move_Results.push(def.R_Name() + "'s defense has slightly decreased");
            else
                Screen.Text_Move_Results.push(att.R_Name() + "'s boiling spit has no effect");
            return info;
        } 
        private static function Lava_Smeer(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            if ( def.Mod_Defense( -3+att.R_Level()/5) != 0 )
                Screen.Text_Move_Results.push(def.R_Name() + "'s defense has decreased");
            else
                Screen.Text_Move_Results.push(att.R_Name() + "'s lava smeer has no effect");
            return info;
        }
                    
        private static function Enrichen(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            def.Add_Experience(def.R_Exp_To_Level() - def.R_Curr_Exp());
            return info;
        } 
        private static function Kick_To_The_Bozak(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            if ( def.R_Gender() == Base_Pokemon_Stats.Male )
                info[0] *= 2;
            else
                info[1] *= .5;
            return info;
        }
                    
        private static function Growl(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            if ( def.Mod_Attack( -1+att.R_Level()/5) != 0 )
                Screen.Text_Move_Results.push(def.R_Name() + "'s attack has slightly decreased");
            else
                Screen.Text_Move_Results.push(att.R_Name() + "'s growl has no effect");
            return info;
        } 
        private static function Roar(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            if ( def.Mod_Attack( -3+att.R_Level()/5) != 0 )
                Screen.Text_Move_Results.push(def.R_Name() + "'s attack has decreased");
            else
                Screen.Text_Move_Results.push(att.R_Name() + "'s roar has no effect");
            return info;
        }
                    
        private static function Meditate(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            if ( att.Mod_Attack( 3+att.R_Level()/5) != 0 )
                Screen.Text_Move_Results.push(att.R_Name() + "'s attack has increased");
            else
                Screen.Text_Move_Results.push(att.R_Name() + "'s meditate failed!");
            return info;
        }
                    
        private static function Harden(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            if ( att.Mod_Defense( 3+att.R_Level()/5) != 0 )
                Screen.Text_Move_Results.push(att.R_Name() + "'s defense has increased");
            else
                Screen.Text_Move_Results.push(att.R_Name() + "'s meditate failed!");
            return info;
        }
                    
        private static function Rest(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array { // no longer a thing
            var x:int = Screen.Random_Range(Math.floor(Number(att.R_Max_Health) * .05),
                                            Math.floor(Number(att.R_Max_Health) * .25));
            if ( x > (20 * (def.R_Is_Enemy()?Level_Stage.Stage_Enemy_Mult[Move(info[4]).Move_Stage]:
                                   Level_Stage.Stage_Player_Mult[Move(info[4]).Move_Stage])) ) // max health recoverable
                x = 20 * (def.R_Is_Enemy()?Level_Stage.Stage_Enemy_Mult[Move(info[4]).Move_Stage]:
                                   Level_Stage.Stage_Player_Mult[Move(info[4]).Move_Stage]);
            info[1] = x;
            Screen.special_fight_effect = att.R_Name() + " recovered " + info[1] + " health";
            return info;
        }
                    
        private static function Sing(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            def.Paralyze();
            Screen.special_fight_effect = att.R_Name() + " has been put to sleep!";
            return info;
        }
                    
        private static function Vampyric_Leach(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            info[1] = Math.floor(info[0] * .5);
            Screen.special_fight_effect = att.R_Name() + " leached " + info[1] + " health";
            return info;
        } 
        private static function Vampyric_Drain(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            info[1] = Math.floor(info[0] * .8);
            Screen.special_fight_effect = att.R_Name() + " leached " + info[1] + " health";
            return info;
        }
                    
        private static function Quicksand_Beam(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            if ( def.Mod_Speed( -1+att.R_Level()/5) != 0 )
                Screen.Text_Move_Results.push(def.R_Name() + "'s speed has slightly decreased");
            else
                Screen.Text_Move_Results.push(att.R_Name() + "'s quicksand beam has no effect");
            return info;
        } 
        private static function Soften_Ground(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            if ( def.Mod_Speed( -3+att.R_Level()/5) != 0 )
                Screen.Text_Move_Results.push(att.R_Name() + "'s speed has decreased");
            else
                Screen.Text_Move_Results.push(att.R_Name() + "'s soften ground has no effect");
            return info;
        } // slow speed
                    
        private static function Copy(att:Base_Pokemon, def:Base_Pokemon, info:Array ):Array {
            // execute opponent's last move
            //var mov:int = def.R_Last_Move();
            //return Call_Move(att, def, new Move(mov, 1, 0), R_Base_Move(att, def, new Move(mov, 1, 0)));
            var arr : Array = [0];
            return arr;
        }
    }
}