package views {
	import com.Model;
	import com.PM;
	import fl.controls.List;
	import fl.data.DataProvider;
	import fl.events.ListEvent;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import views.paymentwin.NormalWindow;
	
	public class VideosWindow extends NormalWindow {
		private var model:Model = Model.instance;
		//elements in flash
		public var title_txt:TextField;
		public var desc_txt:TextField;
		public var duration_txt:TextField;
		public var close_btn:MovieClip;
		public var list_mc:ListContainer;
		public var bg_mc:MovieClip;
		public var subscribe_btn:SimpleButton;
		public var buy_btn:SimpleButton;
		public var puchase_btn:SimpleButton;
		//
		private var _width:Number;
		
		public function VideosWindow() {
			close_btn.buttonMode = true;
			addEventListeners();
			
			list_mc.dataProvider = model.dataXML.videos[0].video;
			duration_txt.text = model.dataXML.videos[0].video.length() + " videos, 4h 42min";
			
			width = main.instance.width;
			height = main.instance.height;
			bg_mc.height = main.instance.height;
			
			main.instance.addEventListener(Event.RESIZE, function():void {
				width = main.instance.width;
				height = main.instance.height;
				bg_mc.height = main.instance.height;
			} );
		}
		public function updateDesc(str:String):void {
			desc_txt.text = str;
		}
		private function addEventListeners():void {
			this.addEventListener(Event.RESIZE, function():void { 
				PM.onResizeHandler() 
			} );
			close_btn.addEventListener(MouseEvent.CLICK, function():void { 
				PM.remove(PM.MOVEMENT_LEFT);
			} );
		}
	}
}