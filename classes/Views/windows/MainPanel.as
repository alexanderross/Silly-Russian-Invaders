/*
Class:MainPanel
Description:Displays the player's cash
Alexander Ross
CS427-SPR2012-SWAG GAMES

Package declaration and imports:
*/
package classes.Views.windows {
	
	import flash.display.MovieClip;	
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.MovieClip;
	
	
	public class MainPanel extends MovieClip {
		private var statusSymbolCt:int=40;
		private var timeTickerState:int=0; // 0-Stopped 1-Active Light(1) 2-Active Light(2)
		
		public function MainPanel(focalData:WorldDE):void {
			super();
			this.stopNotch.visible=false
		}
		
		public function updateHeader(plrCash:int,cyclesSurvived:int):void{
			var years:String=Math.floor(cyclesSurvived / 372)+" Yrs ";
			var months:String=Math.floor((cyclesSurvived % 372) / 31)+" Mo ";
			var days:String = cyclesSurvived % 31+" Days";
			this.cashAmount.text = "$"+plrCash; 
			this.timeSurvived.text = years+""+months+""+days; 
			
			
			this.switchVisibleDot();
				
			
		}
		
		private function switchVisibleDot():void{
			if(timeTickerState == 1){
				timeTickerState = 2;
				this.timerNotch.y = 10;
			}else{
				timeTickerState = 1;
				this.timerNotch.y = 0;
			}
		}
		
		//Functions to adjust the time ticker
		public function stopTicker(e:Event):void{
			this.timerNotch.visible=false;
			this.stopNotch.visible=true;
		}
		
		public function startTicker(e:Event):void{
			this.stopNotch.visible=false;
			this.timerNotch.visible=true;
		}
		
	}
	
}
