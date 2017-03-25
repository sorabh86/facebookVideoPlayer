package views.alerts
{
	import com.PM;
	import fl.controls.Button;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	
	public class ConditionalAlert extends MovieClip {
		public var changeHandler:Function;
		public var closeHandler:Function;
		//elements in flash
		public var title_txt:TextField;
		public var msg_txt:TextField;
		public var yes_btn:Button;
		public var no_btn:Button;
		//
		public function ConditionalAlert():void {
			closeHandler = PM.remove;
			addEventListeners();
		}
		
		private function addEventListeners():void {
			yes_btn.addEventListener(KeyboardEvent.KEY_UP, onOkKeyDown);
			no_btn.addEventListener(KeyboardEvent.KEY_UP, onCancelKeyDown);
		}
		private function onOkKeyDown(evt:KeyboardEvent):void {
			if(evt.charCode == 13) {
				changeHandler();
			}
		}
		private function onCancelKeyDown(evt:KeyboardEvent):void {
			if(evt.charCode == 13) {
				close();
			}
		}
		private function close():void {
			if(closeHandler != null) {
				closeHandler();
			} else {
				PM.remove();
			}
		}
	}
}