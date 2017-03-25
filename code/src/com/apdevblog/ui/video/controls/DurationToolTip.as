package com.apdevblog.ui.video.controls {
	import com.Console;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	
	public class DurationToolTip extends MovieClip {
		//instance
		private static var _instance:DurationToolTip;
		
		//element in flash
		public var txt:TextField;
		//
		public static function get instance():DurationToolTip {
			if (!_instance) {
				_instance = new DurationToolTip();
			}
			return _instance;
		}
		
		public function DurationToolTip() {
			if (_instance) throw new Error('use DurationToolTip.instance to create instance, not allow!');
			txt.selectable = false;
		}
		
		public function update(curTime:Number, totTime:Number):void {
			var curSec:Number = Math.round(curTime % 60);
			var curMin:Number = Math.round((curTime - curSec) / 60);
			var totSec:Number = Math.round(totTime % 60);
			var totMin:Number = Math.round((totTime - totSec) / 60);
			
			txt.text = curMin + ':' + curSec + ' / ' + totMin + ':' + totSec;
		}
		public function updatePosition(target:DisplayObject):void {
			var bound:Rectangle = target.getRect(parent);
			
			this.x = bound.x + bound.height/2 - this.width / 2;
			this.y = bound.y - this.height;
		}
	}
}