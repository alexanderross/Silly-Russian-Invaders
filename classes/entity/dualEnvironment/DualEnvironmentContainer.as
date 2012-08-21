package classes.entity.dualEnvironment{
	import classes.MCEntity;
	import flash.display.Shape;
	import classes.entity.AI.AIDEC;
	import flash.display.Sprite;

	public class DualEnvironmentContainer extends MCEntity{
		
		public var focusObj:City; 
		public var ghost:Sprite;
		public var AIModule:AIDEC;
		public var target:DualEnvironmentContainer;
		public var orginX:int,orginY:int;
		public var spawnCt:int=0, spawnThreshold:int=300;// Interval for enemy DEC to spawn new units
		
		public function DualEnvironmentContainer(xIn:int,yIn:int,cityIn:City):void{
			this.orginX = xIn;
			this.orginY = yIn;
			if(cityIn!=null){
				this.focusObj = cityIn;
				this.labelStr = cityIn.labelStr;
				this.name=this.labelStr;
			}
			super(xIn,yIn);
			this.x=xIn;
			this.y=yIn;
			if(cityIn!=null){
				this.selectionBracket.setTags(this.labelStr,cityIn.ownerName,100);
			}else{
				this.selectionBracket.setTags("Transport Plane","Boeing",100);
			}
			this.ghost= new Sprite()
			this.addChild(ghost);
		
		}
		
		public function initializeAI(ownerIDI:int):void{
			this.AIModule=new AIDEC(this);
			this.ownerID=ownerIDI;
		}
		public function update():void{
			if(this.focusObj!=null){
				this.selectionBracket.setReload(this.spawnCt/this.spawnThreshold);
				this.selectionBracket.setHealthBar(this.focusObj.getTankHealthPct());
			}
		}
		
		public function repairAllContainedHCE():void{
			aquisition.focusObj.applyHCEAttributes(true);
		}
		
		public function acquireCity(aquisition:DualEnvironmentContainer):void{
			this.focusObj.joinTArrays(aquisition.focusObj.tArray);
			aquisition.focusObj.tArray=new Array();
		}
		
		/*
		    Reallocate all HCE's in one city to another, used in "Retreat", or whatever else i may come up with 
		*/
		public function reAllocate(target:DualEnvironmentContainer):void{
			//for
			target.focusObj.aArray=this.focusObj.aArray;
			target.focusObj.tArray=this.focusObj.tArray; 
			/*if(target.focusObj.joinAttrbutes(this.focusObj.myCityAttributes)){
				trace("yay");
			}*/
			
		}
		
	}
}