package classes.entity.AI{
	import flash.geom.Point;
	import classes.entity.dualEnvironment.City;
	import classes.entity.HCE.tank;
	import classes.entity.HCE;
	import classes.Global;

	public class AIHCE{
		public var controller:HCE;
		public var optimalVector:Array;
		public var target:HCE;
		public var basePoint:Point = new Point(0,0);
		public var exhausted:Boolean=false;
		public var stopped:Boolean=false;
		public var totalShots:int=0, hits:int=0, closnessFactor:int=30;
		
		
		
		public function AIHCE(controllerIN:HCE):void{
			this.controller=controllerIN;
		}
		
		public function calculateRoute(targetX:int,targetY:int):void{
	
			this.optimalVector = new Array();
			this.stopped=false;
			var yChg:int = targetY-this.controller.refY;
			var xChg:int = targetX-this.controller.refX; 
			var total:int = Math.abs(xChg)+Math.abs(yChg);
			var xRat:Number = Math.abs(xChg/total);
			var yRat:Number = 1-xRat;
			if(xChg<0){xRat*=-1;}
			if(yChg<0){yRat*=-1;}
			optimalVector.push(xRat);
			optimalVector.push(yRat);
		}
		
		public function moveToDestination():void{
			if(!this.stopped){
				if(!this.controller.move(this.optimalVector[0],this.optimalVector[1])){
					this.stopped=true;
					this.optimalVector=null;
				}
				if(this.inRange()){
					this.stopped=true;
					
				}
				this.controller.moved=true;
				(this.controller as tank).rotateTurretToStagePt(this.target.x,this.target.y);
			}
		}
		
		public function selectTg(focus:City):void{
			var bestIndex:int = -1;
			var bestScore:Number = 0;
			var tempScore:Number = 0;
			for(var i:int=0;i<focus.tArray.length;i++){
				var temp:HCE = (focus.tArray[i] as HCE);
				if(temp.ownerID != this.controller.ownerID){//Friendly fire will NOT BE TOLERATED :p
					tempScore = Math.pow((this.controller.calcDistance(new Point(temp.refX,temp.refY))/temp.ATrange),Global.Difficulty);
					tempScore = tempScore*(temp.health+((temp.ATdamage*temp.ATaccuracy*temp.ATstrength)*Global.Difficulty));
					if(tempScore>bestScore){
						bestScore =  tempScore;
						bestIndex=i;
					}
				}
			}
			if(bestIndex==-1){// Nothing to shoot....
				if(focus.targetAnchor.health>0){
					this.exhausted=true;
				}
			}else{
				this.exhausted=false;
				this.target = focus.tArray[bestIndex] as HCE; 
			}
		}
		
		
		public function inRange():Boolean{
			if(this.controller.calcDistance(new Point(this.target.refX,this.target.refY))<(this.controller.ATrange-this.closnessFactor)){
				return true;
			}else{
				return false;
			}
		}
		
		public function act(focusCity:City):void{
			if(this.target == null || this.exhausted){
				if(!this.exhausted){
					this.selectTg(focusCity);
					(this.controller as tank).rotateTurretToStagePt(this.target.x,this.target.y);
				}
				
			}else{
					if(this.optimalVector==null){
						this.calculateRoute(this.target.refX,this.target.refY);
					}
					if(this.target == null){
						
					}
					if(this.target.moved){
						this.target.moved=false;
						if(!this.inRange() && this.stopped){
							if(Global.Difficulty>2){
								this.target=null;
								this.selectTg(focusCity);
							}
							
							this.calculateRoute(this.target.refX,this.target.refY);
						}
						(this.controller as tank).rotateTurretToStagePt(this.target.x,this.target.y);
					}
					if(!this.stopped){
						this.moveToDestination();
					}
			
					if(this.stopped){ 
						if((this.controller as tank).fire()){
							this.totalShots++;
							if(this.controller.calculateShot(this.target)){
								this.hits++;
								target.damage(this.controller.ATdamage);
							}
						}
						if(((this.hits/this.totalShots) < (1/Global.Difficulty+1))&& this.totalShots>5){
							this.totalShots=0;
							this.hits=0;
							this.closnessFactor=this.closnessFactor*2;
							this.target.moved=true;
						}
					}
					if(this.target.health <0){
						this.stopped=false;
						this.selectTg(focusCity);
						this.optimalVector=null;
						if(this.target!=null){
							(this.controller as tank).rotateTurretToStagePt(this.target.x,this.target.y);
							this.closnessFactor=20;
						}
					}
				}//Target isn't null.. 
				
			}//act()
		}//class
	}//package
