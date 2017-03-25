package com.math {

	public class ColorUtils {
		// rgb2uint: converts red,green,blue values to a uint 
 		public static function rgb2uint(r:Number, g:Number, b:Number):uint {
			//make sure values are in range
            r = (r < 0) ? 0 : r;
            r = (r > 1) ? 1 : r;
            g = (g < 0) ? 0 : g;
            g = (g > 1) ? 1 : g;
            b = (b < 0) ? 0 : b;
            b = (b > 1) ? 1 : b;
            
            var u:uint = uint((Math.round(r*255))<<16) | uint((Math.round(g*255))<<8) | uint(Math.round(b*255));
			return u;
		}
            
 		// rgb2hsl: converts red,green,blue values to hue,saturation,brightness 
 		public static function rgb2hsl(r:Number, g:Number, b:Number):Array {
            var hue:Number = 0;
            var saturation:Number = 0;
            var brightness:Number = 0;
            
            //make sure values are in range
            r = (r < 0) ? 0 : r;
            r = (r > 1) ? 1 : r;
            g = (g < 0) ? 0 : g;
            g = (g > 1) ? 1 : g;
            b = (b < 0) ? 0 : b;
            b = (b > 1) ? 1 : b;
            
            //set brightness
            var colorMax:Number = (r > g) ? ((b > r) ? b : r) : ((b > g) ? b : g);
            var colorMin:Number = (r < g) ? ((b < r) ? b : r) : ((b < g) ? b : g);
            brightness = colorMax;
            
            //set saturation
            if (colorMax != 0)
                saturation = (colorMax - colorMin)/colorMax;

            //set hue
            if (saturation > 0) {
                var red:Number   = (colorMax - r)/(colorMax - colorMin);
                var green:Number = (colorMax - g)/(colorMax - colorMin);
                var blue:Number  = (colorMax - b)/(colorMax - colorMin);
                if (r == colorMax)
                    hue = blue - green;
                else if (g == colorMax)
                    hue = 2 + red - blue;
                else
                    hue = 4 + green - red;
                    
                hue = hue / 6;
            }
            return [ hue, saturation, brightness ];
        }
 
		// rgb2hex: converts red,green,blue values to hex string
        public static function rgb2hex(r:Number, g:Number, b:Number):String {
			var str:String = "";
            //make sure values are in range
            r = (r < 0) ? 0 : r;
            r = (r > 1) ? 1 : r;
            g = (g < 0) ? 0 : g;
            g = (g > 1) ? 1 : g;
            b = (b < 0) ? 0 : b;
            b = (b > 1) ? 1 : b;
			
			var red:uint = uint( Math.round(r*255) );
			var green:uint = uint( Math.round(g*255) );
			var blue:uint = uint( Math.round(b*255) );
				
			var digits:String = "0123456789ABCDEF";
			
			var lku:Array = new Array(6);
			lku[0] = (red-(red%16))/16;
			lku[1] = red%16;
			lku[2] = (green-(green%16))/16;
			lku[3] = green%16;
			lku[4] = (blue-(blue%16))/16;
			lku[5] = blue%16;
			
			for (var i:String in lku) {
				str += digits.charAt(lku[i]);
			}
			return str;
       	}
       
		// hsl2rgb: converts hue,saturation,brightness values to red,green,blue
        public static function hsl2rgb(h:Number, s:Number, b:Number):Array { 
            //make sure values are in range
            h = (h < 0) ? 0 : h;
            h = (h > 1) ? 1 : h;
            s = (s < 0) ? 0 : s;
            s = (s > 1) ? 1 : s;
            b = (b < 0) ? 0 : b;
            b = (b > 1) ? 1 : b;
            
            var red:Number = 0;
            var green:Number = 0;
            var blue:Number = 0;
            
            if (s == 0) {
                red = b;
                green = red;
                blue = red;
            } else {
                var _h:Number = (h - Math.floor(h)) * 6;
                var _f:Number =  _h - Math.floor(_h);
  
                var _p:Number = b * (1.0 - s);
                var _q:Number = b * (1.0 - s * _f);
                var _t:Number = b * (1.0 - (s * (1 - _f)));
            
                switch(Math.floor(_h))  {
                    case 0: red = b; green = _t; blue = _p;
                    	break;
                    case 1: red = _q; green = b; blue = _p;
                        break;
                    case 2: red = _p; green = b; blue = _t;
                        break;
                    case 3: red = _p; green = _q; blue = b;
                        break;
                    case 4: red = _t; green = _p; blue = b;
                        break;
                    case 5: red = b; green = _p; blue = _q;
                        break;
                }
            }
            return [red,green,blue];
        }
        
  		// hsl2uint: converts hue,saturation,brightness values to uint
 		public static function hsl2uint(h:Number, s:Number, b:Number):uint {
 			var rgb:Array = hsl2rgb(h,s,b);
 			
 			return rgb2uint(rgb[0],rgb[1],rgb[2]);
 		}
 		
  		// hsl2hex: converts hue,saturation,brightness values to hex string
 		public static function hsl2hex(h:Number, s:Number, b:Number):String {
 			var rgb:Array = hsl2rgb(h,s,b);
 			return rgb2hex(rgb[0],rgb[1],rgb[2]);
 		}
 		
		// uint2rgb: converts uint values to red,green,blue
        public static function uint2rgb(value:uint):Array {
			var str:String = "";
			
			//make sure value is in range
			value = (value > 0xFFFFFF) ? 0xFFFFFF : value;
			value = (value < 0x000000) ? 0x000000 : value;		
			
			var red:Number = ((value>>16)&0xFF)/255;
			var green:Number = ((value>>8)&0xFF)/255;
			var blue:Number = ((value)&0xFF)/255;
			
			return [red,green,blue];
       	}
       
   		// uint2hsl: converts uint values to hue,saturation,brightness
 		public static function uint2hsl(value:uint):Array {
  			var rgb:Array = uint2rgb(value);
 			return rgb2hsl(rgb[0],rgb[1],rgb[2]);			
 		}
 		   
		// uint2hex: converts uint values to hex string
 		public static function uint2hex(value:uint):String {
  			var rgb:Array = uint2rgb(value);
 			return rgb2hex(rgb[0],rgb[1],rgb[2]);			
 		}
		
		// hex2uint: converts hex string value to uint
        public static function hex2uint(value:String):uint {
			return uint("0x"+value);
       	}
		
    	// hex2rgb: converts hex string value to red,green,blue
 		public static function hex2rgb(value:String):Array {
			return uint2rgb(hex2uint(value));
       	}
		
    	// hex2hsl: converts hex string value to hue,saturation,brightness
 		public static function hex2hsl(value:String):Array {
			return uint2hsl(hex2uint(value));
       	}
 	}
}