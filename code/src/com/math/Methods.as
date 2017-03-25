package com.math {
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import mx.core.UIComponent;
	
	public class Methods extends UIComponent {
		
		private static var bytes:ByteArray ;
		public static var localClickPoint:Point = new Point();
		
		public static var method:Methods = new Methods();
		public static function instance():Methods {
			return method;
		}
		
		public static function StringToByteArray(url:String):ByteArray {
			bytes = new ByteArray();
			var req:URLRequest = new URLRequest(url);
			var ldr:Loader = new Loader();
			ldr.load(req);
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, function getByteArr(e:Event):void {
				bytes = (Bitmap(e.currentTarget.content).bitmapData.getPixels(new Rectangle(0,0, e.currentTarget.content.width, e.currentTarget.content.height)));
			});
			return bytes;
		}
		
		public function moveInteraction(p:Point, target:Object):void {
			var currentX:Number = p.x;
			var currentY:Number = p.y;
	   		var diffX:Number = currentX - localClickPoint.x;
	   		var diffY:Number = currentY - localClickPoint.y;
	    
	   		target.x += diffX;
	   		target.y += diffY;
	    
		   localClickPoint.x = currentX;
		   localClickPoint.y = currentY;
		}
		
		public static function convertGrayScale(target:Object):void {
			target.filters = new Array(new ColorMatrixFilter( new Array (	0.212671, 0.71516, 0.072169, 0, 0, 
																			0.212671, 0.71516, 0.072169, 0, 0, 
																			0.212671, 0.71516, 0.072169, 0, 0,
																			0,0,0,1,0	)));
			colorTranformBrown(target);
		}
		
		public static function colorTranformBrown(target:Object):void {
			var col:ColorTransform = new ColorTransform();
			col.redMultiplier = 1.1;
			col.blueMultiplier = 0.4;
			col.greenMultiplier = 1;
			target.transform.colorTransform = col;
		}
	}
}