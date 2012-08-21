/*
Class:MessageBox
Description:
Alerts the user of an event and upon the box being clicked, triggers a return function and 
destroys the box.
Alexander Ross
CS427-SPR2012-SWAG GAMES

Package declaration and imports:
*/
package classes.Views.windows {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	
	public class MessageBox extends MovieClip {
		
		public function MessageBox(xI:int,yI:int,firstTxt:String,secondTxt:String,closeFn:Function):void {
			this.x=xI;
			this.y=yI;
			this.width = firstTxt.length*30+70;

			this.mainText.text = firstTxt;
			this.secondaryText.text = secondTxt;
			//Re-scale boxes and add listeners
			this.width = firstTxt.length*19+40;
			this.mainText.width=firstTxt.length*19+40;
			this.secondaryText.width=firstTxt.length*19+40;
			this.addEventListener(Event.REMOVED_FROM_STAGE,closeFn);
			this.addEventListener(MouseEvent.CLICK,this.close);
		}
		
		public function close(e:Event):void{
			trace("Rem child");
			this.parent.removeChild(this);
		}
	}
	
}
