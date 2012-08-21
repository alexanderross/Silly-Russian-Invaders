/*
Class:hitSprite
Description:
Containing class for the hit sprite

Alexander Ross
CS427-SPR2012-SWAG GAMES

Package declaration and imports:
*/
package classes.spriteMC {
	
	import flash.display.MovieClip;
	
	
	public class hitSprite extends MovieClip {
		
		public function hitSprite() {
			this.rotation = Math.random()*270
		}
	}
	
}
