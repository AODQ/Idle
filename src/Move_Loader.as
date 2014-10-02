package src {
    public class Move_Loader {
        public var Move_ID:int,
                   Move_Stage:int;
        public var Move_Type:int;
        public function Move_Loader() {
            
        }
        public function New():Move {
            var x:Move;
            x.Move_ID = Move_ID;
            x.Move_Stage = Move_Stage;
            x.Move_Type = Move_Type;
            return x;
        }
    }
}