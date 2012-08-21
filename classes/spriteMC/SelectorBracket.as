/*
Class:SelectorBracket
Description:
Containing class for bracket used by each entity to represent health and charge(load).

Alexander Ross
CS427-SPR2012-SWAG GAMES

Package declaration and imports:
*/
package classes.spriteMC {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.geom.ColorTransform;
	
	
	public class SelectorBracket extends MovieClip {
		
		
		public function SelectorBracket() {
		
		}
		
		public function setTags(nameTag:String,ownerTag:String,healthPct:int):void{
			this.nameBox.text=nameTag;
			this.ownerBox.text=ownerTag;
			this.healthBox.width= (healthPct/100)*92;
		}
		
		public function setReload(percent:Number):void{
			this.reloadBar.width= percent*94;
		}
		public function setOwner(ownerTag:String):void{
			this.ownerBox.text=ownerTag;
		}
		
		public function setName(nameTag:String):void{
			this.nameBox.text=nameTag;
		}
		
		public function setHealthBar(percent:int):void{
			this.healthBox.width= (percent/100)*92;
			var myColor:ColorTransform = healthBox.transform.colorTransform;
			if(percent < 50){
				myColor.color = 0xFFA812;
			}
			if(percent < 25){
				myColor.color = 0xFF0000;
			}
			healthBox.transform.colorTransform=myColor;
		}
		
	}
	
}
