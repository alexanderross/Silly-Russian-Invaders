/*
Class:ContainerPane
Description:
Primary container of all visual objects and controls

Alexander Ross
CS427-SPR2012-SWAG GAMES

Package declaration and imports:
*/
/*
Class:ContainerPane
Description:
Primary containing class for all views and controls.
Alexander Ross
CS427-SPR2012-SWAG GAMES

Package declaration and imports:
*/

package classes.Views{
	import flash.display.MovieClip;
	import classes.entityAttribute.imgComponents.*;
	import classes.Controller.WorldPopulator;
	import classes.Views.windows.MainPanel;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import classes.View;
	import classes.entity.HCE.tank.Abrams;
	import classes.entity.HCE.tank;
	import classes.Controller.Player;
	import classes.entity.dualEnvironment.City;
	import classes.Views.windows.MessageBox;
	import classes.entity.dualEnvironment.DualEnvironmentContainer;
	import flash.events.MouseEvent;
	import classes.entity.HCE.tank.Challenger;
	import fl.motion.Color;
	import classes.entity.dualEnvironment.Capitol;
	import classes.entityAttribute.Icons.queueIcon;
	import classes.entityAttribute.Icons.buildIcon;
	import classes.entityAttribute.Icon;
	import fl.motion.easing.Back;
	import flash.text.TextField;
	import classes.Views.windows.PanelScroller;
	import classes.Global;
	import fl.controls.CheckBox;
	import fl.events.ComponentEvent;
	import flash.text.TextFormat;

	public class ContainerPane extends MovieClip{
		
		public var flowCheckbox:CheckBox;
		public var mainPopulator:WorldPopulator;
		public var viewHolder:MovieClip= new MovieClip();
		public var buildIconHolder:MovieClip = new MovieClip();
		private var queueIconHolder:MovieClip = new MovieClip();
		
		public var contained:View;
		public var tankBuildIcon:buildIcon;
		public var cityBuildIcon:buildIcon;
		public var primaryWindow:MainPanel;
		public var primaryTimer:Timer;
		public var buildQueueDisp:Array;
		public var buyItemDisp:Array;
		public var cycleCount:int = 0;
		public var playerObject:Player;
		public var currentBattleCity:DualEnvironmentContainer;
		public var placingBoughtObject:Boolean=false;
		public var purchaseIndex:int = 0;
		private var labelTxt:TextField = new TextField();
		private var messageContainer:PanelScroller;
		private var letItRoll:Boolean = false;
		private var transportNumber:TextField = new TextField();
		
		public function ContainerPane():void{
			this.transportNumber.x=550;
			this.transportNumber.y=16;
			
			this.flowCheckbox = new CheckBox();
			this.flowCheckbox.label="Flow";
			this.flowCheckbox.addEventListener(ComponentEvent.BUTTON_DOWN,this.flowChange);
			this.flowCheckbox.x=550;
			
			this.messageContainer = new PanelScroller();
			this.messageContainer.y=577;
			this.playerObject = new Player();
			this.mainPopulator = new WorldPopulator();
			this.contained = new WorldView(this.mainPopulator.returnInitialEnvironment());
			this.contained.parentPanel=this;
			this.primaryWindow=new MainPanel(this.contained.focalWorld);
			
		    this.viewHolder.addChild(this.contained);
			this.addChild(this.viewHolder);
			//this.addChild(this.buyAndQueueHolder);
			this.addChild(this.queueIconHolder);
			this.addChild(this.buildIconHolder);
			this.addChild(this.primaryWindow);
			this.addChild(this.messageContainer);
			this.addChild(this.transportNumber);
			this.addChild(this.flowCheckbox);
			this.primaryTimer = new Timer(40);
			this.primaryTimer.addEventListener(TimerEvent.TIMER,this.timerHandler);
			this.primaryTimer.addEventListener(Event.ACTIVATE,this.primaryWindow.startTicker);
			this.primaryTimer.addEventListener(Event.DEACTIVATE,this.primaryWindow.stopTicker);
			
			this.addEventListener(MouseEvent.MOUSE_MOVE, this.mouseMotionListener);
			this.buildQueueDisp = new Array();
			this.buyItemDisp = new Array();
			this.buildProductionQueueView((this.contained as WorldView).focalWorld.plCapitol);
			this.buildBuyMenuView();
			this.addChild(this.labelTxt);
			this.labelTxt.x=300;
			this.labelTxt.y=580;
			this.updateScroller("And so it begins...");
		}
		
		private function buildBuyMenuView(){
			this.buyItemDisp[0]=new Array(0,100,new buildIcon(this.updateScroller,new buildIconTank(50,50),"ABR",0,"M1 Abrams",""));
			this.buyItemDisp[1]=new Array(0,150,new buildIcon(this.updateScroller,new buildIconTank(50,50),"BE",1,"Black Eagle",""));
			this.buyItemDisp[2]=new Array(0,200,new buildIcon(this.updateScroller,new buildIconTank(50,50),"CHAL",2,"Challenger",""));
			this.buyItemDisp[3]=new Array(0,250,new buildIcon(this.updateScroller,new buildIconCity(50,50),"CITY",3,"City",""));
			this.buyItemDisp[4]=new Array(0,300,new buildIcon(this.updateScroller,new buildIconCityRepair(50,50),"REPAIR",4,"Tank Repairs",""));
			this.buyItemDisp[5]=new Array(0,350,new buildIcon(this.updateScroller,new buildIconTransport(50,50),"TRANS",5,"Cargo Transport",""));
			
			for( var k:int = 0;k<this.buyItemDisp.length;k++){
				(this.buyItemDisp[k][2] as Icon).x = this.buyItemDisp[k][0];
				(this.buyItemDisp[k][2] as Icon).y = this.buyItemDisp[k][1];
				(this.buyItemDisp[k][2] as Icon).alpha = .7;
				this.buildIconHolder.addChild(this.buyItemDisp[k][2] as Icon);
				(this.buyItemDisp[k][2] as Icon).addEventListener(MouseEvent.MOUSE_DOWN,this.setTransaction);
			}
		}
		
		private function buildProductionQueueView(dataIN:Capitol):void{
			for(var i:int=0;i<12;i++){
				//Item,x,y,slot open(bool)
				if(i<dataIN.productionQueue.length){
					this.buildQueueDisp.push(new Array(null,650,50*i,true));
				}else{
					this.buildQueueDisp.push(new Array(null,650,50*i,false));
				}
			}
		}
		
		public function updateProductionQueueView(dataIN:Capitol):void{
				var format:TextFormat = new TextFormat();
				format.color = 0xFFFFFF;
				format.bold=true;
				this.transportNumber.text = dataIN.transportList.length+ " Transport";
				if(dataIN.transportList.length > 1){
					this.transportNumber.text.appendText("s");
				}
				this.transportNumber.setTextFormat(format);
				for(var i:int=0;i<dataIN.productionQueue.length;i++){
					if(dataIN.productionQueue[i][0]!=null){
						(this.buildQueueDisp[i][0] as queueIcon).update(dataIN.productionQueue[i][2]);
						if(this.buildQueueDisp[i][3] == false){
							trace("added going unit in slot "+i);
							this.buildQueueDisp[i][3] = true;
							this.queueIconHolder.addChild(this.buildQueueDisp[i][0]);
						}		
					}else if(this.buildQueueDisp[i][0] !=null){
						if(this.buildQueueDisp[i][3] == true){
							this.queueIconHolder.removeChild(this.buildQueueDisp[i][0] as queueIcon);
							this.buildQueueDisp[i][0] =null;
						}
					}
				}
		}
		
		private function runAvailableSlot():int{
			for(var i:int=0;i<this.buildQueueDisp.length;i++){
				if(this.buildQueueDisp[i][0]==null){
					return i; 
				}
			}
			return -1;
		}
		
		private function setTransaction(e:MouseEvent):void{
			trace("CP Transaction DN");
			var tempIco:buildIcon;
			if(e.target as buildIcon == null){
				tempIco = e.target.parent as buildIcon;
			}else{
				tempIco = e.target as buildIcon;
			}
			this.purchaseIndex = tempIco.arrayIndex;
			this.placingBoughtObject=true;
			if(this.purchaseIndex < 3){
				this.addEventListener(MouseEvent.MOUSE_UP,this.purchaseTank);
			}else if(this.purchaseIndex == 3){
				this.addEventListener(MouseEvent.MOUSE_UP,this.purchaseCity);
			}else if(this.purchaseIndex == 4){
				this.addEventListener(MouseEvent.MOUSE_UP,this.purchaseCityRepair);
			}else if(this.purchaseIndex == 5){
				this.addEventListener(MouseEvent.MOUSE_UP,this.purchaseTransport);
			}
			(this.buyItemDisp[this.purchaseIndex][2] as buildIcon).setActive(true);
			
		}
		 
		private function clearTransaction():void{
			(this.buyItemDisp[this.purchaseIndex][2] as buildIcon).setActive(false);
			(this.buyItemDisp[this.purchaseIndex][2] as MovieClip).x = this.buyItemDisp[this.purchaseIndex][0];
			(this.buyItemDisp[this.purchaseIndex][2] as MovieClip).y = this.buyItemDisp[this.purchaseIndex][1];
			this.placingBoughtObject = false;
		}
		
		public function updateScroller(textin:String):void{
			this.messageContainer.addMessage("("+Global.PlrName+")("+Global.Difficulty+"):"+textin);
		}
		
		public function setView(newType:String):void{
			if(newType=="WV"){
				for(var k:int = 0;k<this.buyItemDisp.length;k++){
					(this.buyItemDisp[2] as Icon).visible = true;
				}
				for(k=0;k<dataIN.productionQueue.length;k++){
					(this.buildQueueDisp[i][0] as Icon).visible=true;
				}
			}else{
				for(k = 0;k<this.buyItemDisp.length;k++){
					(this.buyItemDisp[2] as Icon).visible = false;
				}
				for(k=0;k<dataIN.productionQueue.length;k++){
					(this.buildQueueDisp[i][0] as Icon).visible=false;
				}
			}
		}
		
		public function initializeQueueIcon(avSlot:int):void{
				(this.buildQueueDisp[avSlot][0] as MovieClip).x = this.buildQueueDisp[avSlot][1];
				(this.buildQueueDisp[avSlot][0] as MovieClip).y = this.buildQueueDisp[avSlot][2];
				this.buildQueueDisp[avSlot][3]=false;
				this.updateProductionQueueView((this.contained as WorldView).focalWorld.plCapitol);
		}
		
		public function purchaseTank(e:MouseEvent):Boolean{
			
			this.removeEventListener(MouseEvent.MOUSE_UP,this.purchaseTank);
			this.placingBoughtObject=false;
			trace("PTANKLIST");
			if((this.contained as WorldView)!=null){
				if((this.contained as WorldView).hoverDEC!=null){
					if((this.contained as WorldView).hoverDEC.isSelected() && (this.contained as WorldView).hoverDEC.ownerID==0){
						trace("BUY TARGET");
						var avSlot= this.runAvailableSlot();
						if(avSlot >=0){
							
							var arbitraryObj:tank = (this.buyItemDisp[this.purchaseIndex][2] as buildIcon).retrieveItem(Global.PlrName);
							arbitraryObj.ownerID=0;
							this.buildQueueDisp[avSlot][0]= (this.buyItemDisp[this.purchaseIndex][2] as buildIcon).getQueueIconInstance(arbitraryObj.ATbuildTime,(this.contained as WorldView).hoverDEC.labelStr);
							if(this.playerObject.buyObject(arbitraryObj.ATcost,"UNIT")){
								(this.contained as WorldView).focalWorld.plCapitol.queueUnitSend(avSlot,arbitraryObj,(this.contained as WorldView).hoverDEC);
								this.initializeQueueIcon(avSlot);
								trace("Put tank in queue. owner id: "+arbitraryObj.ownerID);
							}else{
								this.buildQueueDisp[avSlot][0]=null;
								trace("Insufficient funs");
							}//elsecanbuy
						}//avslot
					}//decselected
				}//decdefined
			}
			this.clearTransaction();
			
		}
		
		public function purchaseCity(e:MouseEvent):Boolean{
			this.removeEventListener(MouseEvent.MOUSE_UP,this.purchaseCity);
			this.placingBoughtObject=false;
			
			var avSlot= this.runAvailableSlot();
			if(avSlot >=0){
				if(this.playerObject.buyObject(5000,"CITY")){
						(this.contained as WorldView).focalWorld.plCapitol.queueCitySend(avSlot,this.mainPopulator.returnCityDEC(0,Global.PlrName,0,e.stageX,e.stageY));
						this.buildQueueDisp[avSlot][0]= (this.buyItemDisp[this.purchaseIndex][2] as buildIcon).getQueueIconInstance((this.contained as WorldView).focalWorld.plCapitol.productionQueue[avSlot][1],"The middle of nowhere");
						this.initializeQueueIcon(avSlot);
				}	
		    }
			this.clearTransaction();
		}
		
		public function purchaseTransport(e:MouseEvent):Boolean{
			this.removeEventListener(MouseEvent.MOUSE_UP,this.purchaseTransport);
			this.placingBoughtObject=false;
			
			var avSlot= this.runAvailableSlot();
			if(avSlot >=0){
				if(this.playerObject.buyObject(10000,"TRANSPORT")){
						(this.contained as WorldView).focalWorld.plCapitol.queueTransCreate(avSlot);
						this.buildQueueDisp[avSlot][0]= (this.buyItemDisp[this.purchaseIndex][2] as buildIcon).getQueueIconInstance((this.contained as WorldView).focalWorld.plCapitol.productionQueue[avSlot][1],"to Capitol");
						this.initializeQueueIcon(avSlot);
				}
			}
			this.clearTransaction();
		}
		
		public function purchaseCityRepair(e:MouseEvent):Boolean{
			this.removeEventListener(MouseEvent.MOUSE_UP,this.purchaseCity);
			this.placingBoughtObject=false;
			
			var avSlot= this.runAvailableSlot();
			if(avSlot >=0 && (this.contained as WorldView)!=null){
				if((this.contained as WorldView).hoverDEC!=null){
					if((this.contained as WorldView).hoverDEC.isSelected() && (this.contained as WorldView).hoverDEC.ownerID==0){
						if(this.playerObject.buyObject(6000,"REPAIR")){
								(this.contained as WorldView).focalWorld.plCapitol.queueCityRepair(avSlot,(this.contained as WorldView).hoverDEC);
								this.buildQueueDisp[avSlot][0]= (this.buyItemDisp[this.purchaseIndex][2] as buildIcon).getQueueIconInstance((this.contained as WorldView).focalWorld.plCapitol.productionQueue[avSlot][1],(this.contained as WorldView).hoverDEC.labelStr);
								this.initializeQueueIcon(avSlot);
						}//CANBUY
					}//HOVERVALID
				}//HOVERNOTNULL
			}//AVSLOT
			this.clearTransaction();
		}
		
		
		
		public function replenishEnemyCity(cityContainer:DualEnvironmentContainer):void{
				cityContainer.focusObj.tArray = this.mainPopulator.getNewHCEArrayEnemy();
				cityContainer.initializeAI(1);
			
		}
		
		public function halt(haltCode:int,additionalObject:Object=null):void{
			this.primaryTimer.stop();
			if(haltCode==1){
				this.currentBattleCity = (additionalObject as DualEnvironmentContainer);
			}
		}
		
		public function timerHandler(e:TimerEvent):void{
			this.cycleCount++;
			if(this.cycleCount % 10 == 0){
				this.primaryWindow.updateHeader(this.playerObject.cash,this.playerObject.survivalTime);
			}
			if(this.cycleCount % 60 == 0){
				this.playerObject.addSurvivalTime();
				if(this.playerObject.survivalTime%60 == 0 && Global.Difficulty<10){
					this.playerObject.survivalTime=0;
					Global.Difficulty++;
					this.updateScroller("The Russians grow stronger day by day...");
				}
			}
			this.contained.viewTimerListener();
		}
		
		private function mouseMotionListener(e:MouseEvent):void{
			if(this.placingBoughtObject){											 
				(this.buyItemDisp[this.purchaseIndex][2] as MovieClip).x = e.stageX+10;
				(this.buyItemDisp[this.purchaseIndex][2] as MovieClip).y = e.stageY+10;
			}
			if(this.contained as WorldView != null){
				(this.contained as WorldView).moveListener(e);
			}
		}
		
		public function notifyViewChange():void{
			if(this.contained as WorldView != null){
				this.buildIconHolder.visible = true;
				this.queueIconHolder.visible = true;
			}else{
				this.buildIconHolder.visible = false;
				this.queueIconHolder.visible = false;
			}
		}
		
		private function flowChange(e:ComponentEvent):void{
			if(this.letItRoll){
				this.letItRoll = false;
				this.updateScroller("Prompt Messages Enabled");
			}else{
				this.letItRoll = true;
				this.updateScroller("Let it roll! Prompt messages disabled!");
				
			}
		}
		
		public function notifyDestroyed(type:String,owner:int,cost:int):void{
			if(type=="TANK"){
				if(owner != 0){
					this.playerObject.addUnitDestroyed(cost);
				}else{
					this.playerObject.addUnitLost();
				}
			}
		}
		
		public function notifyCity(code:int):void{
			if(code == 0){
				var tintColour:Color = new Color();
				tintColour.setTint(0xFF0000,.1);
				this.playerObject.addCityLost();
				this.currentBattleCity.ownerID=1;
				this.currentBattleCity.focusObj.ownerID=1;
				this.currentBattleCity.initializeAI(1);
				this.currentBattleCity.selectionBracket.setOwner(this.mainPopulator.enemyName);
				this.currentBattleCity.transform.colorTransform=tintColour;
			}else{
				this.playerObject.addCityDefended();
			}
		}
		
		public function alert(xIn:int,yIn:int,pT:String,sT:String,targetFn:Function):void{
			if(this.letItRoll){
				targetFn(new Event(Event.ACTIVATE));
			}else{
				this.addChild(new MessageBox(xIn,yIn,pT,sT,targetFn));
			}
		}
		
		public function endGame(e:Event):void{
			this.parent.gotoAndPlay(3);
		}
		
		public function overHaulHandler(e:Event):void{
			
		}
		
		public function timeStopHandler(e:Event):void{
			
		}
	}
}