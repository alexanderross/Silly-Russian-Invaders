/*
Class:PanelScroller
Description:
Visual container for messages in game.
Alexander Ross
CS427-SPR2012-SWAG GAMES

Package declaration and imports:
*/
package classes.Views.windows{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class PanelScroller extends MovieClip{
		
		private var msgList:Array; // Holds Messages. 
		private var shownMessageIndex:int=0; // Current message viewing index
		private var maxArraySize:int=10;
		private var availableIndex:int=0;
		
		/*
		  Dynamic Flash Vars: 
		  - msgContent:TextField
		*/
		
		public function PanelScroller():void{
			this.msgList = new Array();
			this.addEventListener(MouseEvent.CLICK,this.clickHandler);
			this.addEventListener(MouseEvent.MOUSE_OVER,this.overListener);
			this.addEventListener(MouseEvent.MOUSE_OUT,this.outListener);
			this.alpha=.7;
		}
		
		private function outListener(e:MouseEvent):void{
			this.alpha = .7;
		}
		
		private function overListener(e:MouseEvent):void{
			this.alpha=1;
		}
		
		private function clickHandler(e:MouseEvent):void{
			if(e.localX < 700 && e.localX > 686){
				if(e.localY < 13 && e.localY > 0){
					this.shiftActiveUp();
				}
				if(e.localY < 30 && e.localY > 13){
					this.shiftActiveDown();
				}
			}
		}
		
		public function addMessage(newMsg:String):void{
			for(var k:int=this.maxArraySize;k>=1;k--){
				this.msgList[k] = this.msgList[k-1];
			}
			this.msgList[0]=newMsg;
			this.gotoIndex(0);
		}
		
		private function gotoIndex(target:int):void{
			this.msgContent.text=this.msgList[target];
			this.shownMessageIndex=target;
		}
		
		//Used to cycle to newer message
		public function shiftActiveUp():void{
			if(this.msgList[this.shownMessageIndex-1] != null){
				this.shownMessageIndex--;
				this.msgContent.text = this.msgList[this.shownMessageIndex];
			}
		}
		//Used to cycle to older message
		public function shiftActiveDown():void{
			if(this.msgList[this.shownMessageIndex+1] != null){
				this.shownMessageIndex++;
				this.msgContent.text = this.msgList[this.shownMessageIndex];
			}
		}
	}
}