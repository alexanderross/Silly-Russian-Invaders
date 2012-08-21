package classes.entity.dualEnvironment{
	import classes.MCEntity;
	import classes.entity.HCE;
	import classes.entity.HCE.tank;
	import classes.Views.WorldView;
	import classes.Global;
	
	
	public class Capitol extends DualEnvironmentContainer{
		public var productionQueue:Array;
		public var transportList:Array;
		public var sending:int = -1;
		public var parentW:WorldDE;
		
		/*
		Prod Queue: (2D)
		[
			i:[HCE,prodStart,remaining,destCity]
		]
		
		plAttr:(1D)
		[ Name, curr, timeSur ] 
		
		acList: (COMPLEX 1D) 
		[ Transport ] 
		
		*/
		
		public function Capitol(rxIN:int,ryIN:int):void{
			super(rxIN,ryIN,null);
			this.ownerID=0;
			this.productionQueue=new Array();
			for(var k:int=0; k<6;k++){
				this.productionQueue.push(new Array());
			}
			this.transportList=new Array();
			this.transportList.push(new Transport(this.refX,this.refY));
		}
		
		public function updateCap():void{
			for(var i:int=0;i<this.productionQueue.length;i++){
				if(this.productionQueue[i]!=null){
					this.productionQueue[i][2]--; 
					if(this.productionQueue[i][2]<0){
						if(this.productionQueue[i][3]==null){
								this.addTransport(this.productionQueue[i][0] as Transport);
								this.productionQueue[i]=new Array();
						
						}else{					
								if(this.sendUnit(i)){
									this.productionQueue[i]=new Array();
								}
						}
					}
				}
			}
			for(i=0;i<this.transportList.length;i++){
				if(!(this.transportList[i] as Transport).ready){
					(this.transportList[i] as Transport).AIModule.simpleAct();
					if((this.transportList[i] as Transport).AIModule.isContacted()){
						if((this.transportList[i] as Transport).returning){
							this.decommisionTransport((this.transportList[i] as Transport));
							trace("decomissionedTrans");
						}else{
							this.callBackTransportAfterDelivery((this.transportList[i] as Transport));
						}
					}
				}
			}
		}
		
		private function decommisionTransport(mytransport:Transport):void{
			this.parent.removeChild(mytransport);
			mytransport.ready=true;
			mytransport.AIModule=null;
			mytransport.payload=null;
			mytransport.returning=false;
		}
		
		private function addTransport(transIn:Transport):void{
			this.transportList.push(transIn);
		}
		
		private function destroyTransport(transOut:Transport):void{
			for(var i:int=0;i<this.transportList.length;i++){
				if(this.transportList.name == transOut){
					transOut.parent.removeChild(transOut);
					this.transportList[i]=null;
				}
			}
		}
		
		private function callBackTransportAfterDelivery(mytransport:Transport):void{		
				mytransport.returning=true;
				
				if((mytransport.payload as DualEnvironmentContainer)!= null){
					(this.parent as WorldView).addPurchasedDEC(mytransport.payload);
					(mytransport.payload as DualEnvironmentContainer).visible = true;
					mytransport.AIModule.designateTg(this as DualEnvironmentContainer);		
				}
				
				if(mytransport.target.ownerID==0){
					if(((mytransport.payload) as tank)!=null){
						mytransport.target.focusObj.tArray.push((mytransport.payload) as tank);
					}else if(mytransport.payload==1){
						mytransport.target.focusObj.applyHCEAttributes(true);
						(this.parent as WorldView).parentPanel.updateScroller(mytransport.target.focusObj.labelStr+"'s tanks repaired");
					}
					mytransport.AIModule.designateTg(this as DualEnvironmentContainer);
				}else{
					if(Math.random()*10 < Global.Difficulty){
						this.destroyTransport(mytransport);
						(this.parent as WorldView).parentPanel.updateScroller("Transport shot down attempting to evade enemy occupation of "+mytransport.target.labelStr+"!");
					}else{
						mytransport.AIModule.designateTg(this as DualEnvironmentContainer);
						(this.parent as WorldView).parentPanel.updateScroller("Transport narrowly escaped "+mytransport.target.labelStr+" to fly another day!");
					}
				}
				
		}
		
		public function queueUnitSend(index:int,unit:HCE,dest:DualEnvironmentContainer):void{
			this.productionQueue[index] =new Array(unit,unit.ATbuildTime,unit.ATbuildTime,dest);
		}
		
		public function queueCitySend(index:int,dest:DualEnvironmentContainer):void{
			dest.visible=false;
			this.productionQueue[index] =new Array(dest,500,500,dest);
		}
		
		public function queueTransCreate(index:int):void{
			this.productionQueue[index] =new Array(new Transport(this.refX,this.refY),600,600,null);
		}
		
		public function queueCityRepair(index:int,dest:DualEnvironmentContainer):void{
			this.productionQueue[index] = new Array(1,800,800,dest);
		}
		
		public function sendUnit(sendDex:int):Boolean{
			var availableTransport:int=-1;
			for(var t:int=0;t<this.transportList.length;t++){
				if(this.transportList[t] != null){
					if((this.transportList[t] as Transport).ready){
						(this.transportList[t] as Transport).ATagility=25-(Global.Difficulty*2);// A good time to update this.
						availableTransport = t;
					}
				}
			}
			if(availableTransport >=0){
				//Send it with the Trans of index aT
				this.parent.addChild(this.transportList[availableTransport]);
				//this.parentW.addDEC(this.transportList[availableTransport] as Transport);
				(this.transportList[availableTransport] as Transport).payload=this.productionQueue[sendDex][0];
				(this.transportList[availableTransport] as Transport).initializeAI(-1);
				(this.transportList[availableTransport] as Transport).ready = false;
				(this.transportList[availableTransport] as Transport).AIModule.designateTg(this.productionQueue[sendDex][3] as DualEnvironmentContainer);
				return true;
				
			}//If avail
			else{
				return false;
				
			}
		}//FNC
	}
}