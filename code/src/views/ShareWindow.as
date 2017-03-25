package views {
	import com.PM;
	import fl.controls.TextArea;
	import fl.controls.TextInput;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.System;
	import flash.text.TextFormat;

	public class ShareWindow extends MovieClip {
		//elements in flash
		public var fb_share_btn:SimpleButton;
		public var tweet_share_btn:SimpleButton;
		public var url_input:TextInput;
		public var cpy_url_btn:SimpleButton;
		public var email_btn:SimpleButton;
		public var embed_input:TextArea;
		public var cpy_embed_btn:SimpleButton;
		//
		
		public function ShareWindow():void {
			
			//styling inputs
			var tf:TextFormat = new TextFormat(); 
			tf.color = 0xAAAAAA; 
			tf.font = "Arial"; 
			tf.size = 16; 
			tf.align = "left";
			url_input.setStyle("textFormat", tf);
			embed_input.setStyle("textFormat", tf);
			//
			cpy_url_btn.addEventListener(MouseEvent.CLICK, function() {
				System.setClipboard(url_input.text);
			});
			cpy_embed_btn.addEventListener(MouseEvent.CLICK, function() {
				System.setClipboard(embed_input.text);
			});
			
			this.addEventListener(Event.RESIZE, function():void { 
				PM.onResizeHandler() 
			} );
			close_btn.addEventListener(MouseEvent.CLICK, function():void { 
				PM.remove();
			} );
		}
	}
}