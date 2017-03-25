package views {
	import com.Console;
	import com.Model;
	import com.PM;
	import com.scrollbar.ScrollBar;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ListContainer extends MovieClip {
		//constants
		public static const UPDATE:String = "update";
		//elements in flash
		public var mask_mc:MovieClip;
		public var container_mc:MovieClip;
		public var scroll_bar:ScrollBar;
		//
		public var selectedItem:Object;
		
		//constructor
		public function ListContainer() {
			container_mc.mask = mask_mc;
			scroll_bar.target = this;
		}
		
		public function set dataProvider(xml:XMLList):void {
			for (var i:int = 0; i < xml.length(); i++) {
				var item:ProItem = new ProItem();
				container_mc.addChild(item);
				item.data = xml[i];
				item.y = item.height * i;
				item.addEventListener(MouseEvent.CLICK, onClickHandler);
				if (i == Model.instance.videoIndex) {
					selectedItem = item;
					selectedItem.selected = true;
					//update description on parent container
					VideosWindow(parent).updateDesc(selectedItem.data.desc);
				}
			}
			scroll_bar.updateThumb();
		}
		private function onClickHandler(e:MouseEvent):void {
			if (selectedItem) {
				selectedItem.selected = false;
				selectedItem = null;
			}
			selectedItem = e.currentTarget;
			selectedItem.selected = true;
			//save index for reselect
			Model.instance.videoIndex = selectedItem.parent.getChildIndex(selectedItem) - 1;
			Console.log(Model.instance.videoIndex);
			//update description on parent container
			VideosWindow(parent).updateDesc(selectedItem.data.desc);
			main.instance.video.load(selectedItem.data);
			//PM.remove(PM.MOVEMENT_LEFT);
		}
		public function get dataProvider():XMLList {
			var xml:XMLList = new XMLList();
			var i:int = -1; while (++i < container_mc.numChildren) {
				var item:ProItem = container_mc.getChildAt(i) as ProItem;
				xml[i] = (item.data);
			}
			return xml;
		}
		public function addItem(xml:XML):void {
			var item:ProItem = new ProItem();
			container_mc.addChild(item);
			item.data = xml;
			item.y = item.height * (container_mc.numChildren - 1);
			scroll_bar.updateThumb();
		}
		public function updateIndex(index:int):void {
			while (index < container_mc.numChildren) {
				var item:ProItem = container_mc.getChildAt(index) as ProItem;
				item.y = item.height * index;
				index++;
			}
			scroll_bar.updateThumb();
		}
	}
}