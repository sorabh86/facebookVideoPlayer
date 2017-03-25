package views {
	import caurina.transitions.Tweener;
	import com.Console;
	import com.Model;
	import com.PM;
	import fl.containers.UILoader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class ProItem extends MovieClip {
		//elements in flash
		public var img:UILoader;
		public var title_txt:TextField;
		public var details_txt:TextField;
		public var playing_txt:TextField;
		public var bg_mc:MovieClip;
		public var preloader:MovieClip;
		//
		private var _data:XML;
		private var _selected:Boolean = false;
		
		public function ProItem() {
			this.buttonMode = true;
			this.mouseChildren = false;
			playing_txt.text = "";
			
			img.addEventListener(Event.COMPLETE, onImgLoadComplete);
			addEventListener(MouseEvent.ROLL_OVER, onRollOverHandler);
			addEventListener(MouseEvent.ROLL_OUT, onRollOutHandler);
		}
		
		private function onImgLoadComplete(e:Event):void {
			removeChild(preloader);
			Console.log(parent.getChildIndex(this)+':loaded');
		}
		
		private function onRollOverHandler(e:MouseEvent):void {
			if(!selected)
				Tweener.addTween(bg_mc, {_color:0x202020, time:0.4 } );
		}
		private function onRollOutHandler(e:MouseEvent):void {
			if(!selected)
				Tweener.addTween(bg_mc, {_color:0x000000, time:0.4 } );
		}
		
		public function set data(d:XML):void {
            _data = d;
			img.source = data.thumbnail;
			title_txt.text = data.title;
			details_txt.text = data.info;
        }
        public function get data():XML { return _data; }
		
		public function get selected():Boolean { return _selected; }
		public function set selected(value:Boolean):void {
			_selected = value;
			if (_selected) {
				playing_txt.text = "Now playing";
				Tweener.addTween(bg_mc, {_color:0x242424, time:0.4 } );
			} else {
				playing_txt.text = "";
				Tweener.addTween(bg_mc, {_color:0x000000, time:0.4 } );
			}
		}
	}

}