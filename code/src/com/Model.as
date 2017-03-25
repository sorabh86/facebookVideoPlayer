package com {
	import flash.events.EventDispatcher;
	
	public class Model {
		
		private static var _instance:Model;
		
		public static function get instance():Model {
			if(_instance == null)
				_instance = new Model();
			return _instance;
		}
		
		/*********** CONTROLLERS **********/
		public var pm:EventDispatcher = new EventDispatcher();
		
		public var flashvars:Object;
		public var AppID:String;
		public var videoXML:String;
		public var url:String;
		public var dataXML:XML;
		
		public var facebookData:Object;
		public var embeded_key:String;
		
		public var videoIndex:int = 0;
	}
}