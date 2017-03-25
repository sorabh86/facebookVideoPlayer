package com.apdevblog.ui.video {
	
	import com.apdevblog.events.video.VideoControlsEvent;
	import com.apdevblog.model.vo.VideoMetadataVo;
	import com.apdevblog.ui.video.controls.BtnFullscreen;
	import com.apdevblog.ui.video.controls.BtnPlayPause;
	import com.apdevblog.ui.video.controls.BtnSound;
	import com.apdevblog.ui.video.controls.DurationToolTip;
	import com.apdevblog.ui.video.controls.HDBtnBG;
	import com.apdevblog.ui.video.controls.VideoStatusBar;
	import com.apdevblog.ui.video.controls.VideoTimeLabel;
	import com.apdevblog.ui.video.style.ApdevVideoPlayerDefaultStyle;
	import com.apdevblog.utils.Draw;

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
     *  Dispatched when the user pressed play button.
     *
     *  @eventType com.apdevblog.events.video.VideoControlsEvent
     */
    [Event(name="togglePlayPause", type="com.apdevblog.events.video.VideoControlsEvent")]

	/**
     *  Dispatched when the user pressed fullscreen button.
     *
     *  @eventType com.apdevblog.events.video.VideoControlsEvent
     */
    [Event(name="toggleFullscreen", type="com.apdevblog.events.video.VideoControlsEvent")]
	
	/**
	 * VideoControls for ApdevVideoPlayer.
	 * 
	 * <p>Container with all controls (play/pause, volume, ...) for the 
	 * videoplayer.</p>
	 * 
	 * @playerversion Flash 9
 	 * @langversion 3.0
	 *
	 * @package    com.apdevblog.ui.video
	 * @author     Philipp Kyeck / phil[at]apdevblog.com
	 * @copyright  2009 apdevblog.com
	 * @version    SVN: $Id: ApdevVideoControls.as 8 2009-12-24 11:29:22Z p.kyeck $
	 * 
	 * @see com.apdevblog.ui.video.ApdevVideoPlayer ApdevVideoPlayer
	 */
	public class ApdevVideoControls extends Sprite {
		private var _controlsWidth:int;
		private var _bg:Shape;
		private var _play:BtnPlayPause;
		private var _bar:VideoStatusBar;
		private var _mute:BtnSound;
		private var _fullscreen:BtnFullscreen;
		private var _hd:Sprite;
		
		//private var _time:VideoTimeLabel;
		private var _meta:VideoMetadataVo;
		private var _style:ApdevVideoPlayerDefaultStyle;
		private var _currentLoadingFraction:Number;
		private var _currentPlayingFraction:Number;

		/**
		 * creates a new container for the videoplayer's controls.
		 * @param width		width of the whole container
		 */
		public function ApdevVideoControls(width:int, style:ApdevVideoPlayerDefaultStyle) {
			_init(width, style);
		}
		
		/**
		 * adjusts the controls when the current displaystate changes
		 * (@see flash.display.StageDisplayState StageDisplayState).
		 * 
		 * @param displayState	 stage's displaystate
		 */
		public function updateDisplayState(displayState:String):void {
			_fullscreen.updateState(displayState);
		}
		
		/**
		 * updates the visual loading status.
		 * 
		 * @param fraction		percents of the video that are already loaded 
		 */
		public function updateLoading(fraction:Number):void {
			_currentLoadingFraction = fraction;
			_bar.updateLoading(fraction);
		}
		
		/**
		 * adjusts the controls when the video's playing state changed.
		 * 
		 * @param fraction		percents of the video that are already played
		 */
		public function updatePlaying(fraction:Number):void {
			_currentPlayingFraction = fraction;
			_bar.updatePlaying(fraction);
			
			if(_meta != null) {
				//_time.update(_meta.duration * fraction);
				DurationToolTip.instance.update(_meta.duration * fraction, _meta.duration);
			}
		}
		
		/**
		 * clears all ui elements from stage.
		 */
		private function _clear():void {
			removeChild(_bg);
			removeChild(_play);
			removeChild(_hd);
			//removeChild(_time);
			removeChild(_bar);
			removeChild(_mute);
			removeChild(_fullscreen);
		}
		
		/**
		 * draws the videocontrol's components.
		 */
		protected function _draw():void {
			_bg = new Shape();//Draw.bitmapRoundedRect(width - 40, 50, 10, new MBitmap(1, 1), 1);
			_bg.graphics.beginFill(0, 0);
			_bg.graphics.drawRect(0, 0, width, 90);
			_bg.graphics.beginBitmapFill(new MBitmap(1, 1));
			_bg.graphics.drawRoundRect(20, 20, width - 40, 90 - 40, 8, 8);
			_bg.graphics.endFill();
			addChild(_bg);
			
			var availableWidth:Number = width - _style.controlsPaddingLeft - _style.controlsPaddingRight;
			var curSpaceUsed:Number = 0;
			
			_play = new BtnPlayPause(_style);
			_play.x = 25;//_style.controlsPaddingLeft;
			_play.y = _bg.height / 2 - _play.height/2;
			addChild(_play);
			
			curSpaceUsed += _play.x + _play.width;
			
			_mute = new BtnSound(_style);
			_hd = new HDBtnBG();
			//_time = new VideoTimeLabel(_style);
			_fullscreen = new BtnFullscreen(_style);
			
			curSpaceUsed += _mute.width + _fullscreen.width + _hd.width + 20;// _time.width;
			
			_bar = new VideoStatusBar(availableWidth - (curSpaceUsed + 4 * 3), _style);
			updateLoading(_currentLoadingFraction);
			updatePlaying(_currentPlayingFraction);
			
			//_time.x = width - _style.controlsPaddingRight - _fullscreen.width - _mute.width - 3 - _time.width - 3;
			//_time.y = _bg.height / 2 - _time.height/2;
			
			_mute.x = width - _style.controlsPaddingRight - _fullscreen.width - _hd.width - _mute.width - 20;
			_mute.y = _bg.height / 2 - _mute.height/2;
			
			_hd.x = width - _style.controlsPaddingRight - _fullscreen.width - _hd.width - 20;
			_hd.y = _bg.height / 2 - _hd.height/2;
			
			_fullscreen.x = width - _style.controlsPaddingRight - _fullscreen.width - 20;
			_fullscreen.y = _bg.height / 2 - _fullscreen.height/2;
			
			_bar.x = _play.x + _play.width + 3;
			_bar.y = _bg.height / 2 - _bar.height / 2;
			
			//addChild(_time);
			addChild(_bar);
			addChild(_mute);
			addChild(_hd);
			addChild(_fullscreen);
		}
		
		/**
		 * initializes all important attributes and event listeners.
		 */
		private function _init(width:int, style:ApdevVideoPlayerDefaultStyle):void {
			_controlsWidth = width;
			_style = style;
			
			_currentPlayingFraction = 0;
			_currentLoadingFraction = 0;
			
			_draw();

			addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
		}
		
		/**
		 * event handler - called when user clicks the play/pause btn.
		 */
		private function onClick(event:MouseEvent):void {
			switch(event.target) {
				case _play:
					dispatchEvent(new VideoControlsEvent(VideoControlsEvent.TOGGLE_PLAY_PAUSE, true, true));
				break;
				
				case _fullscreen:
					dispatchEvent(new VideoControlsEvent(VideoControlsEvent.ENTER_FULLSCREEN, true, true));
				break;
			}
		}
		
		/**
		 * videocontrol's current width.
		 */
		override public function get width():Number {
			return _controlsWidth;
		}
		
		override public function set width(width:Number):void {
			_controlsWidth = width;
			
			if(_bg != null) {
				_clear();
				_draw();
			}
		}

		/**
		 * videocontrol's current state (visual representation).
		 */
		public function set state(state:String):void {
			_play.updateState(state);
		}
		
		/**
		 * video's current volume (visual representation).
		 */
		public function set volume(volume:Number):void {
			_mute.updateState(volume);
		}
		
		/**
		 * video's current metadata (visual representation).
		 */
		public function set meta(meta:VideoMetadataVo):void {
			_meta = meta;
			
			_bar.updateMeta(meta);
			//_time.updateMeta(meta);
		}
	}
}
