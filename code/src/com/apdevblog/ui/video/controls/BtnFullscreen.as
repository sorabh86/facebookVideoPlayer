package com.apdevblog.ui.video.controls {
	import com.apdevblog.ui.video.style.ApdevVideoPlayerDefaultStyle;
	import com.apdevblog.utils.Draw;
	import flash.display.MovieClip;

	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;

	/**
	 * Button controlling the video's displaystate.
	 *
	 * @playerversion Flash 9
 	 * @langversion 3.0
	 *
	 * @package    com.apdevblog.ui.video
	 * @author     Aron Woost / aron[at]apdevblog.com
	 * @copyright  2009 apdevblog.com
	 * @version    SVN: $Id: BtnFullscreen.as 2 2009-09-02 11:03:20Z p.kyeck $
	 * 
	 * @see com.apdevblog.ui.video.ApdevVideoPlayer ApdevVideoPlayer
	 * @see com.apdevblog.ui.video.ApdevVideoControls ApdevVideoControls
	 */
	public class BtnFullscreen extends Sprite {
		private var _iconToFullscreen:MovieClip;
		private var _iconToNormal:MovieClip;
		private var _style:ApdevVideoPlayerDefaultStyle;

		/**
		 * creates fullscreen button and initializes it.
		 */
		public function BtnFullscreen(style:ApdevVideoPlayerDefaultStyle) {
			_init(style);
		}
		
		/**
		 * updates stage's displaystate (visually).
		 * 
		 * @param state		the new StageDisplayState
		 */
		public function updateState(state:String):void {
			switch(state) {
				case StageDisplayState.NORMAL:
					_iconToFullscreen.visible = true;
					_iconToNormal.visible = false;
				break;
				
				case StageDisplayState.FULL_SCREEN:
					_iconToFullscreen.visible = false;
					_iconToNormal.visible = true;
				break;
			}
		}		
		
		/**
		 * draws initial button components.
		 */
		private function _draw():void {
			var	bg:Sprite = new FullScreenBtnBG();//Draw.gradientRect(25, 23, 90, _style.btnGradient1, _style.btnGradient2, 1, 1);
			addChild(bg);
			
			// icon 2 fullscreen
			_iconToFullscreen = new FullScreenIconTo();/*new Sprite();
			var g:Graphics = _iconToFullscreen.graphics;
			g.beginFill(_style.btnIcon, 1);
			g.drawRect(2, 2, 3, 1);
			g.drawRect(2, 3, 1, 2);			
			g.drawRect(20, 2, 3, 1);
			g.drawRect(22, 3, 1, 2);
			g.drawRect(2, 18, 1, 3);
			g.drawRect(3, 20, 2, 1);
			g.drawRect(20, 20, 3, 1);
			g.drawRect(22, 18, 1, 2);
			g.drawRect(6, 5, 13, 3);
			g.drawRect(6, 8, 1, 9);
			g.drawRect(18, 8, 1, 9);
			g.drawRect(7, 16, 11, 1);
			g.endFill();*/
			_iconToFullscreen.x = bg.width / 2 - _iconToFullscreen.width / 2;
			_iconToFullscreen.y = bg.height / 2 - _iconToFullscreen.height / 2;
			addChild(_iconToFullscreen);
			
			// icon 2 normal
			_iconToNormal = new FullScreenIconFrom();//new Sprite();
			_iconToNormal.visible = false;
			/*g = _iconToNormal.graphics;
			g.beginFill(_style.btnIcon, 1);
			g.drawRect(6, 10, 3, 1);
			g.drawRect(8, 8, 1, 2);
			g.drawRect(6, 14, 3, 1);
			g.drawRect(8, 15, 1, 2);
			g.drawRect(16, 8, 1, 3);
			g.drawRect(17, 10, 2, 1);
			g.drawRect(16, 14, 3, 1);
			g.drawRect(16, 15, 1, 2);
			g.drawRect(3, 3, 19, 3);
			g.drawRect(3, 6, 1, 14);
			g.drawRect(21, 6, 1, 14);
			g.drawRect(4, 19, 17, 1);
			g.endFill();*/
			_iconToNormal.x = bg.width / 2 - _iconToNormal.width / 2;
			_iconToNormal.y = bg.height / 2 - _iconToNormal.height / 2;
			addChild(_iconToNormal);		
		}
		
		/**
		 * initializes all important attributes and event listeners.
		 */
		private function _init(style:ApdevVideoPlayerDefaultStyle):void {
			_style = style;
			buttonMode = true;
			mouseChildren = false;

			_draw();			
			
			addEventListener(MouseEvent.CLICK, onMouseClick, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
		}
		
		/**
		 * event handler - called when user clicks button.
		 */
		private function onMouseClick(event:MouseEvent):void {	
			_iconToFullscreen.filters = [];
			_iconToNormal.filters = [];
		}

		/**
		 * event handler - called when user rolls over button.
		 */
		private function onMouseOver(event:MouseEvent):void {
			/*var filter:GlowFilter = new GlowFilter();
			filter.color = _style.btnRollOverGlow;
			filter.alpha = _style.btnRollOverGlowAlpha;
			
			_iconToFullscreen.filters = [filter];
			_iconToNormal.filters = [filter];*/
			_iconToFullscreen.gotoAndStop('_over');
			_iconToNormal.gotoAndStop('_over');
		}

		/**
		 * event handler - called when user leaves button with mouse.
		 */
		private function onMouseOut(event:MouseEvent):void {
			/*_iconToFullscreen.filters = [];
			_iconToNormal.filters = [];*/
			_iconToFullscreen.gotoAndStop('_up');
			_iconToNormal.gotoAndStop('_up');
		}
	}
}
