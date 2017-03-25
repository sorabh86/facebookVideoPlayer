package views.paymentwin {
	import flash.display.MovieClip;
	
	public class NormalWindow extends MovieClip {
		private var _width:Number = 0;
		private var _height:Number = 0;
		
		public function NormalWindow() {
			
		}
		
		override public function get width():Number { return _width; }
		override public function set width(value:Number):void { _width = value; }
		
		override public function get height():Number { return _height; }
		override public function set height(value:Number):void { _height = value; }
	}
}