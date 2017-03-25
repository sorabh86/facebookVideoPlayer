package views.paymentwin {
	
	import com.PM;
	import fl.controls.TextInput;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import views.PaymentWindow;
	
	public class PinWindow extends NormalWindow {
		//element in flash
		public var title_txt:TextField;
		
		public var p1_input:TextInput;
		public var p2_input:TextInput;
		public var p3_input:TextInput;
		public var p4_input:TextInput;
		public var p5_input:TextInput;
		public var p6_input:TextInput;
		
		public var done_btn:SimpleButton;
		public var credit_btn:SimpleButton;
		public var close_btn:MovieClip;
		//
		
		public function PinWindow() {
			width = 402.05;
			height = 254.8;
			
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
			
			credit_btn.addEventListener(MouseEvent.CLICK, function():void {
				dispatchEvent(new Event(PaymentWindow.STATE_CREDIT));
			} );
			close_btn.addEventListener(MouseEvent.CLICK, function():void {
				PM.remove() 
			} );
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