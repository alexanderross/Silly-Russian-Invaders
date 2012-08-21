package classes.entity{
	import flash.geom.Point;
	import classes.MCEntity;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import classes.spriteMC.CraterExplosionSprite;
	import classes.entity.dualEnvironment.City;
	import classes.Views.OpenView;
	import classes.spriteMC.hitSprite;
	import classes.entity.AI.AIHCE;

	public class HCE extends MCEntity{
		//ATTRIBUTES(AT)
		public var ATrange:int, ATaccuracy:int, ATfireInterval:int, ATdamage:int,ATstrength:int,ATbuildTime:int,ATcost:int,ATTRIBint:uint;
		//Note: ATagility moved up to the MCEntity base class.
		//
		public var HCEname:String;
		public var AIPause=false;
		public var fired:int=0, tHits:int=0;
		public var fireTicker:int=10;
		public var AIModule:AIHCE; 
		
		public function HCE(refXIn:int,refYIn:int,OID:int):void{
			this.ownerID = OID;
			this.x = refXIn;
			this.y = refYIn;
			super(refXIn,refYIn);
			this.traceMovement=false;
			this.stgHeight=600;
			this.stgWidth=700;
		}
		
		public function initializeAI(owner:int=-2):void{
			if(owner!=-2){
				this.ownerID = owner;
			}
			this.AIModule = new AIHCE(this);
		}
		
		public function move(xV:Number,yV:Number):Boolean{
			xV=Math.round(xV*100);
			yV=Math.round(yV*100);
			//trace("MOV Unit nm: "+this.name+" x: "+this.movementVectX+" y: "+this.movementVectY+" xV:"+xV+" yV"+yV);
			if(xV >= this.movementVectX-10 && xV <= this.movementVectX+10 && yV <= this.movementVectY +10 && yV >= this.movementVectY -10){
				if(super.moveEnt(xV,yV)){
					return true;
				}else{
					return false;
				}
			}else{
				if(xV < this.movementVectX){
					this.movementVectX-=this.ATagility;
				}
				if(xV > this.movementVectX){
					this.movementVectX+=this.ATagility;
				}
				if(yV < this.movementVectY){
					this.movementVectY-=this.ATagility;
				}
				if(yV > this.movementVectY){
					this.movementVectY+=this.ATagility;
				}
			}
			this.rotation = Math.atan2(this.movementVectY/100,this.movementVectX/100)*(180/Math.PI);
			this.selectionBracket.rotation = -(this.rotation);
			//this.movementDir=int((this.movementDir)*10)/10;
			return true;
		}
		
		
		public function calculateShot(targetEnt:MCEntity):Boolean{
			var distance:int = this.calcDistance(new Point(targetEnt.refX,targetEnt.refY));
			var evaluation:int = (distance*distance)/(this.ATrange*this.ATaccuracy);
			var rando:int = Math.random()*(this.ATrange/2);
			this.fired++;
			if(evaluation < (rando)){
				this.tHits++;
				//trace("Hit at distance: "+distance+", accuracy: "+this.ATaccuracy+", Range: "+this.ATrange);
				return true;
			}else{
				//trace("Missed at distance: "+distance+", accuracy: "+this.ATaccuracy+", Range: "+this.ATrange);
				return false;
			}
		}
		
		
		public function damage(amount:int):void{
			this.health = this.health - (amount/this.ATstrength);
			this.selectionBracket.setHealthBar(this.health);
			var hitSpritee:hitSprite=new hitSprite();
			this.addChild(hitSpritee);
			if (this.health <1){
				this.destroy();
			}
		}
		
		public function fire():Boolean{
			if(this.fireTicker<1){
				this.fireTicker=this.ATfireInterval;
				return true;
			}else{
				return false;
			}
		}
		public function destroy():void{
	
		}
		
		public function update(focusC:City):void{
			if(this.AIModule!=null){
				this.AIModule.act(focusC)
			}
			if(this.fireTicker>0){
				this.fireTicker-=5;
				this.selectionBracket.setReload(1-(fireTicker/this.ATfireInterval));
			}
		}
		
		override public function demoteSelection():void{
			super.demoteSelection();
			if(this.AIPause){//If we have overwritten AI, we need to reinitialize on selection.
				this.initializeAI();
			}
		}
		
		
		public function rotateBodyToStagePt(stageX:int,stageY:int):void{
			var currLoc:Point = (localToGlobal(new Point(this.x,this.y)));
			var rotAngle:Number = Math.atan2(currLoc.y-stageY,currLoc.x-stageX);
			this.rotation= rotAngle*(180/Math.PI);
			this.selectionBracket.rotation = -rotAngle*(180/Math.PI);
		}
	}
}