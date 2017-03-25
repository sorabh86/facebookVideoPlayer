package com.math {
	
	public class Material {
		
		public static function uintToRGB(i:uint):Array {
			var red:Number = uint('0x'+ i.toString(16).slice(0,2))/255;
			var green:Number = uint('0x'+ i.toString(16).slice(2,4))/255;
			var blue:Number = uint('0x'+ i.toString(16).slice(4,6))/255;
			
			return new Array(red, green, blue);
		}
		
		public static function material(arr:Array):ColorMatrixFilter {
			var matrix:Array = [arr[0], 0, 0, 0, 0,
								  0, arr[1], 0, 0, 0,
								  0, 0, arr[2], 0, 0,
								  0, 0, 0, 1, 0 ];
			return new ColorMatrixFilter(matrix);
		}
	}
}