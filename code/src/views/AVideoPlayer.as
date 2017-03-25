package views {
	import caurina.transitions.Tweener;
	import com.AM;
	import com.apdevblog.ui.video.ApdevVideoState;
	import com.apdevblog.ui.video.controls.DurationToolTip;
	import com.Console;
	import com.PM;
	import com.util.Base64;
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.Model;
	import com.apdevblog.events.video.VideoControlsEvent;
	import com.apdevblog.ui.video.ApdevVideoPlayer;
	import com.MyVideoPlayerStyle;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	public class AVideoPlayer extends MovieClip {
		private var videoBG:MovieClip;
		private var videoplayer:ApdevVideoPlayer;
		private var _durationToolTip:DurationToolTip;
		//
		private var _data:XML;
			
		public function AVideoPlayer():void {
			_durationToolTip = DurationToolTip.instance;
			addChild(_durationToolTip);
			
			videoBG = new MovieClip();
			videoBG.graphics.beginFill(0, 1);
			videoBG.graphics.drawRect(0, 0, this.width, this.height);
			videoBG.graphics.endFill();
			addChild(videoBG);
			
			addEventListener(Event.RESIZE, onResize);
		}
		
		public function load(xml:XML = null):void {
			if (_data == xml) return;
			_data = xml;
			if (videoplayer) Tweener.addTween(videoplayer, { alpha:0, time:0.5, onComplete:function():void {
				videoplayer.clear();
				removeChild(videoplayer);
				
 				configureVideoPlayer(xml);
			}} );
			else configureVideoPlayer(xml);
		}
		private function configureVideoPlayer(xml:XML):void {
			videoplayer = new ApdevVideoPlayer(main.instance.width, main.instance.height, new MyVideoPlayerStyle());
			videoplayer.alpha = 0;
			Tweener.addTween(videoplayer, { alpha:1, time:0.5 } );
			addChild(videoplayer);
			videoplayer.addEventListener(VideoControlsEvent.STATE_UPDATE, onStateUpdate, false, 0, true);
			videoplayer.controlsOverVideo = true;
			videoplayer.controlsAutoHide = false;
			videoplayer.autoPlay = false;
			videoplayer.videostill = Model.instance.url + xml.thumbnail;
			videoplayer.load(Model.instance.url + xml.videoUrl);
		}
		
		public function playVideo():void {
			if (videoplayer) {
				videoplayer.play();
			}
		}
		/*public function load(id:String = "1"):void {
			var values:URLVariables = new URLVariables();
			values.id = id;
			values.pass = 'pass';
			var urlLoader:URLLoader = new URLLoader();
			var urlRequest:URLRequest = new URLRequest(Model.instance.url + "service.php");
			urlRequest.method = URLRequestMethod.POST;
			urlRequest.data = values;
			urlLoader.load(urlRequest);
			urlLoader.addEventListener(Event.COMPLETE, successOnFetchData);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, errorOnFetchData);
		}
		
		private function successOnFetchData(e:Event):void {
			var xml:XML = XML(Base64.decode(e.currentTarget.data));
			videoplayer.videostill = Model.instance.url + xml.img;// "media/basketball.jpg";
			videoplayer.load(Model.instance.url + xml.video);// "media/basketball.f4v");
		}
		
		private function errorOnFetchData(e:IOErrorEvent):void {
			AM.show("Error:", e.toString(), AM.ERROR);
		}*/
		
		private function onResize(event:Event):void {
			videoBG.width = stage.stageWidth;
			videoBG.height = stage.stageHeight;
			if (!videoplayer) return;
			videoplayer.resize(stage.stageWidth, stage.stageHeight);
		}
		private function onStateUpdate(event:VideoControlsEvent):void {
			Console.log("onStateUpdate() >>> " + event.data);
			if (event.data == ApdevVideoState.VIDEO_STATE_STOPPED) {
				PM.add(new ReplayWindow());
			} else if (event.data == ApdevVideoState.VIDEO_STATE_PLAYING) {
				controlsAutoHide(true);
				videoplayer._toggleVideoControls(true);
				setChildIndex(_durationToolTip, numChildren - 1);
			} else if (event.data == ApdevVideoState.VIDEO_STATE_PAUSED ||
						event.data == ApdevVideoState.VIDEO_STATE_STOPPED ||
						event.data == ApdevVideoState.VIDEO_STATE_EMPTY ) {
				controlsAutoHide(false);
				setChildIndex(_durationToolTip, 0);
			}
		}
		public function controlsAutoHide(bool:Boolean):void {
			videoplayer.controlsAutoHide = bool;
		}
	}
}