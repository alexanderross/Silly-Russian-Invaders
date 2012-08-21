package classes.entity.AI{
	import flash.geom.Point;
	import classes.entity.dualEnvironment.City;
	import classes.entity.dualEnvironment.DualEnvironmentContainer;
	import classes.entity.dualEnvironment.WorldDE;
	import classes.Global;
	

	public class AIDEC{

		public var optimalVector:Array;
		public var controller:DualEnvironmentContainer;
		public var target:DualEnvironmentContainer;
		public var basePoint:Point = new Point(0,0);
		public var exhausted:Boolean=false;
		public var stopped:Boolean=false;
		public var closnessFactor:int=30;
		public var contactedTarget:Boolean = false;
		
		
		
		public function AIDEC(controllerIN:DualEnvironmentContainer):void{
			this.controller=controllerIN;
		    trace("DEC AI ENGINE INITIALIZED");
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
			optimalVector.push(xRat*100);
			optimalVector.push(yRat*100);
			this.controller.movementVectX=optimalVector[0];
			this.controller.movementVectY=optimalVector[0];
			
			
		}
		
		public function isContacted():Boolean{
			var threshold:int=20;
			if(this.controller.target !=null){
				if(this.controller.refX > this.controller.target.x-threshold && this.controller.refY > this.controller.target.y-threshold){
					if(this.controller.refX < this.controller.target.x+threshold && this.controller.refY < this.controller.target.y+threshold){
						this.contactedTarget=true;
						return true;
					}
				}
			}
			return false;
		}
		
		public function moveToDestination():void{
			if(!this.stopped){
				this.controller.moveEnt(this.optimalVector[0],this.optimalVector[1]);
				this.controller.moved=true;
			}
			if(this.isContacted()){
			   this.stopped=true;
			   this.optimalVector=null;
			}
		}

		public function designateTg(targetI:DualEnvironmentContainer):void{
			this.controller.target=targetI;
			this.stopped=false;
		}
		
		public function selectTg(focus:WorldDE):void{
			var bestIndex:int = -1;
			var bestScore:Number = 10000;
			var tempScore:Number = 0;
			for(var i:int=0;i<focus.decArray.length;i++){
				var temp:DualEnvironmentContainer = (focus.decArray[i] as DualEnvironmentContainer);
				if(temp.ownerID != this.controller.ownerID){//Friendly fire will NOT BE TOLERATED :p
					tempScore = this.controller.calcDistance(new Point(temp.refX,temp.refY));
					if(tempScore<bestScore){
						bestScore = tempScore;
						bestIndex=i;
					}
				}
			}
			if(bestIndex==-1){// Nothing to shoot....
				this.exhausted=true;
			}else{
				this.exhausted=false;
				this.controller.target = focus.decArray[bestIndex] as DualEnvironmentContainer; 
			}
		}
		
		public function simpleAct():void{
				if(this.controller.target !=null){
					if(this.optimalVector==null){
						this.calculateRoute(this.controller.target.refX,this.controller.target.refY);
						this.controller.rotation = Math.atan2(this.controller.movementVectY,this.controller.movementVectX)*(180/Math.PI);
					}
					if(!this.stopped){
						this.moveToDestination();
					}
				}
		}

		
		public function act(focusCity:WorldDE):void{
			if(this.controller.target == null || this.exhausted){
				if(!this.exhausted){
					this.selectTg(focusCity);
				}
				
			}else{
				   // this.dumpStatus();
					if(this.optimalVector==null){
						this.calculateRoute(this.controller.target.refX,this.controller.target.refY);
					}
					if(!this.stopped){
						this.moveToDestination();
					}
						
						//if(!this.stopped){
						//}
					if(this.stopped){ 
						
					}
					if(this.controller.target.health <0){
						this.stopped=false;
						this.selectTg(focusCity);
					}
				}//Target isn't null.. 
				
			}//act()
		}//class
	}//package
