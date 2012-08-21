package classes.entity.HCE.artillery{
	import classes.entity.HCE.artillery;
	import classes.entityPeice.artillery.RockIslandMC;

	public class RockIsland extends artillery{
		
		public function RockIsland(xCoord:int,yCoord:int):void{
			super(new RockIslandMC(),xCoord,yCoord);
			this.selectionBracket.setTags("Rock Island M198","<Owner>",this.health);
			this.selectionBracket.y=-3;
		}
	}
}