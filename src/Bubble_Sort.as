package src {
    import flash.system.fscommand;
    public class Bubble_Sort {
        public static const Type:int = 0;
        public static const Name:int = 1;
        public static const Level:int = 2;
        public static const Descending:int = 0;
        public static const Ascending:int = 1;
        
        public static var item_sort_flip:int = 0;
        public static var item_sort_flip_val:int = Ascending;
        
        public static var bot_sort_flip:int = 0;
        public static var bot_sort_flip_val:int = Ascending;
        
        // is x > y ?
        public static function String_Comp(x:String, y:String):Boolean {
            var length = x.length;
            if ( length > y.length ) length = y.length;
            if ( x == y ) return false;
            for ( var i : int = 0; i != length; ++ i )
                if ( x.charAt(i) < y.charAt(i) ) return 0;
                else if ( x.charAt(i) > y.charAt(i) ) return 1;
            if ( x.length < y.length ) return 0;
            return 1;
        }
        
        public static function String_Comp_D(x:String, y:String):Boolean {
            var length = x.length;
            if ( length > y.length ) length = y.length;
            if ( x == y ) return false;
            for ( var i : int = 0; i != length; ++ i )
                if ( x.charAt(i) > y.charAt(i) ) return 0;
                else if ( x.charAt(i) < y.charAt(i) ) return 1;
            if ( x.length < y.length ) return 0;
            return 1;
        }
        
        public static function Item_Sort(arr:Array, type_sort:int, dir:int, tarr:Boolean = false):Array {
            var i:int; var j:int;
            var flag:int = 1;
            
            for ( var i : int = 1; (i != arr.length) && flag; ++ i ) {
                flag = 0;
                for ( var j : int = 0; j != arr.length - 1; ++ j ) {
                    var happened:Boolean = false;
                    switch ( type_sort ) {
                        case Type:
                            if ( dir == Descending ) {
                                if ( Item(arr[j + 1]).R_Item_Stage() > Item(arr[j]).R_Item_Stage() )
                                    happened = true;
                                else if ( Item(arr[j + 1]).R_Item_Type() < Item(arr[j]).R_Item_Type() )
                                    happened = true;
                            } else {
                                if ( Item(arr[j + 1]).R_Item_Stage() < Item(arr[j]).R_Item_Stage() )
                                    happened = true;
                                else if ( Item(arr[j + 1]).R_Item_Type() > Item(arr[j]).R_Item_Type() )
                                    happened = true;
                            }
                        break;
                        case Name:
                            if ( dir == Descending ) {
                                if ( Item(arr[j + 1]).R_Item_Stage() > Item(arr[j]).R_Item_Stage() )
                                    happened = true;
                                else if ( String_Comp(Item.Item_Name[Item(arr[j + 1]).R_Item_Type()],
                                                    Item.Item_Name[Item(arr[j]).R_Item_Type()] ) )
                                    happened = true;
                            } else {
                                if ( Item(arr[j + 1]).R_Item_Stage() < Item(arr[j]).R_Item_Stage() )
                                    happened = true;
                                else if ( String_Comp_D(Item.Item_Name[Item(arr[j + 1]).R_Item_Type()],
                                                    Item.Item_Name[Item(arr[j]).R_Item_Type()] ) )
                                    happened = true;
                            }
                        break;
                    }
                    if ( happened ) {
                        if ( tarr != 0 ) {
                            var z:int = Screen.inventory_items_count[j + 1];
                            Screen.inventory_items_count[j + 1] = Screen.inventory_items_count[j];
                            Screen.inventory_items_count[j] = z;
                        }
                        var temp:Item = arr[j + 1];
                        arr[j + 1] = arr[j];
                        arr[j] = temp;
                        flag = 1;
                    }
                }
            }
            return arr;
        }        
        
        public static function Bot_Sort(arr:Array, type_sort:int, dir:int):Array {
            var i:int; var j:int;
            var flag:int = 1;
            
            for ( var i : int = 1; (i != arr.length) && flag; ++ i ) {
                flag = 0;
                for ( var j : int = 0; j != arr.length - 1; ++ j ) {
                    var happened:Boolean = false;
                    switch ( type_sort ) {
                        case Type:
                            if ( dir == Descending ) {
                                if ( Base_Pokemon(arr[j + 1]).R_Stage() > Base_Pokemon(arr[j]).R_Stage() )
                                    happened = true;
                                else if ( Base_Pokemon(arr[j + 1]).R_Species_ID() > Base_Pokemon(arr[j]).R_Species_ID() )
                                    happened = true;
                            } else {
                                if ( Base_Pokemon(arr[j + 1]).R_Stage() > Base_Pokemon(arr[j]).R_Stage() )
                                    happened = true;
                                else if ( Base_Pokemon(arr[j + 1]).R_Species_ID() < Base_Pokemon(arr[j]).R_Species_ID() )
                                    happened = true;
                            }
                        break;
                        case Name:
                            if ( dir == Descending ) {
                                if ( Base_Pokemon(arr[j + 1]).R_Stage() > Base_Pokemon(arr[j]).R_Stage() )
                                    happened = true;
                                else if ( String_Comp(Base_Pokemon(arr[j + 1]).R_Name(),
                                                      Base_Pokemon(arr[j]).R_Name() ) )
                                    happened = true;
                            } else {
                                if ( Base_Pokemon(arr[j + 1]).R_Name() > Base_Pokemon(arr[j]).R_Name() )
                                    happened = true;
                                else if ( String_Comp_D(Base_Pokemon(arr[j + 1]).R_Name(),
                                                      Base_Pokemon(arr[j]).R_Name() ) )
                                    happened = true;
                            }
                        break;
                        case Level:
                            if ( dir == Descending ) {
                                if ( Base_Pokemon(arr[j + 1]).R_Stage() > Base_Pokemon(arr[j]).R_Stage() )
                                    happened = true;
                                else if ( Base_Pokemon(arr[j + 1]).R_Level() > Base_Pokemon(arr[j]).R_Level() )
                                    happened = true;
                            } else {
                                if ( Base_Pokemon(arr[j + 1]).R_Stage() > Base_Pokemon(arr[j]).R_Stage() )
                                    happened = true;
                                else if ( Base_Pokemon(arr[j + 1]).R_Level() < Base_Pokemon(arr[j]).R_Level() )
                                    happened = true;
                            }
                        break;
                    }
                    if ( happened ) {
                        var temp:Base_Pokemon = arr[j + 1];
                        arr[j + 1] = arr[j];
                        arr[j] = temp;
                        flag = 1;
                    }
                }
            }
            return arr;
        }
        
        
        public static function Sort(type_sort:int = 0) {
            
        }
    }
}