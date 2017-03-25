package com {
	import views.alerts.ConditionalAlert;
	import views.alerts.MessageAlert;
	import views.alerts.WaitAlert;
	
	public class AM {
		
		public static const ERROR:int = 1;
		public static const CONDITION:int = 2;
		public static const WAIT:int = 3;
				
		public static function show(title:String = "", message:String = "", flags:int = 1, yesLabel:String = "Yes",
								noLabel:String = "No", changeHandler:Function = null, closeHandler:Function = null):void {
			
			if(flags == ERROR)
				showMessageAlert(title, message, 'ok');
			if(flags == WAIT)
				showWaitAlert(title,message);
			if(flags == CONDITION)
				showConditionalAlert(title, message, yesLabel, noLabel, changeHandler, closeHandler);
		}
		private static function showWaitAlert(title:String = null, message:String = null):void {
			
			var al:WaitAlert = new WaitAlert();
			PM.add(al);
			
			al.title_txt.text = title;
			al.msg_txt.text = message;
		}
		private static function showConditionalAlert(title:String, message:String, okLabel:String, cancelLabel:String,
													 changeHandler:Function, closeHandler:Function = null):void {
			
			var al:ConditionalAlert = new ConditionalAlert();
			PM.add(al);
			
			al.title_txt.text = title;
			al.msg_txt.text = message;
			al.yes_btn.label = okLabel;
			al.no_btn.label = cancelLabel;

			al.changeHandler = changeHandler;
			al.closeHandler = closeHandler;
		}
		private static function showMessageAlert(title:String, message:String, yesLabel:String):void {
			
			var al:MessageAlert = new MessageAlert();
			PM.add(al);
			
			al.title_txt.text = title;
			al.msg_txt.text = message;
			al.ok_btn.label = yesLabel;
		}
		
		public static function remove():void {
			PM.remove();
		}
	}
}