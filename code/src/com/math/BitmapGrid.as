package com.math
{
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	
	public class BitmapGrid
	{
		public static function get fourSquare():BitmapData {
			var _bitmapData:BitmapData = new BitmapData(20, 20);
			_bitmapData.fillRect(new Rectangle(0, 0, 10, 10), 0xffcccccc);
			_bitmapData.fillRect(new Rectangle(0, 10, 10, 10), 0xffffffff);
			_bitmapData.fillRect(new Rectangle(10, 10, 10, 10), 0xffcccccc);
			_bitmapData.fillRect(new Rectangle(10, 0, 10, 10), 0xffffffff);
			return _bitmapData;
		}
		public static function get squareInSquare():BitmapData {
			var _bitmapData:BitmapData = new BitmapData(10, 10);
			_bitmapData.fillRect(new Rectangle(0, 0, 10, 10), 0xffeeeeee);
			_bitmapData.fillRect(new Rectangle(1, 1, 9, 9), 0x00ffffff);
			return _bitmapData;
		}
	}
}