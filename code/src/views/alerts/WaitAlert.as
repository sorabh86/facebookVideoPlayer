package views.alerts
{
	import com.progress.ProgressBar;
	import flash.display.MovieClip;
	import flash.text.TextField;
	
	public class WaitAlert extends MovieClip {
		public var title_txt:TextField;
		public var msg_txt:TextField;
		public var progressBar:ProgressBar;
		
		public function WaitAlert():void {
			createChildren();
		}
		
		private function createChildren():void {
			
		}
	}
}