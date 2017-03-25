package views
{
	import com.progress.SpinPreloader;
	import fl.containers.UILoader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class FBUserDetailWindow extends MovieClip
	{
		private var states:Array = ["Picture", "Detail"];
		
		private var _currentState:String = 'Picture';
		private var _me:Object;
		
		public var preloader:SpinPreloader;
		public var meImage:UILoader;
		public var meFirstname:TextField;
		public var meLastname:TextField;
		public var meUrl:TextField;
		public var meGender:TextField;
		
		public function FBUserDetailWindow():void {
			stop();
			addEventListenerListeners();
		}
		
		private function addEventListenerListeners():void {
			//addEventListener(MouseEvent.CLICK, changeState);
			meImage.addEventListener(Event.COMPLETE, meImage_completeHandler);
		}
		
		public function set currentState(str:String):void {
			_currentState = str;
			gotoAndStop(_currentState);
		}
		public function get currentState():String {
			return _currentState;
		}
		
		public function set me(obj:Object):void {
			_me = obj;
			updateDisplays();
		}
		public function get me():Object {
			return _me;
		}
		
		public function updateDisplays():void {
			if(!_me) return;
			
			meFirstname.text = "Firstname: "+_me.first_name;
			meLastname.text = "Lastname: "+_me.last_name;
			meGender.text = "Gender: "+_me.gender;
			meUrl.text = "Link: "+_me.link;
			
			meImage.source = (currentState == "Detail")?
				"http://graph.facebook.com/" + _me.id + "/picture?type=large":
				"http://graph.facebook.com/" + _me.id + "/picture?type=small";
			
			preloader.visible = true;
		}
		
		protected function changeState(event:MouseEvent):void {
			this.currentState = currentState == "Detail"?"Picture":"Detail";
			updateDisplays();
		}
		
		protected function meImage_completeHandler(event:Event):void {
			trace('image loaded');
			preloader.visible = false;
		}
	}
}