/*
Class:ChallengerTurret
Description:
Graphical representation of challengers turret

Alexander Ross
CS427-SPR2012-SWAG GAMES

Package declaration and imports:
*/

package classes.entityPeice.tank.Turrets{
    import flash.display.MovieClip
  
	
	public class ChallengerTurret extends MovieClip{
		public function ChallengerTurret():void{
			this.x = this.x-30;
			this.y = this.y+2;
		}
	}
}