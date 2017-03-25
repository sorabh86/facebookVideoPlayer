package com.apdevblog.ui.video.controls {
	import com.apdevblog.events.video.VideoControlsEvent;
	import com.apdevblog.ui.video.style.ApdevVideoPlayerDefaultStyle;
	import com.apdevblog.utils.Draw;
	import flash.display.MovieClip;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
     *  Dispatched when the user changes volume of video.
     *
     *  @eventType com.apdevblog.events.video.VideoControlsEvent
     */
    [Event(name="setVolume", type="com.apdevblog.events.video.VideoControlsEvent")]
	
	/**
	 * Button controlling the video's sound.
	 * 
	 * @playerversion Flash 9
 	 * @langversion 3.0
	 *
	 * @package    com.apdevblog.ui.video
	 * @author     Aron Woost / aron[at]apdevblog.com
	 * @copyright  2009 apdevblog.com
	 * @version    SVN: $Id: BtnSound.as 7 2009-10-13 16:46:31Z p.kyeck $
	 * 
	 * @see com.apdevblog.ui.video.ApdevVideoPlayer ApdevVideoPlayer
	 * @see com.apdevblog.ui.video.ApdevVideoControls ApdevVideoControls
	 */
	public class BtnSound extends Sprite {
		private var _bars:Array;
		private var _style:ApdevVideoPlayerDefaultStyle;
		private var _volumeMc:Sprite;
		//
		private var vol:Number = 1;

		/**
		 * creates fullscreen button and initializes it.
		 */
		public function BtnSound(style:ApdevVideoPlayerDefaultStyle) {
			_init(style);
		}
		
		/**
		 * updates volume state (visually).
		 * @param vol	video's current volume
		 */
		public function updateState(vol:Number):void {
			var num:int = Math.ceil(vol * _bars.length-1);
			for(var i:int = 1;i < _bars.length+1; i++) {
				var bar:Object = _bars[i - 1];
				if(bar != null) {
					bar.alpha = (i - 1 > num) ? .25 : 1;
				}
			}			
		}
		
		/**
		 * draws initial button components.
		 */
		private function _draw():void {
			/*var	bg:Shape = Draw.gradientRect(31, 23, 90, _style.btnGradient1, _style.btnGradient2, 1, 1);
			addChild(bg);*/
			if (_volumeMc != null) {
				removeChild(_volumeMc);
				_volumeMc = null;
			}
			_volumeMc = new VolumeBtnBG();
			addChild(_volumeMc);
			_volumeMc.getChildByName('mute_btn').addEventListener(MouseEvent.CLICK, muteClickHandler);
			
			_bars = new Array();
			
			for (var i:int = 0; i < 5; i++) {
				_bars.push(_volumeMc.getChildByName('bar_' + i));
			}
			/*for(var i:Number = 0;i < 8; i++) {
				var bar:Shape = Draw.rect(2, i + 1, _style.btnIcon, 1);
				bar.x = 4 + (i * 3);
				bar.y = 16 - (1 + i);
				addChild(bar);
				
				_bars.push(bar);
			}*/
			
			_volumeMc.getChildByName('trans_bg').addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown1, false, 0, true);
		}
		private function muteClickHandler(e:MouseEvent):void {
			var target:MovieClip = MovieClip(e.currentTarget);
			if (target.currentFrameLabel == '_unmute') {
				target.gotoAndStop('_mute');
				dispatchEvent(new VideoControlsEvent(VideoControlsEvent.SET_VOLUME, true, true, 0));
			} else {
				target.gotoAndStop('_unmute');
				dispatchEvent(new VideoControlsEvent(VideoControlsEvent.SET_VOLUME, true, true, vol));
				updateState(vol);
			}
		}
		
		/**
		 * initializes all important attributes and event listeners.
		 */
		private function _init(style:ApdevVideoPlayerDefaultStyle):void {
			_style = style;
			mouseEnabled = true;
			buttonMode = true;
			
			_draw();
			
			//addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown1, false, 0, true);
		}
		
		/**
		 * calculates the new volume value and fires event.
		 */
		private function _updateVolume():void {
			var mX:int = mouseX;
			
			if(mX < _bars[0].x+_bars[0].width) {
				vol = 0;
			} else if (mX > _bars[_bars.length-1].x) {
				vol = 1;
			} else {
				vol = (mX - _bars[0].x) / (_bars[_bars.length - 1].x);// 23;
			}
			dispatchEvent(new VideoControlsEvent(VideoControlsEvent.SET_VOLUME, true, true, vol));
		}
		
		/**
		 * event handler - called when user drags the mouse.
		 */
		private function onMouseMove1(event:MouseEvent):void {
			_updateVolume();
		}
		
		/**
		 * event handler - called when user presses button.
		 */
		private function onMouseDown1(event:MouseEvent):void {
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp1, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove1, false, 0, true);
		}
		
		/**
		 * event handler - called when user releases button.
		 */
		private function onMouseUp1(event:MouseEvent):void {
			stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp1);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove1);
			
			_updateVolume();
		}
	}
}