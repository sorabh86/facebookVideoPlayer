package views.paymentwin {
	import com.PM;
	import fl.controls.CheckBox;
	import fl.controls.TextInput;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class SuccessWindow extends NormalWindow {
		//elements in flash
		public var title_txt:TextField;
		public var msg_txt:TextField;
		public var share_checkbox:CheckBox;
		public var done_btn:SimpleButton;
		public var close_btn:MovieClip;
		
		public var p1_input:TextInput;
		public var p2_input:TextInput;
		public var p3_input:TextInput;
		public var p4_input:TextInput;
		public var p5_input:TextInput;
		public var p6_input:TextInput;
		//
		
		public var doneFun:Function;
		
		public function SuccessWindow() {
			width = 404.05;
			height = 267;
			
			//styling inputs
			var tf:TextFormat = new TextFormat(); 
			tf.color = 0xAAAAAA; 
			tf.font = "Arial"; 
			tf.size = 18; 
			tf.align = "center";
			p1_input.setStyle("textFormat", tf);
			p2_input.setStyle("textFormat", tf);
			p3_input.setStyle("textFormat", tf);
			p4_input.setStyle("textFormat", tf);
			p5_input.setStyle("textFormat", tf);
			p6_input.setStyle("textFormat", tf);
			//
			
			close_btn.buttonMode = true;
			
			doneFun = PM.remove;
			done_btn.addEventListener(MouseEvent.CLICK, doneWindow);
			close_btn.addEventListener(MouseEvent.CLICK, removeWindow);
		}
		private function doneWindow(e:MouseEvent):void {
			if (doneFun != null) {
				doneFun();
				doneFun = PM.remove;
			}
		}
		private function removeWindow(e:MouseEvent):void {
			PM.remove() 
		}
		public function set pin(value:String):void {
			p1_input.text = value.charAt(0);
			p2_input.text = value.charAt(1);
			p3_input.text = value.charAt(2);
			p4_input.text = value.charAt(3);
			p5_input.text = value.charAt(4);
			p6_input.text = value.charAt(5);
		}
	}
}