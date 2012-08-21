package classes.entity.HCE.tank{
	import classes.entity.HCE.tank;
	import classes.entityPeice.tank.Bases.BlkEagleBase;
	import classes.entityPeice.tank.Turrets.BlkEagleTurret;

	public class BlackEagle extends tank{
		
		public function BlackEagle(xI:int,yI:int,ownerStringI:String,ownerIDI:int):void{
			super(new BlkEagleBase(),new BlkEagleTurret(),xI,yI,ownerStringI,ownerIDI);
			super.offsetTurret(28,0);
			super.firingSprite.x=-87;
			super.firingSprite.y=-17;
			this.selectionBracket.setTags("Obyekt 640",ownerStringI,this.health);
			trace("BLACK EAG MADE :"+ownerStringI);
			this.ATrange=400;
			this.ATaccuracy=2;
			this.ATagility=10;
			this.ATbuildTime=300;
			this.ATcost=1000;
			this.ATdamage=10;
			this.ATfireInterval=400;
			this.ATstrength=1;
			this.ATTRIBint=0;
			//this.selectionBracket.y=-24;
			//this.selectionBracket.x=-48;
		}
	}
}