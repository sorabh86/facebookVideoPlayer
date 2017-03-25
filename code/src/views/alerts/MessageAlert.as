package views.alerts
{
	import com.PM;
	import fl.controls.Button;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class MessageAlert extends MovieClip {
		public var closeHandler:Function;
		//elements in flash
		public var title_txt:TextField;
		public var msg_txt:TextField;
		public var ok_btn:Button;
		//
		
		public function MessageAlert():void {
			closeHandler = PM.remove;
			addEventListeners();
		}
		
		private function addEventListeners():void {
			ok_btn.addEventListener(MouseEvent.CLICK, function():void { closeHandler() });
		}
	}
	
}