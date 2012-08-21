package classes.entity.HCE.tank{
	import classes.entity.HCE.tank;
	import classes.entityPeice.tank.Bases.ChallengerBase;
	import classes.entityPeice.tank.Turrets.ChallengerTurret;

	public class Challenger extends tank{
		
		public function Challenger(xI:int,yI:int,ownerStringI:String,ownerIDI:int):void{
			super(new ChallengerBase(),new ChallengerTurret(),xI,yI,ownerStringI,ownerIDI);
			super.offsetTurret(27,-1);
			super.firingSprite.x=-95;
			super.firingSprite.y=-17;
			this.selectionBracket.setTags("FV4034 Challenger II",ownerStringI,this.health);
			this.ATrange=300;
			this.ATaccuracy=2;
			this.ATagility=10;
			this.ATbuildTime=500;
			this.ATcost=2000;
			this.ATdamage=15;
			this.ATfireInterval=500;
			this.ATrange=300;
			this.ATstrength=1;
			this.ATTRIBint=0;
			//this.selectionBracket.y=-24;
			//this.selectionBracket.x=-48;
		}
	}
}