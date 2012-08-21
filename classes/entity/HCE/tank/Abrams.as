package classes.entity.HCE.tank{
	import classes.entity.HCE.tank;
	import classes.entityPeice.tank.Bases.AbramsBase;
	import classes.entityPeice.tank.Turrets.AbramsTurret;

	public class Abrams extends tank{
		
		public function Abrams(xI:int,yI:int,ownerStringI:String,ownerIDI:int):void{
			super(new AbramsBase(),new AbramsTurret(),xI,yI,ownerStringI,ownerIDI);
			super.offsetTurret(16,-2);
			super.firingSprite.x=-80;
			super.firingSprite.y=-17;
			this.selectionBracket.setTags("M1A1 Abrams",ownerStringI,this.health);
			this.ATrange=400;
			this.ATaccuracy=3;
			this.ATagility=10;
			this.ATbuildTime=1000;
			this.ATcost=4000;
			this.ATdamage=20;
			this.ATfireInterval=300;
			this.ATrange=400;
			this.ATstrength=2;
			this.ATTRIBint=0;
			//this.selectionBracket.x=-45;
			//this.selectionBracket.y=-25;
		}
	}
}