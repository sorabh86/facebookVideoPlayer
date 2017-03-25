package com.event {
	import flash.events.Event;
	
	public class SSEvent extends Event {
		public static const POP_ADD:String = 'POPADD';
		public static const POP_REMOVE:String = 'POPREMOVE';
		
		public function SSEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event { 
			return new SSEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("SSEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
	}
}