package views {
	import caurina.transitions.Tweener;
	import com.PM;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	
	public class ReplayWindow extends MovieClip {
		//elements in flash
		public var replay_btn:SimpleButton;
		public var buy_btn:SimpleButton;
		//
		
		public function ReplayWindow(/*parent:DisplayObjectContainer*/):void {
			/*parent.addChild(this);
			this.alpha = 0;
			this.x = parent.width / 2 - this.width / 2;
			this.y = parent.width / 2 - this.height / 2;
			Tweener.addTween(this, { alpha:1, time:0.5 } );*/
			
			replay_btn.addEventListener(MouseEvent.CLICK, function():void {
				PM.remove();
				main.instance.video.playVideo();
			});
			buy_btn.addEventListener(MouseEvent.CLICK, function():void {
				PM.remove();
			});
		}
		/*public function removeIt():void {
			Tweener.addTween(this, { alpha:0, time:0.5, onComplete:function():void {
				this.parent.removeChild(this);
			}} );
		}*/
	}
}