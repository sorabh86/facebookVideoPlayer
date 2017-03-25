package views {
	import com.ConnectionManager;
	import com.facebook.graph.Facebook;
	import com.Model;
	import com.PM;
	import com.progress.SpinPreloader;
	import fl.controls.Button;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import views.paymentwin.CreditWindow;
	import views.paymentwin.LoginWindow;
	import views.paymentwin.PinWindow;
	import views.paymentwin.SuccessWindow;

	public class PaymentWindow extends MovieClip {
		public static const STATE_LOGIN:String = "loginState";
		public static const STATE_PIN:String = "PinState";
		public static const STATE_CREDIT:String = "CreditState";
		public static const STATE_SUCCESS:String = "SuccessState";
		
		private var _currentState:String = '';
		public var pName:String = "Jatin Shah";
		private var share2fb:Boolean = false;
		
		//elements in flash
		public var preloader:SpinPreloader;
		public var preloaderBG:MovieClip;
		public var login_window:LoginWindow;
		public var pin_window:PinWindow;
		public var credit_window:CreditWindow;
		public var success_window:SuccessWindow;
		
		/*public var done_btn:Button;
		public var cancel_btn:Button;
		public var close_btn:MovieClip;*/
		
		private var selectedItem:Object;
		private var _pinNo:String;
		
		public function PaymentWindow(currentState:String=STATE_PIN):void {
			hideAllWindows();
			this.currentState = currentState;
			
			showPreloader();
			ConnectionManager.instance.call("getPublicKey", [], onReceivePublickey);
			addEventListeners();
		}
		
		private function showPreloader():void {
			preloaderBG.graphics.clear();
			preloaderBG.graphics.beginFill(0x000000, 0.4);
			var target:Object = currentWindowByState(currentState);
			preloaderBG.graphics.drawRoundRect(0, 0, target.width*target.scaleX, target.height*target.scaleY, 6, 6);
			
			preloaderBG.graphics.endFill();
			preloader.visible = true;
		}
		private function hidePreloader():void {
			preloaderBG.graphics.clear();
			preloader.visible = false;
		}
		
		private function addEventListeners():void {
			addEventListener(Event.RESIZE, function():void { PM.onResizeHandler() } );
			
			login_window.login_btn.addEventListener(MouseEvent.CLICK, function() {
				if (!main.instance._userIsLoggedin)
					main.instance.faceBookLoginFun();
				
				main.instance.addEventListener(main.USER_DATA_RECEIVED, onUserDatatRecievedHandler);
			});
			credit_window.done_btn.addEventListener(MouseEvent.CLICK, requestPinHandler );
			pin_window.done_btn.addEventListener(MouseEvent.CLICK, purchaseVideoByPin );
			
			credit_window.addEventListener(PaymentWindow.STATE_PIN, switchPaymentWindow);
			pin_window.addEventListener(PaymentWindow.STATE_CREDIT, switchPaymentWindow);
		}
		
		private function onUserDatatRecievedHandler(e:Event):void {
			currentState = STATE_CREDIT;
			credit_window.nameText = Model.instance.facebookData.username;
		}
		private function purchaseVideoByPin(ipin:String):void {
			showPreloader();
			var encriptedPin:String = "124830";
			ConnectionManager.instance.call("purchaseVideoByPIN", [encriptedPin], onPurchaseVideoByPinResult);
		}
		private function onPurchaseVideoByPinResult(result:Object):void {
			hidePreloader();
			var xml:XML = XML(result.body);
			if (xml.status == "1") {
				currentState = STATE_SUCCESS;
				success_window.msg_txt.text = "Successfully Purchase this video by pin";
				/*success_window.doneFun = function():void {
					PM.remove();
				}*/
			} else if (xml.status == "0") {
				currentState = STATE_SUCCESS;
				success_window.msg_txt.text = "Please try again, later";
			}
		}
		private function switchPaymentWindow(e:Event):void {
			currentState = e.type;
			//currentWindowByState(e.type).name_txt.text = Model.instance.facebookData.username;
		}
		private function onReceivePublickey(result:Object):void {
			hidePreloader();
			trace('public key:' + result.body);
		}
		
		private function requestPinHandler(e:MouseEvent):void  {
			showPreloader();
			//encript string
			var encriptedString:String = "lasdjfals fadsfk asdkfj lsadj flsajdfl kjasdlfjasdf";
			ConnectionManager.instance.call("purchaseVideo", [encriptedString], onPurchaseVideoResult);
		}
		
		private function onPurchaseVideoResult(result:Object):void {
			hidePreloader();
			var xml:XML = XML(result.body);
			if (xml.status == "1") {
				currentState = STATE_SUCCESS;
				_pinNo = xml.pin;
				success_window.msg_txt.text = "You have purchased Successfully!\n Your PIN for puchase is:" + _pinNo + "\n Note down your PIN Number for continue.";
				success_window.doneFun = function():void {
					currentState = STATE_PIN;
					pin_window.pin = _pinNo;
				}
			} else if (xml.status == "0") {
				currentState = STATE_SUCCESS;
				success_window.msg_txt.text = "User Name:"+Model.instance.facebookData.username+"\nPlease try again, later";
			}
		}
		
		private function shareToFacebook():void {
			// share to face book function
			/*var args:Object = new Object();
			args.link = Model.instance.url;
			args.name = "Video Purchased",				
			args.description = "Purchase video episodes 1-5.";
			args.message = "I purchase video";
			args.caption = "Successfully Purchase Video";
			args.picture = "https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTOCmSkO0-OCIJZ-YP2Kv3HQ6TNzDkvpvRG-CPqb0U-VPMdnw9_";
			Facebook.api('/me/feed', null, args, "POST");*/
		}
		
		public function set currentState(str:String):void {
			if (selectedItem) 
				selectedItem.visible = false;
				
			_currentState = str;
			selectedItem = currentWindowByState(currentState);
			selectedItem.visible = true;
		}
		public function get currentState():String {
			return _currentState;
		}
		
		public function currentWindowByState(state:String):Object {
			switch (state) {
				case STATE_LOGIN:	return login_window;
				case STATE_PIN:		return pin_window;
				case STATE_CREDIT:	return credit_window;
				case STATE_SUCCESS:	return success_window;
			}
			return null;
		}
		
		private function hideAllWindows():void {
			login_window.visible = false;
			pin_window.visible = false;
			credit_window.visible = false;
			success_window.visible = false;
		}
	}
}