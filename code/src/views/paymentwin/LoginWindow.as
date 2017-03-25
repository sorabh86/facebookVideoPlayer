package views.paymentwin {
	import com.PM;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	public class LoginWindow extends NormalWindow {
		//elements in flash
		public var title_txt:TextField;
		public var login_btn:SimpleButton;
		//public var cancel_btn:Button;
		public var close_btn:MovieClip;
		//
		
		public function LoginWindow() {
			width = 402.05;
			height = 170.1;
			close_btn.buttonMode = true;
			
			close_btn.addEventListener(MouseEvent.CLICK, function():void { 
				PM.remove() 
			} );
			/*cancel_btn.addEventListener(MouseEvent.CLICK, function():void {
				PM.remove() 
			} );*/
		}
	}
}