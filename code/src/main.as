package  {
	
	import caurina.transitions.properties.ColorShortcuts;
	import com.AM;
	import com.connections.IC;
	import com.Console;
	import com.facebook.graph.Facebook;
	import com.Model;
	import com.PM;
	import fl.controls.Button;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.Security;
	import com.event.SSEvent;
	import com.ConnectionManager;
	import views.AVideoPlayer;
	import views.FBUserDetailWindow;
	import views.PaymentWindow;
	import views.ShareWindow;
	import views.VideosWindow;
	
	/**
	 * ...
	 * @author 
	 */
	public class main extends MovieClip {
		//constants
		public static const USER_DATA_RECEIVED:String = "userdatareceived";
		public static var instance:main;
		
		/********************** Elements in flash Designs ************************/
		public var video:AVideoPlayer;
		public var buy_btn:MovieClip;
		public var share_btn:SimpleButton;
		//public var login_btn:MovieClip;
		public var fb_user_detail_window:FBUserDetailWindow;
		public var revealVideoBtn:SimpleButton;
		public var popUpBG:MovieClip;
		public var popUpContainer:MovieClip;
		//
		
		private var _permissions : Object = { perms:"publish_stream, read_stream" };
		public var _userIsLoggedin : Boolean = false;
		
		public var model:Model = Model.instance;
		private var _swidth:Number;
		private var _sheight:Number;
		
		/**connection manager**/
		public var cm:ConnectionManager = ConnectionManager.instance;
		
		public function main() {
			instance = this;
			ColorShortcuts.init();
			
			if(Security.sandboxType == Security.LOCAL_TRUSTED) {
				model.AppID = "187922698009730"
				//model.videoXML = "xml/videos.xml";
				model.url = "http://localhost/VideoPlayer/Adword_FB_vidoplayer/bin/";
				model.embeded_key = "0xfffff";
			} else {
				model.flashvars = stage.loaderInfo.parameters;
				
				model.embeded_key = model.flashvars.embeded_key;
				model.AppID = "187922698009730";
							//	"525003704178500";
								// model.flashvars.AppID;
				//model.videoXML = model.flashvars.videoXML;
				model.url = "http://localhost/VideoPlayer/Adword_FB_vidoplayer/bin/";
							//"http://54.243.141.198:8080/AdwordVideoPlayer/client/";
							// model.flashvars.url;
			}
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void  {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			this.width = stage.stageWidth;
			this.height = stage.stageHeight;
			
			//login_btn.stop();
			//login_btn.buttonMode = true;
			Console.log('__________main___________' + width + 'x' + height);
			
			addEventListeners();
			drawPopUpBG(false);
			
			AM.show('Connecting', "Please Wait...", AM.WAIT);
			//IC.instance.check(onConnectionStablish);
			initializeFBApi();
			//loadDataXML(model.url + model.videoXML);
			onResizeStageHandler(null);
		}
		
		public function onConnectionStablish(result:Object):void {
			Console.log(result);
		}
		
		/*public function loadDataXML(url:String):void {
			AM.show('Data Loading', "Please Wait", AM.WAIT);
			var req:URLRequest = new URLRequest();
			req.method = "POST";
			req.url = url;
			
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.load(req);
			loader.addEventListener(Event.COMPLETE, loadVideoXML_result);
			loader.addEventListener(IOErrorEvent.IO_ERROR, loadVideoXML_fault);
		}
		
		private function loadVideoXML_result(e:Event):void {
			AM.remove();
			model.dataXML = new XML(e.currentTarget.data);
			
			initializeFBApi();
			video.load();
		}
		
		private function loadVideoXML_fault(e:IOErrorEvent):void {
			AM.show("ERROR:", e.toString(), AM.ERROR);
		}*/
		
		private function addEventListeners():void {
			buy_btn.addEventListener(MouseEvent.CLICK, showBuyWindow);
			//login_btn.addEventListener(MouseEvent.CLICK, function() { faceBookLoginFun() } );
			share_btn.addEventListener(MouseEvent.CLICK, showShareWindow);
			revealVideoBtn.addEventListener(MouseEvent.CLICK, video_clickHandler);
			
			stage.addEventListener(Event.RESIZE, onResizeStageHandler);
			model.pm.addEventListener(SSEvent.POP_ADD, function():void { popUpBG.visible = true; } );
			model.pm.addEventListener(SSEvent.POP_REMOVE, function():void { popUpBG.visible = false; } );
		}
		
		private function drawPopUpBG(isShow:Boolean):void {
			popUpContainer.mouseEnabled = false;
			popUpContainer.graphics.clear();
			popUpContainer.graphics.beginFill(0xffffff, 0);
			popUpContainer.graphics.drawRect(0, 0, this.width, this.height);
			popUpContainer.graphics.endFill();
			
			popUpBG.graphics.clear();
			popUpBG.graphics.beginFill(0xffffff, 0.6);
			popUpBG.graphics.drawRect(0, 0, this.width, this.height);
			popUpBG.graphics.endFill();
			
			popUpBG.visible = isShow;
		}
		
		private function onResizeStageHandler(e:Event):void {
			width = stage.stageWidth;
			height = stage.stageHeight;
			
			video.dispatchEvent(new Event(Event.RESIZE));
			dispatchEvent(new Event(Event.RESIZE));
			//revealVideoBtn.x = revealVideoBtn.y = 5;
			
			buy_btn.x = this.width - buy_btn.width;
			//buy_btn.y = 5;
			
			//share_btn.x = this.width - buy_btn.width - 5;
			//share_btn.y = 5 + buy_btn.height + 5;
			
			//login_btn.x = this.width - login_btn.width - 5;
			//login_btn.y = this.height - 60;
			
			//fb_user_detail_window.x = this.width - 68;
			//fb_user_detail_window.y = this.height - login_btn.height - 100;
			
			PM.onResizeHandler();
			drawPopUpBG(popUpBG.visible);
		}
		
		private function initializeFBApi():void {
			fb_user_detail_window.visible = _userIsLoggedin;
			Facebook.init(model.AppID, onInit);
		}
		
		private function onInit(result:Object, fail:Object):void {
			Console.log('fb init:'+result, "fb fail:"+fail);
			if (result) {
				_userIsLoggedin = true;
			} else {
				_userIsLoggedin = false;
				cm.call("getDefaultData", [model.embeded_key], onGetDataResult);
			}
			updateLogginStatus();
		}
		
		private function updateLogginStatus():void {
			//login_btn.txt.text = (_userIsLoggedin)?"Logout":"Login";
			fb_user_detail_window.visible = _userIsLoggedin;
			
			if (_userIsLoggedin)
				Facebook.api('/me', request4UserDetails);//get user details
		}
		
		private function request4UserDetails(result:Object, fail:Object):void {
			if(fb_user_detail_window.me != result) {
				fb_user_detail_window.me = result;
				model.facebookData = result;
				cm.call("getData", [model.facebookData.username, model.embeded_key], onGetDataResult );
				dispatchEvent(new Event(USER_DATA_RECEIVED));
			} else {
				AM.show("Connection Problem", "Please Check your net connection, then press [ok]",
							AM.ERROR, "Yes", "No", function() {
					cm.call("getData", [model.facebookData.username, model.embeded_key], onGetDataResult );
				});
			}
		}
		
		private function onGetDataResult(result:Object):void {
			if(PM.content && !PM.content.hasOwnProperty('currentState'))
				AM.remove();
			model.dataXML = new XML(result.body);
			video.load(model.dataXML.videos.video[model.videoIndex]);
			
			if (model.dataXML.status == "1") {
				buy_btn.visible = false;
			} else if (model.dataXML.status == "0") {
				buy_btn.visible = true;
			}
		}
		public function faceBookLoginFun():void {
			if(!_userIsLoggedin)
				Facebook.login(handleLoginResponse, _permissions);
			else
				Facebook.logout(handleLogoutResponse);
		}
		
		private function handleLoginResponse(result:Object, fail:Object):void { 
			if (result) 
				_userIsLoggedin = true;
			else 
				_userIsLoggedin = false;
			
			updateLogginStatus();
		}
		
		private function handleLogoutResponse(result:Object):void { 
			_userIsLoggedin = false;
			updateLogginStatus();
			
			cm.call("getDefaultData", [model.embeded_key], onGetDataResult);
		}
		
		protected function video_clickHandler(event:MouseEvent):void {
			if(model.dataXML) {
				var videoWindow:VideosWindow = new VideosWindow();
				PM.add(videoWindow, PM.MOVEMENT_LEFT);
			} else {
				AM.show("Please Login", "You have to login before continue", AM.ERROR);
			}
		}
		
		protected function showBuyWindow(event:MouseEvent):void {
			if (_userIsLoggedin) {
				cm.call("buyData", [model.facebookData.username, model.embeded_key], buyDataResult);
			} else {
				var paymentWindow:PaymentWindow = new PaymentWindow(PaymentWindow.STATE_LOGIN);
				PM.add(paymentWindow);
				//AM.show("Please Login", "Login or register with facebook account", AM.ERROR);
			}
		}
		
		private function buyDataResult(result:Object):void {
			var xml:XML = XML(result.body);
			if (xml.purchased == "1") {
				AM.show("Notification", "You already purchased this video", AM.ERROR);
			} else if (xml.purchased == "0") {
				var paymentWindow:PaymentWindow = new PaymentWindow(PaymentWindow.STATE_CREDIT);
				PM.add(paymentWindow);
			}
		}
		
		protected function showShareWindow(e:MouseEvent):void {
			cm.call("getShareDetails", [model.embeded_key], onShareWindowResult);
		}
		
		public function onShareWindowResult(result:Object):void {
			var shareWindow:ShareWindow = new ShareWindow();
			PM.add(shareWindow);
		}
		
		/****************************** SETTERS AND GETTERS ***********************************/
		public override function set width(value:Number):void {
			_swidth = value;
		}
		public override function get width():Number {
			return _swidth;
		}
		
		public override function set height(value:Number):void {
			_sheight = value;
		}
		public override function get height():Number {
			return _sheight;
		}
	}
}
