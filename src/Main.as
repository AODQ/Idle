package src {
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import src.Screen
    import flash.events.Event;
    import flash.display.Sprite;
    
    [SWF(width = "1025", height = "635", backgroundColor = "#FFFF0F", frameRate = "60")]
    public class Main extends Sprite {

        private var game_screen:Screen;
		public function Main() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
            return;
		}

		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
            var x:TextField = new TextField();
            x.text = "BHAHAH";
            addChild(x);
			game_screen = new Screen();
            Area.Set_Up_Area();
		}

	}
}