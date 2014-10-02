package src {
    public class Item_Loader {
        public var  item_type:int,
                     item_stage:int,
                     item_count:int;
        public function Item_Loader() {
            
        }
        public function New():Item {
            return new Item(item_type, item_stage);
        }
    }
}