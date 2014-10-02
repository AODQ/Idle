package src {

            /*  Stat	Vitamin
                HP	HP Up
                Attack	Protein
                Defense	Iron
                Special Attack	Calcium
                Special Defense	Zinc
                Speed	Carbos */
    public class Item {
        
        public static const Item_Type_Apply_Pokemon:int = 0,
                            Item_Type_Apply_Global:int = 1;
                            
                            
        private static const ITAP:int = Item_Type_Apply_Pokemon, 
                             ITAG:int = Item_Type_Apply_Global;
        public static const Item_Currency_Type_Standard:int = 0,
                             Item_Currency_Type_Special:int  = 1;
        private static const ICTSt:int = Item_Currency_Type_Standard,
                             ICTSp:int = Item_Currency_Type_Special;
        
        public static const Modifier_Start:int = 59;
        /*
        *         [Embed("../Images/Item_Potion.png")]private var Img_Item_0:Class;
        [Embed("../Images/Item_Super_Potion.png")]private var Img_Item_1:Class;
        [Embed("../Images/Item_Hyper_Potion.png")]private var Img_Item_2:Class;
        [Embed("../Images/Item_Max_Potion.png")]private var Img_Item_3:Class;
        [Embed("../Images/Item_RAM_Upgrade.png")]private var Img_Item_4:Class;
        [Embed("../Images/Item_Attack_Software_Update.png")]private var Img_Item_5:Class;
        [Embed("../Images/Item_Processor_Update.png")]private var Img_Item_6:Class;
        [Embed("../Images/Item_Defense_Software_Update.png")]private var Img_Item_7:Class;
        [Embed("../Images/Item_Defense_Hardware_Update.png")]private var Img_Item_8:Class;
        [Embed("../Images/Item_Language_Update.png")]private var Img_Item_9:Class;
        [Embed("../Images/Item_Revive.png")]private var Img_Item_10:Class;
        [Embed("../Images/Item_Max_Revive.png")]private var Img_Item_11:Class;
        [Embed("../Images/Item_X_Attack.png")]private var Img_Item_12:Class;
        [Embed("../Images/Item_X_Defense.png")]private var Img_Item_13:Class;
        [Embed("../Images/Item_X_Sp_Attack.png")]private var Img_Item_14:Class;
        [Embed("../Images/Item_X_Sp_Defeense.png")]private var Img_Item_15:Class;
        [Embed("../Images/Item_X_Speed.png")]private var Img_Item_16:Class;
        [Embed("../Images/Item_X_Accuracy.png")]private var Img_Item_17:Class;
        [Embed("../Images/Item_TM_ALL.png")]private var Img_Item_18:Class;
        [Embed("../Images/Item_Welder_Modifier.png")]private var Img_Item_19:Class;
        [Embed("../Images/Item_CQB_Modifier.png")]private var Img_Item_20:Class;
        [Embed("../Images/Item_Animal_Modifier.png")]private var Img_Item_21:Class;
        [Embed("../Images/Item_Hydraulic_Modifier.png")]private var Img_Item_22:Class;
        [Embed("../Images/Item_Radiation_Modifier.png")]private var Img_Item_23:Class;
        [Embed("../Images/Item_Heavy_Modifier.png")]private var Img_Item_24:Class;
        [Embed("../Images/Item_Plasma_Modifier.png")]private var Img_Item_25:Class;
        [Embed("../Images/Item_Archaic_Modifier.png")]private var Img_Item_26:Class;
        [Embed("../Images/Item_Ghost_Modifier.png")]private var Img_Item_27:Class;
        [Embed("../Images/Item_Solar_Modifier.png")]private var Img_Item_28:Class;
        [Embed("../Images/Item_Hover_Modifier.png")]private var Img_Item_29:Class;
        [Embed("../Images/Item_Mechanical_Modifier.png")]private var Img_Item_30:Class;
        [Embed("../Images/Item_Freezer_Modifier.png")]private var Img_Item_31:Class;
        [Embed("../Images/Item_Hack_Modifier.png")]private var Img_Item_32:Class;
        [Embed("../Images/Item_Retro_Modifier.png")]private var Img_Item_33:Class;
        [Embed("../Images/Item_Steel_Modifier.png")]private var Img_Item_34:Class;
        [Embed("../Images/Item_Android_Modifier.png")]private var Img_Item_35:Class;
        */
        /*
        *             "Pound", "Kick", "Bite", "Blast",
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
            */
        public static const Item_Name:Array = [
        
                                        "Potion", "Super Potion", "Hyper Potion", "Max Potion",
                                        "RAM Up", "Attack Software Up", "Processor Up",
                                        "Defense Software Up", "Defense Hardware Up", "Language Up",
                                        "Revive", "Max Revive",
                                        "Botomon Poison", "Merger", "Triple Experience", "Reroll Stats",
                                        "Sexy Pill", "Botomon Pollen",
                                        "TM Pound", "TM Kick", "TM Bite", "TM Blast", "TM Flame Breath",
                                        "TM Flame Thrower", "TM Flame Kick", "TM Flame Fury",
                                        "TM Ice Breath", "TM Freezer", "TM Ice Kick", "TM Ice Fury",
                                        "TM Poison Needle", "TM Poison Slam", "TM Poison Bite", "TM Poison Gas",
                                        "TM Paralyze", "TM Burn", "TM Bind", "TM Multi Bind", "TM Sand Blind", "TM Needle Blind",
                                        "TM Multi Hit", "TM Multi Kick",
                                        "TM Ins. Punches", "TM Double Edge", "TM Masoch Fury", "TM Boiling Spit", "TM Lava Smeer",
                                        "TM Enrichen", "TM Kick To Bozak", "TM Growl",
                                        "TM Roar", "TM Meditate", "TM Harden", "TM Sing", "TM Vampyric Drain",
                                        "TM Vampyric Leech", "TM Quicksand Beam",
                                        "TM Soften Ground", "TM Rock Storm",
                                        // modifiers
                                        "Welder Modifier", "Hydraulic Modifier", "Plasma Modifier", "Solar Modifier",
                                        "Freezer Modifier", "CQB Modifier", "Radiation Modifier",
                                        "Archaic Modifier", "Hover Modifier", "Hack Modifier", "Animal Modifier",
                                        "Heavy Modifier", "Ghost Modifier", "Mechanical Modifier", "Retro Modifier",
                                        "Steel Modifier", "Android Modifier",
                                        /*Normal, Welder,  Hydraulic, Plasma,  Solar,  freezer, CQB,     Radiation,  Archaic, 
                                         Hover, Hack,     Animal, Heavy,Ghost, Mechanical, Retro, Steel, Android
                                        */
                                        // 10 crystals per 10 levels
                                        "Soul Crystal Hex", // use them on enemy (they drop by enemies as well)
                                        "Charged Mini Crystal", "Charged Dull Crystal", "Charged Dim Crystal",
                                        "Charged Normal Crystal", "Charged Glowing Crystal", "Charged Heavy Crystal",
                                        "Charged Bright Crystal", "Charged Neon Crystal", "Charged Godly Crystal",
                                        "Charged Herclodian Crystal",
                                        "Charged Legendary Crystal"
                                    ],
                            Item_Cost:Array = [
                                        200, 400, 800, 1000,
                                        100, 75, 50,
                                        75, 50, 100,
                                        300, 1000,
                                        10000, 400000000 , 125000, 4000000,
                                        150000,
                                        15000, 1500, 1500, 1500, 1500, 1500, 1500, 1500,
                                        1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500,
                                        1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500,
                                        1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500,
                                        1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500, 1500,
                                        15, 15, 15, 15,
                                        15, 15, 15,
                                        15, 15, 15, 15,
                                        15, 15, 15, 15,
                                        15, 15,
                                        0,
                                        300, 400, 600,
                                        1200, 2500, 6000,
                                        13000, 30000, 60000, 10000000,
                                        100000
                                              ],
                            Item_Cost_Type:Array = [
                                        ICTSt, ICTSt, ICTSt, ICTSt,
                                        ICTSp, ICTSp, ICTSp,
                                        ICTSp, ICTSp, ICTSp,
                                        ICTSt, ICTSt,
                                        ICTSt, ICTSt, ICTSt, ICTSt,
                                        ICTSt, ICTSt,
                                        ICTSt, ICTSt, ICTSt, ICTSt, ICTSt, ICTSt, ICTSt, ICTSt,
                                        ICTSt, ICTSt, ICTSt, ICTSt, ICTSt, ICTSt, ICTSt, ICTSt,
                                        ICTSt, ICTSt, ICTSt, ICTSt, ICTSt, ICTSt, ICTSt, ICTSt,
                                        ICTSt, ICTSt, ICTSt, ICTSt, ICTSt, ICTSt, ICTSt, ICTSt,
                                        ICTSt, ICTSt, ICTSt, ICTSt, ICTSt, ICTSt, ICTSt, ICTSt, ICTSt,
                                        ICTSp, ICTSp, ICTSp, ICTSp,
                                        ICTSp, ICTSp, ICTSp,
                                        ICTSp, ICTSp, ICTSp, ICTSp,
                                        ICTSp, ICTSp, ICTSp, ICTSp,
                                        ICTSp, ICTSp,
                                        ICTSt, // hex
                                        ICTSt, ICTSt, ICTSt,
                                        ICTSt, ICTSt, ICTSt,
                                        ICTSt, ICTSt, ICTSt, ICTSt,
                                        ICTSt
                                                   ],
                            Item_In_Store:Array = [
                                1, 1, 1, 1,
                                1, 1, 1,
                                1, 1, 1,
                                1, 1,
                                1, 1, 1, 1,
                                1, 1,
                                1, 1, 1, 1, 1, 1, 1, 1,
                                1, 1, 1, 1, 1, 1, 1, 1,
                                1, 1, 1, 1, 1, 1, 1, 1,
                                1, 1, 1, 1, 1, 1, 1, 1,
                                1, 1, 1, 1, 1, 1, 1,
                                1, 1,
                                0, 0, 0, 0,
                                0, 0, 0,
                                0, 0, 0, 0,
                                0, 0, 0, 0,
                                0, 0,
                                0,
                                0, 0, 0,
                                0, 0, 0,
                                0, 0, 0, 0,
                                0
                            ],
                            Item_Is_Drop:Array = [ // item can be dropped by mobs
                                0, 0, 0, 0,
                                0, 0, 0,
                                0, 0, 0,
                                0, 0,
                                0, 0, 0, 0,
                                0, 0,
                                0, 0, 0, 0, 0, 0, 0, 0,
                                0, 0, 0, 0, 0, 0, 0, 0,
                                0, 0, 0, 0, 0, 0, 0, 0,
                                0, 0, 0, 0, 0, 0, 0, 0,
                                0, 0, 0, 0, 0, 0,
                                0, 0, 0, 0, 0, 0,
                                1, 1, 1, 1,
                                1, 1, 1,
                                1, 1, 1, 1,
                                1, 1, 1, 1,
                                1, 1,
                                1, // hex
                                0, 0, 0,
                                0, 0, 0,
                                0, 0, 0, 0,
                                0                                
                                                 ],
                            Item_Type:Array = [
                                        ITAP, ITAP, ITAP, ITAP,
                                        ITAP, ITAP, ITAP, ITAP, ITAP, ITAP,
                                        ITAP, ITAP,
                                        ITAP, ITAP, ITAP, ITAP,
                                        ITAP, ITAP,
                                        ITAP, ITAP, ITAP, ITAP, ITAP, ITAP, ITAP, ITAP, ITAP,
                                        ITAP, ITAP, ITAP, ITAP, ITAP, ITAP, ITAP, ITAP, ITAP,
                                        ITAP, ITAP, ITAP, ITAP, ITAP, ITAP, ITAP, ITAP, ITAP,
                                        ITAP, ITAP, ITAP, ITAP, ITAP, ITAP, ITAP, ITAP, ITAP,
                                        ITAP, ITAP, ITAP, ITAP, ITAP, ITAP, ITAP,
                                        ITAP, ITAP, ITAP, ITAP, ITAP, ITAP,
                                        ITAP,
                                        ITAP, ITAP, ITAP,
                                        ITAP, ITAP, ITAP,
                                        ITAP, ITAP, ITAP,
                                        ITAP
                                              ],
                            Item_Description:Array = [
                                        "Slightly recovers health", "Normally recovers health", "Greatly recovers health", "Majorly recovers health",
                                        "Permanently increases health", "Permanently increases attack", "Permanently increases spec attack",
                                        "Permanently increases defense", "Permanently increases spec defense", "Permanently increase speed",
                                        "Resurrects at low health", "Resurrects at high health",
                                        "Prevents enemies to spawn", "Merge two botomon into one", "Triple XP for awhile", "Rerolls Stats",
                                        "Forces breeding of other species", "Summons all enemy botomon",
                                        "High acc, low dmg att", "Medium acc, medium dmg att", "Low accuracy, high dmg att", "Very low acc, very high dmg att",
                                        "High acc, low burn dmg att", "Medium acc, medium burn dmg att", "Low acc, high burn dmg att", "Very low acc, very high burn dmg att",
                                        "High acc, low freeze dmg att", "Medium acc, medium freeze dmg att", "Low acc, high freeze dmg att", "Very low acc, very high freeze dmg att",
                                        "High acc, low poison dmg att", "Medium acc, medium poison dmg att", "Low acc, high poison dmg att", "Very low acc, very high poison dmg att",
                                        "Chance to paralyze opponent",
                                        "Chance to burn opponent, no dmg",
                                        "Chance to bind damage on opponent", "Chance to bind and paralyze opponent",
                                        "Chance to decrease opponent's spec att", "Chance to decrease opponent's spec def",
                                        "Low multiple high-dmg strikes", "Large multiple low-dmg strikes", "Immense multiple very low-dmg strikes",
                                        "Dmg is dealt to self and opp", "Greater dmg to self and opp",
                                        "Chance to decrease opponent's def", "High chance to decrease opponent's def",
                                        "Increases enemy's stats",
                                        "Double dmg to males, half to females",
                                        "Chance to decrease opponent's att", "High chance to decrease opponent's att",
                                        "Increase self's att",
                                        "Increase self's def",
                                        "Chance to put opponent to sleep",
                                        "Steal opp's health", "Steal large amt of opp's health",
                                        "High chance to decrease enemy speed", "Low chance to greatly decrease enemy speed",
                                        "att with low chance to bind opponent or self",
                                        "Modifies a move to Welder", "Modifies a move to Hydraulic", "Modifies a move to Plasma", "Modifies a move to Solar",
                                        "Modifies a move to Freezer", "Modifies a move to CQB", "Modifies a move to Radiation",
                                        "Modifies a move to Archaic", "Modifies a move to Hover", "Modifies a move to Hack", "Modifies a move to Animal",
                                        "Modifies a move to Heavy", "Modifies a move to Ghost", "Modifies a move to Mechanical", "Modifies a move to Retro",
                                        "Modifies a move to Steel", "Modifies a move to Android",
                                        
                                        "Applies hex on all current enemy botomon",
                                        "A shard of experience",
                                        "A shard of experience",
                                        "A shard of experience",
                                        "A shard of experience",
                                        "A shard of experience",
                                        "A shard of experience",
                                        "A shard of experience",
                                        "A shard of experience",
                                        "A shard of experience",
                                        "An extremely rare shard",
                                        "A shard of experience"
                                              ];
        
        private var   item_type:int,
                      item_stage:int;
        public function Item( item_typee:int = 0, item_stagee:int = 0 ):void {
            item_type = item_typee;
            item_stage = item_stagee;
        }
        
        public function Export():Item_Loader {
            var x:Item_Loader = new Item_Loader();
            x.item_stage = item_stage;
            x.item_type = item_type;
            return x;
        }
        public function R_Item_Type():int { return item_type; }
        public function R_Item_Stage():int { return item_stage; }
        public function Reset_Item_Stage() {
            item_stage = 0;
        }
        public static function Perform_Item(item:Item, pok:Base_Pokemon):Boolean {
            if ( pok.R_Item_Timer_Good() ) return 0;
            var cur_slot:int;
            for ( cur_slot = 0; cur_slot != 4; ++ cur_slot )
                if ( pok == Screen.poke_player[cur_slot] ) break;
            pok.Item_Timer_Reset((Screen.poke_enemy[cur_slot] != null));
            
            switch ( Item.Item_Name[item.R_Item_Type()] ) {
                case "Potion":
                    if ( !pok.R_Is_Dead() )
                        pok.Set_Health( pok.R_Curr_Health() + 20 * (item.R_Item_Stage() + 1));
                    else
                        return false;
                break;
                case "Super Potion":
                    if (!pok.R_Is_Dead() )
                        pok.Set_Health( pok.R_Curr_Health() + 70 * (item.R_Item_Stage() + 1));
                    else
                        return false;
                break;
                case "Hyper Potion":
                    if ( !pok.R_Is_Dead() )
                        pok.Set_Health( pok.R_Curr_Health() +  150 * (item.R_Item_Stage() + 1));
                    else
                        return false;
                break;
                case "Max Potion":
                    if ( !pok.R_Is_Dead() )
                        pok.Set_Health( pok.R_Curr_Health() + 300 * (item.R_Item_Stage() + 1));
                    else
                        return false;
                break;//
                case "RAM Up":
                    if ( pok.R_Stage() != item.R_Item_Stage() ) {
                        Screen.Text_Store_Results.push("Item and Botomon stage have to match!");
                        return false;
                    }
                    var zz:Boolean = pok.Add_Health_EV();
                    if ( !zz )
                        Screen.Text_Store_Results.push("Botomons can only allocate two EV per level");
                    pok.Refresh_Static_Stats();
                    if ( !zz )
                        pok.Clear_Item_Timer();
                    return zz;
                break;
                case "Attack Software Up":
                    if ( pok.R_Stage() != item.R_Item_Stage() ) {
                        Screen.Text_Store_Results.push("Item and Botomon stage have to match!");
                        return false;
                    }
                    var zz:Boolean = pok.Add_Attack_EV();
                    if ( !zz )
                        Screen.Text_Store_Results.push("Botomons can only allocate two EV per level");
                    pok.Refresh_Static_Stats();
                    if ( !zz )
                        pok.Clear_Item_Timer();
                    return zz;
                break;
                case "Processor Up":
                    if ( pok.R_Stage() != item.R_Item_Stage() ) {
                        Screen.Text_Store_Results.push("Item and Botomon stage have to match!");
                        return false;
                    }
                    var zz:Boolean = pok.Add_Spec_Att_EV();
                    if ( !zz )
                        Screen.Text_Store_Results.push("Botomons can only allocate two EV per level");
                    pok.Refresh_Static_Stats();
                    if ( !zz )
                        pok.Clear_Item_Timer();
                    return zz;
                break;
                case "Defense Software Up":
                    if ( pok.R_Stage() != item.R_Item_Stage() ) {
                        Screen.Text_Store_Results.push("Item and Botomon stage have to match!");
                        return false;
                    }
                    var zz:Boolean = pok.Add_Defense_EV();
                    if ( !zz )
                        Screen.Text_Store_Results.push("Botomons can only allocate two EV per level");
                    pok.Refresh_Static_Stats();
                    if ( !zz )
                        pok.Clear_Item_Timer();
                    return zz;
                break;
                case "Defense Hardware Up":
                    if ( pok.R_Stage() != item.R_Item_Stage() ) {
                        Screen.Text_Store_Results.push("Item and Botomon stage have to match!");
                        return false;
                    }
                    var zz:Boolean = pok.Add_Spec_Def_EV();
                    if ( !zz )
                        Screen.Text_Store_Results.push("Botomons can only allocate two EV per level");
                    pok.Refresh_Static_Stats();
                    if ( !zz )
                        pok.Clear_Item_Timer();
                    return zz;
                break;
                case "Language Up":
                    if ( pok.R_Stage() != item.R_Item_Stage() ) {
                        Screen.Text_Store_Results.push("Item and Botomon stage have to match!");
                        return false;
                    }
                    var zz:Boolean = pok.Add_Speed_EV();
                    if ( !zz )
                        Screen.Text_Store_Results.push("Botomons can only allocate two EV per level");
                    pok.Refresh_Static_Stats();
                    if ( !zz )
                        pok.Clear_Item_Timer();
                    return zz;
                break;
                case "Revive":
                    if ( pok.R_Stage() != item.R_Item_Stage() ) {
                        Screen.Text_Store_Results.push("Item and Botomon stage have to match!");
                        return false;
                    }
                    if ( !Screen.fighting_final_boss ) {
                        if ( pok.R_Is_Dead() )
                            pok.Resurrect(20 * (item.R_Item_Stage() + 1));
                        else return false;
                        for ( var i : int = 0; i != 4; ++ i )
                            if ( Screen.poke_player[i] == i ) {
                                Screen.poke_player_new_enemy_timer[i] = 60;
                                break;
                            }
                    } else {
                        Screen.Text_Store_Results.push("Can not revive during boss fight!");
                        return false;
                    }
                break;
                case "Max Revive":
                    if ( pok.R_Stage() != item.R_Item_Stage() ) {
                        Screen.Text_Store_Results.push("Item and Botomon stage have to match!");
                        return false;
                    }
                    if ( !Screen.fighting_final_boss ) {
                        if ( pok.R_Is_Dead() )
                            pok.Resurrect(100 * (item.R_Item_Stage() + 1));
                        else return false;
                        for ( var i : int = 0; i != 4; ++ i )
                            if ( Screen.poke_player[i] == i ) {
                                Screen.poke_player_new_enemy_timer[i] = 60;
                                break;
                            }
                    } else {
                        Screen.Text_Store_Results.push("Can not revive during boss fight!");
                        return false;
                    }
                break;
                case "Botomon Poison":
                    for ( var i : int = 0; i != 4; ++ i ) {
                        Screen.poke_enemy[i] = null;
                        Screen.poke_player_new_enemy_timer[i] = 10000;
                    }
                break;
                case "Merger":
                    var bp1:Base_Pokemon = null;
                    var s1:int;
                    var bp2:Base_Pokemon = null;
                    var s2:int;
                    for ( var i : int = 0; i != 4; ++ i )
                        if ( Screen.poke_player[i] != null )
                            if ( bp1 == null ) {
                                bp1 = Screen.poke_player[i];
                                s1 = i;
                            }
                            else if ( bp2 == null ) {
                                bp2 = Screen.poke_player[i];
                                s2 = i;
                            }
                            else {
                                Screen.Text_Store_Results.push("Use item with only two botomon in field!");
                                pok.Clear_Item_Timer();
                                return false;
                            }
                            /*
                         12 10 13 13 14 13
                         11 10 14 13 14 13
                         */
                          
                    if ( bp1 == null || bp2 == null ) {
                        pok.Clear_Item_Timer();
                        Screen.Text_Store_Results.push("You need two botomon in field!");
                        return false;
                    }
                    if ( bp1.R_Stage() != bp2.R_Stage() ) {
                        Screen.Text_Store_Results.push("Both botomon's stages need to be the same!");
                        return false;
                    }
                    if ( bp1.R_Stage() > item.R_Item_Stage() ) {
                        Screen.Text_Store_Results.push("Bot's stage is too high for item!");
                        pok.Clear_Item_Timer();
                        return false;
                    }
                    var bpl:Base_Pokemon_Loader = bp1.Export_Information();
                    var bpl2:Base_Pokemon_Loader = bp2.Export_Information();
                    var base_attack:Number, base_defense:Number, base_health:Number,
                        base_spec_att:Number, base_spec_def:Number, base_speed:Number,
                        iv_attack:Number, iv_defense:Number, iv_health:Number, iv_spec_att:Number,
                        iv_spec_def:Number, iv_speed:Number;
                    
                    base_attack = bpl.base_attack*.7 + bpl.base_attack*.7;
                    base_defense = bpl.base_defense*.7 + bpl.base_defense*.7;
                    base_health = bpl.base_health*.7 + bpl.base_health*.7;

                    base_spec_att = bpl.base_spec_att*.7 + bpl.base_spec_att*.7;
                    base_spec_def = bpl.base_spec_def*.7 + bpl.base_spec_def*.7;
                    base_speed = bpl.base_speed*.7 + bpl.base_speed*.7;

                    iv_attack = bpl.iv_attack*.7 + bpl.iv_attack*.7;
                    iv_defense = bpl.iv_defense*.7 + bpl.iv_defense*.7;
                    iv_health = bpl.iv_health * .7 + bpl.iv_health * .7;
                    
                    iv_spec_att = bpl.iv_spec_att*.7 + bpl.iv_spec_att*.7;
                    iv_spec_def = bpl.iv_spec_def*.7 + bpl.iv_spec_def*.7;
                    iv_speed = bpl.iv_speed*.7 + bpl.iv_speed*.7;
                    
                    var new_pok:Base_Pokemon = new Base_Pokemon(Screen.Random_Range(0, Base_Pokemon_Stats.Poke_Name.length - 2), bpl.stage);
                    
                    new_pok.Import_Information(new_pok.R_Species_ID(), Base_Pokemon_Stats.Poke_Type_1[new_pok.R_Species_ID()],
                                                                       Base_Pokemon_Stats.Poke_Type_2[new_pok.R_Species_ID()],
                                               Screen.Random_Range(0, 1), 1, 51, 1, 1, 0,
                                               0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, iv_health, iv_attack, iv_defense,
                                               iv_spec_att, iv_spec_def, iv_speed, 0, 0, 0, 0, 0,
                                               0, 0, base_health, base_attack, base_defense, base_spec_att, base_spec_def,
                                               base_speed, "", bpl.stage, [ null, null, null ], 0, 0, [ 0, 0, 0, 0 ], [0, 0, 0, 0], [0, 0, 0, 0], 0, 0, 0, 0, 0);
                    Screen.Start_New_Botomon_Name(new_pok);
                    new_pok.Refresh_Static_Stats();
                    Screen.poke_player[s1] = null;
                    Screen.poke_player[s2] = null;
                break;
                case "Triple Experience":
                    if ( pok.R_Stage() > item.R_Item_Stage() ) {
                        Screen.Text_Store_Results.push("Bot's stage is too high for item!");
                        pok.Clear_Item_Timer();
                        return false;
                    }
                    Screen.triple_experience[cur_slot] = 5000;
                break;
                case "Reroll Stats":
                    if ( pok.R_Stage() > item.R_Item_Stage() ) {
                        Screen.Text_Store_Results.push("Bot's stage is too high for item!");
                        pok.Clear_Item_Timer();
                        return false;
                    }
                    pok.Reroll_Stats();
                break;
                case "Sexy Pill":
                    if ( Screen.breeding_pokemon[0] == null ) {
                        Screen.Text_Store_Results.push(Screen.session_time + ": Botomon need to be breeding!");
                        pok.Clear_Item_Timer();
                        return false;
                    }
                    if ( Base_Pokemon(Screen.breeding_pokemon[0]).R_Stage() > item.R_Item_Stage() ) {
                        Screen.Text_Store_Results.push(Screen.session_time + ": Sexy Pill's stage is too low!");
                        pok.Clear_Item_Timer();
                        return false;
                    }
                    Screen.breeding_force_new = true;
                break;
                case "Botomon Pollen":
                    if ( Area.R_Curr_Area_Stage() > item.R_Item_Stage() ) {
                        Screen.Text_Store_Results.push("Item's stage is too low for this area!");
                        pok.Clear_Item_Timer();
                        return false;
                    }
                    for ( var i : int = 0; i != 4; ++ i )
                        if ( Screen.poke_player[i] != null )
                            if ( !Base_Pokemon(Screen.poke_player[i]).R_Is_Dead() )
                                if ( Screen.poke_enemy[i] == null )
                                    Screen.poke_player_new_enemy_timer[i] = 5;
                break;                                        
                case "TM Pound": return pok.Learn_Move(new Move( 0,item.R_Item_Stage()));
                break;
                case "TM Kick": return pok.Learn_Move(new Move( 1,item.R_Item_Stage()));
                break;
                case "TM Bite": return pok.Learn_Move(new Move( 2,item.R_Item_Stage()));
                break;
                case "TM Blast": return pok.Learn_Move(new Move( 3,item.R_Item_Stage()));
                break;
                case "TM Flame Breath": return pok.Learn_Move(new Move( 4,item.R_Item_Stage()));
                break;
                case "TM Flame Thrower": return pok.Learn_Move(new Move( 5,item.R_Item_Stage()));
                break;
                case "TM Flame Kick": return pok.Learn_Move(new Move( 6,item.R_Item_Stage()));
                break;
                case "TM Flame Fury": return pok.Learn_Move(new Move( 7,item.R_Item_Stage()));
                break;
                case "TM Ice Breath": return pok.Learn_Move(new Move( 8,item.R_Item_Stage()));
                break;
                case "TM Freezer": return pok.Learn_Move(new Move( 9,item.R_Item_Stage()));
                break;
                case "TM Ice Kick": return pok.Learn_Move(new Move(10,item.R_Item_Stage()));
                break;
                case "TM Ice Fury": return pok.Learn_Move(new Move(11,item.R_Item_Stage()));
                break;
                case "TM Poison Needle": return pok.Learn_Move(new Move(12,item.R_Item_Stage()));
                break;
                case "TM Poison Slam": return pok.Learn_Move(new Move(13,item.R_Item_Stage()));
                break;
                case "TM Poison Bite": return pok.Learn_Move(new Move(14,item.R_Item_Stage()));
                break;
                case "TM Poison Gas": return pok.Learn_Move(new Move(15,item.R_Item_Stage()));
                break;
                case "TM Paralyze": return pok.Learn_Move(new Move(16,item.R_Item_Stage()));
                break;
                case "TM Burn": return pok.Learn_Move(new Move(17,item.R_Item_Stage()));
                break;
                case "TM Bind": return pok.Learn_Move(new Move(18,item.R_Item_Stage()));
                break;
                case "TM Multi Bind": return pok.Learn_Move(new Move(19,item.R_Item_Stage()));
                break;
                case "TM Sand Blind": return pok.Learn_Move(new Move(20,item.R_Item_Stage()));
                break;
                case "TM Needle Blind": return pok.Learn_Move(new Move(21,item.R_Item_Stage()));
                break;                
                case "TM Multi Hit": return pok.Learn_Move(new Move(22,item.R_Item_Stage()));
                break;
                case "TM Multi Kick": return pok.Learn_Move(new Move(23,item.R_Item_Stage()));
                break;
                case "TM Ins. Punches": return pok.Learn_Move(new Move(24,item.R_Item_Stage()));
                break;
                case "TM Double Edge": return pok.Learn_Move(new Move(25,item.R_Item_Stage()));
                break;
                case "TM Masoch Fury": return pok.Learn_Move(new Move(26,item.R_Item_Stage()));
                break;
                case "TM Boiling Spit": return pok.Learn_Move(new Move(27,item.R_Item_Stage()));
                break;
                case "TM Lava Smeer": return pok.Learn_Move(new Move(28,item.R_Item_Stage()));
                break;
                case "TM Enrichen": return pok.Learn_Move(new Move(29,item.R_Item_Stage()));
                break;
                case "TM Kick To Bozak": return pok.Learn_Move(new Move(30,item.R_Item_Stage()));
                break;
                case "TM Growl": return pok.Learn_Move(new Move(31,item.R_Item_Stage()));
                break;
                case "TM Roar": return pok.Learn_Move(new Move(32,item.R_Item_Stage()));
                break;
                case "TM Meditate": return pok.Learn_Move(new Move(33,item.R_Item_Stage()));
                break;
                case "TM Harden": return pok.Learn_Move(new Move(34,item.R_Item_Stage()));
                break;
                case "TM Sing": return pok.Learn_Move(new Move(35,item.R_Item_Stage()));
                break;
                case "TM Vampyric Leach": return pok.Learn_Move(new Move(36,item.R_Item_Stage()));
                break;
                case "TM Vampyric Drain": return pok.Learn_Move(new Move(37, item.R_Item_Stage()));
                break;
                case "TM Quicksand Beam": return pok.Learn_Move(new Move(38,item.R_Item_Stage()));
                break;
                case "TM Soften Ground": return pok.Learn_Move(new Move(39,item.R_Item_Stage()));
                break;
                case "TM Rock Storm": return pok.Learn_Move(new Move(40,item.R_Item_Stage()));
                break;
                case "Welder Modifier": case "Hydraulic Modifier": case "Plasma Modifier":
                case "Solar Modifier": case "Freezer Modifier": case "CQB Modifier":
                case "Radiation Modifier": case "Archaic Modifier": case "Hover Modifier":
                case "Hack Modifier": case "Animal Modifier": case "Heavy Modifier":
                case "Ghost Modifier": case "Mechanical Modifier": case "Retro Modifier":
                case "Steel Modifier": case "Android Modifier":
                    if ( item.R_Item_Stage() < pok.R_Stage() ) { // if the item is too low for the pokemon
                        Screen.Text_Store_Results.push("Item's stage is too low for the botomon!");
                        pok.Clear_Item_Timer();
                        return 0;
                    }
                    switch ( Item.Item_Name[item.R_Item_Type()] ) {
                        case "Welder Modifier": return pok.Apply_Modifier(Base_Pokemon_Stats.Type_Welder);
                        break;
                        case "Hydraulic Modifier": return pok.Apply_Modifier(Base_Pokemon_Stats.Type_Hydraulic);
                        break;
                        case "Plasma Modifier": return pok.Apply_Modifier(Base_Pokemon_Stats.Type_Plasma);
                        break;
                        case "Solar Modifier": return pok.Apply_Modifier(Base_Pokemon_Stats.Type_Solar);
                        break;
                        case "Freezer Modifier": return pok.Apply_Modifier(Base_Pokemon_Stats.Type_Freezer);
                        break;
                        case "CQB Modifier": return pok.Apply_Modifier(Base_Pokemon_Stats.Type_CQB);
                        break;
                        case "Radiation Modifier": return pok.Apply_Modifier(Base_Pokemon_Stats.Type_Radiation);
                        break;
                        case "Archaic Modifier": return pok.Apply_Modifier(Base_Pokemon_Stats.Type_Archaic);
                        break;
                        case "Hover Modifier": return pok.Apply_Modifier(Base_Pokemon_Stats.Type_Hover);
                        break;
                        case "Hack Modifier": return pok.Apply_Modifier(Base_Pokemon_Stats.Type_Hack);
                        break;
                        case "Animal Modifier": return pok.Apply_Modifier(Base_Pokemon_Stats.Type_Animal);
                        break;
                        case "Heavy Modifier": return pok.Apply_Modifier(Base_Pokemon_Stats.Type_Heavy);
                        break;
                        case "Ghost Modifier": return pok.Apply_Modifier(Base_Pokemon_Stats.Type_Ghost);
                        break;
                        case "Mechanical Modifier": return pok.Apply_Modifier(Base_Pokemon_Stats.Type_Mechanical);
                        break;
                        case "Retro Modifier":return pok.Apply_Modifier(Base_Pokemon_Stats.Type_Retro);
                        break;
                        case "Steel Modifier": return pok.Apply_Modifier(Base_Pokemon_Stats.Type_Steel);
                        break;
                        case "Android Modifier": return pok.Apply_Modifier(Base_Pokemon_Stats.Type_Android);
                        break;
                    }
                break;
                case "Soul Crystal Hex":
                    for ( var i : int = 0; i != 4; ++ i )
                        if ( Screen.poke_enemy[i] != null && (Screen.poke_enemy[i] as Base_Pokemon).R_Stage() <=
                                                             item.item_stage )
                        {
                            (Screen.poke_enemy[i] as Base_Pokemon).Hex();
                        }
                break;
                case "Charged Mini Crystal":
                    pok.Add_Experience(200 * Level_Stage.Stage_Player_Mult[item.item_stage]);
                    Screen.Text_Store_Results.push(pok.R_Name() + " has gained " + (200 * Level_Stage.Stage_Player_Mult[item.item_stage]) + " XP!");
                break;
                case "Charged Tiny Crystal":
                    pok.Add_Experience(400 * Level_Stage.Stage_Player_Mult[item.item_stage]); 
                    Screen.Text_Store_Results.push(pok.R_Name() + " has gained " + (400 * Level_Stage.Stage_Player_Mult[item.item_stage]) + " XP!");
                break;
                case "Charged Small Crystal":
                    pok.Add_Experience(700 * Level_Stage.Stage_Player_Mult[item.item_stage]); 
                    Screen.Text_Store_Results.push(pok.R_Name() + " has gained " + (700 * Level_Stage.Stage_Player_Mult[item.item_stage]) + " XP!");
                break;
                case "Charged Normal Crystal":
                    pok.Add_Experience(1200*5 * Level_Stage.Stage_Player_Mult[item.item_stage]); 
                    Screen.Text_Store_Results.push(pok.R_Name() + " has gained " + (1200 * Level_Stage.Stage_Player_Mult[item.item_stage]) + " XP!");
                break;
                case "Charged Large Crystal":
                    pok.Add_Experience(2500 * Level_Stage.Stage_Player_Mult[item.item_stage]); 
                    Screen.Text_Store_Results.push(pok.R_Name() + " has gained " + (2500 * Level_Stage.Stage_Player_Mult[item.item_stage]) + " XP!");
                break;
                case "Charged Heavy Crystal":
                    pok.Add_Experience(5000 * Level_Stage.Stage_Player_Mult[item.item_stage]); 
                    Screen.Text_Store_Results.push(pok.R_Name() + " has gained " + (5000 * Level_Stage.Stage_Player_Mult[item.item_stage]) + " XP!");
                break;
                case "Charged Enormous Crystal":
                    pok.Add_Experience(12000 * Level_Stage.Stage_Player_Mult[item.item_stage]); 
                    Screen.Text_Store_Results.push(pok.R_Name() + " has gained " + (12000 * Level_Stage.Stage_Player_Mult[item.item_stage]) + " XP!");
                break;
                case "Charged Massive Crystal":
                    pok.Add_Experience(4000 * Level_Stage.Stage_Player_Mult[item.item_stage]); 
                    Screen.Text_Store_Results.push(pok.R_Name() + " has gained " + (4000 * Level_Stage.Stage_Player_Mult[item.item_stage]) + " XP!");
                break;
                case "Charged Godly Crystal":
                    pok.Add_Experience(12000*5 * Level_Stage.Stage_Player_Mult[item.item_stage]); 
                    Screen.Text_Store_Results.push(pok.R_Name() + " has gained " + (12000*5 * Level_Stage.Stage_Player_Mult[item.item_stage]) + " XP!");
                break;
                case "Charged Bright Crystal":
                    pok.Add_Experience(10000*5 * Level_Stage.Stage_Player_Mult[item.item_stage]); 
                    Screen.Text_Store_Results.push(pok.R_Name() + " has gained " + (10000*5 * Level_Stage.Stage_Player_Mult[item.item_stage]) + " XP!");
                break;
                case "Charged Dim Crystal":
                    pok.Add_Experience(800*5 * Level_Stage.Stage_Player_Mult[item.item_stage]); 
                    Screen.Text_Store_Results.push(pok.R_Name() + " has gained " + (800*5 * Level_Stage.Stage_Player_Mult[item.item_stage]) + " XP!");
                break;
                case "Charged Glowing Crystal":
                    pok.Add_Experience(4000*5 * Level_Stage.Stage_Player_Mult[item.item_stage]); 
                    Screen.Text_Store_Results.push(pok.R_Name() + " has gained " + (4000*5 * Level_Stage.Stage_Player_Mult[item.item_stage]) + " XP!");
                break;
                case "Charged Neon Crystal":
                    pok.Add_Experience(8000*5 * Level_Stage.Stage_Player_Mult[item.item_stage]); 
                    Screen.Text_Store_Results.push(pok.R_Name() + " has gained " + (8000*5 * Level_Stage.Stage_Player_Mult[item.item_stage]) + " XP!");
                break;
                case "Charged Legendary Crystal":
                    pok.Add_Experience(20000*5 * Level_Stage.Stage_Player_Mult[item.item_stage]); 
                    Screen.Text_Store_Results.push(pok.R_Name() + " has gained " + (20000*5 * Level_Stage.Stage_Player_Mult[item.item_stage]) + " XP!");
                break;
                case "Charged Herclodian Crystal":
                    pok.Add_Experience(1600000 * Level_Stage.Stage_Enemy_Mult[item.item_stage]);
                    Screen.Text_Store_Results.push(pok.R_Name() + " has gained " + (1600000 * Level_Stage.Stage_Enemy_Mult[item.item_stage]) + " XP!");
                break;
                case "Charged Dull Crystal":
                    pok.Add_Experience(45 * Level_Stage.Stage_Enemy_Mult[item.item_stage]);
                    Screen.Text_Store_Results.push(pok.R_Name() + " has gained " + (45 * Level_Stage.Stage_Enemy_Mult[item.item_stage]) + " XP!");
                break;
                default:
                    // some error occurred
                    trace("Item ID not found");
                    return 0;
            }
            return 1;
        }
    }
}