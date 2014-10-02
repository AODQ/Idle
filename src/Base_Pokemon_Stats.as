package src {
    import flash.system.fscommand;
    public class Base_Pokemon_Stats {
        // TYPE INFORMATION
        public static const Type_Normal:int =  0,
                  Type_Fire:int             =  1,
                  Type_Water:int            =  2,
                  Type_Electric:int         =  3,
                  Type_Grass:int            =  4,
                  Type_Ice:int              =  5,
                  Type_Fighting:int         =  6,
                  Type_Poison:int           =  7,
                  Type_Ground:int           =  8,
                  Type_Flying:int           =  9,
                  Type_Psychic:int          = 10,
                  Type_Bug:int              = 11,
                  Type_Rock:int             = 12,
                  Type_Ghost:int            = 13,
                  Type_Dragon:int           = 14,
                  Type_Dark:int             = 15,
                  Type_Steel:int            = 16,
                  Type_Fairy:int            = 17,
                  Type_None:int             = 18;
                  
        public static const Type_Effect_None:int   = 0,
                    Type_Effect_Half:int           = 1,
                    Type_Effect_Norm:int           = 2,
                    Type_Effect_Doub:int           = 3;
        
        // convert the known type to float for multiplying
        public static function R_Float_Effect (x:int):Number {
            switch ( int ) {
                case 0: return 0.0;
                case 1: return 0.5;
                case 2: return 1.0;
                case 3: return 2.0;
                default: return 1.0;
            }
        }
        // short version to make the array below more readable/easy to edit
        private static const N:int = 0,
                             H:int = 1,
                             O:int = 2, // O for ordinary
                             D:int = 3;
        //                                     nor fir wat ele gra ice fig poi gro fly psy bug roc gho dra dar ste fai
        private static const
                      Normal_Comp   :Array = [ O,  O,  O,  O,  O,  O,  O,  O,  O,  O,  O,  O,  H,  H,  O,  O,  H,  O  ],
                      Fire_Comp     :Array = [ O,  H,  H,  O,  D,  D,  O,  O,  O,  O,  O,  D,  H,  O,  H,  O,  D,  O  ],
                      Water_Comp    :Array = [ O,  D,  H,  O,  H,  O,  O,  O,  D,  O,  O,  O,  D,  O,  O,  H,  O,  O  ],
                      Electric_Comp :Array = [ O,  O,  D,  H,  H,  O,  O,  O,  H,  D,  O,  O,  O,  O,  H,  O,  O,  O  ],
                      Grass_Comp    :Array = [ O,  H,  D,  O,  H,  O,  O,  H,  D,  H,  O,  H,  D,  O,  H,  H,  H,  O  ],
                      Ice_Comp      :Array = [ O,  H,  H,  O,  D,  H,  O,  O,  D,  D,  O,  O,  O,  O,  D,  O,  H,  O  ],
                      Fighting_Comp :Array = [ D,  O,  O,  O,  O,  D,  O,  H,  O,  H,  H,  H,  D,  H,  O,  D,  D,  H  ],
                      Poison_Comp   :Array = [ O,  O,  O,  O,  D,  O,  O,  H,  H,  O,  O,  O,  H,  H,  O,  O,  H,  D  ],
                      Ground_Comp   :Array = [ O,  D,  O,  D,  H,  O,  O,  D,  O,  H,  O,  H,  D,  O,  O,  O,  D,  O  ],
                      Flying_Comp   :Array = [ O,  O,  O,  H,  D,  O,  D,  O,  O,  O,  O,  D,  H,  O,  O,  O,  H,  O  ],
                      Psychic_Comp  :Array = [ O,  O,  O,  O,  O,  O,  D,  D,  O,  O,  H,  O,  O,  O,  O,  H,  H,  O  ],
                      Bug_Comp      :Array = [ O,  H,  O,  O,  D,  O,  H,  H,  O,  H,  D,  O,  O,  H,  O,  D,  H,  H  ],
                      Rock_Comp     :Array = [ O,  D,  O,  O,  O,  D,  H,  O,  H,  D,  O,  D,  O,  O,  O,  O,  H,  O  ],
                      Ghost_Comp    :Array = [ H,  O,  O,  O,  O,  O,  O,  O,  O,  O,  D,  O,  O,  D,  O,  H,  O,  O  ],
                      Dragon_Comp   :Array = [ O,  O,  O,  O,  O,  O,  O,  O,  O,  O,  O,  O,  O,  O,  D,  O,  H,  H  ],
                      Dark_Comp     :Array = [ O,  O,  O,  O,  O,  O,  H,  O,  O,  O,  D,  O,  O,  D,  O,  H,  O,  H  ],
                      Steel_Comp    :Array = [ O,  H,  H,  H,  O,  D,  O,  O,  O,  O,  O,  O,  D,  O,  O,  O,  H,  D  ],
                      Fairy_Comp    :Array = [ O,  H,  O,  O,  O,  O,  D,  H,  O,  O,  O,  O,  O,  O,  D,  D,  H,  O  ];
        public static const Comparers : Array = [ 
                                            Normal_Comp, Fire_Comp, Water_Comp, Electric_Comp, Grass_Comp, Ice_Comp,
                                            Fighting_Comp, Poison_Comp, Ground_Comp, Flying_Comp, Psychic_Comp,
                                            Bug_Comp, Rock_Comp, Ghost_Comp, Dragon_Comp, Dark_Comp, Steel_Comp,
                                            Fairy_Comp
                                          ];
        // compare two types and return the effect from first to second
        public static function Compare_Types (x:int, y:int):int {
            return Comparers[x][y];
        }
        // GENDER
        public static const Male:int   = 0,
                     Female:int = 1;
                     
                     
        public static const Poke_Name:Array = [
            "Rusty", "Summoned", "DeDoss", "Gantz", "Zero",
            "Lion's Roar", "Krannibal", "Injectoid", "Kooler",
            "G-48", "Pyramido", "Pistonium", "Illuminati",
            "Detective", //13
            "Discro", "Pestilence", "Disco Wolf", "Frost Bite", //17
            "Quad Rowter", "Duke", "Hydrophobia", "Morning Star",//21
            "Solid Snake", "Ballistic", "Brain Freeze", "Memories",//25
            "Clutcher", "Rain Dance", "ShusMonk", "Low Life",//29
            "Deceased", "Cinders", "Poseidon.0", "Ratabot",//33
            "Spindler", "Doc_Ted Cloud", "Hercludes"
        ];
        public static const Type_Welder:int = Type_Fire,
                            Type_Hydraulic:int = Type_Water,
                            Type_Plasma:int = Type_Electric,
                            Type_Solar:int = Type_Grass,
                            Type_Freezer:int = Type_Ice,
                            Type_CQB:int = Type_Fighting,
                            Type_Radiation:int = Type_Poison,
                            Type_Archaic:int = Type_Ground,
                            Type_Hover:int = Type_Flying,
                            Type_Hack:int = Type_Psychic,
                            Type_Animal:int = Type_Bug,
                            Type_Heavy:int = Type_Rock,
                            Type_Mechanical:int = Type_Dragon,
                            Type_Retro:int = Type_Dark,
                            Type_Android:int = Type_Fairy;
        /*  normal 4
            hack 4
            hover 4
            animal 4
            ghost 3
            heavy 4
            freezer 4
            hydraulic 4
            plasma 4
            mechanical 4
            steel 4
            welder 4
            archaic 4
            retro 4
            cqb 3
            solar 4
            radiation 4
            android 4
        */
        public static const Poke_Type_1:Array = [//26
            Type_Normal, Type_Hack, Type_Hack, Type_Hover, Type_Android,//4
            Type_Animal, Type_Ghost, Type_Heavy, Type_Freezer, Type_Heavy,//9
            Type_Hydraulic, Type_Plasma, Type_Mechanical, Type_Steel,//13
            Type_Welder, Type_Radiation, Type_Mechanical, Type_Freezer,//17
            Type_Hover, Type_Retro, Type_Hydraulic, Type_Welder, Type_Ghost,//22
            Type_Heavy, Type_Freezer, Type_Radiation, Type_Steel, Type_Radiation,//27
            Type_Solar, Type_Android, Type_Android, Type_Normal, Type_Hydraulic,//32
            Type_Normal, Type_Mechanical, Type_Plasma, Type_None // none is for boss (replaced in bossify)
        ];
        public static const Poke_Type_2:Array = [
            Type_Retro, Type_Ghost, Type_Retro, Type_Plasma, Type_CQB,//4
            Type_Steel, Type_Solar, Type_Radiation, Type_Plasma, Type_Mechanical,//9
            Type_Archaic, Type_Solar, Type_Archaic, Type_Normal, Type_Hover,//14
            Type_Archaic, Type_Animal, Type_Archaic, Type_Hack, Type_CQB,//19
            Type_Heavy, Type_Retro, Type_CQB, Type_Hover, Type_Hover,//24
            Type_Welder, Type_Mechanical, Type_Plasma, Type_Heavy, Type_Animal,//29
            Type_Welder, Type_Hack, Type_Plasma, Type_Animal, Type_Android,
            Type_Poison,
            Type_None
        ];
         // low life, poisoden, ratabot
        // useful functions
        
        public static function R_HP_Info(level:Number, iv:Number, base:Number, is_enemy:Boolean ):int {
            return Math.pow((8 + (15/iv)*(iv - 4)*6/11 + Math.pow(iv*(level-1),.8) + (15-iv)*(level*(15-iv)*.01) // IV
                            + Math.pow((base-60), Math.pow(level, .02))), 1.2 - ((100 - level/2) * .003)) *
                                (Screen.R_Curr_Area() == 0 && is_enemy?.5:1);
        }
        // use HP_Info if the stat is for Health
        public static function R_Stat_Info(level:Number, iv:Number, base:Number ):int {
            return (8 + (15/iv)*(iv - 4)*6/11 + Math.pow(iv*(level-1),.8) + (15-iv)*(level*(15-iv)*.01) // IV
                            + Math.pow((base-60), Math.pow(level, .02))); // base
        }
        public static function R_Type_To_String(x:int):String {
            switch ( x ) { // the in-game types and engine types differ by named
                case Type_None: return "";
                case Type_Animal: return "Animal";
                case Type_Retro: return "Retro";
                case Type_Mechanical: return "Mechanical";
                case Type_Plasma: return "Plasma";
                case Type_Android: return "Android";
                case Type_CQB: return "CQB";
                case Type_Welder: return "Welder";
                case Type_Hover: return "Hover";
                case Type_Ghost: return "Ghost";
                case Type_Solar: return "Solar";
                case Type_Archaic: return "Archaic";
                case Type_Freezer: return "Freezer";
                case Type_Normal: return "Normal";
                case Type_Radiation: return "Radiation";
                case Type_Psychic: return "Hacking";
                case Type_Heavy: return "Heavy";
                case Type_Steel: return "Steel";
                case Type_Hydraulic: return "Hydraulic";
                default:
                    return "NULL";
            }
        }
    }
}