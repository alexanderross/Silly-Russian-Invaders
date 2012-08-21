package classes.entity.HCE{
	import classes.entity.HCE;
	import classes.entityPeice.entityPeice;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import classes.SpriteMC.muzzleFlash;
	import classes.MCEntity;

	public class tank extends HCE{
		public var base:MovieClip, tankTurret:MovieClip,firingSprite:muzzleFlash; 
		
		public function tank(baseI:MovieClip,turretI:MovieClip,xI:int,yI:int,ownerStringI:String,ownerIDI:int):void{
			this.firingSprite= new muzzleFlash();
			this.base=baseI;
			this.ownerID=ownerIDI;
			this.ownerString=ownerStringI;
			this.tankTurret=turretI;
			this.addChild(this.base);
			this.addChild(this.tankTurret);
			
			this.tankTurret.addChild(this.firingSprite);
			super(xI,yI,ownerIDI);
		}
		
		
		override public function fire():Boolean{
			if(super.fire()){
				this.firingSprite.gotoAndPlay(1);
				return true;
			}else{
				return false;
			}
		}
		

		public function offsetTurret(xShift:int,yShift:int):void{
			this.tankTurret.x +=xShift;
			this.tankTurret.y +=yShift;
		}

		public function rotateTurretToStagePt(stageX:int,stageY:int):void{
			var currLoc:Point = (localToGlobal(new Point(this.tankTurret.x,this.tankTurret.y)));
			var rotAngle:Number = Math.atan2(currLoc.y-stageY,currLoc.x-stageX);
			this.tankTurret.rotation= rotAngle*(180/Math.PI)-this.rotation;
		}
		
	}
}