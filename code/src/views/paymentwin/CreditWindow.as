package views.paymentwin 
{
	import com.PM;
	import fl.controls.TextInput;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import views.PaymentWindow;
	
	public class CreditWindow extends NormalWindow {
		//elements in flash
		public var title_txt:TextField;
		public var name_txt:TextField;
		public var price_txt:TextField;
		
		public var creditcard_input:TextInput;
		public var exp1_input:TextInput;
		public var exp2_input:TextInput;
		public var cvc_input:TextInput;
		
		public var done_btn:SimpleButton;
		public var pin_btn:SimpleButton;
		public var close_btn:MovieClip;
		//
		
		public function CreditWindow() {
			width = 402.05;
			height = 254.8;
			
			//styling inputs
			var tf:TextFormat = new TextFormat(); 
			tf.color = 0xAAAAAA; 
			tf.font = "Arial"; 
			tf.size = 18; 
			tf.align = "center";
			creditcard_input.setStyle("textFormat", tf);
			exp1_input.setStyle("textFormat", tf);
			exp2_input.setStyle("textFormat", tf);
			cvc_input.setStyle("textFormat", tf);
			//
			
			close_btn.buttonMode = true;
			
			pin_btn.addEventListener(MouseEvent.CLICK, function():void { 
				dispatchEvent(new Event(PaymentWindow.STATE_PIN));
			} );
			close_btn.addEventListener(MouseEvent.CLICK, function():void { PM.remove() } );
		}
		public function set nameText(value:String):void {
			name_txt.text = "Not " + value + "?";
		}
	}
}