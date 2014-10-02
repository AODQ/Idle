package src {
    public class Move {
        public var Move_ID:int,
                    Move_Stage:int;
        public var Move_Type:int;
        public function Move(id:int = 0, stage:int = 0, type:int = 0) {
            Move_ID = id;
            Move_Stage = stage;
            Move_Type = type
        }
        public function Export_Move():Move_Loader {
            var x:Move_Loader = new Move_Loader();
            x.Move_Type = Move_Type;
            x.Move_Stage = Move_Stage;
            x.Move_ID = Move_ID;
            return x;
        }
    }
}