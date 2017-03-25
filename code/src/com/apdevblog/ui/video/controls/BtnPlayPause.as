package com.apdevblog.ui.video.controls {
	import com.apdevblog.ui.video.style.ApdevVideoPlayerDefaultStyle;
	import com.apdevblog.ui.video.ApdevVideoState;
	import com.apdevblog.utils.Draw;
	import flash.display.MovieClip;

	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;

	public class BtnPlayPause extends Sprite {
		private var _play:MovieClip;
		private var _pause:MovieClip;
		private var _state:String;
		private var _style:ApdevVideoPlayerDefaultStyle;

		/**
		 * creates play/pause button and initializes it.
		 */
		public function BtnPlayPause(style:ApdevVideoPlayerDefaultStyle) {
			_init(style);
		}
		
		/**
		 * updates video's playback state (visually).
		 * 
		 * @param state		the new ApdevVideoState
		 */
		public function updateState(state:String):void {
			visible = true;
			_state = state;
			
			switch(state) {
				case ApdevVideoState.VIDEO_STATE_PLAYING:
					_play.visible = false;
					_pause.visible = true;
				break;
				
				case ApdevVideoState.VIDEO_STATE_PAUSED:
				case ApdevVideoState.VIDEO_STATE_STOPPED:
					_play.visible = true;
					_pause.visible = false;
				break;
			}
		}

		private function _draw():void {
			var	bg:Sprite = new PlayBtnBG();//Draw.gradientRect(23, 23, 90, _style.btnGradient1, _style.btnGradient2, 1, 1);
			addChild(bg);
			var g:Graphics;
			
			// play icon
			_play = new PlayIcon();/*new Sprite();
			g = _play.graphics;
			g.beginFill(_style.btnIcon, 1);
			g.drawRect(9, 5, 1, 1);
			g.drawRect(9, 6, 2, 1);
			g.drawRect(9, 7, 3, 1);
			g.drawRect(9, 8, 4, 1);
			g.drawRect(9, 9, 5, 1);
			g.drawRect(9, 10, 6, 1);
			g.drawRect(9, 11, 7, 1);
			g.drawRect(9, 12, 6, 1);
			g.drawRect(9, 13, 5, 1);
			g.drawRect(9, 14, 4, 1);
			g.drawRect(9, 15, 3, 1);
			g.drawRect(9, 16, 2, 1);
			g.drawRect(9, 17, 1, 1);
			g.endFill();*/
			_play.x = bg.width / 2 - _play.width / 2;
			_play.y = bg.height / 2 - _play.height / 2;
			addChild(_play);
			
			// pause icon
			_pause = new PauseIcon();//new Sprite();
			_pause.visible = false;
			/*g = _pause.graphics;
			g.beginFill(_style.btnIcon, 1);
			g.drawRect(7, 5, 3, 12);
			g.drawRect(13, 5, 3, 12);
			g.endFill();*/
			_pause.x = (bg.width / 2 - _pause.width / 2) - 4;
			_pause.y = bg.height / 2 - _pause.height / 2;
			addChild(_pause);
		}

		private function _init(style:ApdevVideoPlayerDefaultStyle):void {
			_style = style;
			buttonMode = true;
			mouseChildren = false;
			
			_draw();
			
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
			
			_state = ApdevVideoState.VIDEO_STATE_PAUSED;
		}

		private function onMouseOver(event:MouseEvent):void {
			/*var filter:GlowFilter = new GlowFilter();
			filter.color = _style.btnRollOverGlow;
			filter.alpha = _style.btnRollOverGlowAlpha;
			
			_pause.filters = [filter];
			_play.filters = [filter];*/
			_pause.gotoAndStop('_over');
			_play.gotoAndStop('_over');
		}

		private function onMouseOut(event:MouseEvent):void {
			/*_pause.filters = [];
			_play.filters = [];*/
			_pause.gotoAndStop('_up');
			_play.gotoAndStop('_up');
		}		
	}
}
