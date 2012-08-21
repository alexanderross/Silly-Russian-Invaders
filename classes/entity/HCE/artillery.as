package classes.entity.HCE{
	import classes.entity.HCE;
	import classes.entityPeice.entityPeice;
	import flash.display.MovieClip;
	import flash.geom.Point;

	public class artillery extends HCE{
		public var body:MovieClip; 
		
		public function artillery(bodyI:MovieClip,xI:int,yI:int):void{
			
			this.body=bodyI;
			this.addChild(this.body);
			super(xI,yI,1);
		}

		public function offsetbody(xShift:int,yShift:int):void{
			this.body.x +=xShift;
			this.body.y +=yShift;
		}

		public function rotateUnitToStagePt(stageX:int,stageY:int):void{
			var currLoc:Point = (localToGlobal(new Point(this.body.x,this.body.y)));
			var rotAngle:Number = Math.atan2(currLoc.y-stageY,currLoc.x-stageX);
			this.body.rotation= rotAngle*(180/Math.PI);
		}
	}
}