/*
Class:QueueIcon
Description:
Visual container for items currently being built in the queue, or waiting to be delivered
Alexander Ross
CS427-SPR2012-SWAG GAMES

Package declaration and imports:
*/

package classes.entityAttribute.Icons{
	import classes.entityAttribute.Icon;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.BitmapData;
	
	public class queueIcon extends Icon{
		
		public var currentCharge:int=0,thresholdCharge:int=0;
		private var loadBar:MovieClip;
		public var isComplete:Boolean=false;
		private var destinationStr:String = "";
		
		
		public function queueIcon(callBackIN:Function,iconIn:BitmapData,objName:String,shortNmIn:String,destStr:String,thresholdIN:int):void{
			super(iconIn);
			this.thresholdCharge = thresholdIN;
			this.callBackFunction = callBackIN;
			this.loadBar= new MovieClip();
			this.addChild(this.loadBar);
			this.loadBar.graphics.beginFill(0x00ff00,.5);
			this.loadBar.graphics.drawRect(0,0,1,50);
			this.loadBar.graphics.endFill();
			this.addEventListener(Event.REMOVED_FROM_STAGE,this.remList);
			this.shortName=shortNmIn;
			this.destinationStr = destStr;
		}
		
		public function update(reference:int):void{
			this.currentCharge=reference;
			this.reShapeLoader();
			
			//We wont need to listen for completion, because the container panel handles icon
			//removal, and will remove this when complete. the remList removal listener should call 
			//it's exit function, displaying its completion message to the containerPanel.
			
		}
		
		public function remList(e:Event):void{
			this.callBackFunction("Building "+this.shortName+" Complete, sending to "+this.destinationStr+".");
		}
		
		public function reShapeLoader():void{
			this.loadBar.width = 50 * (currentCharge/thresholdCharge);
		}
	}
}