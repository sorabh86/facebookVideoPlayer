package com.apdevblog.ui.video.controls 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	public class HDBtnBG extends MovieClip 
	{
		private var hdToolTip:MovieClip;
		public function HDBtnBG() {
			addEventListener(MouseEvent.CLICK, onClickOnHdBtn);
		}
		private function onClickOnHdBtn(e:MouseEvent):void {
			if (hdToolTip) {
				removeToolTipHandler(null);
			} else {
				var bound:Rectangle = this.getBounds(main.instance);
				hdToolTip = new HDToolTip();
				main.instance.addChild(hdToolTip);
				hdToolTip.x = bound.x + bound.width / 2 - hdToolTip.width / 2;
				hdToolTip.y = bound.y + 10 - hdToolTip.height;
				hdToolTip.addEventListener(MouseEvent.ROLL_OUT, removeToolTipHandler);
				main.instance.video.controlsAutoHide(false);
			}
		}
		private function removeToolTipHandler(e:MouseEvent):void {
			hdToolTip.parent.removeChild(hdToolTip);
			hdToolTip = null;
			main.instance.video.controlsAutoHide(true);
		}
	}
}