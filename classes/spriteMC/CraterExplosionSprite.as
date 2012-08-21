/*
Class:CraterExplosionSprite
Description:
Containing class for the persistant crater explosion

Alexander Ross
CS427-SPR2012-SWAG GAMES

Package declaration and imports:
*/

package classes.spriteMC {
	
	import flash.display.MovieClip;
	
	
	public class CraterExplosionSprite extends MovieClip {
		
		
		public function CraterExplosionSprite(xI:int,yI:int,multiplier:int) {
			this.x=xI;
			this.y=yI;
			this.width=this.width*multiplier;
			this.height=this.height*multiplier;
			this.rotation = Math.random()*360;

		}
	}
	
}
