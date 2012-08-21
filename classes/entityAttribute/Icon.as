/*
Class:Icon
Description:
parent class for icons

Alexander Ross
CS427-SPR2012-SWAG GAMES

Package declaration and imports:
*/

package classes.entityAttribute{
	
	import flash.display.MovieClip;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.events.Event;

	public class Icon extends MovieClip{
		
		public var containedImage:BitmapData;
		public var callBackFunction:Function;
		protected var shortName:String;
		protected var description:String;
		
		public function Icon(backgroundImage:BitmapData):void{
			this.containedImage=backgroundImage;
			this.addChild(new Bitmap(backgroundImage));
		}
		
		public function callBack(contentOut:String):void{
			this.callBackFunction(contentOut);
		}
		
		public function deleteHandler(e:Event):void{
			this.iscomplete=true;
			this.parent.removeChild(this);
		}
	}
}