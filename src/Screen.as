package src {
    //import com.spikything.utils.BlastedMouseWheelBlock;
    import flash.display.LoaderInfo;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.AVStreamSwitchEvent;
    import flash.events.UncaughtErrorEvent;
    import flash.net.FileReference;
    import flash.net.NetStreamInfo;
    import flash.net.registerClassAlias;
    import flash.net.SharedObject;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;
    import flash.net.URLRequest;
    import flash.system.Security;
    import flash.text.TextFormat;
    import mx.utils.LoaderUtil;
    import src.Move_Info;
    import src.Move;
    import src.Level_Stage;
    import src.Item;
    import src.Base_Pokemon_Stats;
    import flash.display.Bitmap;
    import flash.display.Loader;
    import flash.text.Font;
    import flash.display.Stage;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.events.MouseEvent;
    import flash.display.LoaderInfo;
    import flash.display.Loader;
    import flash.net.URLRequest;
    import flash.events.Event;
    import flash.system.Security;
    import com.spikything.utils.MouseWheelTrap;
	import flash.text.TextField;
    import src.Base_Pokemon;
    import flash.system.fscommand;
    import flash.utils.ByteArray;
    public class Screen extends Sprite {
        // font
        /* [Embed(source = "../Fonts/COMICATE.ttf",
                fontName = "Font_Inconsolata",
                mimeType = "application/x-font",
                advancedAntiAliasing = "true"
              )
        ] */private var Inconsolate_Font:Class;
    
        public static const K_a:int =  0, K_b:int =  1, K_c:int =  2, K_d:int =  3, K_e:int =  4, K_f:int =  5, K_g:int =  6, K_h:int =  7,
                            K_i:int =  8, K_j:int =  9, K_k:int = 10, K_l:int = 11, K_m:int = 12, K_n:int = 13, K_o:int = 14, K_p:int = 15,
                            K_q:int = 16, K_r:int = 17, K_s:int = 18, K_t:int = 19, K_u:int = 20, K_v:int = 21, K_w:int = 22, K_x:int = 23,
                            K_y:int = 24, K_z:int = 25, K_0:int = 26, K_1:int = 27, K_2:int = 28, K_3:int = 29, K_4:int = 30, K_5:int = 31,
                            K_6:int = 32, K_7:int = 33, K_8:int = 34, K_9:int = 35,
                            K_shift:int = 36, K_space:int = 37, K_enter:int = 38, K_backspace:int = 39;
        
        public static var Keyboard_Keys:Array = [
                                                  false, false, false, false, false, false, false, false,
                                                  false, false, false, false, false, false, false, false,
                                                  false, false, false, false, false, false, false, false,
                                                  false, false, false, false, false, false, false, false,
                                                  false, false, false, false,
                                                  false, false, false, false, false, false, false, false
                                                ];
    
    
    // GLOBAL PUBLIC
        public static var current_stage_level:int = 0;
        // IDs of all the user pokemon fighting
        public static var poke_player :Array = [ null, null, null, null ];
        public static var poke_player_timer:Array = [ null, null, null, null ]; // for the move
        public static var poke_player_new_enemy_timer:Array = [ null, null, null, null ];
        // IDs of all the enemy pokemon fighting
        public static var poke_enemy:Array = [ null, null, null, null ];
        public static var poke_enemy_timer:Array = [ null, null, null, null ]; // for the move
        
        public static var hex_crystal_count:int = 0;
        
        public static var current_money:Number = 0;
        public static var current_s_money:Number = 0;
        public static var current_area :int = 0;
        public static var session_time:Number = 0;
        public static var total_time:Number = 0;
        
        public var xp_min:Number = 0,
                   gold_min:Number = 0,
                   dps_min:Number = 0,
                   pokemon_caught:Number = 0,
                   pokemon_killed:Number = 0,
                   pokemon_bred:Number = 0,
                   avg_pokemon_lvl:Number = 0;
    // GLOBAL PRIVATE
        public var current_menu_selected:int = 0;
        private const Menu_Menu:int = 0,
                      Menu_Trainer:int = 1,
                      Menu_Breeding:int = 2,
                      Menu_Pokemon:int = 3,
                      Menu_Party:int = 4,
                      Menu_Inventory:int = 5,
                      Menu_Store:int = 6;
    
        private const Global_Line_Seperator_X:int = 0,
                      Global_Line_Seperator_Y:int = 224;
        private const Area_Box_X:int = 830,
                      Area_Text_Box_Y:int = 1;
        
        private const Bottom_Menu_Switch_Bar_Y:int = 600,
                      Bottom_Menu_Switch_Bar_Store_X:int = 91,
                      Bottom_Menu_Switch_Bar_Items_X:int = 242,
                      Bottom_Menu_Switch_Bar_Poke_Bank_X:int = 403,
                      Bottom_Menu_Switch_Bar_Party_X:int = 595,
                      Bottom_Menu_Switch_Bar_Breeding_X:int = 751,
                      Bottom_Menu_Switch_Bar_Trainer_X:int = 900,
                      Bottom_Menu_Switch_Bar_Menu_X:int = 1026;
                      
        // fight global                      
        private const G_Enemy_Name_X:Array = [ 40, 284, 530, 830 ], G_Player_Name_X:Array = [ 40,  284, 530, 800 ],
                      G_Enemy_Name_Y:Array = [ 13,  13,  13,  13 ], G_Player_Name_Y:Array = [ 210, 210, 210, 210 ], 
                      G_Enemy_Level_X:Array = [ 112, 362, 615, 873 ], G_Player_Level_X:Array = [ 112, 362, 615, 873 ],
                      G_Enemy_Level_Y:Array = [ 197, 197, 197, 197 ], G_Player_Level_Y:Array = [  57,  57,  57,  57 ],
                      G_Enemy_Gender_X:Array = [ 182, 437, 692, 947 ], G_Player_Gender_X:Array = [ 182, 437, 692, 947 ],
                      G_Enemy_Gender_Y:Array = [  32,  32,  32,  32 ], G_Player_Gender_Y:Array = [ 176, 176, 176, 176 ],
                      G_Enemy_Health_Bar_X:Array = [ 106, 357, 613, 868 ], G_Player_Health_Bar_X:Array = [ 106, 357, 613, 868 ],
                      G_Enemy_Health_Bar_Y:Array = [  55,  55,  55,  55 ], G_Player_Health_Bar_Y:Array = [ 187, 187, 187, 187 ],
                                                                           G_Player_Exp_Bar_X:   Array = [ 106, 357, 613, 868 ],
                                                                           G_Player_Exp_Bar_Y:   Array = [ 173, 173, 173, 173 ],
                      G_Enemy_Sprite_X:Array = [ 38, 284, 517, 797 ], G_Player_Sprite_X:Array = [  38, 284, 517, 797 ],
                      G_Enemy_Sprite_Y:Array = [ 11,  11,  11,  11 ], G_Player_Sprite_Y:Array = [ 154, 154, 154, 154 ];
        
    // MENU PUBLIC
        public static var area_dropdown_selected:int = 0;
        public static var area_dropdown_bar_ratio:int =  0; // out of 1000
        public static var area_dropdown_top_index:int = 0; // generally i%5==0
        
        public static var is_auto_heal:Array = [ 0, 0, 0, 0 ];
    // MENU PRIVATE
        private static var menu_current_area:int = 0;
        
        public static function R_Curr_Area():int { return current_area; }
        
        private const Menu_Area_Title_Text_X:int =  15,
                      Menu_Area_Title_Text_Y:int = 250,
                      Menu_Area_Desc_Text_X:int =  13,
                      Menu_Menu_Area_Desc_Text_Y:int = 256,
                      Menu_Area_Change_Area_Text_X:int =  13,
                      Menu_Area_Change_Area_Text_Y:int = 356,
                      Menu_Area_DropDown_X:int =  88,
                      Menu_Area_DropDown_Y:int = 357,
                      Menu_Area_GO_X:int = 88,
                      Menu_Area_GO_Y:int = 400;
        
        private const Menu_Reset_Button_X:int =  21,
                      Menu_Reset_Button_Y:int = 456,
                      Menu_Save_Button_X:int  =  21,
                      Menu_Save_Button_Y:int  = 490,
                      Menu_Load_Button_X:int  =  21,
                      Menu_Load_Button_Y:int  = 527;
        
        private const Menu_Information_Text_X:int = 347,
                      Menu_Information_Text_Y:int = 240;
        
        private const Menu_Time_Information_X:int = 622,
                      Menu_Time_Information_Y:int = 244;
        
        private const Menu_Combat_Log_X:int = 631,
                      Menu_Combat_Log_Y:int = 321;
    //  PARTY POKEMON PRIVATE
        private const Party_Pokemon_Name_X:Array = [  45,  45, 724, 724 ],
                      Party_Pokemon_Name_Y:Array = [ 250, 423, 250, 423 ],
                      Party_Pokemon_Sprite_X:Array = [  50,  50, 725, 725 ],
                      Party_Pokemon_Sprite_Y:Array = [ 280, 450, 280, 450 ],
                      Party_Pokemon_Information_X:Array = [  57,  57, 804, 804 ],
                      Party_Pokemon_Information_Y:Array = [ 346, 532, 346, 532 ],
                      Party_Pokemon_Health_Text_X:Array = [ 128, 128, 804, 804 ],
                      Party_Pokemon_Health_Text_Y:Array = [ 262, 450, 262, 450 ],
                      Party_Pokemon_Health_Bar_X:Array = [ 133, 133, 810, 810 ],
                      Party_Pokemon_Health_Bar_Y:Array = [ 260, 448, 260, 448 ],
                      Party_Pokemon_Xp_Text_X:Array = [ 130, 130, 804, 804 ],
                      Party_Pokemon_Xp_Text_Y:Array = [ 284, 470, 284, 470 ],
                      Party_Pokemon_Xp_Bar_X:Array = [ 129, 129, 800, 800 ],
                      Party_Pokemon_Xp_Bar_Y:Array = [ 300, 488, 300, 488 ],
                      Party_Pokemon_Lvl_X:Array = [ 136, 136, 810, 810 ],
                      Party_Pokemon_Lvl_Y:Array = [ 325, 512, 325, 512 ];
                      
        private const Party_Move_Start_X:Array = [ 335, 335, 525, 525 ], // upgrades
                      Party_Move_Start_Y:Array = [ 280, 400, 280, 400 ],
                      Party_Move_Start_Y_Diff:int = 33,
                      Party_Move_Text_X:Array = [ 368, 368, 450, 450 ],
                      Party_Move_Text_Y:Array = [ 236, 428, 236, 428 ],
                      Party_Move_Text_Y_Diff:int = 31;
    // POKEBANK PUBLIC
        public static var pb_current_scrollbar_ratio:int = 0; // out of 1000
        public static var pb_current_top_index:int; // generally i%5==0
        public static var pokemon_in_bank:Array = [ ];
        
    // POKEBANK PRIVATE
        /*
    *         private const In_Scrollbar_X:int =  79,
                      In_Scrollbar_Y:int = 310,
                      In_Scrollbar_Bottom_Y:int = 480,
                      In_Height_Per_Item:int = 32,
                      In_Up_Arrow_X:int =  31,
                      In_Up_Arrow_Y:int = 300,
                      In_Down_Arrow_X:int = 31,
                      In_Down_Arrow_Y:int = 400;
                      
        private const In_Bar_Info_Text_Y:int = 300,
                      In_Bar_Name_Text_X:int = 252,
                      In_Bar_Curr_Money_Text_X:int = 83;
        
        private const In_Money_Text_X:int = 660,
                      In_Money_Text_Y:int = 312 + 21,
                      In_Spec_Money_Icon_X:int = 640,
                      In_Spec_Money_Icon_Y:int = 312 + 11,
                      In_Sell_Button_Times_One_Icon_X:int = 709,
                      In_Sell_Button_Times_One_Icon_Y:int = 312 + 11,
                      In_Sell_Button_Times_Ten_Icon_X:int = 744,
                      In_Sell_Button_Times_Ten_Icon_Y:int = 312 + 11,
                      In_Sprite_X:int = 150,
                      In_Sprite_Y:int = 312 + 16,
                      In_Name_Info_X:int = 246,
                      In_Name_Info_Y:int = 312 + 20,
                      In_Desc_Info_X:int = 378,
                      In_Desc_Info_Y:int = 312 + 15,
                      In_Use_Button_Y:int = 312 + 11,
                      In_Use_Button_1_X:int = 806,
                      In_Use_Button_Diff_X:int = 30;
    */
        private const Pb_Scrollbar_X:int =  79,
                      Pb_Scrollbar_Y:int = 310,
                      Pb_Scrollbar_Bottom_Y:int = 480,
                      Pb_Height_Per_Item:int = 48,
                      Pb_Up_Arrow_X:int =  31,
                      Pb_Up_Arrow_Y:int = 300,
                      Pb_Down_Arrow_X:int = 31,
                      Pb_Down_Arrow_Y:int = 400;
        
        private const Pb_Info_Text_Y:int = 300;
        private const Pb_Lvl_Text_X:int = 252,
                      Pb_Name_Text_X:int = 180,
                      Pb_Stats_Text_X:int = 402,
                      Pb_Sell_Text_X:int = 668,
                      Pb_Equip_Text_X:int = 788;
         
        private const Pb_Sell_Info_Text_X:int = 600 - 40,
                      Pb_Sell_Info_Text_Y:int =  312 + 13,
                      Pb_Sell_Icon_X:int = 680 - 40,
                      Pb_Sell_Icon_Y:int = 312 + 11,
                      Pb_Level_Info_Text_X:int = 390 - 40,
                      Pb_Level_Info_Text_Y:int = 312 + 13,
                      Pb_Pokemon_Sprite_X:int = 159 - 40,
                      Pb_Pokemon_Sprite_Y:int = 312 + 20,
                      Pb_Name_Info_X:int = 292 - 120,
                      Pb_Name_Info_Y:int = 312 + 16,
                      Pb_Stats_X:int = 388 - 240,
                      Pb_Stats_Y:int = 312 + 35,
                      Pb_Equip_Icon_X:int = 734 - 40,
                      Pb_Equip_Icon_Y:int = 312 + 13,
                      Pb_Equip_X_Diff:int =  29,
                      Pb_Trainer_X:int = 955,
                      Pb_Trainer_Y:int = 312 + 23;
    // STORE PUBLIC
        public var st_current_scrollbar_ratio:int; // out of 1000
        public var st_current_top_index:int; // generally i%5==0
        // contains the actual item (with buy/sell price on item)
        public var store_items:Array = [ null ];
    // STORE PRIVATE
        private const St_Scrollbar_X:int =  79,
                      St_Scrollbar_Y:int = 310,
                      St_Scrollbar_Bottom_Y:int = 480,
                      St_Height_Per_Item:int = 32,
                      St_Up_Arrow_X:int =  31,
                      St_Up_Arrow_Y:int = 300,
                      St_Down_Arrow_X:int = 31,
                      St_Down_Arrow_Y:int = 400;
                      
        private const St_Bar_Info_Text_Y:int = 300;
        private const St_Bar_Name_Text_X:int = 252,
                      St_Bar_Curr_Money_Text_X:int = 83;
        
        private const St_Money_Text_X:int = 590,
                      St_Money_Text_Y:int = 312 + 21,
                      St_Spec_Money_Icon_X:int = 580,
                      St_Spec_Money_Icon_Y:int = 312 + 11,
                      St_Buy_Button_Times_One_Icon_X:int = 709,
                      St_Buy_Button_Times_One_Icon_Y:int = 312 + 11,
                      St_Buy_Button_Times_Ten_Icon_X:int = 744,
                      St_Buy_Button_Times_Ten_Icon_Y:int = 312 + 11,
                      St_Sprite_X:int = 150,
                      St_Sprite_Y:int = 312 + 16,
                      St_Name_Info_X:int = 246,
                      St_Name_Info_Y:int = 312 + 20,
                      St_Desc_Info_X:int = 348,
                      St_Desc_Info_Y:int = 312 + 15;
    // BREED PUBLIC
        public var currently_breeding:Boolean = false;
        public var timer_breeding:Number = 0;
        // contains actual pokemon obj
        public static  var breeding_pokemon:Array = [ null, null ];
        public static var breeding_force_new:Boolean = false;
        public var breeding_level:int = 0;
        public var breeding_experience:int = 0;
        public var breeding_experience_to_level:int = 250;
        
    // BREED PRIVATE
        private var breeding_mult_timer:Number = 1.0;
        
        private const Breeding_Level_Cap:int = 700;
        private const breeding_sub_mult_per_level:Number = .01
        private const breeding_mult_exp_per_level:Number = 1.25; 
        private const breeding_add_exp_per_level:int = 100;
        
        private const Breed_Button_X:int = 400,
                    Breed_Button_Y:int = 302,
                    Breed_Retrieve_X:int = 480,
                    Breed_Retrieve_Y:int = 302,
                    Breed_Slot_Name_1_X:int = 80,
                    Breed_Slot_Name_1_Y:int = 400,
                    Breed_Slot_Name_2_X:int = 708,
                    Breed_Slot_Name_2_Y:int = 400,
                    Breed_Slot_Sprite_1_X:int = 80,
                    Breed_Slot_Sprite_1_Y:int = 444,
                    Breed_Slot_Sprite_2_X:int = 700,
                    Breed_Slot_Sprite_2_Y:int = 444,
                    Breed_Slot_Interconnect_Sprite_X:int = 188,
                    Breed_Slot_Interconnect_Sprite_Y:int = 441,
                    Breed_Time_Remaining_Text_X:int = 771,
                    Breed_Time_Remaining_Text_Y:int = 540;
    // INVENTORY PUBLIC
        // contains actual item with amount (buy/sell price too)
        public static var in_current_scrollbar_ratio:int = 0; // out of 1000
        public static var in_current_top_index:int = 0;
        public static var inventory_items:Array = [  ];
        public static var inventory_items_count:Array = [ ];
    // INVENTORY PRIVATE
        private const In_Scrollbar_X:int =  79,
                      In_Scrollbar_Y:int = 310,
                      In_Scrollbar_Bottom_Y:int = 480,
                      In_Height_Per_Item:int = 32,
                      In_Up_Arrow_X:int =  31,
                      In_Up_Arrow_Y:int = 300,
                      In_Down_Arrow_X:int = 31,
                      In_Down_Arrow_Y:int = 400;
                      
        private const In_Bar_Info_Text_Y:int = 300,
                      In_Bar_Name_Text_X:int = 252,
                      In_Bar_Curr_Money_Text_X:int = 83;
        
        private const In_Money_Text_X:int = 660,
                      In_Money_Text_Y:int = 312 + 21,
                      In_Spec_Money_Icon_X:int = 640,
                      In_Spec_Money_Icon_Y:int = 312 + 11,
                      In_Sell_Button_Times_One_Icon_X:int = 709,
                      In_Sell_Button_Times_One_Icon_Y:int = 312 + 11,
                      In_Sell_Button_Times_Ten_Icon_X:int = 744,
                      In_Sell_Button_Times_Ten_Icon_Y:int = 312 + 11,
                      In_Sprite_X:int = 150,
                      In_Sprite_Y:int = 312 + 16,
                      In_Name_Info_X:int = 246,
                      In_Name_Info_Y:int = 312 + 20,
                      In_Desc_Info_X:int = 378,
                      In_Desc_Info_Y:int = 312 + 15,
                      In_Use_Button_Y:int = 312 + 11,
                      In_Use_Button_1_X:int = 806,
                      In_Use_Button_Diff_X:int = 30;
                      
    // TRAINER PUBLIC
        public static var trainer_curr_pokemon:Base_Pokemon = null;
        public static var trainer_levels:Array = [ 0, 0, 0, 0, 0, 0 ];
        public static var trainer_curr_price:Array = [ 0, 0, 0, 0, 0, 0 ];
        public static var trainer_xp_f:Array = [   0, 0, 0, 0, 0, 0 ];
        public static var trainer_upgrade_per_click:int = 0;
        private static var trainer_count:int = 0;
        private const Trainer_Count_Max:int = 60; // until the effect is added
    // TRAINER PRIVATE
        private const Total_Trainers:int = 6;
        private const Trainer_Title_Text:Array = [ "Wisdom from the Developer",
                                                   "Time Dispenser",
                                                   "Time Chamber",
                                                   "RSI Decreaser",
                                                   "Honor System",
                                                   "Programmer Help"
                                                 ];
                      
        private const Trainer_Max_Level:int = 20;
        
        private const Trainer_Price_Base:Array = [
            175, 30000,  25000000,
            200, 32000, 35000000,
        ],
                      Trainer_Price_Add:Array = [
            110,  500, 5000,
            70, 750, 6000
        ],
                      Trainer_Price_Mult:Array = [
            1.1, 1.2, 1.3,
            1.15, 1.25, 1.4
        ]; // affects add
        private const Trainer_Effect_Base:Array = [
            1000, 20000, 300000,
            2000, 40000, 800000
        ],
                      Trainer_Effect_Add:Array = [
            100, 200, 400,
            100, 300, 600
        ],
                      Trainer_Effect_Mult:Array = [
            1.3, 1.6, 2.2,
            1.6, 1.9, 2.3
        ];
        private const Trainer_Title_Offset:int = 120;
        private const Trainer_Title_Text_X:Array = [
                          110, 110, 110,
                          779, 779, 779,                          
                      ],
                      Trainer_Title_Text_Y:Array = [
                          240, 240 + Trainer_Title_Offset, 240 + Trainer_Title_Offset*2,
                          240, 240 + Trainer_Title_Offset, 240 + Trainer_Title_Offset*2
                      ],
                      Trainer_Per_Frame_X:Array = [
                          110, 110, 110,
                          779, 779, 779
                      ],
                      Trainer_Per_Frame_Y:Array = [
                          255, 255 + Trainer_Title_Offset, 255 + Trainer_Title_Offset*2,
                          255, 255 + Trainer_Title_Offset, 255 + Trainer_Title_Offset*2
                      ],
                      Trainer_Per_60FPS_X:Array = [
                          110, 110, 110,
                          779, 779, 779
                      ],
                      Trainer_Per_60FPS_Y:Array = [
                          270, 270 + Trainer_Title_Offset, 270 + Trainer_Title_Offset*2,
                          270, 270 + Trainer_Title_Offset, 270 + Trainer_Title_Offset*2
                      ],
                      Trainer_Upg_Button_X:Array = [
                          110, 110, 110,
                          779, 779, 779
                      ],
                      Trainer_Upg_Button_Y:Array = [
                          300, 300 + Trainer_Title_Offset, 300 + Trainer_Title_Offset*2,
                          300, 300 + Trainer_Title_Offset, 300 + Trainer_Title_Offset*2
                      ],
                      Trainer_Price_X:Array = [
                          204, 204, 204,
                          879, 879, 879
                      ],
                      Trainer_Price_Y:Array = [
                          491, 491 + Trainer_Title_Offset, Trainer_Title_Offset*2,
                          491, 491 + Trainer_Title_Offset, Trainer_Title_Offset*2
                      ],
                      Trainer_Sprite_X:Array = [
                          19,  19,  19,
                          685, 685, 685
                      ],
                      Trainer_Sprite_Y:Array = [
                          240, 360, 480,
                          240, 360, 480
                      ];
                    
        private const Trainer_Info_X:int = 340,
                      Trainer_Info_Y:int = 340,
                      Trainer_Pokemon_Name_X:int = 476,
                      Trainer_Pokemon_Name_Y:int = 339,
                      Trainer_Pokemon_Level_X:int = 557,
                      Trainer_Pokemon_Level_Y:int = 339,
                      Trainer_Pokemon_Sprite_X:int = 460,
                      Trainer_Pokemon_Sprite_Y:int = 360,
                      Trainer_Button_X:int = 400,
                      Trainer_Button_Y:int = 444,
                      Trainer_Button_Text_X:int = 418,
                      Trainer_Button_Text_Y:int = 473;
   
        // AS3 BULLSHIT (O:)
        
            
        // IMAGES
        // menu/misc items ~~~~~~~~~~~~
            // stages			Img_Bottom_Bar = new NLoader("Bottom_Bar.png");
            //fscommand("quit");
        [Embed("../Images/Bottom_Bar.png")]private var Img_Bottom_Bar:Class;
        [Embed("../Images/Simple_Bar.png")]private var Img_Simple_Bar:Class;
        
        [Embed("../Images/Icon_Menu_Select.png")]private var Img_Bottom_Bar_Highlight:Class;
        [Embed("../Images/Icon_0_Button.png")]private var Img_0_Button:Class;
        [Embed("../Images/Icon_1_Button.png")]private var Img_1_Button:Class;
        [Embed("../Images/Icon_2_Button.png")]private var Img_2_Button:Class;
        [Embed("../Images/Icon_3_Button.png")]private var Img_3_Button:Class;
        [Embed("../Images/Icon_4_Button.png")]private var Img_4_Button:Class;
        [Embed("../Images/Icon_X_Button.png")]private var Img_X_Button:Class;
        
        [Embed("../Images/Icon_Female.png")]private var Img_Female:Class;
        [Embed("../Images/Icon_Male.png")]private var Img_Male:Class;
        [Embed("../Images/Icon_Female_Button.png")]private var Img_Breed_Female_Button:Class;
        [Embed("../Images/Icon_Male_Button.png")]private var Img_Breed_Male_Button:Class;
                    
        [Embed("../Images/Icon_Battle_Global_Health_Bar.png")]private var Img_Battle_Global_Health_Bar:Class;
        [Embed("../Images/Icon_Battle_Global_Xp_Bar.png")]private var Img_Battle_Global_Xp_Bar:Class;
        [Embed("../Images/Icon_Battle_Global_Text_Box.png")]private var Img_Battle_Global_Text_Box:Class;
                    
        [Embed("../Images/Icon_Breed_Button.png")]private var Img_Breed_Button:Class;
        [Embed("../Images/Icon_Breed_Collect_Button.png")]private var Img_Breed_Collect:Class;
        [Embed("../Images/Icon_Breed_Intertwine.png")]private var Img_Breed_Intertwine:Class;
                    
        [Embed("../Images/Icon_Down_Arrow.png")]private var Img_Down_Arrow:Class;
        [Embed("../Images/Icon_Up_Arrow.png")]private var Img_Up_Arrow:Class;
                    
        [Embed("../Images/Icon_Female.png")]private var Img_Gender_Female:Class;
        [Embed("../Images/Icon_Male.png")]private var Img_Gender_Male:Class;
                    
        [Embed("../Images/Icon_Menu_Area_Backdrop.png")]private var Img_Menu_Area_List_Backdrop:Class;
        [Embed("../Images/Icon_Menu_Area_Bar.png")]private var Img_Menu_Area_Bar:Class;
        [Embed("../Images/Icon_Menu_Go.png")]private var Img_Menu_GO:Class;
        [Embed("../Images/Icon_Menu_Load.png")]private var Img_Menu_Load_Button:Class;
        [Embed("../Images/Icon_Menu_Reset.png")]private var Img_Menu_Reset_Button:Class;
        [Embed("../Images/Icon_Menu_Save.png")]private var Img_Menu_Save_Button:Class;
                    
        [Embed("../Images/Icon_Party_Health_Bar.png")]private var Img_Party_Health_Bar:Class;
        [Embed("../Images/Icon_Party_Exp_Bar.png")]private var Img_Party_Xp_Bar:Class;
        [Embed("../Images/Icon_Party_No_Pokemon.png")]private var Img_Party_None:Class;
                    
        [Embed("../Images/Icon_Scrollbar.png")]private var Img_Scroll_Bar:Class;
        [Embed("../Images/Icon_Scrollbar_Background.png")]private var Img_Scroll_Bar_Backdrop:Class;
                    
        [Embed("../Images/Icon_Spec_Money.png")]private var Img_Spec_Money:Class;
                    
        [Embed("../Images/Icon_Trainer_Button.png")]private var Img_Trainer_Button:Class;
        [Embed("../Images/Icon_Trainer_Exp_Bar.png")]private var Img_Trainer_Experience_Bar:Class;
        [Embed("../Images/Icon_Trainer_Player_Button.png")]private var Img_Trainer_Player_Button:Class;
        [Embed("../Images/Icon_Trainer_Upgrade.png")]private var Img_Trainer_Upgrade_Button:Class;
        [Embed("../Images/Icon_Trainer_Upgrade_Icon_1.png")]private var Img_Trainer_Upgrade1:Class;
        [Embed("../Images/Icon_Trainer_Upgrade_Icon_2.png")]private var Img_Trainer_Upgrade2:Class;
        [Embed("../Images/Icon_Trainer_Upgrade_Icon_3.png")]private var Img_Trainer_Upgrade3:Class;
        [Embed("../Images/Icon_Trainer_Upgrade_Icon_4.png")]private var Img_Trainer_Upgrade4:Class;
        [Embed("../Images/Icon_Trainer_Upgrade_Icon_5.png")]private var Img_Trainer_Upgrade5:Class;
        [Embed("../Images/Icon_Trainer_Upgrade_Icon_6.png")]private var Img_Trainer_Upgrade6:Class;
         
        [Embed("../Images/Badge_01.png")]private var Badge_0:Class;
        [Embed("../Images/Badge_02.png")]private var Badge_1:Class;
        [Embed("../Images/Badge_03.png")]private var Badge_2:Class;
        [Embed("../Images/Badge_04.png")]private var Badge_3:Class;
        [Embed("../Images/Badge_05.png")]private var Badge_4:Class;
        [Embed("../Images/Badge_06.png")]private var Badge_5:Class;
        [Embed("../Images/Badge_07.png")]private var Badge_6:Class;
        [Embed("../Images/Badge_08.png")]private var Badge_7:Class;
        [Embed("../Images/Badge_09.png")]private var Badge_8:Class;
        [Embed("../Images/Badge_10.png")]private var Badge_9:Class;
        [Embed("../Images/Badge_11.png")]private var Badge_10:Class;
        [Embed("../Images/Badge_12.png")]private var Badge_11:Class;
        [Embed("../Images/Badge_13.png")]private var Badge_12:Class;
        [Embed("../Images/Badge_14.png")]private var Badge_13:Class;
        [Embed("../Images/Badge_15.png")]private var Badge_14:Class;
        [Embed("../Images/Badge_16.png")]private var Badge_15:Class;
        [Embed("../Images/Badge_17.png")]private var Badge_16:Class;
        [Embed("../Images/Badge_18.png")]private var Badge_17:Class;
        [Embed("../Images/Badge_19.png")]private var Badge_18:Class;
        [Embed("../Images/Badge_20.png")]private var Badge_19:Class;
        [Embed("../Images/Badge_21.png")]private var Badge_20:Class;
        [Embed("../Images/Badge_22.png")]private var Badge_21:Class;
        [Embed("../Images/Badge_23.png")]private var Badge_22:Class;
        [Embed("../Images/Badge_24.png")]private var Badge_23:Class;
        [Embed("../Images/Badge_25.png")]private var Badge_24:Class;
        [Embed("../Images/Badge_26.png")]private var Badge_25:Class;
        [Embed("../Images/Badge_27.png")]private var Badge_26:Class;
        [Embed("../Images/Badge_28.png")]private var Badge_27:Class;
        [Embed("../Images/Badge_29.png")]private var Badge_28:Class;
        [Embed("../Images/Badge_30.png")]private var Badge_29:Class;
        [Embed("../Images/Badge_31.png")]private var Badge_30:Class;
        [Embed("../Images/Badge_32.png")]private var Badge_31:Class;
        [Embed("../Images/Badge_33.png")]private var Badge_32:Class;
        [Embed("../Images/Badge_34.png")]private var Badge_33:Class;
        [Embed("../Images/Badge_35.png")]private var Badge_34:Class;
        [Embed("../Images/Badge_36.png")]private var Badge_35:Class;
        [Embed("../Images/Badge_37.png")]private var Badge_36:Class;
        [Embed("../Images/Badge_38.png")]private var Badge_37:Class;
        [Embed("../Images/Badge_39.png")]private var Badge_38:Class;
        [Embed("../Images/Badge_40.png")]private var Badge_39:Class;
        [Embed("../Images/Badge_41.png")]private var Badge_40:Class;
        [Embed("../Images/Badge_42.png")]private var Badge_41:Class;
        [Embed("../Images/Badge_43.png")]private var Badge_42:Class;
        [Embed("../Images/Badge_44.png")]private var Badge_43:Class;
        [Embed("../Images/Badge_45.png")]private var Badge_44:Class;
        [Embed("../Images/Badge_46.png")]private var Badge_45:Class;
        [Embed("../Images/Badge_47.png")]private var Badge_46:Class;
        [Embed("../Images/Badge_48.png")]private var Badge_47:Class;
        [Embed("../Images/Badge_49.png")]private var Badge_48:Class;
        [Embed("../Images/Badge_50.png")]private var Badge_49:Class;
        [Embed("../Images/Badge_51.png")]private var Badge_50:Class;
        [Embed("../Images/Badge_52.png")]private var Badge_51:Class;
        [Embed("../Images/Badge_53.png")]private var Badge_52:Class;
        [Embed("../Images/Badge_54.png")]private var Badge_53:Class;
        [Embed("../Images/Badge_55.png")]private var Badge_54:Class;
        [Embed("../Images/Badge_56.png")]private var Badge_55:Class;
        [Embed("../Images/Badge_57.png")]private var Badge_56:Class;
        [Embed("../Images/Badge_58.png")]private var Badge_57:Class;
        [Embed("../Images/Badge_59.png")]private var Badge_58:Class;
        [Embed("../Images/Badge_60.png")]private var Badge_59:Class;
        [Embed("../Images/Badge_62.png")]private var Badge_60:Class;
        [Embed("../Images/Badge_63.png")]private var Badge_61:Class;
        [Embed("../Images/Badge_64.png")]private var Badge_62:Class;

        private static var Img_Level_Stages:Array;
            
            
            // all botomon
            /*            "Rusty", "Summoned", "DeDoss", "Gantz", "Zero",
            "Lion's Roar", "Krannibal", "Injectoid", "Kooler",
            "G-48", "Pyramido", "Pistonium", "Illuminati",
            "Detective",
            "Discro", "Pestilence", "Disco Wolf", "Frost Bite",
            "Quad Rowter", "Duke", "Hydrophobia", "Morning Star",
            "Solid Snake", "Ballistic", "Brain Freeze", "Memories",
            "Clutcher", "Rain Dance", "ShusMonk", "Low Life",
            "Deceased", "Cinders", "Poseidon.0", "Ratabot",
            "Spindler"*/
        [Embed("../Images/Bot_Rusty.png")]private var Bot_0:Class
        [Embed("../Images/Bot_Summoned.png")]private var Bot_1:Class
        [Embed("../Images/Bot_DeDoss.png")]private var Bot_2:Class
        [Embed("../Images/Bot_Gantz.png")]private var Bot_3:Class
        [Embed("../Images/Bot_Zero.png")]private var Bot_4:Class
        [Embed("../Images/Bot_Lion's Roar.png")]private var Bot_5:Class
        [Embed("../Images/Bot_Krannibal.png")]private var Bot_6:Class
        [Embed("../Images/Bot_Injectoid.png")]private var Bot_7:Class
        [Embed("../Images/Bot_Kooler.png")]private var Bot_8:Class
        [Embed("../Images/Bot_G-48.png")]private var Bot_9:Class
        [Embed("../Images/Bot_Pyramido.png")]private var Bot_10:Class
        [Embed("../Images/Bot_Pistonium.png")]private var Bot_11:Class
        [Embed("../Images/Bot_Illuminati.png")]private var Bot_12:Class
        [Embed("../Images/Bot_Detective.png")]private var Bot_13:Class
        [Embed("../Images/Bot_Discro.png")]private var Bot_14:Class
        [Embed("../Images/Bot_Pestilence.png")]private var Bot_15:Class
        [Embed("../Images/Bot_Disco Wolf.png")]private var Bot_16:Class
        [Embed("../Images/Bot_Frost Bite.png")]private var Bot_17:Class
        [Embed("../Images/Bot_Quad Rowter.png")]private var Bot_18:Class
        [Embed("../Images/Bot_Duke.png")]private var Bot_19:Class
        [Embed("../Images/Bot_Ghost_Ship.png")]private var Bot_20:Class
        [Embed("../Images/Bot_Morning Star.png")]private var Bot_21:Class
        [Embed("../Images/Bot_Solid Snake.png")]private var Bot_22:Class
        [Embed("../Images/Bot_Ballistic.png")]private var Bot_23:Class
        [Embed("../Images/Bot_Brain Freeze.png")]private var Bot_24:Class
        [Embed("../Images/Bot_Memories.png")]private var Bot_25:Class
        [Embed("../Images/Bot_Clutcher.png")]private var Bot_26:Class
        [Embed("../Images/Bot_Rainbow.png")]private var Bot_27:Class
        [Embed("../Images/Bot_ShusMonk.png")]private var Bot_28:Class
        [Embed("../Images/Bot_Leopard_Star.png")]private var Bot_29:Class
        [Embed("../Images/Bot_Deceased.png")]private var Bot_30:Class
        [Embed("../Images/Bot_Cinders.png")]private var Bot_31:Class
        [Embed("../Images/Bot_Poseidon_0.png")]private var Bot_32:Class
        [Embed("../Images/Bot_Ratabot.png")]private var Bot_33:Class
        [Embed("../Images/Bot_Spindler.png")]private var Bot_34:Class
        [Embed("../Images/vomit cloud.png")]private var Bot_35:Class;
        
        [Embed("../Images/Item_Potion.png")]private var Img_Item_0:Class;
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
        [Embed("../Images/Item_Soul_Crystal_Hex.png")]private var Img_Item_36:Class;
        [Embed("../Images/Item_Mini_Crystal.png")]private var Img_Item_37:Class;
        [Embed("../Images/Item_Dull_Crystal.png")]private var Img_Item_38:Class;
        [Embed("../Images/Item_Dim_Crystal.png")]private var Img_Item_39:Class;
        [Embed("../Images/Item_Normal_Crystal.png")]private var Img_Item_40:Class;
        [Embed("../Images/Item_Glowing_Crystal.png")]private var Img_Item_41:Class;
        [Embed("../Images/Item_Heavy_Crystal.png")]private var Img_Item_42:Class;
        [Embed("../Images/Item_Bright_Crystal.png")]private var Img_Item_43:Class;
        [Embed("../Images/Item_Neon_Crystal.png")]private var Img_Item_44:Class;
        [Embed("../Images/Item_Godly_Crystal.png")]private var Img_Item_45:Class;
        [Embed("../Images/Item_Legendary_Crystal.png")]private var Img_Item_46:Class;
        [Embed("../Images/Item_Herclodian_Crystal.png")]private var Img_Item_47:Class;
        
        [Embed("../Images/Icon_Damaged.png")]private var Icon_Damaged:Class;
        private var Img_Pokemon:Array;
            
        
        private var Img_Items:Array;
        
        // fight vars
        public static const Min_Fighting_Timer:int = 60*2;
        public static const Max_Fighting_Timer:int = 60*4;
        public static const Max_Dead_Timer:int = 60*240;
        public static const Max_Enemy_Respawn_Timer:int = 60 * 20;
        
        // scrollbar ratios
        
        

        // important etc
        public var mouse_down:Boolean;
        
        public static var Text_Move_Results:Array;
        public static var Text_User_Results:Array;
        public static var Text_Store_Results:Array;
        
        public static function Add_Item_Inventory(x:Item, amt:int = 1):void {
            if ( x.R_Item_Type() == Item.Item_Name.length - 1 )
                collected_legendary_crystals += amt;
            for ( var i:int = 0; i != inventory_items.length; ++ i )
                if ( Item(inventory_items[i]).R_Item_Stage() == x.R_Item_Stage() &&
                     Item(inventory_items[i]).R_Item_Type()  == x.R_Item_Type() ) {
                    inventory_items_count[i] += amt;
                    return;
                }
            // item doesn't exist yet
            inventory_items.push(x);
            inventory_items_count.push(amt);
        }
        
        public static function Add_Item_Inventory_Move(x:Move):void {
            // find TM01
            var i:int;
            Text_Store_Results.push("Adding move to inventory");
            for ( i = 0; i != Item.Item_Name.length; ++ i )
                if ( Item.Item_Name[i] == "TM Pound" ) break;
            if ( i == Item.Item_Name.length ) {
                Text_Store_Results.push("Error finding item TM Pound in function Screen.Add_Item_Inventory(x:Move)\n");
                return;
            }
            // split it up into base move and type
            if ( x.Move_Type > 0 ) {
                // find Welder Modifier
                var z:int;
                for ( z = 0; z != Item.Item_Name.length; ++ z )
                    if ( Item.Item_Name[z] == "Welder Modifier" ) break;
                if ( z == Item.Item_Name.length ) {
                    trace("Error finding item Welder Modifier in function Screen.Add_Item_Inventory(x:Move)\n");
                    return;
                }
                Text_Store_Results.push("Modifier " + Item.Item_Name[z + x.Move_Type-1] + " added to inventory");
                Add_Item_Inventory(new Item(z + x.Move_Type-1, x.Move_Stage));            
            }
            Text_Store_Results.push("Move " + Item.Item_Name[x.Move_ID + i] + " added to inventory");
            Add_Item_Inventory(new Item(x.Move_ID + i, x.Move_Stage));
        }
        
        public static function Random_Range(min:Number, max:Number):int {
            return (Math.floor(Math.random() * (max - min + 1)) + min);
        }
        
        private static var ms_x_prop:int = 0;
        private static var ms_y_prop:int = 0;
        
        public function Refresh_Mouse_Statistics():void {
            ms_x_prop = this.mouseX;;
            ms_y_prop = this.mouseY;
        }
        
        public static function Mouse_In_Box(x:int, y:int, w:int, h:int):Boolean {
            var mouse_x:int = ms_x_prop;
            var mouse_y:int = ms_y_prop;
            //trace("Mouse: " + String(mouse_x) + ", " + String(mouse_y));
            //trace("Obj: " + String(x) + " - " + String(x + w) + " : " + String(y) + " - " + String(y + h));
            return ( x < mouse_x && x + w > mouse_x &&
                     y < mouse_y && y + h > mouse_y );
        }
        
        // used so that textfield isn't mixed with bitmap
        private static var children_bitmap:Array = new Array(); // array contains an array size 2 { Offset_in_array, image ID }
        private static var children_offset:int = 0;
        private static var children_id:int = 1;
        
        private function Mouse_In_Img(img:Class):Boolean {
            for ( var i : int = 0; i != children_bitmap.length; ++ i ) {
                //trace(children_bitmap[i][children_id], " = ", img.ID, " ?");
                if ( children_bitmap[i][children_id] == img.ID )
                    if ( Mouse_In_Box( (this.getChildAt(children_bitmap[i][children_offset])).x,
                                         (this.getChildAt(children_bitmap[i][children_offset])).y,
                                         (this.getChildAt(children_bitmap[i][children_offset])).width,
                                         (this.getChildAt(children_bitmap[i][children_offset])).height ) )
                        return true; // the reason I want to iterate through every single image is if there are copies of an image
            }
            return 0;
        }
        
        public static var highest_level_botomon:int = 1;
        public static var botomon_kill_amt:int = 0;
        public static var botomon_bred:int = 0;
        public static var collected_legendary_crystals:int = 0;
        public static var collected_herclodian_crystals:int = 0;
        public static var highest_damage:int = 0;
        
        // money, pancakes, amt of bosses killed
        private function Kong_API_Set_Up():void {
            QuickKong.connectToKong(stage);
        }
        private static function Kong_API_Refresh() {
            QuickKong.stats.submit("Highest level botomon", highest_level_botomon);
            QuickKong.stats.submit("Botomons killed", botomon_kill_amt);
            QuickKong.stats.submit("Total money", current_money);
            QuickKong.stats.submit("Total pancakes", current_s_money);
            QuickKong.stats.submit("Highest Stage", current_stage_level);
            QuickKong.stats.submit("Botomon Bred", botomon_bred);
            QuickKong.stats.submit("Collected Legendary Crystals", collected_legendary_crystals);
            QuickKong.stats.submit("Highest Damage", highest_damage);
            QuickKong.stats.submit("Herclodian Crystals", collected_herclodian_crystals);
        }
        private static var saved_file:SharedObject;
        private static var save_helper:Save_Helper = new Save_Helper();
        
        private function Save():void {
            var saved_file:SharedObject = SharedObject.getLocal("Bot_Save", "/");
            // clear current data in arrays
            // botomon
            if ( final_boss != null )
                save_helper.final_boss = final_boss.Export_Information();
            else
                save_helper.final_boss = null;
            if ( trainer_curr_pokemon != null )
                save_helper.trainer_curr_pokemon = trainer_curr_pokemon.Export_Information();
            else
                save_helper.trainer_curr_pokemon = null;
            
            var t:Array = new Array();
            for ( var i : int = 0; i != poke_enemy.length; ++ i )   
                if ( poke_enemy[i] == null )
                    t.push(null);
                else
                    t.push(Base_Pokemon(poke_enemy[i]).Export_Information());
            save_helper.poke_enemy = t;
            
            var t:Array = new Array();
            for ( var i : int = 0; i != poke_player.length; ++ i )   
                if ( poke_player[i] == null )
                    t.push(null);
                else
                    t.push(Base_Pokemon(poke_player[i]).Export_Information());
            save_helper.poke_player = t;
            
            var t:Array = new Array();
            for ( var i : int = 0; i != pokemon_in_bank.length; ++ i )
                t.push(Base_Pokemon(pokemon_in_bank[i]).Export_Information());
            save_helper.pokemon_in_bank = t;
                        
            var t:Array = new Array();
            for ( var i : int = 0; i != inventory_items.length; ++ i ) {
                t.push(Item(inventory_items[i]).Export());
                Item_Loader(t[t.length - 1]).item_count = inventory_items_count[i];
            }
            save_helper.inventory_items = t;
            
            var t:Array = new Array();
            for ( var i : int = 0; i != 2; ++ i )
                if ( breeding_pokemon[i] == null ) t.push(null);
                else t.push(Base_Pokemon(breeding_pokemon[i]).Export_Information());
            save_helper.breeding_pokemon = t;
            var save_helper_information:ByteArray = new ByteArray();
            save_helper_information.writeObject(save_helper);
            
            saved_file.data.save_helper_information = save_helper_information;
            
            saved_file.data.poke_enemy_timer = poke_enemy_timer;
            saved_file.data.poke_player_new_enemy_timer = poke_player_new_enemy_timer;
            saved_file.data.poke_player_timer = poke_player_timer;
            
            saved_file.data.highest_level_botomon = highest_level_botomon;
            saved_file.data.botomon_kill_amt = botomon_kill_amt;
            
            saved_file.data.Text_Move_Results = Text_Move_Results;
            saved_file.data.Text_User_Results = Text_User_Results;
            saved_file.data.Text_Store_Results = Text_Store_Results;
            
            saved_file.data.pibbypibbypibbypib = pibbypibbypibbypib;
            saved_file.data.has_done_init_naming = has_done_init_naming;
            saved_file.data.setting_name = 0;
            
            saved_file.data.current_money = current_money;
            saved_file.data.current_s_money = current_s_money;
            
            saved_file.data.collected_herclodian_crystals = collected_herclodian_crystals;
            saved_file.data.trainer_levels = trainer_levels;
            saved_file.data.trainer_curr_price = trainer_curr_price;
            saved_file.data.trainer_xp_f = trainer_xp_f;
            saved_file.data.trainer_upgrade_per_click = trainer_upgrade_per_click;
            saved_file.data.trainer_count = trainer_count;
            saved_file.data.hex_crystal_max = hex_crystal_max;
            saved_file.data.currently_breeding = currently_breeding;
            saved_file.data.timer_breeding = timer_breeding;
            saved_file.data.breeding_mult_timer = breeding_mult_timer;
            saved_file.data.breeding_level = breeding_level
            saved_file.data.breeding_experience = breeding_experience;
            saved_file.data.breeding_experience_to_level= breeding_experience_to_level
            
            saved_file.data.triple_experience = triple_experience;
            saved_file.data.breeding_force_new = breeding_force_new;
            saved_file.data.fighting_final_boss = fighting_final_boss;
            saved_file.data.special_fight_effect = special_fight_effect;
            saved_file.data.final_boss_stolen_botomon = final_boss_stolen_botomon;
            saved_file.data.final_boss_timer = final_boss_timer;
            saved_file.data.Is_Boss_Rush = Is_Boss_Rush;
            saved_file.data.final_63_boss_beat = final_63_boss_beat;
            saved_file.data.collected_legendary_crystals = collected_legendary_crystals;
            saved_file.data.current_area = current_area;
            saved_file.data.current_stage_level = current_stage_level;
            saved_file.data.menu_current_area = menu_current_area;
            saved_file.data.total_time = total_time + session_time;
            saved_file.data.setting_name = setting_name;
            saved_file.data.botomon_bred = botomon_bred;
            
            Kong_API_Refresh();
            
            
            saved_file.flush();
            saved_file.close();
            if ( String(Text_User_Results[Text_User_Results.length - 1]).search("Save complete!") == -1 )
                Text_User_Results.push(session_time + ": " +"Save complete!");
            save_refresh = 100;
        }
        private function Load():void {
            var saved_file:SharedObject = SharedObject.getLocal("Bot_Save", "/");
            if ( !saved_file.data.hasOwnProperty("save_helper_information") ) {
                fscommand("quit");
            }
            var byte_helper:ByteArray = saved_file.data.save_helper_information;
            byte_helper.position = 0;
            
            save_helper = null;
            byte_helper.position = 0;
            save_helper = byte_helper.readObject();
                
            if ( final_boss != null )
                final_boss = (save_helper.final_boss as Base_Pokemon_Loader).New();
            else
                final_boss = null;
                            
            poke_enemy = save_helper.poke_enemy;
            var t:Array = new Array();
            for ( var i : int = 0; i != 4; ++ i )
                if ( poke_enemy[i] == null ) t.push(null);
                else t.push(Base_Pokemon_Loader(poke_enemy[i]).New());
            poke_enemy = t;            
            
            poke_player = save_helper.poke_player;
            var t:Array = new Array();
            for ( var i : int = 0; i != 4; ++ i )
                if ( poke_player[i] == null ) t.push(null);
                else t.push(Base_Pokemon_Loader(poke_player[i]).New());
            poke_player = t;
            
            pokemon_in_bank = save_helper.pokemon_in_bank;
            var t:Array = new Array();
            for ( var i : int = 0; i != pokemon_in_bank.length; ++ i )
                t.push(Base_Pokemon_Loader(pokemon_in_bank[i]).New());
            pokemon_in_bank = t;
                
            breeding_pokemon = save_helper.breeding_pokemon;
            var t:Array = new Array();
            for ( var i : int = 0; i != breeding_pokemon.length; ++ i )
                if ( breeding_pokemon[i] == null ) t.push(null)
                else t.push(Base_Pokemon_Loader(breeding_pokemon[i]).New());
            breeding_pokemon = t;
            if ( save_helper.trainer_curr_pokemon != null )
                trainer_curr_pokemon = save_helper.trainer_curr_pokemon.New();
            else
                trainer_curr_pokemon = null;
            
            inventory_items = save_helper.inventory_items;
            var t:Array = new Array();
            var b:Array = new Array();
            for ( var i : int = 0; i != inventory_items.length; ++ i ) {
                Text_Move_Results.push(Item_Loader(inventory_items[i]).item_stage + " " + Item_Loader(inventory_items[i]).item_type);
                t.push(Item_Loader(inventory_items[i]).New());
                if ( Item(t[t.length - 1]).R_Item_Stage() < 0 )
                    Item(t[t.length - 1]).Reset_Item_Stage();
                b.push(Item_Loader(inventory_items[i]).item_count);
            }
            inventory_items = t;
            inventory_items_count = b;
            
            poke_enemy_timer = saved_file.data.poke_enemy_timer ;
            poke_player_new_enemy_timer = saved_file.data.poke_player_new_enemy_timer ;
            poke_player_timer = saved_file.data.poke_player_timer ;
            //Text_Move_Results = saved_file.data.Text_Move_Results ;
            Text_User_Results = saved_file.data.Text_User_Results ;
            Text_Store_Results = saved_file.data.Text_Store_Results ;
            
            pibbypibbypibbypib = saved_file.data.pibbypibbypibbypib ;
            has_done_init_naming = saved_file.data.has_done_init_naming;
            setting_name = saved_file.data.setting_name;
            
            current_money = saved_file.data.current_money ;
            current_s_money = saved_file.data.current_s_money ;
            
                
            
            trainer_levels = saved_file.data.trainer_levels ;
            trainer_curr_price = saved_file.data.trainer_curr_price ;
            trainer_xp_f = saved_file.data.trainer_xp_f ;
            trainer_upgrade_per_click = saved_file.data.trainer_upgrade_per_click ;
            trainer_count = saved_file.data.trainer_count ;
            botomon_bred = 0;
            botomon_bred = saved_file.data.botomon_bred;
            collected_legendary_crystals = 0;
            collected_legendary_crystals = saved_file.data.collected_legendary_crystals;
            if ( collected_legendary_crystals == 0 ) {
                for ( var i : int = 0; i != inventory_items.length; ++ i )
                    if ( Item(inventory_items[i]).R_Item_Type() == Item.Item_Name.length - 1 ) {
                        collected_legendary_crystals = inventory_items_count[i];
                        break;
                    }
            }
            if ( "highest_level_botomon" in saved_file.data ) {
                saved_file.data.highest_level_botomon = highest_level_botomon;
                saved_file.data.botomon_kill_amt = botomon_kill_amt;
            } else {
                highest_level_botomon = 0;
                botomon_kill_amt = 0;
            }
            
            currently_breeding = saved_file.data.currently_breeding ;
            timer_breeding = saved_file.data.timer_breeding ;
            breeding_level = saved_file.data.breeding_level;
            breeding_experience = saved_file.data.breeding_experience ;
            breeding_experience_to_level = saved_file.data.breeding_experience_to_level;
            triple_experience = [ 0, 0, 0, 0 ];
            if ( "triple_experience" in saved_file.data )
                triple_experience = saved_file.data.triple_experience;
            if ( "collected_herclodian_crystals" in saved_file.data )
                collected_herclodian_crystals = saved_file.data.collected_herclodian_crystals;
            breeding_force_new = false;
            breeding_force_new = saved_file.data.breeding_force_new;
            fighting_final_boss = saved_file.data.fighting_final_boss ;
            special_fight_effect = saved_file.data.special_fight_effect ;
            final_boss_stolen_botomon = saved_file.data.final_boss_stolen_botomon ;
            final_boss_timer = saved_file.data.final_boss_timer ;
            Is_Boss_Rush = saved_file.data.Is_Boss_Rush ;
            final_63_boss_beat = saved_file.data.final_63_boss_beat ;
            
            current_area = saved_file.data.current_area ;
            current_stage_level = saved_file.data.current_stage_level ;
            menu_current_area = saved_file.data.menu_current_area ;
            total_time = saved_file.data.total_time;
            session_time = 0;
            in_current_scrollbar_ratio = 0;
            in_current_top_index = 0;
            st_current_scrollbar_ratio = 0;
            st_current_top_index = 0;
            pb_current_scrollbar_ratio = 0;
            pb_current_top_index = 0;
            
            
            hex_crystal_max = saved_file.data.hex_crystal_max;
            
            for ( var st : int = 1; st < current_stage_level + 1; ++ st )
                for ( var i : int = 0; i != Area.Area_Name.length; ++ i )
                    Area.Area_Stage.push(st);
            
            // store items
            store_items = new Array();
            for ( var i : int = 0; i != current_stage_level+1; ++ i )
                store_items = R_Store_Items(i);
                
            pibbypibbypibbypib = 5;
            has_done_init_naming = 1;
            
            breeding_mult_timer = 1.0;
            var i:int;
            for ( i = 0; i < breeding_level; ++ i )
                breeding_mult_timer -= .01;
            if ( botomon_bred == 0 && i > 1 )
                botomon_bred = i;
                            
            if ( fighting_final_boss  ) {
                fighting_final_boss = 0;
                final_boss = null;
                Boss_Fight_Start();
            }
            
            if ( trainer_curr_price[0] < Trainer_Price_Base[0] ) {
                for ( var i : int = 0; i != 6; ++ i ) {
                    trainer_curr_price[i] = Trainer_Price_Base[i];
                    trainer_levels = [ 0, 0, 0, 0, 0, 0 ];
                    trainer_upgrade_per_click = 0;
                    trainer_xp_f = [ 0, 0, 0, 0, 0, 0 ];
                }
            }
            
            if ( timer_breeding <= 0 ) breeding_done = true;
            
            Text_Move_Results.push(session_time + ": " +"Load complete!");
            saved_file.flush();
            saved_file.close();
        }
        
        private function Reset_Save():void {
            if ( !Keyboard_Keys[K_p] ) return;
            var saved_file:SharedObject = SharedObject.getLocal("Bot_Save", "/");
            
            delete saved_file.data.poke_player ;
            delete saved_file.data.trainer_curr_pokemon ;
            delete saved_file.data.pokemon_in_bank ;
            delete saved_file.data.inventory_items ;
            delete saved_file.data.inventory_items_count ;
            delete saved_file.data.store_items ;
            
            delete saved_file.data.poke_enemy_timer ;
            delete saved_file.data.poke_player_new_enemy_timer ;
            delete saved_file.data.poke_player_timer ;
            
            delete saved_file.data.Text_Move_Results ;
            delete saved_file.data.Text_User_Results ;
            delete saved_file.data.Text_Store_Results ;
            
            delete saved_file.data.pibbypibbypibbypib ;
            delete saved_file.data.has_done_init_naming;
            
            delete saved_file.data.current_money ;
            delete saved_file.data.current_s_money ;
            
            delete saved_file.data.trainer_curr_pokemon ;
            delete saved_file.data.trainer_levels ;
            delete saved_file.data.trainer_curr_price ;
            delete saved_file.data.trainer_xp_f ;
            delete saved_file.data.trainer_upgrade_per_click ;
            delete saved_file.data.trainer_count ;
            
            delete saved_file.data.breeding_pokemon ;
            delete saved_file.data.currently_breeding ;
            delete saved_file.data.timer_breeding ;
            delete saved_file.data.breeding_mult_timer ;
            delete saved_file.data.breeding_level ;
            delete saved_file.data.breeding_experience ;
            delete saved_file.data.breeding_experience_to_level;
            
            delete saved_file.data.fighting_final_boss ;
            delete saved_file.data.special_fight_effect ;
            delete saved_file.data.final_boss_stolen_botomon ;
            delete saved_file.data.final_boss_timer ;
            delete saved_file.data.Is_Boss_Rush ;
            delete saved_file.data.final_63_boss_beat ;
            
            delete saved_file.data.current_area ;
            delete saved_file.data.current_stage_level ;
            delete saved_file.data.menu_current_area ;
            delete saved_file.data.total_time ;
            
            Template_Start();
            
            saved_file.flush();
            saved_file.close();            
        }
        
        // FUNCTIONS PUBLIC
        


        [SWF(width = "1025", height = "635", backgroundColor = "#0FFF0F", frameRate = "60")]
        public function Screen() : void {
            trace("START PROCESS");
            if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
            return;
        }
        
		private function init(e:Event = null):void {
            Kong_API_Set_Up();
            flash.net.registerClassAlias("src.Base_Pokemon", Base_Pokemon);
            flash.net.registerClassAlias("src.Item", Item);
            flash.net.registerClassAlias("src.Move", Move);
            flash.net.registerClassAlias("src.Item_Loader", Item_Loader);
            flash.net.registerClassAlias("src.Move_Loader", Move_Loader);
            flash.net.registerClassAlias("src.Base_Pokemon_Loader", Base_Pokemon_Loader);
            
            Text_Move_Results = new Array();
            
            Area.Set_Up_Area();
            //this.width = 2000;
            //this.height = 2000;
            //this.x = this.y = 0;
            removeEventListener(Event.ADDED_TO_STAGE, init);
            stage.addEventListener(KeyboardEvent.KEY_DOWN, Refresh_Key_Down);
            stage.addEventListener(KeyboardEvent.KEY_UP, Refresh_Key_Up);
            //stage.addEventListener(MouseEvent.MOUSE_WHEEL, Refresh_Mouse_Wheel);
            
            //BlastedMouseWheelBlock.initialize(stage, 
            
            saved_file = SharedObject.getLocal("Bot_Save", "/");
            Img_Bottom_Bar.ID = 0;

            Template_Start();
            Load_Sprites();

            stage.addEventListener(MouseEvent.MOUSE_DOWN, Refresh_Click);

            stage.addEventListener(Event.ENTER_FRAME, Refresh_Every_Frame);
        }
        
        private static var pibbypibbypibbypib = 0;
        private static var has_done_init_naming:Boolean = false;
        // sets default vars when save is reset OR when game starts up
        private function Template_Start():void {
            while ( Text_Move_Results.length != 0 ) Text_Move_Results.pop();
            Text_Move_Results.push(session_time + ": " + " Welcome to Herc Idle! Instructions are for losers, derive your own!");
            Text_Store_Results = new Array();
            Text_User_Results = new Array();
            
            poke_enemy = [ null, null, null, null ];
            poke_player = [ null, null, null, null ];
            poke_enemy_timer = [ null, null, null, null ];
            poke_player_new_enemy_timer = [ Random_Range(60, Max_Enemy_Respawn_Timer), Random_Range(60, Max_Enemy_Respawn_Timer),
                                            Random_Range(60, Max_Enemy_Respawn_Timer), Random_Range(60, Max_Enemy_Respawn_Timer) ];
            poke_player_timer = [ null, null, null, null ];
            trainer_curr_pokemon = null;
            pokemon_in_bank = [ ];
            var item_it:int = 0;
            for ( var i : int = 0; i != Item.Item_Name.length; ++ i )
                if ( Item.Item_Name[i] == "Charged Mini Crystal" ) item_it = i;
            inventory_items = [ new Item(0,0), new Item(item_it - 1,0) ];
            inventory_items_count = [ new int(3), new int (5) ];
            
            store_items = R_Store_Items(0);
            var x:String = "";
            for ( var i : int = 0; i != inventory_items.length; ++ i )
                x += " || " + String(i) + ": " + Item.Item_Name[Item(inventory_items[i]).R_Item_Type()];
            
            x = "";
            for ( i = 0; i != store_items.length; ++ i )
                x += " || " + String(i) + ": " + Item.Item_Name[Item(store_items[i]).R_Item_Type()];
            
            current_area = 0;
            current_menu_selected = 0;
                        
            st_current_scrollbar_ratio = 0;
            st_current_top_index = 0;
            in_current_scrollbar_ratio = 0;
            in_current_top_index = 0;
            pb_current_scrollbar_ratio = 0;
            pb_current_top_index = 0;
            total_time = session_time = 0;
            
            pokemon_in_bank = [ ];
            pibbypibbypibbypib = 0;
            has_done_init_naming = 0;
            current_money = 3000; // this should be enough money to get some moves and then
                                  // hopefully get a modifier and/or hex crystals
            current_s_money = 0;
            
            trainer_curr_pokemon = null;
            trainer_levels = [ 0, 0, 0, 0, 0, 0 ];
            trainer_xp_f = [ 0, 0, 0, 0, 0, 0 ];
            for ( var i : int = 0; i != 6; ++ i )
                trainer_curr_price[i] = Trainer_Price_Base[i];
            breeding_pokemon = [ null, null ];
            currently_breeding = 0;
            timer_breeding = 0;
        }
        
        // keyboard input for botomon name
        
        public static var setting_name:Boolean = false;
        public static var setting_temp_name:String = "";
        public static var setting_curr_char:int = -1;
        public static var setting_name_botomon:Base_Pokemon;
        public static var setting_refresh_time:int = 3;
        public static var setting_looping:Boolean = 0 as Boolean;
        public static var setting_looping_char:int = 0;
        
        
        public static function Start_New_Botomon_Name(x:Base_Pokemon){
            setting_name = true;
            setting_temp_name = "";
            setting_name_botomon = x;
        }
        
        
        private static function Refresh_Botomon_Name() {
            //if ( --setting_refresh_time >= 0 ) return;
            var t_setting_curr_char:int = -1;
            
            if ( Screen.Keyboard_Keys[Screen.K_enter] ) {
                Screen.Keyboard_Keys[Screen.K_enter] = 0; // so that the user has to press it twice instead of A+Enter = 4 A
                if ( setting_temp_name.length != 0 ) {
                    setting_name_botomon.Set_Name(setting_temp_name);
                    pokemon_in_bank.push(setting_name_botomon);
                    setting_name = false;
                    setting_temp_name = "";
                    setting_name_botomon = null;
                    return;
                }
            }
            if ( Screen.Keyboard_Keys[Screen.K_backspace] ) {
                if ( setting_curr_char == -1 ) {
                    t_setting_curr_char = Screen.K_backspace;
                    if ( setting_temp_name.length > 0 )
                        setting_temp_name = setting_temp_name.slice(0, setting_temp_name.length - 1);
                }
            }
            if ( setting_temp_name.length < 16 ) {
                for ( var i : int = 0; i != Screen.K_z + 1; ++ i ) {
                    if ( Screen.Keyboard_Keys[i + K_a] )
                        if ( setting_curr_char == -1 ) {
                            setting_temp_name += String.fromCharCode( i + 97 - Keyboard_Keys[K_shift] * 0 );
                            t_setting_curr_char = i + K_a;
                        }
                }
                for ( var i : int = Screen.K_0; i != K_9 + 1; ++ i ) {
                    if ( Screen.Keyboard_Keys[i] )
                        if ( setting_curr_char == -1 ) {
                            setting_temp_name += String.fromCharCode(i + 48 - 26); // 26 is offset
                            t_setting_curr_char = i;
                        }
                }
                if ( Screen.Keyboard_Keys[Screen.K_space] ) {
                    if ( setting_curr_char == -1 ) {
                        setting_temp_name += " ";
                        t_setting_curr_char = K_space;
                    }
                }
            }
            if ( !Screen.Keyboard_Keys[setting_curr_char] || setting_looping ) {
                if ( !Screen.Keyboard_Keys[setting_looping_char] ) setting_looping = 0;
                else if ( setting_looping ) {
                    setting_curr_char = -1;
                    setting_refresh_time = 8;
                    return;
                }
                setting_curr_char = t_setting_curr_char;
                setting_refresh_time = 20;
            }
            else if ( --setting_refresh_time <= 0 ) {
                setting_looping = 1;
                setting_looping_char = setting_curr_char;
            }
        }
                
        // pretty much only ever to be used in brand new areas or new save
        private function R_Store_Items(stage:int):Array {
            var ar:Array = new Array();
            for ( var x : int = 0; x != stage+1; ++ x )
            for ( var i : int = 0; i != Item.Item_In_Store.length; ++ i )
                if ( Item.Item_In_Store[i] )
                    ar.push(new Item(i, x) );
            return ar;
        }
        public static var hex_crystal_max:int = 10;
        public static var triple_experience:Array = [ 0, 0, 0, 0 ];
        private function Win_Battle(i:int):void { // does item l00t, experience, etc
            ++botomon_kill_amt;
            var val:Number = Math.floor((poke_enemy[i] as Base_Pokemon).R_Value() * Level_Stage.Stage_Player_Mult[current_stage_level]);
            
            var money:int = Math.floor(Number(Random_Range((val * 20) * .4, (val * 60) * 1.2)) / Number(25)) * .5,
                   xp:int = Math.floor(Number(Random_Range((val * 20) * .4,  (val * 40) * 1.2)) / Number(25)) * 4,
                item_c:int = int(Random_Range(0, 100 * Level_Stage.Stage_Enemy_Mult[current_stage_level]) < 1 + current_stage_level);
            if ( triple_experience[i] > 0 )
                xp *= 3;
            if ( ++hex_crystal_count >= 10 ) {
                hex_crystal_count = 0;
                var x:int;
                for ( x = 0;; ++ x )
                    if ( Item.Item_Name[x] == "Soul Crystal Hex" ) break;
                Add_Item_Inventory(new Item(x, (poke_enemy[i] as Base_Pokemon).R_Stage()));
            }
            if ( is_auto_heal[i] ) {
                money *= .8;
                xp *= .8;
                
                (poke_player[i] as Base_Pokemon).Set_Health((poke_player[i] as Base_Pokemon).R_Max_Health());
            }
            
            var stage_chance:int = (Random_Range(0, 100000) % 3);
            var stagess: int = (poke_enemy[i] as Base_Pokemon).R_Stage() - stage_chance;
            if ( stagess < 0 )
                stagess = 0;
            var mod_st:int = 0;
            for ( var z : int = 0; z != Item.Item_Name.length; ++ z )
                if ( Item.Item_Name[z] == "Welder Modifier" ) {
                    mod_st = z;
                    break;
                }
            var item_t:Item = new Item(Random_Range(mod_st, mod_st + 16),
                                       Random_Range(stagess,
                                                    (poke_enemy[i] as Base_Pokemon).R_Stage()));
            current_money += money;
            var bot_ascended:Boolean;
             // xp
            if ( (poke_player[i] as Base_Pokemon).Add_Experience(xp) == 1 ) { // ascension
                bot_ascended = 1;
            }
            // item
            if ( item_c ) {
                Add_Item_Inventory(item_t);
                item_o += ", got " + Item.Item_Name[item_t.R_Item_Type()];
            }
            // output
            var item_o:String = "";
            if ( (poke_enemy[i] as Base_Pokemon).R_Hexed() ) {
                var item_start:int;
                for ( var item_it : int = 0; item_it != Item.Item_Name.length; ++ item_it )
                    if ( Item.Item_Name[item_it] == "Charged Mini Crystal" ) {
                        item_start = item_it;
                    }
                var item_chance:int = Random_Range(0, 350000 * ((poke_enemy[i] as Base_Pokemon).R_Level() / 65)*((poke_player[i] as Base_Pokemon).R_Level() / 65));
                item_chance *= (current_area % 11)/3;
                
                var item_get:int = item_chance > 0 ? item_chance > 50000 ? item_chance > 95000 ?
                                   item_chance > 130000 ? item_chance > 150000 ? item_chance > 200000 ?
                                   item_chance > 250000 ? item_chance > 300000 ? item_chance > 400000 ?
                                   item_chance > 500000 ?
                                   
                                   item_start + 10 : item_start + 8 : item_start + 7 :
                                   item_start + 6 : item_start + 5 : item_start + 4 :
                                   item_start + 3 : item_start + 2 : item_start + 1 :
                                   item_start : item_start;
                
                if ( Random_Range(0, 1000) < 2 ) {
                    item_get = item_start + 9;
                    ++collected_herclodian_crystals;
                }
                var stage_chance:int = (Random_Range(0, 100000) % 3);
                if ( (poke_enemy[i] as Base_Pokemon).R_Stage() - stage_chance < 0 )
                    stage_chance = (poke_enemy[i] as Base_Pokemon).R_Stage();
                
                Add_Item_Inventory(new Item(item_get,
                    Random_Range(stagess, (poke_enemy[i] as Base_Pokemon).R_Stage())));
                item_o += ", got " + Item.Item_Name[item_get];
            }
            
            Text_Move_Results.push(session_time+": " + (poke_player[i] as Base_Pokemon).R_Name() + " slayed the "
                + Base_Pokemon_Stats.Poke_Name[(poke_enemy[i] as Base_Pokemon).R_Species_ID()] +
                    " for $" + money + ", " + xp + " xp"+ item_o);
            if ( bot_ascended )
                Text_User_Results.push(session_time+": "+ (poke_player[i] as Base_Pokemon).R_Name() + " has ascended to stage "
                    + (poke_player[i] as Base_Pokemon).R_Stage() + "!!");
        }
        
        public function Refresh_Click(e:MouseEvent):void {
            mouse_down = e.buttonDown;
        }
        public function Refresh_Delta_Menu(e:int):void {
            var x:int = e;
            down_key_ref = 2;
            switch ( current_menu_selected ) {
                case Menu_Menu:
                    x *= -1;
                    if ( x > 1 ) x = 10; // amount of areas
                    if ( x < -1 ) x = -10;
                    if ( area_dropdown_top_index + x >= 0
                    &&   area_dropdown_top_index + x < Area.Area_Name.length * (1+current_stage_level))
                        area_dropdown_top_index += x;
                    else if ( area_dropdown_top_index + x < 0 ) area_dropdown_top_index = 0;
                    else if ( area_dropdown_top_index + x >= Area.Area_Name.length * (1 + current_stage_level))
                        area_dropdown_top_index = Area.Area_Name.length * (1+current_stage_level) - 1
                break;
                case Menu_Pokemon:
                    if ( pb_current_top_index + x >= 0
                    &&   pb_current_top_index + x < pokemon_in_bank.length )
                        pb_current_top_index += x;
                break;
                case Menu_Store:
                    if ( st_current_top_index + x >= 0
                    &&   st_current_top_index + x < store_items.length )
                        st_current_top_index += x;
                break;
                case Menu_Inventory:
                    if ( in_current_top_index + x >= 0
                    &&   in_current_top_index + x < inventory_items.length )
                        in_current_top_index += x;
                break;
            }
        }
        public function Toggle_Key_From_Event(x:int, toggle:Boolean) : void {
            trace(x);
            //sa 40 sz 65 s0 66 s9 75
            if ( x >= 97 && x <= 122 || x >= 65 && x <= 90 )
                Keyboard_Keys[x - 97] = toggle;
            if ( x >= 48 && x <= 57 )
                Keyboard_Keys[x - (48 - 26)] = toggle;
            //if ( x >= 
            if ( x == 11 ) {
                Keyboard_Keys[K_shift] = toggle;
            }
            if ( x == 32 ) {
                Keyboard_Keys[K_space] = toggle;
            }
            if ( x == 8 )
                Keyboard_Keys[K_backspace] = toggle;
            if ( x == 13 )
                Keyboard_Keys[K_enter] = toggle;
        }
        public function Clean_Botomon_Bank() {
            for ( var i : int = 0; i != pokemon_in_bank.length; ++ i )
                if ( pokemon_in_bank[i] == null ||
                     pokemon_in_bank[i] == 0 ) {
                     pokemon_in_bank.splice(i, 1)
                }
        }
        public static var down_key_ref:int = 0;
        private function Refresh_Key_Down(e:KeyboardEvent):void {
            Toggle_Key_From_Event(e.charCode, 1);
            if ( e.shiftKey )
                Keyboard_Keys[K_shift] = true;
            if ( --down_key_ref < 0 ) {
                if ( !setting_name) {
                    if ( e.charCode == 119 ) Refresh_Delta_Menu( -1);
                    else if ( e.charCode == 115 ) Refresh_Delta_Menu( 1);
                    else if ( e.charCode == 97 ) Refresh_Delta_Menu( -5);
                    else if ( e.charCode == 100 ) Refresh_Delta_Menu( 5);
                    else if ( e.charCode == 101 ) Refresh_Delta_Menu( 100 );
                    else if ( e.charCode == 113 ) Refresh_Delta_Menu( -100 );
               }
            }
        }
        private function Refresh_Key_Up(e:KeyboardEvent):void {
            Toggle_Key_From_Event(e.charCode, 0);
            if ( !e.shiftKey )
                Keyboard_Keys[K_shift] = false;
            if ( !Keyboard_Keys[K_w] && !Keyboard_Keys[K_s] && !Keyboard_Keys[K_a] &&
                 !Keyboard_Keys[K_d] ) down_key_ref = -1;
        }
        private static var REF_Count:int = 0;
        private static var Beta_Key_Timer:int = 10;
        private static var Collection_Heal_Timer:int = 100;
        private static var is_auto_save:Boolean = false;
        public function Refresh_Every_Frame(e:Event) : void {
            if ( pibbypibbypibbypib != 5 && has_done_init_naming == 0) {
                Refresh_Mouse_Statistics();
                if ( Mouse_In_Img( Img_Menu_Load_Button ) && mouse_down ) {// put here instead of menu because pibbypibbypibbypib
                    Load();
                    return;
                } else if ( mouse_down ) mouse_down = 0;
                if ( !setting_name ) {
                    var bas_pok:Base_Pokemon = new Base_Pokemon(0, 0);
                    Start_New_Botomon_Name(bas_pok);
                    if ( ++pibbypibbypibbypib == 5 ) {
                        Clean_Botomon_Bank();
                        has_done_init_naming = 1;
                        setting_name = 0;
                    }
                }
            }
            Draw_Screen();
            if ( setting_name )
                Refresh_Botomon_Name();
            else {
                if ( Keyboard_Keys[K_k] && !setting_name ) {
                    Save();
                }
                if ( Keyboard_Keys[K_l] && Keyboard_Keys[K_o] && !setting_name ) {
                    Load();
                }
                if ( --Collection_Heal_Timer <= 0 ) {
                    Collection_Heal_Timer = 260;
                    for ( var i : int = 0; i != pokemon_in_bank.length; ++ i )
                        (pokemon_in_bank[i] as Base_Pokemon).Set_Health((pokemon_in_bank[i] as Base_Pokemon).R_Curr_Health() + 
                                                                        (pokemon_in_bank[i] as Base_Pokemon).R_Level() *
                                                                        Level_Stage.Stage_Player_Mult[(pokemon_in_bank[i] as Base_Pokemon).R_Stage()]);
                }
                for ( var i : int = 0; i != pokemon_in_bank.length; ++ i )
                    (pokemon_in_bank[i] as Base_Pokemon).Refresh_Item_Timer();
                for ( var i : int = 0; i != 4; ++ i )
                    if ( poke_player[i] != null ) {
                        (poke_player[i] as Base_Pokemon).Refresh_Item_Timer();
                        if ( !Base_Pokemon(poke_player[i]).R_Is_Dead() &&
                             poke_player_new_enemy_timer[i] > 90000 ) poke_player_new_enemy_timer[i] = 40;
                    }
                if ( currently_breeding && timer_breeding > 27000 ) timer_breeding = 24000;
                //12 13 11 15 14 13
                // advertisements!
                if ( session_time % 1000 == 0 && is_auto_save )
                    Save();
                if ( session_time % 100000 == 0 )
                    Text_User_Results.push("AD: Come join Pride chat and make the dev unlonely!");
                if ( session_time % 500000 == 0 )
                    Text_User_Results.push("AD: Programmer? Join Game Dev Room to chat!");
                if ( session_time % 1000000 == 0 )
                    Text_User_Results.push("This is a Kongregate Exclusive game!");
                if ( session_time % 2000000 == 0 )
                    Text_User_Results.push("Please donate to me, I'm starving.");
                if ( session_time % 3000000 == 0 )
                    Text_User_Results.push("If enough ask, I might post source code on github");
                if ( session_time % 4000000 == 0 )
                    Text_User_Results.push("By Xenocideophile/InfiNinete Fingers/Hercludes");
                if ( session_time % 5000000 == 0 )
                    Text_User_Results.push("(All one person). Check out Core of Pulcher!!");
                if ( session_time % 8000000 == 0 )
                    Text_User_Results.push("Special thanks to Pride & GDR for beta testing!");
                if ( session_time % 160000000 == 0 )
                    Text_User_Results.push("Thanks to Martyn898 for idea & stain88 for testing!");
                // check mouse/keyboard events and run battle process
                ++session_time;
                if ( timer_breeding > 0 ) --timer_breeding;
                if ( timer_breeding == 0 && currently_breeding ) {
                    Text_User_Results.push(session_time +": " +"Sexy time is over, breeding is complete.");
                    breeding_done = true;
                    --timer_breeding;
                }
                Refresh_Mouse_Statistics();
                Refresh_UI_Menu_Mouse_Check ();
                Trainer_Refresh();
                Fight_Frame();
                for ( var i : int = 0; i != 4; ++ i ) {
                    if ( triple_experience[i] >= 0 )
                        --triple_experience[i];
                    if ( botomon_player_damaged[i] > 0 )
                        --botomon_player_damaged[i];
                    else if ( poke_player[i] == null )
                        botomon_player_damaged[i] = 0;
                    
                    if ( botomon_enemy_damaged[i] > 0 )
                        --botomon_enemy_damaged[i];
                    else if ( poke_enemy[i] == null )
                        botomon_enemy_damaged[i] = 0;
                    
                    if ( final_boss_damaged > 0 )
                        --final_boss_damaged;
                    else if ( final_boss == null )
                        final_boss_damaged = 0;
                        
                    if ( poke_enemy[i] != null )
                    if ( Base_Pokemon(poke_enemy[i]).R_Species_ID() == Base_Pokemon_Stats.Poke_Name.length - 1 ) {
                        poke_enemy[i] = null;
                        poke_player_new_enemy_timer[i] = 250;
                    }
                }
                /* b0t0m0n */
                return;
            }
        }
        public function Trainer_Refresh():void {
            if ( trainer_curr_pokemon == null ) return;
            if ( ++trainer_count >= Trainer_Count_Max ) {
                trainer_count = 0;
                var prev_level:int = trainer_curr_pokemon.R_Level();
                for ( var i : int = 3; i != 6; ++ i )
                    trainer_curr_pokemon.Add_Experience(trainer_xp_f[i]);
                if ( trainer_curr_pokemon.R_Level() != prev_level ) {
                    // sort through all the botomons and decide which ones from everywhere are highest level
                    // The only vars that are truly important are fourth highest level and # of botomon
                    if ( trainer_curr_pokemon.R_Stage() >= current_stage_level ) {
                        Text_Store_Results.push("Botomon's stage has to be lower than current stage!");
                        pokemon_in_bank.push(trainer_curr_pokemon);
                        trainer_curr_pokemon = null;
                    }
                }
            }
        }
        private function Menu_Switch_Check():Boolean {
            var mouse_x:int = this.mouseX;
            
            if ( this.mouseY > Bottom_Menu_Switch_Bar_Y ) {
                if ( mouse_x <= Bottom_Menu_Switch_Bar_Store_X ) {
                    current_menu_selected = Menu_Store;
                } else if ( mouse_x <= Bottom_Menu_Switch_Bar_Items_X ) {
                    current_menu_selected = Menu_Inventory;
                } else if ( mouse_x <= Bottom_Menu_Switch_Bar_Poke_Bank_X ) {
                    current_menu_selected = Menu_Pokemon;
                } else if ( mouse_x <= Bottom_Menu_Switch_Bar_Party_X ) {
                    current_menu_selected = Menu_Party;
                } else if ( mouse_x <= Bottom_Menu_Switch_Bar_Breeding_X ) {
                    current_menu_selected = Menu_Breeding;
                } else if ( mouse_x <= Bottom_Menu_Switch_Bar_Trainer_X ) {
                    current_menu_selected = Menu_Trainer;
                } else if ( mouse_x <= Bottom_Menu_Switch_Bar_Menu_X ) {
                    current_menu_selected = Menu_Menu;
                } else return 0;
                return 1;
            } else return 0;
                
        
        }
        
        private function Refresh_UI_Menu_Mouse_Check() : void {
            if ( mouse_down ) {
                mouse_down = 0;
                if ( !Menu_Switch_Check() ) // also does routines if menus were switched
                if ( Mouse_In_Img( Img_Menu_Load_Button ) ) {// put here instead of menu because pibbypibbypibbypib
                    Load();
                    return;
                }
                switch ( current_menu_selected ) {
                    case Menu_Menu:
                        // area
                        if ( Mouse_In_Box( 90, 369, 248, 450) )
                            area_dropdown_selected = area_dropdown_top_index;
                        if ( Mouse_In_Img( Img_Menu_Save_Button ) )
                            Save();
                        if ( Mouse_In_Img( Img_Menu_Reset_Button ) )
                            Reset_Save();
                        if ( Mouse_In_Img( Img_Up_Arrow ) ) {
                            if ( area_dropdown_top_index + 1 < Area.Area_Stage.length ) {
                                area_dropdown_top_index += 1;
                                area_dropdown_selected = area_dropdown_top_index;
                            }
                        }
                        
                        if ( Mouse_In_Img( Img_0_Button ) ) {
                            is_auto_save = false;
                        }
                        if ( Mouse_In_Img( Img_1_Button ) ) {
                            is_auto_save = true;
                        }
                        
                        if ( Mouse_In_Img( Img_Down_Arrow ) ) {
                            if ( area_dropdown_top_index - 1 >= 0 ) {
                                area_dropdown_top_index -= 1;
                                area_dropdown_selected = area_dropdown_top_index;
                            }
                        }
                        if ( Mouse_In_Img( Img_Menu_GO ) ) {
                            if ( current_area != area_dropdown_selected ) {
                                // clear pokemon from fighting (doesn't happen anymore! MWahahaha)
                                /*
                                poke_player_timer = [ 0, 0, 0, 0 ];
                                poke_player_new_enemy_timer = [ Random_Range(60, Max_Enemy_Respawn_Timer), Random_Range(60, Max_Enemy_Respawn_Timer),
                                                                Random_Range(60, Max_Enemy_Respawn_Timer), Random_Range(60, Max_Enemy_Respawn_Timer)];
                                
                                poke_enemy = [ null, null, null, null ];
                                poke_enemy_timer = [ 0, 0, 0, 0 ];
                                */
                                // change area
                                current_area = area_dropdown_selected;
                            }
                        }
                        if ( Mouse_In_Img( Img_X_Button ) ) {
                            var will_fight_fin_boss:Boolean = 0;
                            for ( var i : int = 0; i != 4; ++ i )
                                if ( poke_player[i] != null ) will_fight_fin_boss = 1;
                            if ( !will_fight_fin_boss ) {
                                Text_User_Results.push("You need to equip bots to fight final boss!");
                                break;
                            }
                            if ( final_63_boss_beat )
                                Boss_Rush_Start();
                            else
                                Boss_Fight_Start();
                        }
                    break;
                    case Menu_Party:
                        // party member removed ?
                        if ( Mouse_In_Img( Img_X_Button ) ) {                        
                            if (  mouseX < 300 && mouseY < (height + 60) / 2 ) {
                                if ( !(poke_player[0] as Base_Pokemon).R_Is_Dead() &&
                                     triple_experience[0] < 0 ) {
                                    pokemon_in_bank.push(poke_player[0]);
                                    poke_player[0] = null;
                                    is_auto_heal[0] = 0;
                                }
                            } else if ( mouseX < 300 && mouseY > (height + 60) / 2 ) {
                                if ( !(poke_player[1] as Base_Pokemon).R_Is_Dead() &&
                                     triple_experience[0] < 0 ) {
                                    pokemon_in_bank.push(poke_player[1]);
                                    poke_player[1] = null;
                                    is_auto_heal[1] = 0;
                                }
                            } else if ( mouseX > 300 && mouseY < (height+60) / 2 ) {
                                if ( !(poke_player[2] as Base_Pokemon).R_Is_Dead() &&
                                     triple_experience[0] < 0 ) {
                                    pokemon_in_bank.push(poke_player[2]);
                                    poke_player[2] = null;
                                    is_auto_heal[2] = 0;
                                }
                            } else if ( mouseX > 300 && mouseY > (height+60) / 2 ) {
                                if ( !(poke_player[3] as Base_Pokemon).R_Is_Dead() &&
                                     triple_experience[0] < 0 ) {
                                    pokemon_in_bank.push(poke_player[3]);
                                    poke_player[3] = null;
                                    is_auto_heal[3] = 0;
                                }
                            }
                        }
                        if ( Mouse_In_Img( Img_1_Button ) ) {
                            if (  mouseX < 300 && mouseY < (height + 60) / 2 ) {
                                    is_auto_heal[0] = 0;
                            } else if ( mouseX < 300 && mouseY > (height + 60) / 2 ) {
                                    is_auto_heal[1] = 0;
                            } else if ( mouseX > 300 && mouseY < (height+60) / 2 ) {
                                    is_auto_heal[2] = 0;
                            } else if ( mouseX > 300 && mouseY > (height+60) / 2 ) {
                                    is_auto_heal[3] = 0;
                            }
                        }
                        if ( Mouse_In_Img( Img_0_Button ) ) {
                            if (  mouseX < 300 && mouseY < (height + 60) / 2 ) {
                                if ( Level_Stage.Stage_Player_Mult[(poke_player[0] as Base_Pokemon).R_Stage()] * 1000 <= current_money ) {
                                    current_money -= Level_Stage.Stage_Player_Mult[(poke_player[0] as Base_Pokemon).R_Stage()] * 1000;
                                    is_auto_heal[0] = 1;
                                }
                            } else if ( mouseX < 300 && mouseY > (height + 60) / 2 ) {
                                if ( Level_Stage.Stage_Player_Mult[(poke_player[1] as Base_Pokemon).R_Stage()] * 1000 <= current_money ) {
                                    current_money -= Level_Stage.Stage_Player_Mult[(poke_player[1] as Base_Pokemon).R_Stage()] * 1000;
                                    is_auto_heal[1] = 1;
                                }
                            } else if ( mouseX > 300 && mouseY < (height+60) / 2 ) {
                                if ( Level_Stage.Stage_Player_Mult[(poke_player[2] as Base_Pokemon).R_Stage()] * 1000 <= current_money ) {
                                    current_money -= Level_Stage.Stage_Player_Mult[(poke_player[2] as Base_Pokemon).R_Stage()] * 1000;
                                    is_auto_heal[2] = 1;
                                }
                            } else if ( mouseX > 300 && mouseY > (height+60) / 2 ) {
                                if ( Level_Stage.Stage_Player_Mult[(poke_player[3] as Base_Pokemon).R_Stage()] * 1000 <= current_money ) {
                                    current_money -= Level_Stage.Stage_Player_Mult[(poke_player[3] as Base_Pokemon).R_Stage()] * 1000;
                                    is_auto_heal[3] = 1;
                                }
                            }
                        }
                    break;
                    case Menu_Breeding:
                        if ( Mouse_In_Img( Img_Breed_Button ) ) {
                                currently_breeding = 1;
                                timer_breeding = Math.floor(Number(30 * 40 * 20)
                                    * breeding_mult_timer);
                                if ( Base_Pokemon_Stats.Poke_Name[Base_Pokemon(breeding_pokemon[0]).R_Species_ID()] == "Doc_Ted Cloud" )
                                    timer_breeding *= .5;
                        }
                        if ( Mouse_In_Img( Img_Breed_Collect ) ) {
                            if ( timer_breeding <= 0 ) {
                                currently_breeding = 0;
                                ++botomon_bred;
                                timer_breeding = 0;
                                breeding_done = false;
                                // xp stuff
                                breeding_experience += Math.floor(Number(30 * 30 * 20 *
                                    Level_Stage.Stage_Player_Mult[(breeding_pokemon[0] as Base_Pokemon).R_Stage()])
                                    * breeding_mult_timer) / 50;
                                if ( breeding_level != Breeding_Level_Cap )
                                while ( breeding_experience >= breeding_experience_to_level ) {
                                    breeding_experience_to_level += breeding_add_exp_per_level;
                                    breeding_experience_to_level = 
                                        Math.floor(Number(breeding_experience_to_level) * breeding_mult_exp_per_level);
                                    
                                    ++breeding_level;
                                    Text_User_Results.push("Breeding mechanics have been improved, better sex!");
                                    breeding_mult_timer -= breeding_sub_mult_per_level;
                                }
                                
                                var bot_breed:int;
                                if ( Random_Range(0, 100) < 20 || breeding_force_new ) // new pokemon breed
                                    bot_breed = Random_Range(0, Base_Pokemon_Stats.Poke_Name.length-2);
                                else
                                    bot_breed = (breeding_pokemon[0] as Base_Pokemon).R_Species_ID();
                                breeding_force_new = false;
                                var bas_pok:Base_Pokemon = new Base_Pokemon(
                                    bot_breed,
                                    (breeding_pokemon[0] as Base_Pokemon).R_Stage(),
                                    1, 1, null
                                );
                                Start_New_Botomon_Name(bas_pok);// is added to the thingy
                                Clean_Botomon_Bank();
                            }
                        }
                        if ( Mouse_In_Img( Img_X_Button ) ) {
                            if ( mouseX < 300 ) {
                                pokemon_in_bank.push(breeding_pokemon[0]);
                                breeding_pokemon[0] = null;
                            } else {
                                pokemon_in_bank.push(breeding_pokemon[1]);
                                breeding_pokemon[1] = null;
                            }
                        }
                    break;
                    case Menu_Pokemon:
                            /*
                            *                     Apply_To_Screen("Sort by name", 40, 250);
                        Apply_Img_To_Screen(Img_X_Button, 60, 270);
                        Apply_To_Screen("Sort by type", 130, 250);
                        Apply_Img_To_Screen(Img_X_Button, 150, 270);
                        Apply_To_Screen("Sort by level", 220, 250);
                        Apply_Img_To_Screen(Img_X_Button, 240, 270);
                        */
                        if ( Mouse_In_Img ( Img_X_Button ) ) {
                            if ( mouseY < 296 ) {
                                if ( mouseX < 120 ) {
                                    if ( Bubble_Sort.bot_sort_flip == Bubble_Sort.Name )
                                        if ( Bubble_Sort.bot_sort_flip_val == 1 )
                                            Bubble_Sort.bot_sort_flip_val = 0;
                                        else Bubble_Sort.bot_sort_flip_val = 1;
                                        //Bubble_Sort.bot_sort_flip_val = Bubble_Sort.item_sort_flip_val == 1?0:1;
                                    else
                                        Bubble_Sort.bot_sort_flip_val = 0;
                                    Bubble_Sort.Bot_Sort(pokemon_in_bank, Bubble_Sort.Name, Bubble_Sort.bot_sort_flip_val);
                                    Bubble_Sort.bot_sort_flip = Bubble_Sort.Name;
                                    trace("BOT SORT FLIP: " + Bubble_Sort.bot_sort_flip + ", VAL: " + Bubble_Sort.bot_sort_flip_val);
                                }
                                else if ( mouseX < 230 ) {
                                    if ( Bubble_Sort.bot_sort_flip == Bubble_Sort.Type )
                                        if ( Bubble_Sort.bot_sort_flip_val == 1 )
                                            Bubble_Sort.bot_sort_flip_val = 0;
                                        else Bubble_Sort.bot_sort_flip_val = 1;
                                    else
                                        Bubble_Sort.bot_sort_flip_val = 0;
                                    Bubble_Sort.Bot_Sort(pokemon_in_bank, Bubble_Sort.Type, Bubble_Sort.bot_sort_flip_val);
                                    Bubble_Sort.bot_sort_flip = Bubble_Sort.Type;
                                } else {
                                    if ( Bubble_Sort.bot_sort_flip == Bubble_Sort.Level )
                                        if ( Bubble_Sort.bot_sort_flip_val == 1 )
                                            Bubble_Sort.bot_sort_flip_val = 0;
                                        else Bubble_Sort.bot_sort_flip_val = 1;
                                    else
                                        Bubble_Sort.bot_sort_flip_val = 0;
                                    Bubble_Sort.Bot_Sort(pokemon_in_bank, Bubble_Sort.Level, Bubble_Sort.bot_sort_flip_val);
                                    Bubble_Sort.bot_sort_flip = Bubble_Sort.Level;
                                }
                                return;
                            }
                            /*
                            * 317 - 345
                            * 360 - 400
                            * 416 - 446
                            * 465 - 495
                            * */
                            var i:int = 0;
                            if ( mouseY > 317 && mouseY < 345 )
                                i = 0;
                            else if ( mouseY > 360 && mouseY < 400 )
                                i = 1;
                            else if ( mouseY > 416 && mouseY < 446 )
                                i = 2;
                            else if ( mouseY > 465 && mouseY < 495 )
                                i = 3;
                            else i = 4;
                            Text_Store_Results.push(session_time + ": " +(pokemon_in_bank[pb_current_top_index + i] as Base_Pokemon).R_Name() + " has been sold!");
                            current_s_money += (pokemon_in_bank[pb_current_top_index + i] as Base_Pokemon).R_Value();
                            pokemon_in_bank[pb_current_top_index + i] = null;
                            pokemon_in_bank.splice(pb_current_top_index + i, 1);
                            if ( pb_current_top_index >= pokemon_in_bank.length ) pb_current_top_index = pokemon_in_bank.length - 1;
                            return;
                        }
                        if ( Mouse_In_Img ( Img_Trainer_Button ) ) {
                            var tr_it:int = 0;
                            if ( mouseY > 317 && mouseY < 355 )
                                tr_it = 0;
                            else if ( mouseY > 370 && mouseY < 420 )
                                tr_it = 1;
                            else if ( mouseY > 423 && mouseY < 460 )
                                tr_it = 2;
                            else if ( mouseY > 465 && mouseY < 500 )
                                tr_it = 3;
                            else tr_it = 4;
                                                        
                            if ( pokemon_in_bank[pb_current_top_index + tr_it].R_Stage() >= current_stage_level ) {
                                Text_Store_Results.push("Botomon's stage has to be lower than current stage!");
                            } else {
                                var t:Base_Pokemon = trainer_curr_pokemon; // pre-req to test
                                trainer_curr_pokemon = pokemon_in_bank[pb_current_top_index + tr_it];
                                if ( t != null )
                                    pokemon_in_bank[pb_current_top_index + tr_it] = t;
                                else
                                    pokemon_in_bank.splice(pb_current_top_index + tr_it, 1);
                                if ( pb_current_top_index >= pokemon_in_bank.length )
                                    pb_current_top_index = pokemon_in_bank.length - 1;
                            }
                            return;
                        }
                        if ( Mouse_In_Img ( Img_Breed_Female_Button ) ||
                             Mouse_In_Img ( Img_Breed_Male_Button ) ) {
                            var i:int = 0;
                            if ( mouseY > 317 && mouseY < 355 )
                                i = 0;
                            else if ( mouseY > 370 && mouseY < 420 )
                                i = 1;
                            else if ( mouseY > 423 && mouseY < 460 )
                                i = 2;
                            else if ( mouseY > 465 && mouseY < 500 )
                                i = 3;
                            else i = 4;
                            
                            var Break_From_Breed_Check:Boolean = false;
                            // pre-reqs
                            for ( var breed_it:int = 0; breed_it != 2; ++ breed_it )
                                if ( breeding_pokemon[breed_it] != null )
                                    if ( (breeding_pokemon[breed_it] as Base_Pokemon).R_Species_ID() !=
                                         (pokemon_in_bank[pb_current_top_index + i] as Base_Pokemon).R_Species_ID() ||
                                         (breeding_pokemon[breed_it] as Base_Pokemon).R_Stage() !=
                                         (pokemon_in_bank[pb_current_top_index + i] as Base_Pokemon).R_Stage() )
                                                Break_From_Breed_Check = true;
                            if ( !Break_From_Breed_Check ) {
                                var gender:int = int((pokemon_in_bank[pb_current_top_index + i] as Base_Pokemon).R_Gender());
                                var t:Base_Pokemon = breeding_pokemon[gender];
                                
                                breeding_pokemon[gender] =
                                    pokemon_in_bank[pb_current_top_index + i];
                                if ( t != null )
                                    pokemon_in_bank[pb_current_top_index + i] = t;
                                else
                                    pokemon_in_bank.splice(pb_current_top_index + i, 1);
                                if ( pb_current_top_index >= pokemon_in_bank.length )
                                    pb_current_top_index = pokemon_in_bank.length - 1;
                            }
                        }
                        if ( mouseY < 550 ) {
                            var button : Array = [ Img_1_Button, Img_2_Button, Img_3_Button,
                                                Img_4_Button ];
                            for ( var x:int = 0; x != 4; ++ x )
                                if ( Mouse_In_Img ( button[x] ) ) { // equip buttons
                                    var i:int = 0;
                                    if ( mouseY > 317 && mouseY < 345 )
                                        i = 0;
                                    else if ( mouseY > 360 && mouseY < 400 )
                                        i = 1;
                                    else if ( mouseY > 416 && mouseY < 446 )
                                        i = 2;
                                    else if ( mouseY > 465 && mouseY < 495 )
                                        i = 3;
                                    else i = 4;
                                    if ( triple_experience[x] < 0 )
                                    if ( poke_player[x] == null ||
                                        (poke_player[x] as Base_Pokemon).R_Is_Dead() == 0 ) {
                                        var t:Base_Pokemon = poke_player[x];
                                        poke_player[x] = pokemon_in_bank[pb_current_top_index + i];
                                        is_auto_heal[x] = 0;
                                        if ( t != null )
                                            pokemon_in_bank[pb_current_top_index + i] = t;
                                        else
                                            pokemon_in_bank.splice(pb_current_top_index + i, 1);
                                        if ( pb_current_top_index >= pokemon_in_bank.length )
                                            pb_current_top_index = pokemon_in_bank.length - 1;
                                    }
                                }
                        } else { // Rem Moves(I don't do the iteration thing because they're really close and I'm lazy)
                            if ( Mouse_In_Img( Img_1_Button ) && poke_player[0] != null ) {
                                if ( Keyboard_Keys[K_1] )
                                    (poke_player[0] as Base_Pokemon).Remove_Move(0);
                                    
                                else if ( Keyboard_Keys[K_2] )
                                    (poke_player[0] as Base_Pokemon).Remove_Move(1);
                                    
                                else if ( Keyboard_Keys[K_3] )
                                    (poke_player[0] as Base_Pokemon).Remove_Move(2);
                                    
                                    
                            } else if ( Mouse_In_Img( Img_2_Button ) && poke_player[1] != null ) {
                                if ( Keyboard_Keys[K_1] )
                                    (poke_player[1] as Base_Pokemon).Remove_Move(0);
                                    
                                else if ( Keyboard_Keys[K_2] )
                                    (poke_player[1] as Base_Pokemon).Remove_Move(1);
                                    
                                else if ( Keyboard_Keys[K_3] )
                                    (poke_player[1] as Base_Pokemon).Remove_Move(2);
                                    
                                    
                            } else if ( Mouse_In_Img( Img_3_Button ) && poke_player[2] != null ) {
                                if ( Keyboard_Keys[K_1] )
                                    (poke_player[2] as Base_Pokemon).Remove_Move(0);
                                    
                                else if ( Keyboard_Keys[K_2] )
                                    (poke_player[2] as Base_Pokemon).Remove_Move(1);
                                    
                                else if ( Keyboard_Keys[K_3] )
                                    (poke_player[2] as Base_Pokemon).Remove_Move(2);
                                    
                                    
                            } else if ( Mouse_In_Img( Img_4_Button ) && poke_player[3] != null ) {
                                if ( Keyboard_Keys[K_1] )
                                    (poke_player[3] as Base_Pokemon).Remove_Move(0);
                                    
                                else if ( Keyboard_Keys[K_2] )
                                    (poke_player[3] as Base_Pokemon).Remove_Move(1);
                                    
                                else if ( Keyboard_Keys[K_3] )
                                    (poke_player[3] as Base_Pokemon).Remove_Move(2);
                            }
                        }
                        
                        if ( Mouse_In_Img( Img_Up_Arrow ) )
                            if ( pb_current_top_index - 5 >= 0 )
                                pb_current_top_index -= 5;
                        if ( Mouse_In_Img( Img_Down_Arrow ) )
                            if ( pb_current_top_index + 5 < pokemon_in_bank.length )
                                pb_current_top_index += 5;
                        
                    break;
                    case Menu_Inventory:
                        if ( Mouse_In_Img(Img_0_Button) ) {
                            soul_crystal_hex_active = !soul_crystal_hex_active;
                        }
                        if ( Mouse_In_Img(Img_X_Button) ) {
                            if ( mouseY < 296 ) {
                                if ( mouseX < 120 ) {
                                    if ( Bubble_Sort.item_sort_flip == Bubble_Sort.Name )
                                        if ( Bubble_Sort.item_sort_flip_val == 0 )
                                            Bubble_Sort.item_sort_flip_val = 1;
                                        else
                                            Bubble_Sort.item_sort_flip_val = 0;
                                    else
                                        Bubble_Sort.item_sort_flip_val = 0;
                                    Bubble_Sort.Item_Sort(inventory_items, Bubble_Sort.Name, Bubble_Sort.item_sort_flip_val, 1);
                                    Bubble_Sort.item_sort_flip = Bubble_Sort.Name;
                                }
                                else if ( mouseX < 230 ) {
                                    if ( Bubble_Sort.item_sort_flip == Bubble_Sort.Type )
                                        if ( Bubble_Sort.item_sort_flip_val == 0 )
                                            Bubble_Sort.item_sort_flip_val = 1;
                                        else
                                            Bubble_Sort.item_sort_flip_val = 0;
                                    else
                                        Bubble_Sort.item_sort_flip_val = 0;
                                    Bubble_Sort.Item_Sort(inventory_items, Bubble_Sort.Type, Bubble_Sort.item_sort_flip_val, 1);
                                    Bubble_Sort.item_sort_flip = Bubble_Sort.Type;
                                }
                                return;
                            }
                            var i:int = 0;
                            if ( mouseY > 317 && mouseY < 345 )
                                i = 0;
                            else if ( mouseY > 353 && mouseY < 376 )
                                i = 1;
                            else if ( mouseY > 385 && mouseY < 411 )
                                i = 2;
                            else if ( mouseY > 411 && mouseY < 445 )
                                i = 3;
                            else i = 4;
                            
                            Text_Store_Results.push(session_time+": "+Item.Item_Name[Item(inventory_items[in_current_top_index + i]).R_Item_Type()] + " has been sold!");
                            var amt_sold:int = int(Boolean(mouseX > 736)) * 9 + 1 + int(Keyboard_Keys[K_t])*1000; // true = 10, false = 0
                            if ( inventory_items_count[in_current_top_index + i] < amt_sold )
                                amt_sold = inventory_items_count[in_current_top_index + i]; // in <10 items, clear all items
                            if ( Item.Item_Cost_Type[Item(inventory_items[in_current_top_index + i]).R_Item_Type()] == Item.Item_Currency_Type_Special )
                                current_s_money += Math.floor(Level_Stage.Stage_Enemy_Mult[Item(inventory_items[in_current_top_index + i]).R_Item_Stage()] *
                                                   Item.Item_Cost[Item(inventory_items[in_current_top_index + i]).R_Item_Type()] * amt_sold);
                            else
                                current_money += Math.floor(Level_Stage.Stage_Enemy_Mult[Item(inventory_items[in_current_top_index + i]).R_Item_Stage()] *
                                                 Item.Item_Cost[Item(inventory_items[in_current_top_index + i]).R_Item_Type()] * amt_sold);
                            inventory_items_count[in_current_top_index + i] -= amt_sold;
                            if ( inventory_items_count[in_current_top_index + i] <= 0 ) {
                                inventory_items_count.splice(in_current_top_index + i, 1);
                                inventory_items.splice(in_current_top_index + i, 1);
                            }
                        }
                        var buttons:Array = [ Img_1_Button, Img_2_Button, Img_3_Button,
                                             Img_4_Button ];
                        for ( var o:int = 0; o != 4; ++o )
                            if ( Mouse_In_Img(buttons[o]) ) {
                                var i:int = 0;
                                if ( mouseY > 317 && mouseY < 345 )
                                    i = 0;
                                else if ( mouseY > 353 && mouseY < 376 )
                                    i = 1;
                                else if ( mouseY > 385 && mouseY < 411 )
                                    i = 2;
                                else if ( mouseY > 411 && mouseY < 445 )
                                    i = 3;
                                else i = 4;
                                if ( poke_player[o] != null )
                                    if ( Item.Perform_Item(Item(inventory_items[in_current_top_index + i]), (poke_player[o] as Base_Pokemon)) ) {
                                        Text_Store_Results.push(session_time + ": " + Item.Item_Name[Item(inventory_items[in_current_top_index + i]).R_Item_Type()] +
                                            " has been used!");
                                        
                                        if ( --inventory_items_count[in_current_top_index + i] <= 0) {
                                            inventory_items.splice(in_current_top_index + i, 1);
                                            inventory_items_count.splice(in_current_top_index + i, 1);
                                        }
                                    }
                            }
                        
                        if ( Mouse_In_Img( Img_Up_Arrow ) )
                            if ( in_current_top_index - 5 >= 0 )
                                in_current_top_index -= 5;
                        if ( Mouse_In_Img( Img_Down_Arrow ) )
                            if ( in_current_top_index + 5 < inventory_items.length )
                                in_current_top_index += 5;
                        
                        
                    break; 
                    case Menu_Store:
                        if ( Mouse_In_Img(Img_X_Button) ) {
                            if ( mouseY < 296 ) {
                                if ( mouseX < 120 ) {
                                    if ( Bubble_Sort.item_sort_flip == Bubble_Sort.Name )
                                        if ( Bubble_Sort.item_sort_flip_val == 0 )
                                            Bubble_Sort.item_sort_flip_val = 1;
                                        else
                                            Bubble_Sort.item_sort_flip_val = 0;
                                    else
                                        Bubble_Sort.item_sort_flip_val = 0;
                                    Bubble_Sort.Item_Sort(store_items, Bubble_Sort.Name, Bubble_Sort.item_sort_flip_val, 0);
                                    Bubble_Sort.item_sort_flip = Bubble_Sort.Name;
                                }
                                else if ( mouseX < 230 ) {
                                    if ( Bubble_Sort.item_sort_flip == Bubble_Sort.Type )
                                        if ( Bubble_Sort.item_sort_flip_val == 0 )
                                            Bubble_Sort.item_sort_flip_val = 1;
                                        else
                                            Bubble_Sort.item_sort_flip_val = 0;
                                    else
                                        Bubble_Sort.item_sort_flip_val = 0;
                                    Bubble_Sort.Item_Sort(store_items, Bubble_Sort.Type, Bubble_Sort.item_sort_flip_val, 0);
                                    Bubble_Sort.item_sort_flip = Bubble_Sort.Type;
                                }
                                return;
                            }
                            var i:int = 0;
                            if ( mouseY > 317 && mouseY < 345 )
                                i = 0;
                            else if ( mouseY > 353 && mouseY < 376 )
                                i = 1;
                            else if ( mouseY > 385 && mouseY < 411 )
                                i = 2;
                            else if ( mouseY > 411 && mouseY < 445 )
                                i = 3;
                            else i = 4;
                            
                            var amt_sold:int = int(Boolean(mouseX > 736)) * 9 + 1; // true = 10, false = 0
                            
                            var item_cost:Number = Math.floor(Level_Stage.Stage_Enemy_Mult[Item(store_items[st_current_top_index + i]).R_Item_Stage()] *
                                                   Item.Item_Cost[Item(store_items[st_current_top_index + i]).R_Item_Type()]);
                            var item_type:int = Item.Item_Cost_Type[Item(store_items[st_current_top_index + i]).R_Item_Type()];
                            // if curr$ < items$ then items$ ~= (<) curr$
                            if ( item_type == Item.Item_Currency_Type_Special ) {
                                if ( item_cost * amt_sold > current_s_money )
                                    amt_sold = (current_s_money / item_cost);
                            } else {
                                if ( item_cost * amt_sold > current_money )
                                    amt_sold = (current_money / item_cost);
                            }
                            
                            if ( amt_sold <= 0 ) return; // don't want weird, exploitive bugs
                            if ( item_type == Item.Item_Currency_Type_Special )
                                current_s_money -= item_cost * amt_sold;
                            else
                                current_money -= item_cost * amt_sold;
                            Add_Item_Inventory(store_items[st_current_top_index + i], amt_sold);
                            Text_Store_Results.push(session_time + ": " + 
                                Item.Item_Name[Item(store_items[st_current_top_index + i]).R_Item_Type()] + " has been bought!");
                        }
                        if ( Mouse_In_Img( Img_Up_Arrow ) )
                            if ( st_current_top_index - 5 >= 0 )
                                st_current_top_index -= 5;
                        if ( Mouse_In_Img( Img_Down_Arrow ) )
                            if ( st_current_top_index + 5 < store_items.length )
                                st_current_top_index += 5;
                    break;
                    case Menu_Trainer:
                        if ( Mouse_In_Img(Img_Trainer_Upgrade_Button) ) {
                            if ( mouseY > 280 && mouseY < 325 )
                                if ( mouseX < 500 )
                                    Upgrade_Button(0);
                                else
                                    Upgrade_Button(3);
                            else if ( mouseY > 394 && mouseY < 450 )
                                if ( mouseX < 500 )
                                    Upgrade_Button(1);
                                else
                                    Upgrade_Button(4);
                            else
                                if ( mouseX < 500 )
                                    Upgrade_Button(2);
                                else
                                    Upgrade_Button(5);
                        }
                        if ( Mouse_In_Img ( Img_Trainer_Player_Button ) && trainer_curr_pokemon != null )
                            trainer_curr_pokemon.Add_Experience(trainer_upgrade_per_click);
                        if ( Mouse_In_Img ( Img_X_Button ) ) {
                            pokemon_in_bank.push(trainer_curr_pokemon);
                            trainer_curr_pokemon = null;
                        }
                    break;
                }
            }
        }
        private function Upgrade_Button(i:int):void {
            if ( trainer_levels[i] < Trainer_Max_Level ) {
                if ( trainer_curr_price[i] <= current_s_money ) {
                    current_s_money -= trainer_curr_price[i];
                    
                    trainer_curr_price[i] = Math.floor((trainer_curr_price[i] + Trainer_Price_Add[i]) * Trainer_Price_Mult[i]);
                    ++trainer_levels[i];
                    if ( i < 3 ) {// click
                        trainer_upgrade_per_click -= trainer_xp_f[i];
                    }
                    trainer_xp_f[i] += Trainer_Effect_Add[i];
                    trainer_xp_f[i] *= Trainer_Effect_Mult[i];
                    trainer_xp_f[i] = Math.floor(trainer_xp_f[i]);
                    if ( i < 3 ) {// click
                        trainer_upgrade_per_click += trainer_xp_f[i];
                    }
                }
            }
        }
        private function Refresh_Battle_Status(i:int):void {
            if ( poke_player[i] != null ) {
                // check if dead
                if ( (poke_player[i] as Base_Pokemon).R_Curr_Health() <= 0 && 
                     !((poke_player[i] as Base_Pokemon).R_Is_Dead()) ) {
                    (poke_player[i] as Base_Pokemon).Set_Health(0);
                    (poke_player[i] as Base_Pokemon).Kill();
                    Text_Move_Results.push(session_time + ": " + (poke_player[i] as Base_Pokemon).R_Name() + " has died!");
                    poke_enemy[i] = null;
                    poke_enemy_timer[i] = 99999999;
                    poke_player_new_enemy_timer[i] = 9999999;
                }
                
                // check if battle won
                if ( poke_enemy[i] != null )
                    if ( (poke_enemy[i] as Base_Pokemon).R_Curr_Health() <= 0 ) {
                        Win_Battle(i);
                        poke_enemy[i] = null;
                        poke_player_new_enemy_timer[i] = Random_Range(60,Max_Enemy_Respawn_Timer);
                        (poke_player[i] as Base_Pokemon).Refresh_Battle_Stats();
                        return;
                    }
            }
        }
        
        private function Mod_Player_Boss_Battle_Stats() {
            var player_mod:Number = 1;
            var count : int = 0;
            for ( var i : int = 0; i != 4; ++ i )
                if ( poke_player[i] != null ) {
                    player_mod += (poke_player[i] as Base_Pokemon).R_Speed();
                    ++count;
                }
            player_mod /= count;
            var enemy_mod:Number = Number(final_boss.R_Speed()) / player_mod;
            final_boss.Mod_Accuracy(20 + 40 * enemy_mod);
            if ( final_boss.R_Accuracy() > 100 )
                final_boss.Mod_Accuracy(100);
            
            player_mod = 1; count = 0;
            for ( var i : int = 0; i != 4; ++ i )
                if ( poke_player[i] != null ) {
                    player_mod += (poke_player[i] as Base_Pokemon).R_Spec_Def();
                    ++count;
                }
            player_mod /= count;
            enemy_mod = Number(final_boss.R_Spec_Def()) / player_mod;
            
            final_boss.Mod_Evade(20 + 40 * enemy_mod);
            if ( final_boss.R_Evade() > 100 )
                final_boss.Mod_Evade(100);
            
            for ( var i : int = 0; i != 4; ++ i ) {
                if ( poke_player[i] == null ) break;
                player_mod = (poke_player[i] as Base_Pokemon).R_Speed() / (final_boss.R_Speed()*.75);
                
                (poke_player[i] as Base_Pokemon).Mod_Accuracy(20 + 40 * player_mod);
                if ( (poke_player[i] as Base_Pokemon).R_Accuracy() > 100 )
                    final_boss.Mod_Accuracy(100);
                
                player_mod = (poke_player[i] as Base_Pokemon).R_Spec_Def() / (final_boss.R_Spec_Def()*.75);
                
                (poke_player[i] as Base_Pokemon).Mod_Evade(20 + 40 * player_mod);
                if ( (poke_player[i] as Base_Pokemon).R_Evade() > 100 )
                    final_boss.Mod_Evade(100);
            }
        }
        
        private function Mod_Player_Enemy_Battle_Stats(i:int) {
            if ( poke_player[i] == null ) return;
            if ( fighting_final_boss ) {
                poke_enemy[i] = final_boss;
            }
            var enemy_mod:Number = Number((poke_enemy[i] as Base_Pokemon).R_Speed()) / Number((poke_player[i] as Base_Pokemon).R_Speed());
            var player_mod:Number = Number((poke_player[i] as Base_Pokemon).R_Speed()) / Number((poke_enemy[i] as Base_Pokemon).R_Speed());
            
            (poke_enemy[i] as Base_Pokemon).Mod_Accuracy(20 + 40 * enemy_mod);
            if ( (poke_enemy[i] as Base_Pokemon).R_Accuracy() > 100 )
                (poke_enemy[i] as Base_Pokemon).Mod_Accuracy(100);
                        
            (poke_player[i] as Base_Pokemon).Mod_Accuracy(20 + 40 * player_mod);
            if ( (poke_player[i] as Base_Pokemon).R_Accuracy() > 100 )
                (poke_player[i] as Base_Pokemon).Mod_Accuracy(100);
                
            var enemy_mod:Number = Number((poke_enemy[i] as Base_Pokemon).R_Spec_Def()) / Number((poke_player[i] as Base_Pokemon).R_Spec_Def());
            var player_mod:Number = Number((poke_player[i] as Base_Pokemon).R_Spec_Def()) / Number((poke_enemy[i] as Base_Pokemon).R_Spec_Def());
                
            (poke_enemy[i] as Base_Pokemon).Mod_Evade(20 + 40 * enemy_mod);
            if ( (poke_enemy[i] as Base_Pokemon).R_Evade() > 100 )
                (poke_enemy[i] as Base_Pokemon).Mod_Evade(100);

            
            (poke_player[i] as Base_Pokemon).Mod_Evade(20 + 40 * player_mod);
            if ( (poke_player[i] as Base_Pokemon).R_Evade() > 100 )
                (poke_player[i] as Base_Pokemon).Mod_Evade(100);
                
            if ( fighting_final_boss ) {
                final_boss = poke_enemy[i];
                poke_enemy[i] = null;
            }
        }
        
        public static var soul_crystal_hex_active:Boolean = false;
        
        private function Refresh_Start_Battle_Frame(i:int):void {
            // respawn player?
            if ( poke_player[i] != null ) {
                if ( (poke_player[i] as Base_Pokemon).R_Is_Dead() ) {
                    if ( (poke_player[i] as Base_Pokemon).R_Dead_Timer() <= 0 ) {
                        (poke_player[i] as Base_Pokemon).Resurrect(Math.floor((poke_player[i] as Base_Pokemon).R_Max_Health() ));
                        poke_player_new_enemy_timer[i] = Random_Range(60, Max_Enemy_Respawn_Timer);
                    }
                    else
                        (poke_player[i] as Base_Pokemon).Ref_Dead_Timer();
                }
            }
            // new enemy pokemon
            if ( poke_enemy[i] == null &&
                 poke_player[i] != null ) {
                if ( !(poke_player[i] as Base_Pokemon).R_Is_Dead() )
                    if ( --poke_player_new_enemy_timer[i] <= 0 ) {
                        poke_enemy[i] = Area.R_New_Botomon(current_area);
                        if ( soul_crystal_hex_active ) {
                            for ( var z : int = 0; z != inventory_items.length; ++ z )
                                if ( Item.Item_Name[Item(inventory_items[z]).R_Item_Type()] == "Soul Crystal Hex" && 
                                     Base_Pokemon(poke_enemy[i]).R_Stage() == Item(inventory_items[z]).R_Item_Stage() ) {
                                    Base_Pokemon(poke_enemy[i]).Hex();
                                    if ( --inventory_items_count[z] <= 0 ) {
                                        inventory_items.splice(z, 1);
                                        inventory_items_count.splice(z, 1);
                                        break;
                                    }
                                }
                        
                        }
                        poke_player_timer[i] = Random_Range(Min_Fighting_Timer, Max_Fighting_Timer);
                        poke_enemy_timer[i] = Random_Range(Min_Fighting_Timer, Max_Fighting_Timer);
                        Mod_Player_Enemy_Battle_Stats(i)
                        Text_Move_Results.push(session_time + ": " +(poke_player[i] as Base_Pokemon).R_Name() + " has encountered level "
                            + (poke_enemy[i]).R_Level() + " " +
                            Base_Pokemon_Stats.Poke_Name[(poke_enemy[i] as Base_Pokemon).R_Species_ID()]);
                    }
            }
        }
        static var status_effect:int = 0;
        static const Status_Effect_Start:int = 340;
        
        private function Status_Effect() {
            status_effect = Status_Effect_Start;
            for ( var x : int = 0; x != 4; ++ x ) {
                if ( poke_enemy[x] == null || poke_player[x] == null ) continue;
                var effects:Array = (poke_player[x] as Base_Pokemon).R_Status_Effects();
                var damage:Array = (poke_player[x] as Base_Pokemon).R_Status_Effects_Damage();
                for ( var i : int = 0; i != effects.length; ++ i ) {
                    switch ( effects[i] ) {
                        case Move_Info.Effect_Burn:
                            Text_Move_Results.push(session_time+": " + (poke_player[x] as Base_Pokemon).R_Name() + " has taken " + damage[i] + " burn damage");
                            break;
                        case Move_Info.Effect_Freeze:
                            Text_Move_Results.push(session_time+": " + (poke_player[x] as Base_Pokemon).R_Name() + " has taken " + damage[i] + " freeze damage");
                            break;
                        case Move_Info.Effect_Normal:
                            Text_Move_Results.push(session_time+": " + (poke_player[x] as Base_Pokemon).R_Name() + " has taken " + damage[i] + " damage");
                            break;
                        case Move_Info.Effect_Poison:
                            Text_Move_Results.push(session_time+": " + (poke_player[x] as Base_Pokemon).R_Name() + " has taken " + damage[i] + " poison damage");
                            break;
                        default: // none
                        break;
                    }
                    if ( damage[i] != 0 ) {
                        (poke_player[x] as Base_Pokemon).Add_Health( -damage[i]);
                        (poke_player[x] as Base_Pokemon).Refresh_Effect_Count();
                    }
                }
                effects = (poke_enemy[x] as Base_Pokemon).R_Status_Effects();
                damage = (poke_enemy[x] as Base_Pokemon).R_Status_Effects_Damage();
                for ( var i : int = 0; i != effects.length; ++ i ) {
                    switch ( effects[i] ) {
                        case Move_Info.Effect_Burn:
                            Text_Move_Results.push(session_time+": " + (poke_enemy[x] as Base_Pokemon).R_Name() + " has taken " + damage[i] + " burn  damage");
                            break;
                        case Move_Info.Effect_Freeze:
                            Text_Move_Results.push(session_time+": " + (poke_enemy[x] as Base_Pokemon).R_Name() + " has taken " + damage[i] + " freeze damage");
                            break;
                        case Move_Info.Effect_Normal:
                            Text_Move_Results.push(session_time+": " + (poke_enemy[x] as Base_Pokemon).R_Name() + " has been harmed for " + damage[i] + " damage");
                            break;
                        case Move_Info.Effect_Poison:
                            Text_Move_Results.push(session_time+": " + (poke_enemy[x] as Base_Pokemon).R_Name() + " has taken " + damage[i] + " poison damage");
                            break;
                        default:
                        break;
                    }
                    if ( damage[i] != 0 ) {
                        (poke_enemy[x] as Base_Pokemon).Add_Health(-damage[i]);
                        (poke_enemy[x] as Base_Pokemon).Refresh_Effect_Count();
                    }
                }
            }
        }
        
        // this is to e used inside the Move Info where the moves are called and some apply special things such as bind
        public static var special_fight_effect:String = "";
        
        public static var fighting_final_boss:Boolean = false;
        
        public static var final_boss:Base_Pokemon = null;
        
        public static const final_boss_timer_min:int = 170;
        public static const final_boss_timer_max:int = 220;
        public static var final_boss_timer:int;
        public static var final_63_boss_beat:Boolean = false;
        private static var final_boss_stolen_botomon:Array = new Array();
        
        private function Unlock_Next_Stage( ) {
            if ( final_boss.R_Stage() == 62 ) {
                Text_Move_Results.push(session_time+": " + "Hercludes, the mighty dev, has been slain!!");
                Text_Move_Results.push(session_time+": " + "Congratulations on beating my game!!!! This isn't much of a \"You Win\" screen, but");
                Text_Move_Results.push(session_time+": " + " I didn't expect anyone to get this far!");
                Text_Move_Results.push(session_time+": " + "As a prize, you have unlocked boss rush mode. Beat all 63 bosses in a row!!");
                Text_Move_Results.push(session_time+": " + "If you record yourself beating boss rush mode");
                Text_Move_Results.push(session_time+": " + "I'll give you some special prize for my main project, Core of Pulcher!");
                Text_Move_Results.push(session_time+": " + "(I don't know what to do yet, so if you had anything in mind I might do it)");
                final_63_boss_beat = true;
                return;
            }
            // add new store items
            store_items = R_Store_Items(final_boss.R_Stage()+1);
            // add new areas
            for ( var i : int = 0; i != Area.Area_Name.length; ++ i )
                Area.Area_Stage.push(final_boss.R_Stage() + 1);
            
            Base_Pokemon_Stats.Poke_Type_1[Base_Pokemon_Stats.Poke_Type_1.length - 1] = Base_Pokemon_Stats.Type_None;
            Base_Pokemon_Stats.Poke_Type_2[Base_Pokemon_Stats.Poke_Type_2.length - 1] = Base_Pokemon_Stats.Type_None;
            // off
            ++current_stage_level;
            Save();
        }
        
        private function Win_Battle_Boss( ) {
            ++botomon_kill_amt;
            if ( Is_Boss_Rush ) {
                if ( final_boss.R_Stage() == 62 ) {
                    Text_Move_Results.push(session_time+": " + "Holy shit, you actually beat the boss rush. Kongratz! If you recorded it");
                    Text_Move_Results.push(session_time+": " + "then just upload it to youtube and message me or something, you'll");
                    Text_Move_Results.push(session_time+": " + "get a special prize for my (much more serious) project Core of Pulcher");
                    Text_Move_Results.push(session_time+": " + "(like I said earlier, if you had anything in mind please share)");
                    Text_Move_Results.push(session_time+": " + "Other than that, thanks for wasting your time on this crap game! :o)");
                    final_boss = null;
                    Is_Boss_Rush = 0;
                    fighting_final_boss = 0;
                } else {
                    fighting_final_boss = 1;
                    Text_Move_Results.push("Fighting Hercludes on stage " + final_boss.R_Stage());
                    final_boss = new Base_Pokemon(Base_Pokemon_Stats.Poke_Name.length - 1, final_boss.R_Stage() + 1, false,
                        150.0 + 450.0 * (Number(final_boss.R_Stage() + 1) / 32.0));
                    Mod_Player_Boss_Battle_Stats();
                    final_boss.Bossify();
                }
                return;
            }
            if ( final_boss.R_Stage() != 62 ) {
                Text_Move_Results.push(session_time+": " + "You hear a booming voice from Hercludes, \"That was but a flesh would!\"");
                Text_Move_Results.push(session_time+": " + "Hercludes vanishes in thin air");
                Text_Move_Results.push(session_time+": " + "You have beaten " + final_boss.R_Name() + ", for now.");
                Text_Move_Results.push(session_time+": " + "As a reward, you have been given 20 legendary crystals");
                Add_Item_Inventory(new Item(Item.Item_Name.length - 1, final_boss.R_Stage()+1), 20);
                Text_Move_Results.push(session_time+": " + "You have unlocked the next stage! Unlock Boss Rush and beat ");
                Text_Move_Results.push(session_time+": " + "all 63 to receive a special prize in Core of Pulcher, my main project!");
                Text_Move_Results.push(session_time+": " + "(You'll have to record it and put it on youtube)");
            }
            
            Unlock_Next_Stage();
            
            for ( var i : int = 0; i != final_boss_stolen_botomon.length; ++ i ) {
                Text_Move_Results.push(session_time+": " + "You have rescued " + (final_boss_stolen_botomon[i] as Base_Pokemon).R_Name() + "!");
                pokemon_in_bank.push((final_boss_stolen_botomon[i] as Base_Pokemon));
            }
            
            final_boss_stolen_botomon = new Array();
        }
        
        private function Boss_Fight_Start( ) {
            for ( var i : int = 0; i != 4; ++ i )
                poke_enemy[i] = null;
            while ( Text_Move_Results.length > 0 ) Text_Move_Results.pop();
            
            // get new B0SS
            final_boss = new Base_Pokemon(Base_Pokemon_Stats.Poke_Name.length - 1, current_stage_level,
                                          0, 150.0 + 450 * (current_stage_level) / 32.0);
            Mod_Player_Boss_Battle_Stats();
            final_boss.Bossify();
            fighting_final_boss = 1;
            
            Text_Move_Results.push(session_time + ": " + final_boss.R_Name() + " has arrived!");
            final_boss_timer = Random_Range(final_boss_timer_min, final_boss_timer_max);
            for ( var i : int = 0; i != 4; ++ i )
                if ( poke_player[i] != null ) {
                    poke_player_timer[i] = Random_Range(final_boss_timer, final_boss_timer_max);
                    if ( (poke_player[i] as Base_Pokemon).R_Is_Dead() )
                        (poke_player[i] as Base_Pokemon).Resurrect(1);
                    (poke_player[i] as Base_Pokemon).Add_Health(
                        (poke_player[i] as Base_Pokemon).R_Max_Health()
                    );
                    (poke_player[i] as Base_Pokemon).Refresh_Battle_Stats();
                }
        }
        public static var Is_Boss_Rush:Boolean = false;
        private function Boss_Rush_Start( ) {
            for ( var i : int = 0; i != 4; ++ i )
                poke_enemy[i] = null;
            
            for ( var i : int = 0; i != 4; ++ i ) {
                if ( poke_player[i] == null ) continue;
                (poke_player[i] as Base_Pokemon).Set_Health((poke_player[i] as Base_Pokemon).R_Max_Health());
                (poke_player[i] as Base_Pokemon).Refresh_Battle_Stats();
            }
            
            fighting_final_boss = 1;
            final_boss = new Base_Pokemon(Base_Pokemon_Stats.Poke_Name.length - 1, 0, 0,
                                          150.0 + 450 * (0) / 32.0);
            final_boss.Bossify();
            Is_Boss_Rush = true;
        }
        
        private function Boss_Status_Effect() {
            status_effect = Status_Effect_Start;
            effects = final_boss.R_Status_Effects();
            damage = final_boss.R_Status_Effects_Damage();
            for ( var i : int = 0; i != effects.length; ++ i ) {
                switch ( effects[i] ) {
                    case Move_Info.Effect_Burn:
                        Text_Move_Results.push(session_time+": " + final_boss.R_Name() + " has taken " + damage[i] + " burn damage");
                        break;
                    case Move_Info.Effect_Freeze:
                        Text_Move_Results.push(session_time+": " + final_boss.R_Name() + " has taken " + damage[i] + " freeze damage");
                        break;
                    case Move_Info.Effect_Normal:
                        Text_Move_Results.push(session_time+": " + final_boss.R_Name() + " has taken " + damage[i] + " damage");
                        break;
                    case Move_Info.Effect_Poison:
                        Text_Move_Results.push(session_time+": " + final_boss.R_Name() +  " has taken " + damage[i] + " poison damage");
                        break;
                    default:
                    break;
                }
                if ( damage[i] != 0 ) {
                    final_boss.Add_Health(-damage[i]);
                    final_boss.Refresh_Effect_Count();
                }
            }
            
            for ( var x : int = 0; x != 4; ++ x ) {
                if ( poke_player[x] == null || (poke_player[x] as Base_Pokemon).R_Is_Dead() ) continue;
                var effects:Array = (poke_player[x] as Base_Pokemon).R_Status_Effects();
                var damage:Array = (poke_player[x] as Base_Pokemon).R_Status_Effects_Damage();
                for ( var i : int = 0; i != effects.length; ++ i ) {
                    switch ( effects[i] ) {
                        case Move_Info.Effect_Burn:
                            Text_Move_Results.push(session_time+": " + (poke_player[x] as Base_Pokemon).R_Name() + " has taken " + damage[i] + " burn damage");
                            break;
                        case Move_Info.Effect_Freeze:
                            Text_Move_Results.push(session_time+": " + (poke_player[x] as Base_Pokemon).R_Name() + " has taken " + damage[i] + " freeze damage");
                            break;
                        case Move_Info.Effect_Normal:
                            Text_Move_Results.push(session_time+": " + (poke_player[x] as Base_Pokemon).R_Name() + " has taken " + damage[i] + " damage");
                            break;
                        case Move_Info.Effect_Poison:
                            Text_Move_Results.push(session_time+": " + (poke_player[x] as Base_Pokemon).R_Name() + " has taken " + damage[i] + " poison damage");
                            break;
                        default: // none
                        break;
                    }
                    if ( damage[i] != 0 ) {
                        (poke_player[x] as Base_Pokemon).Add_Health( -damage[i]);
                        (poke_player[x] as Base_Pokemon).Refresh_Effect_Count();
                    }
                }
                
            }
        
        }
        
        private function Boss_Battle_Status() {
            // check if dead
            for ( var i : int = 0; i != poke_player.length; ++ i ) {
                if ( poke_player[i] != null )            
                if ( (poke_player[i] as Base_Pokemon).R_Curr_Health() <= 0 && 
                    !((poke_player[i] as Base_Pokemon).R_Is_Dead()) ) {
                    (poke_player[i] as Base_Pokemon).Set_Health(0);
                    (poke_player[i] as Base_Pokemon).Kill();
                    Text_Move_Results.push(session_time + ": " + (poke_player[i] as Base_Pokemon).R_Name() + " has died!");
                }
            }
            
            // check if battle won
            if ( final_boss.R_Curr_Health() <= 0 ) {
                fighting_final_boss = 0;
                Win_Battle_Boss();
                if ( !Is_Boss_Rush ) 
                    final_boss = null;
                final_boss_timer = 0;
                
                for ( var i : int = 0; i != 4; ++ i )
                    if ( poke_player[i] != null ) {
                        poke_player_new_enemy_timer[i] = Random_Range(60,Max_Enemy_Respawn_Timer);
                        (poke_player[i] as Base_Pokemon).Refresh_Battle_Stats();
                    }
                return;
            }
            
            // check if battle lost
            var battle_lost:Boolean = 1;
            for ( var i : int = 0; i != 4; ++ i )
                if ( poke_player[i] != null )
                    if ( !(poke_player[i] as Base_Pokemon).R_Is_Dead() ) battle_lost = 0;
            
            if ( battle_lost && !Is_Boss_Rush ) { // choose a botomon to permanently destroy
                 var poss_victims:Array = new Array();
            
                for ( var i : int = 0; i != 4; ++ i )
                    if ( poke_player[i] != null ) poss_victims.push(i);
                
                var victim_id : int = poss_victims[Random_Range(0, poss_victims.length - 1)];
                
                Text_Move_Results.push(session_time+": " + final_boss.R_Name() + " has slayed all of your botomons!");
                Text_Move_Results.push(session_time+": " + final_boss.R_Name() + " steals your botomon " +
                    (poke_player[victim_id] as Base_Pokemon).R_Name() + "! Slay " + final_boss.R_Name() +
                    " to retrieve your botomon back!");
                final_boss_stolen_botomon.push(poke_player[victim_id]);
                poke_player[victim_id] = null;
                fighting_final_boss = 0;
                Save(); // Save to prevent assholes from abusing load to reload boss and get preferred type,
                        // or regain their botomons
            }
        }

        private function Boss_Fight_Frame( ) {
            // check battle status
            Boss_Battle_Status();
            if ( !fighting_final_boss ) return;

            // perform effects (burn/poison/etc)
            if ( --status_effect <= 0 ) {
                Boss_Status_Effect();
            }

            // check battle status
            Boss_Battle_Status();
            if ( !fighting_final_boss ) return;

            // check boss timer
            var break_this:Boolean = true;
            Break_This_Boss:while ( break_this == true ) {
                break_this = false;
                if ( --final_boss_timer <= 0 ) {
                    final_boss_timer = Random_Range(final_boss_timer_min, final_boss_timer_max);
                    if ( final_boss.R_Paralyzed() > 0 ) {
                        final_boss.Neg_Paralysis();
                        if ( Random_Range(0, 3) < 3 ) {
                            Text_Move_Results.push(session_time+": " + final_boss.R_Name() + "'S move skipped due to paralysis!!!");
                            break Break_This_Boss;
                        }
                    }
                    // find victim for boss to slaughter
                    var poss_victims:Array = new Array();
                    
                    for ( var i : int = 0; i != 4; ++ i )
                        if ( poke_player[i] != null  )
                            if ( (poke_player[i] as Base_Pokemon).R_Is_Dead() == 0 )
                                poss_victims.push(i);
                    
                    var victim_id : int = poss_victims[Random_Range(0, poss_victims.length - 1)];
                    //trace(victim_id);
                    special_fight_effect = "";
                    var results:Array =
                            Move_Info.Perform_Move(final_boss, (poke_player[victim_id] as Base_Pokemon));
                    
                    Mod_Player_Boss_Battle_Stats();
                    
                    // output
                    if ( results.length == 5 ) {
                        if ( results[3] )
                            Text_Move_Results.push(session_time + ": " + final_boss.R_Name()
                                + "'s " + Move_Info.Names[Move(results[4]).Move_ID] + " missed");
                        else {
                            (poke_player[victim_id] as Base_Pokemon).Add_Health(results[0]*-1);
                            final_boss.Add_Health(results[victim_id]);
                            botomon_player_damaged[victim_id] = Damage_Timer;
                            if ( Move_Info.Power[Move(results[4]).Move_ID] != 0 ) {
                                Text_Move_Results.push(session_time + ": " + final_boss.R_Name() + " dealt "
                                    + results[0] + " damage to " + (poke_player[victim_id] as Base_Pokemon).R_Name()
                                    + " using " + Move_Info.Names[Move(results[4]).Move_ID]
                                    + " { " + Base_Pokemon_Stats.R_Type_To_String(Move(results[4]).Move_Type) + " }");
                                if ( results[2] == 2 ) // 2 = crit
                                    Text_Move_Results[Text_Move_Results.length - 1] += " CRITICAL!";
                                if ( special_fight_effect != "" )
                                    Text_Move_Results.push(special_fight_effect);
                            }
                        }
                    }                
                }
            }
            // check battle status
            Boss_Battle_Status();
            
            if ( !fighting_final_boss ) return;
            
            // check player timer
            Break_This_Player:for ( var i : int = 0; i != 4; ++ i )
            if ( --poke_player_timer[i] < 0 && poke_player[i] != null ) {
                poke_player_timer[i] = Random_Range(final_boss_timer_min, final_boss_timer_max)*2;
                
                if ( (poke_player[i] as Base_Pokemon).R_Paralyzed() > 0 ) {
                     (poke_player[i] as Base_Pokemon).Neg_Paralysis();
                    if ( Random_Range(0, 3) < 3 ) {
                        Text_Move_Results.push(session_time+": " + (poke_player[i] as Base_Pokemon).R_Name() + "'s move skip due to paralysis");
                        continue Break_This_Player;
                    }
                }
                
                special_fight_effect = "";
                var results:Array =
                    Move_Info.Perform_Move(poke_player[i], final_boss);
                
                Mod_Player_Boss_Battle_Stats();
                
                if ( results.length != 5 ) {
                    if ( results[0] == 0 )
                        Text_Move_Results.push(session_time + ": " + (poke_player[i] as Base_Pokemon).R_Name() + " does not have a move "
                                            + "equipped -- turn skipped" );
                    else
                        Text_Move_Results.push(session_time + ": " + (poke_player[i] as Base_Pokemon).R_Name() + " failed to perform move");
                    
                } else {
                    // output
                    if ( results[3] )
                        Text_Move_Results.push(session_time + ": " + (poke_player[i] as Base_Pokemon).R_Name() + "'s " +
                            Move_Info.Names[ Move(results[4]).Move_ID ] + " missed");
                    else {
                        final_boss.Add_Health(results[0]*-1);
                        (poke_player[i] as Base_Pokemon).Add_Health(results[1]);
                        final_boss_damaged = 5;
                        if ( Move_Info.Power[Move(results[4]).Move_ID] != 0 ) {
                            Text_Move_Results.push(session_time + ": " + (poke_player[i] as Base_Pokemon).R_Name() + " dealt " + results[0] + " damage to "
                                + final_boss.R_Name() + " using " + Move_Info.Names[Move(results[4]).Move_ID]);
                            if ( results[2] == 2 ) // crit
                                Text_Move_Results[Text_Move_Results.length - 1] += " CRITICAL!";
                            if ( special_fight_effect != "" )
                                Text_Move_Results.push(special_fight_effect);
                        }
                    }
                }
            }
        }
        
        private function Fight_Frame() : void {
            if ( fighting_final_boss ) { Boss_Fight_Frame(); return; }
            // STATUS EFFECT
            if ( --status_effect <= 0 ) {
                Status_Effect();
            }
            
            Poke_Player_Loop:for ( var i:int = 0; i != 4; ++ i ) {
                Refresh_Battle_Status(i);
                Refresh_Start_Battle_Frame(i);
                // check if player/enemy are there
                if ( poke_player[i] == null ||
                     poke_enemy[i]  == null  ) continue; // Run this in case next slot not empty
                
                // run player move process if player timer is good
                if ( --poke_player_timer[i] < 0 ) {
                    poke_player_timer[i] = Random_Range(Min_Fighting_Timer, Max_Fighting_Timer);
                    var t_s_mod:Number = ((poke_player[i] as Base_Pokemon).R_Speed() / (poke_enemy[i] as Base_Pokemon).R_Speed());
                    if ( t_s_mod < .33 ) t_s_mod = .5;
                    if ( t_s_mod > 3 ) t_s_mod = 2;
                    poke_player_timer[i] /= t_s_mod;
                    
                    if ( (poke_player[i] as Base_Pokemon).R_Paralyzed() > 0 ) {
                        (poke_player[i] as Base_Pokemon).Neg_Paralysis();
                        if ( Random_Range(0, 3) < 3 ) {
                            Text_Move_Results.push(session_time+": " + (poke_player[i] as Base_Pokemon).R_Name() + "'s move skip due to paralysis");
                            continue Poke_Player_Loop;
                        }
                    }
                    special_fight_effect = "";
                    var results:Array =
                        Move_Info.Perform_Move((poke_player[i] as Base_Pokemon),
                                                (poke_enemy[i] as Base_Pokemon));
                                                
                    Mod_Player_Enemy_Battle_Stats(i);
                    if ( results.length != 5 ) {
                        if ( results[0] == 0 )
                            Text_Move_Results.push(session_time + ": " +(poke_player[i] as Base_Pokemon).R_Name() + " does not have a move "
                                                + "equipped -- turn skipped" );
                        else
                            Text_Move_Results.push(session_time + ": " + (poke_player[i] as Base_Pokemon).R_Name() + " failed to perform its move");
                        
                    } else {
                        // output
                        if ( results[3] )
                            Text_Move_Results.push(session_time + ": " + (poke_player[i] as Base_Pokemon).R_Name() + "'s " +
                                Move_Info.Names[ Move(results[4]).Move_ID ] + " missed");
                        else {
                            (poke_enemy[i] as Base_Pokemon).Add_Health(results[0]*-1);
                            (poke_player[i] as Base_Pokemon).Add_Health(results[1]);
                        if ( Move_Info.Power[Move(results[4]).Move_ID] != 0 ) {
                            botomon_enemy_damaged[i] = Damage_Timer;
                            Text_Move_Results.push(session_time + ": " + (poke_player[i] as Base_Pokemon).R_Name() + " dealt " + results[0] + " damage to "
                                + (poke_enemy[i] as Base_Pokemon).R_Name() + " using " + Move_Info.Names[Move(results[4]).Move_ID]);
                            if ( results[2] == 2 ) // crit
                                Text_Move_Results[Text_Move_Results.length - 1] += " CRITICAL!";
                            if ( special_fight_effect != "" )
                                    Text_Move_Results.push(session_time +": " +special_fight_effect);
                            }
                        }
                    }
                }
                Refresh_Battle_Status(i);
            }
            
            
            // run enemy move process if enemy timer is good
            Poke_Enemy_Loop:for ( var i : int = 0; i != 4; ++ i ) {
                Refresh_Battle_Status(i);
                if ( poke_enemy[i] == null || poke_player[i] == null ) continue;
                if ( --poke_enemy_timer[i] < 0 ) {
                    poke_enemy_timer[i] = Random_Range(Min_Fighting_Timer, Max_Fighting_Timer);
                    var t_s_mod:Number = (poke_enemy[i] as Base_Pokemon).R_Speed() / (poke_player[i] as Base_Pokemon).R_Speed();
                    if ( t_s_mod < .33 ) t_s_mod = .33;
                    if ( t_s_mod > 3 ) t_s_mod = 3;
                    poke_enemy_timer[i] /= t_s_mod;
                    
                    if ( (poke_enemy[i] as Base_Pokemon).R_Paralyzed() > 0 ) {
                         (poke_enemy[i] as Base_Pokemon).Neg_Paralysis();
                        if ( Random_Range(0, 3) < 3 ) {
                            Text_Move_Results.push(session_time +": " + (poke_enemy[i] as Base_Pokemon).R_Name() + "'s move skip due to paralysis!");
                            continue Poke_Enemy_Loop;
                        }
                    }
                         // returns an array of 4 (Damage Dealt, Damage Healed, Critical(bool), miss (1=miss), move). Applies affect
                        // on pokemon. Includes grabbing the move set and pseudo randomizing which
                        // move to perform
                    special_fight_effect = "";
                    var results:Array =
                        Move_Info.Perform_Move( (poke_enemy[i] as Base_Pokemon),
                                                (poke_player[i] as Base_Pokemon));
                    // output
                    if ( results.length == 5 ) {
                        if ( results[3] )
                            Text_Move_Results.push(session_time + ": " +Base_Pokemon_Stats.Poke_Name[(poke_enemy[i] as Base_Pokemon).R_Species_ID()]
                                + "'s " + Move_Info.Names[Move(results[4]).Move_ID] + " missed");
                        else {
                            (poke_player[i] as Base_Pokemon).Add_Health(results[0]*-1);
                            (poke_enemy[i] as Base_Pokemon).Add_Health(results[1]);
                            if ( Move_Info.Power[Move(results[4]).Move_ID] != 0 ) {
                                botomon_player_damaged[i] = Damage_Timer;
                                Text_Move_Results.push(session_time + ": " +Base_Pokemon_Stats.Poke_Name[(poke_enemy[i] as Base_Pokemon).R_Species_ID()] + " dealt "
                                    + results[0] + " damage to " + (poke_player[i] as Base_Pokemon).R_Name() + " using " + Move_Info.Names[Move(results[4]).Move_ID]
                                    + " { " + Base_Pokemon_Stats.R_Type_To_String(Move(results[4]).Move_Type) + " }");
                                if ( results[2] == 2 ) // 2 = crit
                                    Text_Move_Results[Text_Move_Results.length - 1] += " CRITICAL!";
                                if ( special_fight_effect != "" )
                                    Text_Move_Results.push(session_time +": " +special_fight_effect);
                            }
                        }
                    } else
                        Text_Move_Results.push("Enemy bot at " + i + " couldn't perform its move properly.");
                    
                    Mod_Player_Enemy_Battle_Stats(i);
                }
                Refresh_Battle_Status(i);
            }
        }
        
        public function Apply_Img_To_Screen_Small(img:Class, x:int, y:int):void {
            children_bitmap.push([
                int(this.numChildren),
                img.ID
            ]);
            this.addChild((new img() as Bitmap));
            this.getChildAt(this.numChildren - 1).width /= 2;
            this.getChildAt(this.numChildren - 1).height /= 2;
            this.getChildAt(this.numChildren - 1).x = x;
            this.getChildAt(this.numChildren - 1).y = y;
        }
        public function Apply_Img_To_Screen(img:Class, x:int, y:int):void {
            // children_offset = 0, id = 1
            children_bitmap.push([
                int(this.numChildren),
                img.ID
            ]);
            this.addChild((new img() as Bitmap));
            //this.getChildAt(this.numChildren - 1).width /= 10;
            //this.getChildAt(this.numChildren - 1).height /= 10;
            this.getChildAt(this.numChildren - 1).x = x;
            this.getChildAt(this.numChildren - 1).y = y;
        }
        public function Apply_To_Screen(str:String, x:int, y:int, trunc_num:Boolean = true):void {
            if ( trunc_num )
            for ( var i : int = 0; i != str.length; ++ i )
                if ( str.charCodeAt(i) >= 48 &&
                     str.charCodeAt(i) <= 57 ) {
                     var t:Number = 0, z:int = i;
                     while ( str.charCodeAt(z) >= 48 &&
                             str.charCodeAt(z) <= 57 ) {
                        t = (t + str.charCodeAt(z++) - 48) * 10;
                        if ( z >= str.length ) break;
                     }
                     if ( z - i > 6 ) {
                        var t_s:String = String(String(t).charCodeAt(0) - 48) + "." +
                                         String(String(t).charCodeAt(1) - 48) +
                                         String(String(t).charCodeAt(2) - 48) + "E" + String(z - i);
                        str = str.slice(0, i) + t_s + str.slice(z, str.length);
                     }
                }
            
            var img:TextField = new TextField();
            img.width = 6666;
            img.height = 300;
            
            //img.setTextFormat(monospace_format);
            //img.embedFonts = true;
            
            img.selectable = 0;
            img.text = str;
            this.addChild(img);
            this.getChildAt(this.numChildren - 1).x = x;
            this.getChildAt(this.numChildren - 1).y = y;
        }
        public function Apply_Alpha_Img(img:Class, x:int, y:int, z:Number):void {
            children_bitmap.push([
                int(this.numChildren),
                img.ID
            ]);
            this.addChild((new img() as Bitmap));
            
            this.getChildAt(this.numChildren - 1).x = x;
            this.getChildAt(this.numChildren - 1).y = y;
            this.getChildAt(this.numChildren - 1).alpha = z;
        }
        
        public static var save_refresh:int = 0;
        public static var breeding_done:Boolean = false;
        
        public static var botomon_player_damaged:Array = [ 0, 0, 0, 0 ];
        public static var botomon_enemy_damaged:Array = [ 0, 0, 0, 0 ];
        public static var final_boss_damaged:int = 0;
        public static const Damage_Timer = 15;
        
        public function Draw_Screen() : void {
            // check that something didn't fuck up
            if ( pb_current_top_index < 0 ) pb_current_top_index = 0;
            
			// clear entire array
            while ( children_bitmap.length > 0 ) children_bitmap.pop()
			while ( this.numChildren > 0 ) this.removeChildAt(this.numChildren - 1);
            
            if ( QuickKong.userName == "JaneFrost2" ||
                 QuickKong.userName == "oatmeals" ||
                 QuickKong.userName == "necktweaker") {
                       highest_level_botomon = 0;
                       botomon_kill_amt=0;
                       current_money=0;
                       current_s_money=0;
                       current_stage_level=0;
                       botomon_bred=0;
                       collected_legendary_crystals=0;
                       highest_damage = 0;
                       Reset_Save();
            }
            
            if ( save_refresh > 0 ) {
                --save_refresh;
                Apply_To_Screen("Game Saved!", 890, 580);
            }
            
			// border and backgrounds
			// Use REGEX later on to have the multi->single defs:
			// s/\((.+), ?(.+)), ?(.+)\) *= *\((.+), ?(.+)\);$/$1$2 = $5;\n$1$3 = $6;/g;
            
            
            // if setting name
            if ( pibbypibbypibbypib != 5 ) {
                Apply_To_Screen("This project is still in a semi-beta state. Be sure to READ DESCRIPTION!!", 100, 500);
                for ( var i : int = 0; i != pokemon_in_bank.length; ++ i ) {
                    Apply_Img_To_Screen(Img_Pokemon[0], 30 + i * 200, 100);
                    Apply_To_Screen(Base_Pokemon(pokemon_in_bank[i]).R_Name(), 30 + i * 200, 170, false);
                }
            }
            if ( setting_name ) {
                if ( pibbypibbypibbypib != 5 && has_done_init_naming == 0 )
                    Apply_Img_To_Screen(Img_Menu_Load_Button, 700, 600);
                Apply_To_Screen("Enter name for your new botomon ( " +
                    Base_Pokemon_Stats.Poke_Name[setting_name_botomon.R_Species_ID()] + " ) max 16 characters: " + setting_temp_name + "#", 100, 300, false);
                Apply_Img_To_Screen(Img_Pokemon[setting_name_botomon.R_Species_ID()], 320, 330);
                if ( setting_name_botomon.R_Gender() == Base_Pokemon_Stats.Male )
                    Apply_Img_To_Screen(Img_Male, 305, 330);
                else
                    Apply_Img_To_Screen(Img_Female, 305, 330);
                Apply_Img_To_Screen(Img_Level_Stages[setting_name_botomon.R_Stage()], 305, 370);
                return;
            }
            
            Apply_To_Screen("Current Money: $" + String(current_money), 300, 550);
            Apply_To_Screen("                               " + String(current_s_money), 300, 570);
            Apply_To_Screen("Hex Crystal Charge: " + hex_crystal_count + " / " + 10, 300, 580);
            Apply_Img_To_Screen(Img_Spec_Money, 375, 570);
            
            if ( fighting_final_boss ) {
                Apply_Img_To_Screen(Img_Trainer_Upgrade1, 400, 0);
                Apply_Img_To_Screen(Img_Level_Stages[final_boss.R_Stage()], 380, 0);
                Apply_To_Screen("Hercludes, The Legendary Programmer { " +
                Base_Pokemon_Stats.R_Type_To_String(Base_Pokemon_Stats.Poke_Type_1[Base_Pokemon_Stats.Poke_Type_1.length - 1]) + ", " +
                Base_Pokemon_Stats.R_Type_To_String(Base_Pokemon_Stats.Poke_Type_2[Base_Pokemon_Stats.Poke_Type_1.length - 1]) + " }", 200, 75);
                Apply_To_Screen("Health: " + final_boss.R_Curr_Health() + " / " + final_boss.R_Max_Health() +
                                "\nAccuracy: " + final_boss.R_Accuracy() + "\nEvasion: " + final_boss.R_Evade() +
                                "\nLevel: " + final_boss.R_Level(), 200, 3);                                
            }
            for ( var i:int = 0; i != 4; ++ i ) { // display iterative things (player/enemy information)
                if ( poke_player[i] != null ) { // player-
                    Apply_Img_To_Screen(Img_Pokemon[(poke_player[i] as Base_Pokemon).R_Species_ID()], G_Player_Sprite_X[i], G_Player_Sprite_Y[i]);
                    Apply_Img_To_Screen(Img_Level_Stages[(poke_player[i] as Base_Pokemon).R_Stage()],
                        this.getChildAt(this.numChildren - 1).x + this.getChildAt(this.numChildren - 1).width, // r
                        this.getChildAt(this.numChildren - 1).y // u
                    );
                    
                    if ( botomon_player_damaged[i] > 0 )
                        Apply_Alpha_Img(Icon_Damaged, G_Player_Sprite_X[i], G_Player_Sprite_Y[i],
                                        Number(botomon_player_damaged[i])/Number(Damage_Timer));
                    
                    Apply_To_Screen((poke_player[i] as Base_Pokemon).R_Name() + "\n" +
                                    "Level: " + String((poke_player[i] as Base_Pokemon).R_Level()), G_Player_Name_X[i], G_Player_Name_Y[i], false);
                    Apply_To_Screen("Health: " + String((poke_player[i] as Base_Pokemon).R_Curr_Health()) + " / "
                                  + String((poke_player[i] as Base_Pokemon).R_Max_Health()), G_Player_Health_Bar_X[i],
                                                                                         G_Player_Health_Bar_Y[i]);
                    if ( triple_experience[i] > 0 )
                        Apply_To_Screen("*3 XP: " + triple_experience[i], G_Player_Exp_Bar_X[i], G_Player_Exp_Bar_Y[i] - 13);
                    Apply_To_Screen("XP: " + String((poke_player[i] as Base_Pokemon).R_Curr_Exp()) + " / "
                                  + String((poke_player[i] as Base_Pokemon).R_Exp_To_Level()), G_Player_Exp_Bar_X[i],
                                                                                           G_Player_Exp_Bar_Y[i]);
                    Apply_To_Screen("Item Timer: " + (poke_player[i] as Base_Pokemon).R_Item_Timer_Frac(), G_Player_Exp_Bar_X[i], G_Player_Exp_Bar_Y[i] + 25);
                    if ( !(poke_player[i] as Base_Pokemon).R_Is_Dead() && poke_enemy[i] == null && !fighting_final_boss)
                        Apply_To_Screen("Item Timer: " + (poke_player[i] as Base_Pokemon).R_Item_Timer_Frac() + "\n"
                                        + "\nNew enemy: " + poke_player_new_enemy_timer[i], G_Player_Exp_Bar_X[i], G_Player_Exp_Bar_Y[i] + 25);
                    if ( (poke_player[i] as Base_Pokemon).R_Is_Dead() && !fighting_final_boss ) {
                        Apply_To_Screen("Respawning: " + Math.floor(Number((poke_player[i] as Base_Pokemon).R_Dead_Timer())
                                                                        / Number(Max_Dead_Timer- (Screen.Max_Dead_Timer*.9)*(1 - Screen.R_Curr_Area()/Area.Amt_Of_Base_Stages)) * 100),
                                    G_Player_Exp_Bar_X[i],
                                    G_Player_Exp_Bar_Y[i] + 50);
                    }
                    
                    if ( (poke_player[i] as Base_Pokemon).R_Gender() == Base_Pokemon_Stats.Female ) {// female
                       Apply_Img_To_Screen(Img_Female, G_Player_Sprite_X[i] - 10, G_Player_Sprite_Y[i] + 20);
                    } else {
                        Apply_Img_To_Screen(Img_Male, G_Player_Sprite_X[i] - 10, G_Player_Sprite_Y[i] + 20);
                    }
                    if ( fighting_final_boss ) { // boss
                        if ( (poke_player[i] as Base_Pokemon).R_Is_Dead() ) {
                            Apply_To_Screen("Botomon is dead", G_Player_Exp_Bar_X[i], G_Player_Exp_Bar_Y[i] + 45);
                        } else {
                            Apply_To_Screen("Accuracy: " + (poke_player[i] as Base_Pokemon).R_Accuracy() + "\nEvasion: " +
                                    (poke_player[i] as Base_Pokemon).R_Evade(), G_Player_Exp_Bar_X[i],
                                                                            G_Player_Exp_Bar_Y[i] + 45);
                        }
                    } else if ( poke_enemy[i] != null ) { // enemy ( no xp displayed )
                        Apply_Img_To_Screen(Img_Pokemon[(poke_enemy[i] as Base_Pokemon).R_Species_ID()],
                            G_Enemy_Sprite_X[i], G_Enemy_Sprite_Y[i]);
                        
                        Apply_Img_To_Screen(Img_Level_Stages[(poke_enemy[i] as Base_Pokemon).R_Stage()],
                            this.getChildAt(this.numChildren - 1).x + this.getChildAt(this.numChildren -1).width, // r
                            this.getChildAt(this.numChildren - 1).y
                            );
                            
                        if ( botomon_enemy_damaged[i] > 0 )
                            Apply_Alpha_Img(Icon_Damaged, G_Enemy_Sprite_X[i], G_Enemy_Sprite_Y[i],
                                            Number(botomon_enemy_damaged[i])/Number(Damage_Timer));
                        
                        Apply_To_Screen("Health: " + String((poke_enemy[i] as Base_Pokemon).R_Curr_Health()) + " / "
                                      + String((poke_enemy[i] as Base_Pokemon).R_Max_Health()), G_Enemy_Health_Bar_X[i],
                                                                                            G_Enemy_Health_Bar_Y[i] - 30
                                       );
                        Apply_To_Screen("Accuracy: " + (poke_enemy[i] as Base_Pokemon).R_Accuracy() + "\nEvasion: " +
                            (poke_enemy[i] as Base_Pokemon).R_Evade(), G_Enemy_Health_Bar_X[i],
                                                                   G_Enemy_Health_Bar_Y[i]);
                        // the below is applied to player because this only applies when fighting
                        Apply_To_Screen("Accuracy: " + (poke_player[i] as Base_Pokemon).R_Accuracy() + "\nEvasion: " +
                            (poke_player[i] as Base_Pokemon).R_Evade(), G_Player_Exp_Bar_X[i],
                                                                    G_Player_Exp_Bar_Y[i] + 45);
                                                                    
                        Apply_To_Screen("Level: " + String((poke_enemy[i] as Base_Pokemon).R_Level()), G_Enemy_Sprite_X[i],
                                                                                                   G_Enemy_Sprite_Y[i] + 60);
                        var Type_String:String = Base_Pokemon_Stats.Poke_Name[(poke_enemy[i] as Base_Pokemon).R_Species_ID()] + " { " +
                            Base_Pokemon_Stats.R_Type_To_String(Base_Pokemon_Stats.Poke_Type_1[(poke_enemy[i] as Base_Pokemon).R_Species_ID()]);
                        if ( Base_Pokemon_Stats.Poke_Type_2[(poke_enemy[i] as Base_Pokemon).R_Species_ID()] != Base_Pokemon_Stats.Type_None )
                            Type_String += ", " + Base_Pokemon_Stats.R_Type_To_String(Base_Pokemon_Stats.Poke_Type_2[
                                                                               (poke_enemy[i] as Base_Pokemon).R_Species_ID()]);
                        Type_String += " } ";
                        Apply_To_Screen(Type_String, G_Enemy_Sprite_X[i], G_Enemy_Sprite_Y[i] + 80);
                        var Move_String:String = " { ";
                        var temp_move:Array = (poke_enemy[i] as Base_Pokemon).R_Move_Set();
                        for ( var mov_it : int = 0; mov_it != temp_move.length; ++ mov_it ) {
                            if ( temp_move[mov_it] == null ) continue;
                            Move_String += Move_Info.Names[Move(temp_move[mov_it]).Move_ID];
                            if ( mov_it == 1 ) Move_String += ",\n";
                            if ( mov_it == 0 ) Move_String += ", ";
                            else if ( mov_it == 2 ) Move_String += " }";
                        }
                        Apply_To_Screen(Move_String, G_Enemy_Sprite_X[i], G_Enemy_Sprite_Y[i] + 100);
                        
                        if ( (poke_enemy[i] as Base_Pokemon).R_Gender() == Base_Pokemon_Stats.Female ) {// female
                           Apply_Img_To_Screen(Img_Female, G_Enemy_Sprite_X[i] - 10, G_Enemy_Sprite_Y[i] + 20);
                        } else {
                            Apply_Img_To_Screen(Img_Male, G_Enemy_Sprite_X[i] - 10, G_Enemy_Sprite_Y[i] + 20);
                        }
                        
                        if ( (poke_enemy[i] as Base_Pokemon).R_Hexed() == true )
                            Apply_Img_To_Screen(Img_Item_36, G_Enemy_Sprite_X[i] - 40, G_Enemy_Sprite_Y[i]);
                        
                    }
                }
			}
			switch ( current_menu_selected ) {
				case Menu_Menu:
                    if ( !fighting_final_boss ) { // Can't have players save during a really COOL part of the game 8-]
    					Apply_Img_To_Screen(Img_Menu_Load_Button, Menu_Load_Button_X, Menu_Load_Button_Y);
					    Apply_Img_To_Screen(Img_Menu_Save_Button, Menu_Save_Button_X, Menu_Save_Button_Y);
                        if ( is_auto_save ) {
                            Apply_Img_To_Screen(Img_0_Button, Menu_Save_Button_X, Menu_Save_Button_Y + 70);
                            Apply_To_Screen("Auto-Saving (every 1,000 frames)", Menu_Save_Button_X, Menu_Save_Button_Y + 90);
                        } else {
                            Apply_Img_To_Screen(Img_1_Button, Menu_Save_Button_X, Menu_Save_Button_Y + 70);
                            Apply_To_Screen("Not Auto-Saving", Menu_Save_Button_X, Menu_Save_Button_Y + 90);
                        }
                        Apply_To_Screen("Hold P while using Reset Save!", Menu_Reset_Button_X, Menu_Reset_Button_Y - 15);
					    Apply_Img_To_Screen(Img_Menu_Reset_Button, Menu_Reset_Button_X, Menu_Reset_Button_Y);
					    Apply_Img_To_Screen(Img_Menu_Area_Bar, Menu_Area_DropDown_X, Menu_Area_DropDown_Y);
                    }
                    if ( !fighting_final_boss ) {
					    Apply_Img_To_Screen(Img_Up_Arrow, Menu_Area_DropDown_X - 25, Menu_Area_DropDown_Y-15);
                        Apply_Img_To_Screen(Img_Down_Arrow, Menu_Area_DropDown_X - 25, Menu_Area_DropDown_Y + 15);
                        Apply_Img_To_Screen(Img_Menu_GO, Menu_Area_GO_X, Menu_Area_GO_Y);
					}
                    
                    while ( Text_Move_Results.length > 15 )
                        Text_Move_Results.splice(0, 1);
                    var str:String = new String();
                    for ( var i : int = 0; i != Text_Move_Results.length; ++ i )
                        str += Text_Move_Results[i] + "\n";
                    Apply_To_Screen(str, 500, 300);
                    
                    while ( Text_User_Results.length > 10 )
                        Text_User_Results.splice(0, 1);
                    str = new String();
                    for ( var i : int = 0; i != Text_User_Results.length; ++ i )
                        str += Text_User_Results[i] + '\n';
                    Apply_To_Screen(str, 200, 380);
                    
                    var temp_fields:Array = [ new String(), new String(), new String(), new String() ];
					temp_fields[0] = "Current Session Time: " + String(session_time) +
												   "\nCurrent Global  Time: " + String(total_time) + "\nEffect Refresh: "
                                                   + Math.floor(Number(status_effect) / Number(Status_Effect_Start) * 100);
					
                    if ( !fighting_final_boss ) {
                        temp_fields[1] = String(Area.Area_Name[current_area%Area.Area_Name.length]) + "\n";
					    for ( i = 0; i != 1; ++ i )
    						temp_fields[2]+= String(Area.Area_Name[(area_dropdown_top_index + i)%Area.Area_Name.length])
													    + " "
                                                        + " Stage " + (1+int((area_dropdown_top_index + i)/ (Area.Amt_Of_Base_Stages))) + "\n";
                    }
                                                       
                    Apply_To_Screen((temp_fields[0]), Menu_Time_Information_X, Menu_Time_Information_Y);
                    Apply_To_Screen((temp_fields[1]), Menu_Area_Title_Text_X, Menu_Area_Title_Text_Y);
                    Apply_To_Screen((temp_fields[2]), Menu_Area_DropDown_X, Menu_Area_DropDown_Y-3);
                    Apply_To_Screen((temp_fields[3]), 600, 400);
                    
                    // final boss
                    if ( (1 + current_area) % 10 == 0 && current_stage_level == ((1 + current_area) / 10)-1
                            && !fighting_final_boss ) // current area is of last area AND of last stage (and not prv one)
                        if ( final_63_boss_beat ) {
                            Apply_To_Screen("BOSS RUSH", Menu_Area_DropDown_X, Menu_Area_DropDown_Y - 25);
                            Apply_Img_To_Screen(Img_X_Button, Menu_Area_DropDown_X + 70, Menu_Area_DropDown_Y - 20);
                        } else {
                            Apply_To_Screen("FIGHT BOSS (DANGEROUS)", Menu_Area_DropDown_X, Menu_Area_DropDown_Y - 25);
                            Apply_Img_To_Screen(Img_X_Button, Menu_Area_DropDown_X + 160, Menu_Area_DropDown_Y - 20);
                        }
                    
                    
                break;
				case Menu_Inventory:
					// things outside the list
                    var txt_list_info:String = new String();
                    txt_list_info = "Name                                               Information                                                             Sell                                                         Use(Hold 1-3)";
                   
                    Apply_To_Screen(txt_list_info, St_Bar_Name_Text_X - 30, In_Bar_Info_Text_Y);
                    Apply_Img_To_Screen(Img_Up_Arrow, In_Up_Arrow_X, In_Up_Arrow_Y);
                    Apply_Img_To_Screen(Img_Down_Arrow, In_Down_Arrow_X, In_Down_Arrow_Y);
                    Apply_Img_To_Screen(Img_Scroll_Bar, In_Scrollbar_X,
                        In_Scrollbar_Y + (inventory_items.length != 1 ? (in_current_top_index / (inventory_items.length - 1)) * (In_Scrollbar_Bottom_Y - In_Scrollbar_Y) :
                                                                         0 ));

                    Apply_To_Screen("Sort by name", 40, 250);
                    Apply_Img_To_Screen(Img_X_Button, 60, 270);
                    Apply_To_Screen("Sort by type", 130, 250);
                    Apply_Img_To_Screen(Img_X_Button, 150, 270);
                    
                    Apply_Img_To_Screen(Img_0_Button, 21, 490+70);
                    if ( soul_crystal_hex_active )
                        Apply_To_Screen("Auto Hex Apply", 21, 490+90);
                    else
                        Apply_To_Screen("No Auto Hex Apply", 21, 490+90);
                    Apply_Img_To_Screen(Img_Simple_Bar, In_Scrollbar_X, In_Scrollbar_Y);
                    Apply_Img_To_Screen(Img_Simple_Bar, In_Scrollbar_X, In_Scrollbar_Bottom_Y + 20);

                    for ( var inv_it:int = 0; inv_it != 5; ++ inv_it ) {
                        if ( in_current_top_index + inv_it >= inventory_items.length ) break; // no item beyond this limit
                        var curr_item_it:Item = Item(inventory_items[in_current_top_index + inv_it]);
                        Apply_Img_To_Screen(Img_Items[curr_item_it.R_Item_Type()], St_Sprite_X - 40,
                                            In_Sprite_Y + In_Height_Per_Item * inv_it);
                                            
                        Apply_Img_To_Screen( Img_Level_Stages[curr_item_it.R_Item_Stage()],
                            this.getChildAt(this.numChildren - 1).x + this.getChildAt(this.numChildren - 1).width,
                            this.getChildAt(this.numChildren - 1).y
                        );
                        
                        Apply_Img_To_Screen(Img_X_Button, In_Sell_Button_Times_One_Icon_X,
                                                      In_Sell_Button_Times_One_Icon_Y + In_Height_Per_Item * inv_it);
                        Apply_Img_To_Screen(Img_X_Button, In_Sell_Button_Times_Ten_Icon_X,
                                                      In_Sell_Button_Times_Ten_Icon_Y + In_Height_Per_Item * inv_it);
                        var Temp_Img_1_6:Array = [ Img_1_Button, Img_2_Button,
                                                   Img_3_Button, Img_4_Button ];
                        
                        var but_it_end:int = 4;
                        
                        for ( var but_it:int = 0; but_it != 4; ++ but_it ) {
                            if ( poke_player[but_it] != null )
                               if ( !Base_Pokemon(poke_player[but_it]).R_Item_Timer_Good() )
                                    Apply_Img_To_Screen(Temp_Img_1_6[but_it],
                                        In_Use_Button_1_X + (but_it * In_Use_Button_Diff_X),
                                        In_Use_Button_Y + In_Height_Per_Item * inv_it);
                        }

                        var item_desc_txt:Array = [ new String(), new String(), new String(), new String() ];
                        item_desc_txt[0] = String(Item.Item_Name[curr_item_it.R_Item_Type()]) + "{" +
                                                            String(inventory_items_count[in_current_top_index + inv_it]) + "}";
                        item_desc_txt[1] = Item.Item_Description[curr_item_it.R_Item_Type()];
                        item_desc_txt[2] = Math.floor(Level_Stage.Stage_Enemy_Mult[curr_item_it.R_Item_Stage()] * Item.Item_Cost[curr_item_it.R_Item_Type()]);
                        item_desc_txt[3] = "*10";
                        Apply_To_Screen(item_desc_txt[0], St_Name_Info_X - 80, In_Name_Info_Y + In_Height_Per_Item * inv_it);
                        Apply_To_Screen(item_desc_txt[1], St_Desc_Info_X, In_Desc_Info_Y + In_Height_Per_Item * inv_it);
                        Apply_To_Screen(item_desc_txt[2], St_Money_Text_X, In_Money_Text_Y + In_Height_Per_Item * inv_it);
                        Apply_To_Screen(item_desc_txt[3], In_Sell_Button_Times_Ten_Icon_X,
                                                                     In_Sell_Button_Times_Ten_Icon_Y + 16 + In_Height_Per_Item * inv_it);
                        
                        if ( Item.Item_Cost_Type[Item(inventory_items[in_current_top_index + inv_it]).R_Item_Type()]
                                                                                                        == Item.Item_Currency_Type_Special ) {
                            Apply_Img_To_Screen(Img_Spec_Money, St_Spec_Money_Icon_X, In_Spec_Money_Icon_Y + In_Height_Per_Item * inv_it);
                        } else {
                            Apply_To_Screen("$", St_Spec_Money_Icon_X, In_Spec_Money_Icon_Y + In_Height_Per_Item * inv_it);
                        }
                    }
                break;
				case Menu_Store:
                    // outside of list
                    Apply_To_Screen("Name                                                              Description                                                                 Purchase",St_Bar_Name_Text_X - 30,St_Bar_Info_Text_Y);
                    Apply_Img_To_Screen(Img_Up_Arrow, St_Up_Arrow_X, St_Up_Arrow_Y);
                    Apply_Img_To_Screen(Img_Down_Arrow, St_Down_Arrow_X, St_Down_Arrow_Y);
                    Apply_To_Screen("Sort by name", 40, 250);
                    Apply_Img_To_Screen(Img_X_Button, 60, 270);
                    Apply_To_Screen("Sort by type", 130, 250);
                    Apply_Img_To_Screen(Img_X_Button, 150, 270);
                    Apply_Img_To_Screen(Img_Scroll_Bar, St_Scrollbar_X,
                        St_Scrollbar_Y + (store_items.length != 1? (st_current_top_index / (store_items.length - 1)) * (St_Scrollbar_Bottom_Y - St_Scrollbar_Y)
                                                                 : 0));
                    Apply_Img_To_Screen(Img_Simple_Bar, St_Scrollbar_X, St_Scrollbar_Y);
                    Apply_Img_To_Screen(Img_Simple_Bar, St_Scrollbar_X, In_Scrollbar_Bottom_Y + 20);
                    // items in list { some vars are reused by inventory b/c their positioning is nearly identical for most items
                    for ( var i:int = 0; i != 5; ++ i ) { 
                        if ( st_current_top_index + i >= store_items.length ) break; // no item beyond this limit
                        Apply_Img_To_Screen(Img_Items[Item(store_items[st_current_top_index + i]).R_Item_Type()], St_Sprite_X - 40, St_Sprite_Y + St_Height_Per_Item * i);
                        Apply_Img_To_Screen(Img_Level_Stages[Item(store_items[st_current_top_index + i]).R_Item_Stage()],
                            this.getChildAt(this.numChildren - 1).x + this.getChildAt(this.numChildren - 1).width,
                            this.getChildAt(this.numChildren - 1).y
                            );
                        Apply_To_Screen(String(Item.Item_Name[Item(store_items[st_current_top_index + i]).R_Item_Type()]), St_Name_Info_X - 60,
                                                                                                                           St_Name_Info_Y + St_Height_Per_Item * i);
                        Apply_To_Screen(String(Item.Item_Description[Item(store_items[st_current_top_index + i]).R_Item_Type()]), St_Desc_Info_X,
                                                                                                                           St_Desc_Info_Y + St_Height_Per_Item * i);
                        Apply_To_Screen(String(Math.floor(Level_Stage.Stage_Enemy_Mult[Item(store_items[st_current_top_index + i]).R_Item_Stage()]
                                    * Item.Item_Cost[Item(store_items[st_current_top_index + i]).R_Item_Type()])), St_Money_Text_X,
                                                                                                                           St_Money_Text_Y + St_Height_Per_Item * i);
                        Apply_Img_To_Screen(Img_X_Button, St_Buy_Button_Times_One_Icon_X, St_Buy_Button_Times_One_Icon_Y + St_Height_Per_Item * i);
                        Apply_Img_To_Screen(Img_X_Button, In_Sell_Button_Times_Ten_Icon_X,
                                                      In_Sell_Button_Times_Ten_Icon_Y + St_Height_Per_Item * i);
                        Apply_To_Screen("*10", In_Sell_Button_Times_Ten_Icon_X,
                                               In_Sell_Button_Times_Ten_Icon_Y + 16 + St_Height_Per_Item * i);
                        if ( Item.Item_Cost_Type[Item(store_items[st_current_top_index + i]).R_Item_Type()] == Item.Item_Currency_Type_Special ) {
                            Apply_Img_To_Screen(Img_Spec_Money, St_Spec_Money_Icon_X, St_Spec_Money_Icon_Y + St_Height_Per_Item * i);
                        } else {
                            Apply_To_Screen("$", St_Spec_Money_Icon_X, St_Spec_Money_Icon_Y + St_Height_Per_Item * i);
                        }
                    }
                break;
                case Menu_Pokemon:
                    // outside of list
                    Apply_To_Screen("Name                                                                                                                                             Sell                      Equip                                      Breed                Trainer", Pb_Name_Text_X, Pb_Info_Text_Y);
                    Apply_Img_To_Screen(Img_Up_Arrow, Pb_Up_Arrow_X, Pb_Up_Arrow_Y);
                    Apply_To_Screen("Sort by name", 40, 250);
                    Apply_Img_To_Screen(Img_X_Button, 60, 270);
                    Apply_To_Screen("Sort by type", 130, 250);
                    Apply_Img_To_Screen(Img_X_Button, 150, 270);
                    Apply_To_Screen("Sort by level", 220, 250);
                    Apply_Img_To_Screen(Img_X_Button, 240, 270);
                    Apply_Img_To_Screen(Img_Down_Arrow, Pb_Down_Arrow_X, Pb_Down_Arrow_Y);
                    Apply_Img_To_Screen(Img_Scroll_Bar, Pb_Scrollbar_X,
                        Pb_Scrollbar_Y + (pokemon_in_bank.length != 1 ? (pb_current_top_index / (pokemon_in_bank.length - 1)) * (Pb_Scrollbar_Bottom_Y - Pb_Scrollbar_Y)
                                                                      : 0));
                    Apply_Img_To_Screen(Img_Simple_Bar, Pb_Scrollbar_X, Pb_Scrollbar_Y);
                    Apply_Img_To_Screen(Img_Simple_Bar, Pb_Scrollbar_X, Pb_Scrollbar_Bottom_Y + 20);
                    
                    Apply_To_Screen("Remove Move (hold 1-3)", 1, 530);
                    var buttons:Array = [ Img_1_Button, Img_2_Button,
                                          Img_3_Button, Img_4_Button ]; // these represent the botomons in party
                    for ( var it : int = 0; it != 4; ++ it )
                        if ( poke_player[it] != null )
                            Apply_Img_To_Screen(buttons[it], 4 + it * 45, 560);
                    // inside list
                    for ( var i:int = 0; i != 4; ++ i ) {
                        if ( pb_current_top_index + i >= pokemon_in_bank.length ) break; // no more botomon to disp
                        Apply_Img_To_Screen_Small(Img_Pokemon[(pokemon_in_bank[pb_current_top_index+i] as Base_Pokemon).R_Species_ID()], Pb_Pokemon_Sprite_X,
                                                                                                                           Pb_Pokemon_Sprite_Y + (Pb_Height_Per_Item * i));
                        Apply_Img_To_Screen(Img_Level_Stages[(pokemon_in_bank[pb_current_top_index + i] as Base_Pokemon).R_Stage()],
                            this.getChildAt(this.numChildren - 1).x + this.getChildAt(this.numChildren - 1).width,
                            this.getChildAt(this.numChildren - 1).y
                                       );
                       if ( (pokemon_in_bank[pb_current_top_index + i] as Base_Pokemon).R_Gender() == Base_Pokemon_Stats.Female ) {// female
                            Apply_Img_To_Screen(Img_Female, Pb_Pokemon_Sprite_X - 10, Pb_Pokemon_Sprite_Y + Pb_Height_Per_Item * i);
                            if ( !currently_breeding )
                                Apply_Img_To_Screen(Img_Breed_Female_Button, Pb_Trainer_X - 80, Pb_Trainer_Y + Pb_Height_Per_Item * i);
                        } else {
                            Apply_Img_To_Screen(Img_Male, Pb_Pokemon_Sprite_X - 10, Pb_Pokemon_Sprite_Y + Pb_Height_Per_Item * i);    
                            if ( !currently_breeding )
                                Apply_Img_To_Screen(Img_Breed_Male_Button, Pb_Trainer_X - 80, Pb_Trainer_Y + Pb_Height_Per_Item * i);
                        }
                        Apply_To_Screen((pokemon_in_bank[pb_current_top_index + i] as Base_Pokemon).R_Name() + " ( " +
                                        (pokemon_in_bank[pb_current_top_index + i] as Base_Pokemon).R_Level() + " ) " +
                                        "{ " + Base_Pokemon_Stats.R_Type_To_String(
                                               Base_Pokemon_Stats.Poke_Type_1[(pokemon_in_bank[pb_current_top_index + i] as Base_Pokemon).R_Species_ID()]) +
                                        ", " + Base_Pokemon_Stats.R_Type_To_String(
                                               Base_Pokemon_Stats.Poke_Type_2[(pokemon_in_bank[pb_current_top_index + i] as Base_Pokemon).R_Species_ID()]) +
                                        " } " + Base_Pokemon_Stats.Poke_Name[(pokemon_in_bank[pb_current_top_index + i] as Base_Pokemon).R_Species_ID()],
                                        Pb_Name_Info_X, Pb_Name_Info_Y + (Pb_Height_Per_Item * i), false);
                                        
                        Apply_To_Screen("HP: " + (pokemon_in_bank[pb_current_top_index + i] as Base_Pokemon).R_Curr_Health() + "/ " +
                                                 (pokemon_in_bank[pb_current_top_index + i] as Base_Pokemon).R_Max_Health() +
                                        " Att: " + (pokemon_in_bank[pb_current_top_index + i] as Base_Pokemon).R_Attack() +
                                        " Def: " + (pokemon_in_bank[pb_current_top_index + i] as Base_Pokemon).R_Defense() +
                                        " S Att: " + (pokemon_in_bank[pb_current_top_index + i] as Base_Pokemon).R_Spec_Att() +
                                        " S Def: " + (pokemon_in_bank[pb_current_top_index + i] as Base_Pokemon).R_Spec_Def() +
                                        " Speed: " + (pokemon_in_bank[pb_current_top_index + i] as Base_Pokemon).R_Speed(),
                                                        Pb_Stats_X, Pb_Stats_Y + (Pb_Height_Per_Item * i));
                                        
                        if ( !fighting_final_boss ) { // Can't have players change their botomon 
                            var buttons:Array = [ Img_1_Button, Img_2_Button,
                                                  Img_3_Button, Img_4_Button ];
                            for ( var it : int = 0; it != 4; ++ it )
                                Apply_Img_To_Screen(buttons[it], Pb_Equip_Icon_X + Pb_Equip_X_Diff * it, Pb_Equip_Icon_Y + (Pb_Height_Per_Item * i));
                        }
                        Apply_Img_To_Screen(Img_X_Button, Pb_Sell_Icon_X, Pb_Sell_Icon_Y + Pb_Height_Per_Item * i);
                        Apply_To_Screen( String((pokemon_in_bank[pb_current_top_index + i] as Base_Pokemon).R_Value()),
                            Pb_Sell_Info_Text_X, (Pb_Name_Info_Y-3) + Pb_Height_Per_Item * i);
                        Apply_Img_To_Screen(Img_Spec_Money, Pb_Sell_Info_Text_X - 16, (Pb_Name_Info_Y - 3) + Pb_Height_Per_Item * i);
                        Apply_Img_To_Screen(Img_Trainer_Button, Pb_Trainer_X, Pb_Trainer_Y + Pb_Height_Per_Item * i);
                    }
                break;
                case Menu_Party:
                    for ( var pa_it:int = 0; pa_it != 4; ++ pa_it ) {
                        if ( poke_player[pa_it] == null ) continue;
                        Apply_Img_To_Screen_Small(Img_Pokemon[(poke_player[pa_it] as Base_Pokemon).R_Species_ID()], Party_Pokemon_Sprite_X[pa_it], Party_Pokemon_Sprite_Y[pa_it]);
                        Apply_Img_To_Screen(Img_Level_Stages[(poke_player[pa_it] as Base_Pokemon).R_Stage()],
                            this.getChildAt(this.numChildren - 1).x + this.getChildAt(this.numChildren - 1).width,
                            this.getChildAt(this.numChildren - 1).y
                            );
                        if ( !fighting_final_boss ) // Can't have players change their botomon
                            Apply_Img_To_Screen(Img_X_Button, Party_Pokemon_Sprite_X[pa_it] - 40, Party_Pokemon_Sprite_Y[pa_it] + 20);
                        //Apply_Img_To_Screen(Img_Party_Health_Bar, Party_Pokemon_Health_Bar_X[pa_it], Party_Pokemon_Health_Bar_Y[pa_it]);
                        //Apply_Img_To_Screen(Img_Party_Xp_Bar, Party_Pokemon_Xp_Bar_X[pa_it], Party_Pokemon_Xp_Bar_Y[pa_it]);
                        Apply_To_Screen("Health: " + String((poke_player[pa_it] as Base_Pokemon).R_Curr_Health()) + " / " + String((poke_player[pa_it] as Base_Pokemon).R_Max_Health()),
                                        Party_Pokemon_Health_Text_X[pa_it], Party_Pokemon_Health_Text_Y[pa_it]);
                        Apply_To_Screen("Experience: " + String((poke_player[pa_it] as Base_Pokemon).R_Curr_Exp()) + " / " + String((poke_player[pa_it] as Base_Pokemon).R_Exp_To_Level()),
                                        Party_Pokemon_Xp_Bar_X[pa_it], Party_Pokemon_Xp_Bar_Y[pa_it]);
                        Apply_To_Screen("HP: " + (poke_player[pa_it] as Base_Pokemon).R_Max_Health() +
                                        " Att: " + (poke_player[pa_it] as Base_Pokemon).R_Attack() +
                                        " Def: " + (poke_player[pa_it] as Base_Pokemon).R_Defense() + "\n" +
                                        "S Att: " + (poke_player[pa_it] as Base_Pokemon).R_Spec_Att() +
                                        " S Def: " + (poke_player[pa_it] as Base_Pokemon).R_Spec_Def() +
                                        " Speed: " + (poke_player[pa_it] as Base_Pokemon).R_Speed(),
                                        Party_Pokemon_Information_X[pa_it], Party_Pokemon_Information_Y[pa_it]);
                        Apply_To_Screen((poke_player[pa_it] as Base_Pokemon).R_Name() + " (" +
                                        String((poke_player[pa_it] as Base_Pokemon).R_Level()) + ")", Party_Pokemon_Name_X[pa_it],
                                                                                              Party_Pokemon_Name_Y[pa_it], false);
                        var move_list_txt:String = new String();
                        var move_list:Array = (poke_player[pa_it] as Base_Pokemon).R_Move_Set();
                        for ( var i:int = 0; i != 3; ++ i ) {
                            if ( move_list[i] != null ) {
                                move_list_txt += (i+1) + ": " + Move_Info.Names[Move(move_list[i]).Move_ID];
                                move_list_txt += " { " + Base_Pokemon_Stats.R_Type_To_String(Move(move_list[i]).Move_Type) + " } ";
                                move_list_txt += "\n";
                                Apply_Img_To_Screen(Img_Level_Stages[Move(move_list[i]).Move_Stage], Party_Move_Start_X[pa_it] - 20,
                                                                                      Party_Move_Start_Y[pa_it] + 15 * i);
                            }
                        }
                        Apply_To_Screen("Move Set {", Party_Move_Start_X[pa_it] - 80, Party_Move_Start_Y[pa_it] + 40);
                        Apply_To_Screen(move_list_txt, Party_Move_Start_X[pa_it], Party_Move_Start_Y[pa_it]);
                        if ( is_auto_heal[pa_it] == 0 ) {
                            Apply_To_Screen("$" + 1000 * Level_Stage.Stage_Player_Mult[(poke_player[pa_it] as Base_Pokemon).R_Stage()],
                                        Party_Pokemon_Sprite_X[pa_it] - 40, Party_Pokemon_Sprite_Y[pa_it] + 100);
                            Apply_Img_To_Screen(Img_0_Button, Party_Pokemon_Sprite_X[pa_it] - 40, Party_Pokemon_Sprite_Y[pa_it] + 80);
                            Apply_To_Screen("Autoheal", Party_Pokemon_Sprite_X[pa_it] - 45, Party_Pokemon_Sprite_Y[pa_it] + 60);
                        } else
                            Apply_Img_To_Screen(Img_1_Button, Party_Pokemon_Sprite_X[pa_it] - 40, Party_Pokemon_Sprite_Y[pa_it] + 80);
                    }
                    Apply_To_Screen("Auto heal: 20% income from enemy, 100% health after fight.", 20, 570);
                break;
				case Menu_Breeding:
                    Apply_To_Screen("Level: " + breeding_level + "\nExperience: " + breeding_experience + "\nTo Level: " +
                                    breeding_experience_to_level + "\n" +
                                    "Ratio: " + (int(breeding_mult_timer * 100)) +
                                    "\nFrames per breeding session: " + int(Number(30 * 40 * 20)
                                    * breeding_mult_timer) +
                                    "\nTotal Botomon Bred: " + botomon_bred
                        , 20, 500);
                
                    if ( !currently_breeding && breeding_pokemon[0] != null && breeding_pokemon[1] != null ) // to make sure player doesn't think they can breed w/ 1 bot
                        Apply_Img_To_Screen(Img_Breed_Button, Breed_Button_X, Breed_Button_Y);
                    else if ( currently_breeding ) {
                        Apply_Img_To_Screen(Img_Breed_Intertwine, Breed_Slot_Interconnect_Sprite_X, Breed_Slot_Interconnect_Sprite_Y);
                        if ( timer_breeding <= 0 )
                            Apply_Img_To_Screen(Img_Breed_Collect, Breed_Retrieve_X, Breed_Retrieve_Y);
                        var asdf_whatever_idc:String = "";
                        if ( breeding_force_new )
                            asdf_whatever_idc = "\nChance of new species of botomon: 99%";
                        else
                            asdf_whatever_idc = "\nChance of new species of botomon: 20%";
                        Apply_To_Screen("Time Remaining: " + String(timer_breeding) + asdf_whatever_idc, Breed_Time_Remaining_Text_X, Breed_Time_Remaining_Text_Y);
                    }
                    if ( breeding_pokemon[0] != null ) {
                        Apply_Img_To_Screen(Img_Male, Breed_Slot_Sprite_1_X, Breed_Slot_Sprite_1_Y - 40);
                        Apply_To_Screen((breeding_pokemon[0] as Base_Pokemon).R_Name(), Breed_Slot_Name_1_X+5, Breed_Slot_Name_1_Y, false);
                        Apply_Img_To_Screen(Img_Pokemon[(breeding_pokemon[0] as Base_Pokemon).R_Species_ID()], Breed_Slot_Sprite_1_X, Breed_Slot_Sprite_1_Y);
                        Apply_Img_To_Screen(Img_Level_Stages[(breeding_pokemon[0] as Base_Pokemon).R_Stage()],
                            this.getChildAt(this.numChildren - 1).x + this.getChildAt(this.numChildren - 1).width,
                            this.getChildAt(this.numChildren - 1).y
                            );
                        if ( !currently_breeding )
                            Apply_Img_To_Screen(Img_X_Button, Breed_Slot_Sprite_1_X - 40, Breed_Slot_Sprite_1_Y + 15);
                    }
                    if ( breeding_pokemon[1] != null ) {
                        Apply_Img_To_Screen(Img_Female, Breed_Slot_Sprite_2_X, Breed_Slot_Sprite_2_Y - 40);
                        Apply_To_Screen((breeding_pokemon[1] as Base_Pokemon).R_Name(), Breed_Slot_Name_2_X+5, Breed_Slot_Name_2_Y, false);
                        Apply_Img_To_Screen(Img_Pokemon[(breeding_pokemon[1] as Base_Pokemon).R_Species_ID()], Breed_Slot_Sprite_2_X, Breed_Slot_Sprite_2_Y);
                        Apply_Img_To_Screen(Img_Level_Stages[(breeding_pokemon[1] as Base_Pokemon).R_Stage()],
                            this.getChildAt(this.numChildren - 1).x + this.getChildAt(this.numChildren - 1).width,
                            this.getChildAt(this.numChildren - 1).y
                            );
                        if ( !currently_breeding )
                            Apply_Img_To_Screen(Img_X_Button, Breed_Slot_Sprite_2_X - 40, Breed_Slot_Sprite_2_Y + 15);
                    }
                break;
				case Menu_Trainer:
                    Apply_Img_To_Screen(Img_Trainer_Player_Button, Trainer_Button_X, Trainer_Button_Y);
                    Apply_To_Screen(" +XP: " + trainer_upgrade_per_click, Trainer_Button_Text_X, Trainer_Button_Text_Y);
                    if ( trainer_curr_pokemon != null ) {
                        Apply_Img_To_Screen(Img_Pokemon[(trainer_curr_pokemon as Base_Pokemon).R_Species_ID()],
                                                        Trainer_Pokemon_Sprite_X, Trainer_Pokemon_Sprite_Y);
                        Apply_Img_To_Screen(Img_Level_Stages[(trainer_curr_pokemon as Base_Pokemon).R_Stage()],
                                        this.getChildAt(this.numChildren - 1).x + this.getChildAt(this.numChildren - 1).width,
                                        this.getChildAt(this.numChildren - 1).y
                                       );
                        Apply_Img_To_Screen(Img_X_Button, Trainer_Pokemon_Sprite_X - 40, Trainer_Pokemon_Sprite_Y + 16);
                                       
                        Apply_To_Screen(String((trainer_curr_pokemon as Base_Pokemon).R_Name()), Trainer_Pokemon_Name_X, Trainer_Pokemon_Name_Y, false);
                        Apply_To_Screen("Level: " + String((trainer_curr_pokemon as Base_Pokemon).R_Level()),
                                                        Trainer_Pokemon_Level_X, Trainer_Pokemon_Level_Y);
                        Apply_To_Screen("Experience: " + String((trainer_curr_pokemon as Base_Pokemon).R_Curr_Exp()) +
                                        " / " + String((trainer_curr_pokemon as Base_Pokemon).R_Exp_To_Level()), 320, 300);
                    }
                    var upgrades:Array = [ Img_Trainer_Upgrade1, Img_Trainer_Upgrade2, Img_Trainer_Upgrade3,
                                           Img_Trainer_Upgrade4, Img_Trainer_Upgrade5, Img_Trainer_Upgrade6 ];
                    
                    for ( var t:int = 0; t != Trainer_Upg_Button_X.length; ++ t ) { // iterate through all the upgrades
                        Apply_Img_To_Screen(Img_Spec_Money, Trainer_Per_60FPS_X[t]-10, Trainer_Per_60FPS_Y[t] + 15);
                        Apply_To_Screen("   " + trainer_curr_price[t], Trainer_Per_60FPS_X[t], Trainer_Per_60FPS_Y[t]+13);
                        Apply_Img_To_Screen(upgrades[t], Trainer_Sprite_X[t], Trainer_Sprite_Y[t]);
                        Apply_Img_To_Screen(Img_Trainer_Upgrade_Button, Trainer_Upg_Button_X[t], Trainer_Upg_Button_Y[t]);
                        Apply_To_Screen("Level: " + trainer_levels[t] + "/20", Trainer_Sprite_X[t], Trainer_Sprite_Y[t] + 80);
                        Apply_To_Screen("1 F: " + Math.floor(trainer_xp_f[t]), Trainer_Per_Frame_X[t], Trainer_Per_Frame_Y[t]);
                        Apply_To_Screen("60F: " + Math.floor(trainer_xp_f[t] * 60), Trainer_Per_60FPS_X[t], Trainer_Per_60FPS_Y[t]);
                        Apply_To_Screen(String(Trainer_Title_Text[t]), Trainer_Title_Text_X[t], Trainer_Title_Text_Y[t]);
                    }
                    
			}
            // very last thing applied
            Apply_Img_To_Screen(Img_Bottom_Bar, 0, Bottom_Menu_Switch_Bar_Y);
            if ( timer_breeding <= 0 && currently_breeding)
                Apply_To_Screen("(Done)", 630, 600);
            switch ( current_menu_selected ) {
                case Menu_Inventory: case Menu_Pokemon: case Menu_Store:
                while ( Text_Store_Results.length > 6 )
                    Text_Store_Results.splice(0, 1);
                str = "";
                for ( var i : int = 0; i != Text_Store_Results.length; ++ i )
                    str += Text_Store_Results[i] + '\n';
                Apply_To_Screen(str, 500, 500);
            }

            var bot_menu_sw_x:int;
            var cur_men_str:String;
            switch ( current_menu_selected ) {
                case Menu_Menu: bot_menu_sw_x = Bottom_Menu_Switch_Bar_Menu_X; cur_men_str = "Menu"; break;
                case Menu_Breeding: bot_menu_sw_x = Bottom_Menu_Switch_Bar_Breeding_X; cur_men_str = "Breeding";break;
                case Menu_Party: bot_menu_sw_x = Bottom_Menu_Switch_Bar_Party_X; cur_men_str = "Party";break;
                case Menu_Trainer: bot_menu_sw_x = Bottom_Menu_Switch_Bar_Trainer_X; cur_men_str = "Trainer";break;
                case Menu_Store: bot_menu_sw_x = Bottom_Menu_Switch_Bar_Store_X; cur_men_str = "Store";break;
                case Menu_Pokemon: bot_menu_sw_x = Bottom_Menu_Switch_Bar_Poke_Bank_X; cur_men_str = "Botomon";break;
                case Menu_Inventory: bot_menu_sw_x = Bottom_Menu_Switch_Bar_Items_X; cur_men_str = "Inventory";break;
            }
            Apply_To_Screen("Menu: " + cur_men_str, 900, 5);
            Apply_Img_To_Screen(Img_Bottom_Bar_Highlight, bot_menu_sw_x - 30, Bottom_Menu_Switch_Bar_Y + 20);
            
            if ( final_boss_damaged > 0 )
                Apply_Alpha_Img(Icon_Damaged, 380, 0,
                                Number(final_boss_damaged)/Number(Damage_Timer));
        }
    
        public function Load_Sprites():void {
                
            Img_Bottom_Bar.ID = 0;
                    
            Img_Bottom_Bar_Highlight.ID = 1;
            Img_1_Button.ID = 2;
            Img_2_Button.ID = 3;
            Img_3_Button.ID = 4;
            Img_4_Button.ID = 5;
            
            Img_X_Button.ID = 8;
                                
            Img_Battle_Global_Health_Bar.ID = 9;
            Img_Battle_Global_Xp_Bar.ID = 10;
            Img_Battle_Global_Text_Box.ID = 11;
                                
            Img_Breed_Button.ID = 12;
            Img_Breed_Collect.ID = 13;
            Img_Breed_Intertwine.ID = 14;
                                
            Img_Down_Arrow.ID = 15;
            Img_Up_Arrow.ID = 16;
                                
            Img_Female.ID = 17;
            Img_Male.ID = 18;
                                
            Img_Menu_Area_List_Backdrop.ID = 19;
            Img_Menu_Area_Bar.ID = 20;
            Img_Menu_GO.ID = 21;
            Img_Menu_Load_Button.ID = 22;
            Img_Menu_Reset_Button.ID = 23;
            Img_Menu_Save_Button.ID = 24;
                                
            Img_Party_Health_Bar.ID = 25;
            Img_Party_Xp_Bar.ID = 26;
            Img_Party_None.ID = 27;
                                
            Img_Scroll_Bar.ID = 28;
            Img_Scroll_Bar_Backdrop.ID = 29;

            Img_Spec_Money.ID = 30;

            Img_Trainer_Button.ID = 31;
            Img_Trainer_Experience_Bar.ID = 32;
            Img_Trainer_Player_Button.ID = 33;
            Img_Trainer_Upgrade_Button.ID = 34;
            Img_Trainer_Upgrade1.ID = 35;
            Img_Trainer_Upgrade2.ID = 36;
            Img_Trainer_Upgrade3.ID = 37;
            Img_Trainer_Upgrade4.ID = 38;
            Img_Trainer_Upgrade5.ID = 39;
            Img_Trainer_Upgrade6.ID = 40;

            Badge_0.ID = 41;
            Badge_1.ID = 42;
            Badge_2.ID = 43;
            Badge_3.ID = 44;
            Badge_4.ID = 45;
            Badge_5.ID = 46;
            Badge_6.ID = 47;
            Badge_7.ID = 48;
            Badge_8.ID = 49;
            Badge_9.ID = 50;
            Badge_10.ID = 51;
            Badge_11.ID = 52;
            Badge_12.ID = 53;
            Badge_13.ID = 54;
            Badge_14.ID = 55;
            Badge_15.ID = 56;
            Badge_16.ID = 57;
            Badge_17.ID = 58;
            Badge_18.ID = 59;
            Badge_19.ID = 60;
            Badge_20.ID = 61;
            Badge_21.ID = 62;
            Badge_22.ID = 63;
            Badge_23.ID = 64;
            Badge_24.ID = 65;
            Badge_25.ID = 66;
            Badge_26.ID = 67;
            Badge_27.ID = 68;
            Badge_28.ID = 69;
            Badge_29.ID = 70;
            Badge_30.ID = 71;
            Badge_31.ID = 72;
            Badge_32.ID = 73;
            Badge_33.ID = 74;
            Badge_34.ID = 75;
            Badge_35.ID = 76;
            Badge_36.ID = 77;
            Badge_37.ID = 78;
            Badge_38.ID = 79;
            Badge_39.ID = 80;
            Badge_40.ID = 81;
            Badge_41.ID = 82;
            Badge_42.ID = 83;
            Badge_43.ID = 84;
            Badge_44.ID = 85;
            Badge_45.ID = 86;
            Badge_46.ID = 87;
            Badge_47.ID = 88;
            Badge_48.ID = 89;
            Badge_49.ID = 90;
            Badge_50.ID = 91;
            Badge_51.ID = 92;
            Badge_52.ID = 93;
            Badge_53.ID = 94;
            Badge_54.ID = 95;
            Badge_55.ID = 96;
            Badge_56.ID = 97;
            Badge_57.ID = 98;
            Badge_58.ID = 99;
            Badge_59.ID = 100;
            Badge_60.ID = 101;
            Badge_61.ID = 102;
            Badge_62.ID = 103;

            Bot_0.ID = 105;
            Bot_1.ID = 106;
            Bot_2.ID = 107;
            Bot_3.ID = 108;
            Bot_4.ID = 109;
            Bot_5.ID = 110;
            Bot_6.ID = 111;
            Bot_7.ID = 112;
            Bot_8.ID = 113;
            Bot_9.ID = 114;
            Bot_10.ID = 115;
            Bot_11.ID = 116;
            Bot_12.ID = 117;
            Bot_13.ID = 118;
            Bot_14.ID = 119;
            Bot_15.ID = 120;
            Bot_16.ID = 121;
            Bot_17.ID = 122;
            Bot_18.ID = 123;
            Bot_19.ID = 124;
            Bot_20.ID = 125;
            Bot_21.ID = 126;
            Bot_22.ID = 127;
            Bot_23.ID = 128;
            Bot_24.ID = 129;
            Bot_25.ID = 130;
            Bot_26.ID = 131;
            Bot_27.ID = 132;
            Bot_28.ID = 133;
            Bot_29.ID = 134;
            Bot_30.ID = 135;
            Bot_31.ID = 136;
            Bot_32.ID = 137;
            Bot_33.ID = 138;
            Bot_34.ID = 189;

            Img_Item_0.ID = 139;
            Img_Item_1.ID = 140;
            Img_Item_2.ID = 141;
            Img_Item_3.ID = 142;
            Img_Item_4.ID = 143;
            Img_Item_5.ID = 144;
            Img_Item_6.ID = 145;
            Img_Item_7.ID = 146;
            Img_Item_8.ID = 147;
            Img_Item_9.ID = 148;
            Img_Item_10.ID = 149;
            Img_Item_11.ID = 150;
            Img_Item_12.ID = 151;
            Img_Item_13.ID = 152;
            Img_Item_14.ID = 153;
            Img_Item_15.ID = 154;
            Img_Item_16.ID = 155;
            Img_Item_17.ID = 156;
            Img_Item_18.ID = 157;
            Img_Item_19.ID = 158;
            Img_Item_20.ID = 159;
            Img_Item_21.ID = 160;
            Img_Item_22.ID = 161;
            Img_Item_23.ID = 162;
            Img_Item_24.ID = 163;
            Img_Item_25.ID = 164;
            Img_Item_26.ID = 165;
            Img_Item_27.ID = 166;
            Img_Item_28.ID = 167;
            Img_Item_29.ID = 168;
            Img_Item_30.ID = 169;
            Img_Item_31.ID = 170;
            Img_Item_32.ID = 171;
            Img_Item_33.ID = 172;
            Img_Item_34.ID = 173;
            Img_Item_35.ID = 174;
            Img_Item_36.ID = 175;
            Img_Item_37.ID = 176;
            Img_Item_38.ID = 177;
            Img_Item_39.ID = 178;
            Img_Item_40.ID = 179;
            Img_Item_41.ID = 180;
            Img_Item_42.ID = 181;
            Img_Item_43.ID = 182;
            Img_Item_44.ID = 183;
            Img_Item_45.ID = 184;
            Img_Item_46.ID = 185;
            Img_Item_47.ID = 201;
            
            Img_Breed_Female_Button.ID = 186;
            Img_Breed_Male_Button.ID = 187;
            
            Img_0_Button.ID = 188;
            Bot_35.ID = 200;
            
            Icon_Damaged.ID = 202;
            Img_Level_Stages = [
                Badge_0, Badge_1,   Badge_2,   Badge_3,   Badge_4,   Badge_5,
                Badge_6,   Badge_7,   Badge_8,   Badge_9,   Badge_10,
                Badge_11,   Badge_12,   Badge_13,   Badge_14,   Badge_15,
                Badge_16,   Badge_17,   Badge_18,   Badge_19,   Badge_20,
                Badge_21,   Badge_22,   Badge_23,   Badge_24,   Badge_25,
                Badge_26,   Badge_27,   Badge_28,   Badge_29,   Badge_30,
                Badge_31,   Badge_32,   Badge_33,   Badge_34,   Badge_35,
                Badge_36,   Badge_37,   Badge_38,   Badge_39,   Badge_40,
                Badge_41,   Badge_42,   Badge_43,   Badge_44,   Badge_45, 
                Badge_46,   Badge_47,   Badge_48,   Badge_49,   Badge_50,
                Badge_51,   Badge_52,   Badge_53,   Badge_54,   Badge_55,
                Badge_56,   Badge_57,   Badge_58,   Badge_59,   Badge_60,
                Badge_61,   Badge_62
            ];
            Img_Pokemon = [
                Bot_0,   Bot_1,   Bot_2,   Bot_3,   Bot_4,
                Bot_5,   Bot_6,   Bot_7,   Bot_8,   Bot_9,
                Bot_10,   Bot_11,   Bot_12,   Bot_13,   Bot_14,
                Bot_15,   Bot_16,   Bot_17,   Bot_18,   Bot_19,
                Bot_20,   Bot_21,   Bot_22,   Bot_23,   Bot_24,
                Bot_25,   Bot_26,   Bot_27,   Bot_28,   Bot_29,
                Bot_30,   Bot_31,   Bot_32,   Bot_33,   Bot_34,
                Bot_35
            ];
            Img_Items = [
            Img_Item_0, Img_Item_1, Img_Item_2, Img_Item_3, Img_Item_4,
            Img_Item_5, Img_Item_6, Img_Item_7, Img_Item_8, Img_Item_9,
            Img_Item_10, Img_Item_11, Img_Item_12, Img_Item_13, Img_Item_14,
            Img_Item_15, Img_Item_16, Img_Item_17,
            // 40 items of TM
            Img_Item_18, Img_Item_18, Img_Item_18, Img_Item_18, Img_Item_18,
            Img_Item_18, Img_Item_18, Img_Item_18, Img_Item_18, Img_Item_18,
            Img_Item_18, Img_Item_18, Img_Item_18, Img_Item_18, Img_Item_18,
            Img_Item_18, Img_Item_18, Img_Item_18, Img_Item_18, Img_Item_18,
            Img_Item_18, Img_Item_18, Img_Item_18, Img_Item_18, Img_Item_18,
            Img_Item_18, Img_Item_18, Img_Item_18, Img_Item_18, Img_Item_18,
            Img_Item_18, Img_Item_18, Img_Item_18, Img_Item_18, Img_Item_18,
            Img_Item_18, Img_Item_18, Img_Item_18, Img_Item_18, Img_Item_18,
            Img_Item_18,
            
            Img_Item_19, Img_Item_20, Img_Item_21, Img_Item_22, Img_Item_23,
            Img_Item_24, Img_Item_25, Img_Item_26, Img_Item_27, Img_Item_28,
            Img_Item_29, Img_Item_30, Img_Item_31, Img_Item_32, Img_Item_33,
            Img_Item_34, Img_Item_35, Img_Item_36, Img_Item_37, Img_Item_38,
            Img_Item_39, Img_Item_40, Img_Item_41, Img_Item_42, Img_Item_43,
            Img_Item_44, Img_Item_45, Img_Item_47, Img_Item_46
            ];
        }
    } // screen
}; // package