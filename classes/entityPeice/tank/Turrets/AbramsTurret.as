/*
Class:AbramsTurret
Description:
Graphical representation of abrams turret

Alexander Ross
CS427-SPR2012-SWAG GAMES

Package declaration and imports:
*/

package classes.entityPeice.tank.Turrets{
    import flash.display.MovieClip
	
	public class AbramsTurret extends MovieClip{
		public function AbramsTurret():void{
			this.x = this.x-15;
			this.y = this.y+2;
		}
	}
}