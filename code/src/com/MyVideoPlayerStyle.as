package com {
	import com.apdevblog.ui.video.style.ApdevVideoPlayerDefaultStyle;
	import com.apdevblog.utils.StringUtils;
	
	public class MyVideoPlayerStyle extends ApdevVideoPlayerDefaultStyle
	{
		public function MyVideoPlayerStyle():void {
			//background gradient color top
			bgGradient1 = 0x010101;

			//background gradient alpha top
			bgGradient1Alpha = 1.0;

			//background gradient color bottom
			bgGradient2 = 0x000000;

			//background gradient alpha bottom
			bgGradient2Alpha = 1.0;
			
			//background color for videocontrols
			controlsBg = 0xFF0000;

			//videocontrols' background alpha
			controlsBgAlpha = 0.2;
			
			//btn's background gradient color top
			btnGradient1 = 0x555555;

			//btn's background gradient color bottom
			btnGradient2 = 0x222222;
			
			//btn's icon color
			btnIcon = 0xFFFFFF;

			//btn's icon glow color
			btnRollOverGlow = 0x000000;

			//btn's icon glow alpha
			btnRollOverGlowAlpha = 0.45;
			
			//background color for timer control
			timerBg = 0x000000;
			
			//timercontrol's background alpha
			timerBgAlpha = 0.0;
			
			//text color when timer is counting up
			timerUp = 0x000000;
			
			//text color when timer is counting down
			timerDown = 0x999999;
			
			//background color of time-bar
			barBg = 0xF4F4F4;
			
			//alpha of time-bar
			barBgAlpha = 0.5;
			
			//background color of time-bar (loading)
			barLoading = 0xC8C8C8;
			
			//background color of time-bar (playing)
			barPlaying = 0x2F2F2F;
			
			//color of the knob on the time-bar 
			barKnob = 0xffffff;
			
			//color of the knob's outline on the time-bar
			barKnobOutline = 0x000000;
			
			//alpha of the knob's outline on the time-bar
			barKnobOutlineAlpha = 0.2;
			
			//color of the big play icon (only shown when using jpg at the beginning)
			playIcon = 0xFFFFFF;
			
			//alpha of the big play icon
			playIconAlpha = 1.0;
			
			//videocontrols padding left side (in pixel) 
			controlsPaddingLeft = 5;
			
			//videocontrols padding right side (in pixel)
			controlsPaddingRight = 5;
			
			//flag for ignoring any style-info passed via flashvars
			ignoreFlashvars = false;
		}
	}
}
