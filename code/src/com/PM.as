package com {
	import caurina.transitions.Tweener;
	import com.event.SSEvent;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.setTimeout;
	
	public class PM {
		public static const MOVEMENT_NONE:String = 'movementnone';
		public static const MOVEMENT_RIGHT:String = 'movementright';
		public static const MOVEMENT_LEFT:String = 'movementleft';
		
		public static var content:DisplayObject;
		private static var time:Number = 0.8;
		private static var transition:String = "easeinoutcirc";
		
		public static function add(item:DisplayObject, movement:String=MOVEMENT_NONE):void {
			if(content) {
				remove();
				setTimeout(function():void {
						content = item;
						main.instance.popUpContainer.addChild(content);
						addEffect(movement);
						Model.instance.pm.dispatchEvent(new SSEvent(SSEvent.POP_ADD));
					}, time * 1000);
			} else {
				content = item;
				main.instance.popUpContainer.addChild(content);
				addEffect(movement);
				Model.instance.pm.dispatchEvent(new SSEvent(SSEvent.POP_ADD));
			}
		}
		
		public static function onResizeHandler(e:Event = null):void {
			if (!content) return;
			content.x = main.instance.width/2-content.width/2;
			content.y = main.instance.height / 2 - content.height / 2;
		}
		
		private static function addEffect(movement:String):void {
			if(!content) return;
			content.alpha = 0;
			content.x = (movement == MOVEMENT_LEFT) ? -content.width :
						(movement == MOVEMENT_RIGHT) ? main.instance.width :
						main.instance.width / 2 - content.width / 2;
						
			content.y = main.instance.height / 2 - content.height / 2;
			Tweener.addTween(content, { x:main.instance.width / 2 - content.width / 2, alpha:1, time:time, transition:transition } );
			Tweener.addTween(main.instance.popUpBG, { alpha:0.4, time:time, transition:transition } );
		}
		
		private static function removeEffect():void {
			main.instance.popUpContainer.removeChild(content);
			content = null;
			Model.instance.pm.dispatchEvent(new SSEvent(SSEvent.POP_REMOVE));
		}
		
		public static function remove(movement:String = MOVEMENT_NONE):void {
			var calX:Number = (movement == MOVEMENT_RIGHT) ? main.instance.width : 
								(movement == MOVEMENT_LEFT) ? 0 - content.width :
								main.instance.width / 2 - content.width / 2;
			Tweener.addTween(content, { x:calX, alpha:0, time:time, transition:transition, onComplete:removeEffect});
			Tweener.addTween(main.instance.popUpBG, {alpha:0, time:time, transition:transition});
		}
	}
}