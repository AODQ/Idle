package src {
    public class Area {
        private static const Normal:int = Base_Pokemon_Stats.Type_Normal,
                             Welder:int = Base_Pokemon_Stats.Type_Welder,
                             Hydraulic:int = Base_Pokemon_Stats.Type_Hydraulic,
                             Plasma:int = Base_Pokemon_Stats.Type_Plasma,
                             Solar:int = Base_Pokemon_Stats.Type_Solar,
                             Freezer:int = Base_Pokemon_Stats.Type_Freezer,
                             CQB:int = Base_Pokemon_Stats.Type_CQB,
                             Radiation:int = Base_Pokemon_Stats.Type_Radiation,
                             Archaic:int = Base_Pokemon_Stats.Type_Archaic,
                             Hover:int = Base_Pokemon_Stats.Type_Hover,
                             Hack:int = Base_Pokemon_Stats.Type_Hack,
                             Animal:int = Base_Pokemon_Stats.Type_Animal,
                             Heavy:int = Base_Pokemon_Stats.Type_Heavy,
                             Ghost:int = Base_Pokemon_Stats.Type_Ghost,
                             Mechanical:int = Base_Pokemon_Stats.Type_Mechanical,
                             Retro:int = Base_Pokemon_Stats.Type_Retro,
                             Steel:int = Base_Pokemon_Stats.Type_Steel,
                             Android:int = Base_Pokemon_Stats.Type_Android;
        public static const Pokemon_Type:Array = [
            [ Normal, Welder, Hydraulic, ],
            [ Mechanical, Steel, Freezer ],
            [ Hover, Hydraulic, CQB ],
            [ Heavy, Archaic, Retro, Steel ],
            [ Android, Hack, Welder ],
            [ Ghost, Radiation, Plasma ],
            [ CQB, Welder, Animal ],
            [ Heavy, Archaic, Hover ],
            [ Hydraulic, Normal, Animal ],
            [ Normal, Welder, Hydraulic, Plasma, Solar,
              Freezer, CQB, Radiation, Archaic, Hover,
              Hack, Animal, Heavy, Ghost, Mechanical, Retro, Steel,
              Android
            ]
        ];
        public static const Area_Description:Array = [
            "The fields have an intense spark of light reflection with young botomons",
            "A terrible factory filled with radioactive machinery.",
            "Suspended in mid-air, it's legend that this state was obtained when \nmultiple humans were \nslaughtered mercilessly by bots. It now floats on their souls. ",
            "A filthy slum full of the worst botomon hipsters",
            "A grand, opaque place full of pondering thoughts",
            "No one remembers the name of these hills; the death and destruction caused an area full of ruined bots",
            "The streets contain shady figures and bots; vaporised human shadows coat the wall. Several botomon\nparts and gears pave the street forming several abandoned towering homes\nand buildings",
            "A massive field were many heavy botomon live. The weather is cool; the landscape suggests otherwise.\nMuch of the grass has died as a result of the inhabitants",
            "A nightmare to all who enter; many mazes and puzzles lead to nowhere but confusion.",
            "A large area were the best of the best come to beat each other up"
        ];
        public static const Area_Name:Array = [
            "Green Grass fields of the Kenhik",
            "Dire Mechanical Factory",
            "Floating Island of Misery",
            "Underground Tunnelways",
            "Thinker's Haven",
            "Burnt Hills",
            "Decimated Metropolis",
            "Field of Giants",
            "Water Temple",
            "Grand Temple of Botomon Kicking"
        ];
        public static const Area_Level:Array = [
            [1, 10],  [10, 20], [20, 30], [30, 40],
            [40, 50], [50, 60], [60, 70], [70, 80],
            [80, 90], [90, 100]
        ];
        public static var Area_Stage:Array = [
            1, 1, 1, 1, 1, 1, 1, 1, 1, 1
        ];
        public static const Amt_Of_Base_Stages:int = 10;
        
        // Bot_Ord_Types is a two dimensional array. First element is type, second array contains elements of pokemon ID
        private static var Bot_Ord_Types:Array = new Array();
        
        
        public static function Set_Up_Area():void {
            // pre-setup
            trace("Setting up area");
            // set up by type
            for ( var i : int = 0; i != Base_Pokemon_Stats.Type_None; ++ i )
                Bot_Ord_Types.push(new Array); // type
                                                                // -1 for the boss
            for ( var x : int = 0; x != Base_Pokemon_Stats.Poke_Name.length - 1; ++ x ) { // x acts as the ID
                (Bot_Ord_Types[int(Base_Pokemon_Stats.Poke_Type_1[x])] as Array).push(x);
                trace(Base_Pokemon_Stats.Poke_Type_1[x] + " = " + x + "{ " +
                    (Bot_Ord_Types[Base_Pokemon_Stats.Poke_Type_1[x]] as Array).length + " }");
                if ( Base_Pokemon_Stats.Poke_Type_2[x] != Base_Pokemon_Stats.Type_None ) {
                    (Bot_Ord_Types[Base_Pokemon_Stats.Poke_Type_2[x]] as Array).push(x);
                    trace("^ " + Base_Pokemon_Stats.Poke_Type_1[x] + " = " + x + "{ " +
                        (Bot_Ord_Types[Base_Pokemon_Stats.Poke_Type_1[x]] as Array).length + " }");
                }
            }
            
            for ( var t_it : int = 0; t_it != Bot_Ord_Types.length; ++ t_it ) {
                trace(t_it + " length: " + (Bot_Ord_Types[t_it] as Array).length + Base_Pokemon_Stats.R_Type_To_String(t_it));
                for ( var x : int = 0; x != (Bot_Ord_Types[t_it] as Array).length; ++ x )
                    trace(Base_Pokemon_Stats.Poke_Name[(Bot_Ord_Types[t_it] as Array)[x]]);
            }
        }
        
        public static function R_Curr_Area_Stage():int {
            return int(Number(Screen.R_Curr_Area()) / Number(Amt_Of_Base_Stages));
        }
        
        public static function Elem_Not_Exist(x:int, arr:Array):Boolean {
            for ( var i : int = 0; i != arr.length; ++ i )
                if ( arr[i] == x ) return 0;
            return 1;
        }
        
        public static function R_New_Botomon(x:int):Base_Pokemon {
            // compile a list of possible botomon choices
            x %= Amt_Of_Base_Stages;
            var poss_bots:Array = new Array();
            for ( var type_it : int = 0; type_it != (Pokemon_Type[x] as Array).length; ++ type_it ) { // it through botomon types
                // iterate through all botomon IDs using the pokemon_type as the reference to iterate
                for ( var bot_list : int = 0; bot_list != (Bot_Ord_Types[type_it] as Array).length; ++ bot_list ) {
                    poss_bots.push((Bot_Ord_Types[type_it] as Array)[bot_list]);
                }
                        
            }
            
            return new Base_Pokemon(poss_bots[Screen.Random_Range(0, poss_bots.length-2)], R_Curr_Area_Stage(), false,
                                    Screen.Random_Range((Area_Level[x] as Array)[0], (Area_Level[x] as Array)[1]), null);
        }
    }
}
//