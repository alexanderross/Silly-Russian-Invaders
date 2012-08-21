package classes.entityAttribute.AttributeSets{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class upgradeElement extends MovieClip{
		//public var popup:customTextBox;
		public var upgradeName:String="", currLevel:int=0;
		public function upgradeElement():void{
			/*this.addEventListener(MouseEvent.MOUSE_OVER,this.rollOn);
			this.addEventListener(MouseEvent.MOUSE_OUT,this.rollOutf);
			this.deactivate();*/
			
		}
		/*
		public function deactivate():void{
			this.alpha=.5;
		}
		
		public function activate():void{
			this.alpha=1;
		}
		
		public function rollOn(evt:MouseEvent):void{
			this.popup = new customTextBox(this.upgradeName+" Level: "+this.currLevel);
			this.addChild(this.popup);
		}
		public function rollOutf(evt:MouseEvent):void{
			this.removeChild(this.popup);
		}
		*/
	}
}