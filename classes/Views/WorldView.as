/*
Class: 
Description:
Visual class for the WorldView standpoint, which shows the view of friendly enemies and cities

Alexander Ross
CS427-SPR2012-SWAG GAMES

Package declaration and imports:
*/

package classes.Views{
	import classes.MCEntity;
	import classes.entity.dualEnvironment.WorldDE;
	import classes.entity.dualEnvironment.DualEnvironmentContainer;
	import classes.View;
	import flash.events.MouseEvent;
	import classes.entity.dualEnvironment.City;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.events.Event;
	import classes.entity.dualEnvironment.Capitol;
	import classes.Views.windows.MainPanel;
	import flash.display.Sprite;
	import classes.entity.HCE;
	import classes.Global;
	
	public class WorldView extends View{
		
		public var focalWorld:WorldDE;
		public var startMoveX:int=0,startMoveY:int=0;
		public var cycleTime:int=3,currentCycle:int=0;
		public var nextView:OpenView;
		public var switching:Boolean=false;
		public var hoverDEC:DualEnvironmentContainer;
		
		public function WorldView(focalIn:WorldDE):void{
			this.focalWorld= focalIn;//Set world data into attribute
			super(100);//Call the parent constructor
			this.addChild(new PrimaryWorldViewTexture(0,0));//Load backing image
			this.loadWorld(focalIn);
		}
		//Load all items contained in world onto the stage
		public function loadWorld(fcWorld:WorldDE):void{
			for(var t:int=0;t<fcWorld.decArray.length;t++){
				var temp:DualEnvironmentContainer = fcWorld.decArray[t] as DualEnvironmentContainer;
				this.addChild(temp);
				if(temp.ownerID==0){
					temp.addEventListener(MouseEvent.MOUSE_OVER,this.notifier);
				}
				temp.addEventListener(MouseEvent.CLICK,this.cityClickListener);
			}
			this.addChild(fcWorld.plCapitol);
			fcWorld.plCapitol.x=fcWorld.plCapitol.refX;
			fcWorld.plCapitol.y=fcWorld.plCapitol.refY;
			this.focalWorld = fcWorld;
		}
		//Add a DEC that has been purchased into the world's array and add it to the stage.
		public function addPurchasedDEC(newDEC:DualEnvironmentContainer):void{
			this.focalWorld.addDEC(newDEC);
			this.addChild(newDEC);
			if(newDEC.ownerID==0){
				newDEC.addEventListener(MouseEvent.MOUSE_OVER,this.notifier);
			}
			newDEC.addEventListener(MouseEvent.CLICK,this.cityClickListener);
		}
		
		
		//Listener for Enemy DEC's that have contacte d a friendly city.
		private function contactListener(sourceDEC:DualEnvironmentContainer,destDEC:DualEnvironmentContainer):void{
			destDEC.acquireCity(sourceDEC); // Merge contents of enemy city into player's city
			this.parentPanel.halt(1,destDEC); // Stop the timer
			this.nextView=new OpenView(destDEC.focusObj); // Load the openView of the impending battle
			sourceDEC.AIModule.contactedTarget=false; // Release contact switch
			sourceDEC.target=null; // Release target so AI can designate another on next wave.
			this.alert(300,300,destDEC.labelStr+" Is under attack!","",this.switchToPreparedView); // prompt user.
		}
		
		//Erase all tracks made by an enemy city advancing on a friendly city.
		private function backoutCity(focalDEC:DualEnvironmentContainer):void{
			focalDEC.removeChild(focalDEC.ghost);
			focalDEC.ghost = new Sprite();
			focalDEC.addChild(focalDEC.ghost);
			focalDEC.refX=focalDEC.x;
			focalDEC.refY=focalDEC.y;
			focalDEC.AIModule=null;
			focalDEC.spawnCt=0;
		}
		
		//Listener to switch to a pre-loaded view, used in the return statement for the alert raised by the contact function
		public function switchToPreparedView(e:Event):void{
				this.switchViews(this.nextView);
		}
		
		//Notifies the container pane of a DualEnvironmentContainer being selected, used for purchases.
		public function notifier(evt:MouseEvent):void{
			if((evt.target as DualEnvironmentContainer)!=null){
				this.hoverDEC = (evt.target as DualEnvironmentContainer);
			}
		}
		
		//Listener for mouse movement, allows the user to pan around the world. 
		public function moveListener(e:MouseEvent):void{
			var movementEdge:int=100;
			var movementDivider:int=10;
			if(e.stageY > 600-movementEdge && this.y > -300){
				this.y-= (e.stageY - (600-movementEdge))/movementDivider;
			}
			if(e.stageY < movementEdge && this.y < 0){
				this.y+= (movementEdge-e.stageY)/movementDivider;
			}
			if(e.stageX >700-movementEdge && this.x > -700){
				this.x-= (e.stageX - (700-movementEdge))/movementDivider;
			}
			if(e.stageX < movementEdge && this.x < 0){
				this.x+= (movementEdge-e.stageX)/movementDivider;
			}
		
		}
		
		//Listens for a city being clicked, used to select cities or if ctrl is pressed, forces the city to be loaded into openView
		public function cityClickListener(event:MouseEvent){
			if(this.pressedKeys[17]==true){//ctrl
				this.switchViews(new OpenView((event.currentTarget as DualEnvironmentContainer).focusObj));
			}else{
				this.focalObj= event.currentTarget as DualEnvironmentContainer;
			}
		}
		
		//Augments the parent listener call.
		override public function addListeners(e:Event):void{
			this.addEventListener(MouseEvent.MOUSE_MOVE,this.moveListener);
			super.addListeners(e);
		}
		
		//Augments the parent destroyListener call to destroy unique listeners
	    override public function destroyListeners(e:Event):void{
			this.removeEventListener(MouseEvent.MOUSE_MOVE,this.moveListener);
			super.destroyListeners(e);
		}
		
		//Reduced-interval timer used to move AI peices.
		public function secondaryTimerListener():void{
			this.parentPanel.updateProductionQueueView(this.focalWorld.plCapitol);
			for(var ct:int=0;ct<this.focalWorld.decArray.length;ct++){
				var tempDEC:DualEnvironmentContainer= (this.focalWorld.decArray[ct] as DualEnvironmentContainer);
				if(tempDEC.ownerID ==1){
					if(tempDEC.AIModule!=null){
						 tempDEC.AIModule.act(this.focalWorld);
						 if(tempDEC.AIModule.contactedTarget){
							 this.contactListener(tempDEC,tempDEC.target);
							 this.backoutCity(tempDEC);
						 }
					}
					if(tempDEC.spawnCt > tempDEC.spawnThreshold/Global.Difficulty){
						if(tempDEC.focusObj.tArray.length ==0){
							tempDEC.spawnCt=-1;
							this.parentPanel.replenishEnemyCity(tempDEC);
							trace("Spawning new set at city");
						}
					}else{
						tempDEC.spawnCt++;
					}
				}
			}
		}
		
		//Override with empty function, for we don't want the user to move DEC's
		override public function public function myBoardListener(e:KeyboardEvent){
		}
		
		}
		
		//Primary timer listener, called from the containerPane
		override public function viewTimerListener():void{
				this.focalWorld.plCapitol.updateCap();
				
				this.currentCycle++;
				if(this.currentCycle > this.cycleTime){
					this.currentCycle=0;
					this.secondaryTimerListener();
				}
				var friendDecArrayCount=0;
				for(var count:int=0;count<this.focalWorld.decArray.length;count++){
					(this.focalWorld.decArray[count] as DualEnvironmentContainer).update();
					if((this.focalWorld.decArray[count] as DualEnvironmentContainer).ownerID==0){
						friendDecArrayCount++;
					}
						  
				}//For
				if(friendDecArrayCount==0){
					this.parentPanel.alert(350,300,"Defeat","You have lost :(",this.parentPanel.endGame);
				}
			
		}//Timer listener
	}
}