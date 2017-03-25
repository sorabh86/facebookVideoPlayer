package com.connections {
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class IC {
		private static var _instance:IC;
		public static function get instance():IC {
			if (!_instance)
				_instance = new IC();
			return _instance;
		}
		
		private var pingURL:String = "http://www.facebook.com/";
		private var loader:URLLoader;
		private var request:URLRequest;
		
		public function IC() {
			
        }
		
		public function check(callback:Function=null):void {
			loader = new URLLoader();
            request = new URLRequest(pingURL);
            loader.load(request);
			
            loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, callback);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIoErrorHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler);
		}
		
		private function onSecurityErrorHandler(e:SecurityErrorEvent):void {
			trace('security:' + e);
		}
		private function onIoErrorHandler(e:IOErrorEvent):void {
			trace('ioerror:' + e);
		}
		private function httpStatusHandler(event:HTTPStatusEvent):void {
            trace("httpStatusHandler: " + event);
            trace("status: " + event.status);
        }
	}
}