package com {
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.NetConnection;
	import flash.net.registerClassAlias;
	import flash.net.Responder;
	import mx.messaging.messages.AcknowledgeMessage;
	import mx.messaging.messages.ErrorMessage;
	import mx.messaging.messages.RemotingMessage;
	
	registerClassAlias("flex.messaging.messages.RemotingMessage", RemotingMessage);
	registerClassAlias("flex.messaging.messages.AcknowledgeMessage", AcknowledgeMessage);
	registerClassAlias("flex.messaging.messages.ErrorMessage", ErrorMessage);
	
	public class ConnectionManager {
		private static var _instance:ConnectionManager;
		public static function get instance():ConnectionManager {
			if (!_instance)
				_instance = new ConnectionManager();
			
			return _instance;
		}
		
		private var url:String = "http://localhost:8080/AdwordVideoPlayer/messagebroker/amf";
								//	"http://54.243.141.198:8080/AdwordVideoPlayer/messagebroker/amf";
		private var netConnection:NetConnection;
		private var destination:String = "videoService";
		
		public function ConnectionManager() {
			if (_instance)
				throw new Error('ConnectionMananer is a singleton class');
			
			netConnection = new NetConnection();
			netConnection.connect(url);
			activateNCListener(netConnection);
		}
		public function call(operation:String, sendObject:Object, onResult:Function):void {
			var remotingMsg:RemotingMessage = new RemotingMessage();
			remotingMsg.operation = operation;
			remotingMsg.body = sendObject;
			remotingMsg.destination = destination;
			remotingMsg.headers = {DSEndpoint: "java-amf"};
			
			var respnd:Responder = new Responder(onResult, onFault);
			netConnection.call(null, respnd, remotingMsg);
		}
		
		public function onFault(e:ErrorMessage):void {
			trace("RPC Fail:" + e.faultString);
			AM.show("Connection Failed", "Unable To Connect server", AM.ERROR);
		}
		
		private function activateNCListener(netConnection:EventDispatcher):void {
			netConnection.addEventListener(NetStatusEvent.NET_STATUS, onStatusFetchHandler);
			/*netConnection.addEventListener(Event.ACTIVATE, onActivateHandler);
			netConnection.addEventListener(Event.DEACTIVATE, onDeactivateHandler);
			netConnection.addEventListener(AsyncErrorEvent.ASYNC_ERROR, onASyncErrorHandler);*/
			netConnection.addEventListener(IOErrorEvent.IO_ERROR, onIoErrorHandler);
			/*netConnection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityErrorHandler);*/
		}
		private function onSecurityErrorHandler(e:SecurityErrorEvent):void {
			Console.log('securityerror:' + e);
		}
		private function onIoErrorHandler(e:IOErrorEvent):void {
			AM.show('ERROR', 'Unable to connect to server. Please Refresh the page', AM.ERROR);
			Console.log('ioerror:' + e);
		}
		private function onASyncErrorHandler(e:AsyncErrorEvent):void {
			Console.log('asyncerror:' + e);
		}
		private function onDeactivateHandler(e:Event):void {
			Console.log('deactivate:' + e);
		}
		private function onActivateHandler(e:Event):void {
			Console.log('activate:' + e);
		}
		private function onStatusFetchHandler(e:NetStatusEvent):void {
			AM.show('ERROR', 'Unable to connect to server. Please Refresh the page', AM.ERROR);
			Console.log('netstatus:'+e.info + " : " + e);
		}
	}
}