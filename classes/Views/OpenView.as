/*
Class:OpenView
Description:
Visual class for the OpenView standpoint, which shows the individual battles at each city
Alexander Ross
CS427-SPR2012-SWAG GAMES

Package declaration and imports:
*/

package classes.Views{
	import flash.utils.Timer;
	import classes.selectorAura;
	import classes.entity.dualEnvironment.City;
	import classes.entity.HCE.tank;
	import classes.entity.HCE;
	import flash.display.DisplayObject;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import classes.spriteMC.CraterExplosionSprite;
	import classes.MCEntity;
	import classes.View;
	import classes.entity.AI.AIHCE;
	import classes.Views.windows.entityDisplay;
	import classes.Views.windows.CityStatus;
	import flash.events.Event;

	public class OpenView extends View{
		
		public var focalCity:City;
		var viewBar:CityStatus;
		var enemyTanks:int=0,friendlyTanks:int=0,winProb:Number=0;
		var statusCode:int=0;
		
		
		public function OpenView(focalCityI:City):void{
			super(40);
	        this.loadCity(focalCityI);
		}
		
		override public function addListeners(e:Event):void{
			this.addEventListener(MouseEvent.MOUSE_MOVE,myMouseMover);
			this.addEventListener(MouseEvent.MOUSE_UP,myMouseListenerUP); 
			super.addListeners(e);
		}
		
		override public function destroyListeners(e:Event):void{
			this.removeEventListener(MouseEvent.MOUSE_MOVE,myMouseMover);
			this.removeEventListener(MouseEvent.MOUSE_UP,myMouseListenerUP);
			super.destroyListeners(e);
		}
		
		//Load a city data object into the view, adding it's contained objects to the stage
		public function loadCity(focalCityI:City):void{
			this.focalCity = focalCityI;
			while(this.numChildren!=0){ // Kill the children
				this.removeChildAt(0);
			}
			this.addChild(focalCity.myBackground);
			this.addChild(mouseAura);
			for(var i:int=0;i<this.focalCity.tArray.length;i++){
				this.insertObject(this.focalCity.tArray[i]); 
				(this.focalCity.tArray[i] as HCE).initializeAI();
			}
			for(i=0;i<this.focalCity.tArray.length;i++){
				this.insertObject(this.focalCity.tArray[i]); 
			}
			this.viewBar = new CityStatus(focalCity.labelStr);
			this.addChild(this.viewBar);
			this.viewBar.y=575;
			
		}

		//Remove an entity from the stage, and remove it from the data object's tank array
		public function removeEnt(ent:MCEntity,index:int):void{
			this.focalCity.removeTank(index);
			this.parentPanel.notifyDestroyed("TANK",ent.ownerID,(ent as HCE).ATcost);
			this.removeChild(ent);
			this.addChildAt(new CraterExplosionSprite(ent.refX,ent.refY,1),1);
		}
		
		override public function myBoardListener(e:KeyboardEvent){
			this.pressedKeys[e.keyCode]=true;
			if(e.keyCode > 36 && e.keyCode < 41){
				if(this.focalObj!=null){
					if(pressedKeys[37] && pressedKeys[38])(focalObj as HCE).move(-.5,-.5);	
					else if(pressedKeys[38] && pressedKeys[39])  (focalObj as HCE).move(.5,-.5);
					else if(pressedKeys[39] && pressedKeys[40])  (focalObj as HCE).move(.5,.5);
					else if(pressedKeys[37] && pressedKeys[40])  (focalObj as HCE).move(-.5,.5);
					else {
						if(e.keyCode==37) (focalObj as HCE).move(-1,0);
						if(e.keyCode==38) (focalObj as HCE).move(0,-1);
						if(e.keyCode==39) (focalObj as HCE).move(1,0);
						if(e.keyCode==40) (focalObj as HCE).move(0,1);
					}//Keycode is R1 Vector (ELSE of R2 vector)
				}//A focalobject is non null
			}
			//-----------------------------------------
		}
		
		/*Listen for a click, essentially. If ctrl is held and a tank is selected, fire. If shift is held while clicking a tank, 
		the tank's attributes are shown, and the timer is stopped. If no key is pressed, and the tank belongs to the player, that tank
		is selected.
		*/
		public function myMouseListenerUP(e:MouseEvent){
		  this.mouseIsDown=false;
		  this.mouseAura.click();
		  var selIndex:int = -1; // Save a selected index.
		  var tempFocus:HCE;
		  for(var iC:int=0;iC<this.focalCity.tArray.length;iC++){
			  tempFocus=(this.focalCity.tArray[iC] as HCE);
			  if(tempFocus.isSelected() && !tempFocus.globalFocus){
				  selIndex = iC;
			  }
		  }
		  if(selIndex >=0){	
		  	var Ttarget:HCE = (this.focalCity.tArray[selIndex] as HCE);
		    if(this.pressedKeys[16]){//Shift
				this.parentPanel.halt(2);
				this.addChild(new entityDisplay(Ttarget,this.focalCity.myCityAttributes));
			}
		    else if(this.pressedKeys[17]==true){//ctrl
			  if((this.focalObj as tank)!=null){
				if((this.focalObj as tank).ownerID!=Ttarget.ownerID){
					if((this.focalObj as tank).fire()){
						if((focalObj as tank).calculateShot(Ttarget)){
							Ttarget.damage((this.focalObj as tank).ATdamage);
						}//CALCSHOT
					}//fire
				}//ID=

			  }//fTank not null
			}else{// pressed ctrl
				for(iC=0;iC<this.focalCity.tArray.length;iC++){
					tempFocus=(this.focalCity.tArray[iC] as HCE);
					tempFocus.demoteSelection();
					if(iC==selIndex){
						tempFocus.markSelected();
						this.focalObj =tempFocus as tank;
						if((focalObj as tank).AIModule!=null){
							(focalObj as tank).AIModule=null;
							(focalObj as tank).AIPause=true;
						}
						
					}
				}
			}
		  }else{
			  if((this.focalObj as tank)!=null){
				if((this.focalObj as tank).fire()){
				    this.addChildAt(new CraterExplosionSprite(e.stageX,e.stageY,1),1);
				}
			  }
		  }
		  trace("");
		}
		
		//Trace mouse movement and update the position of the selectionAura
		public function myMouseMover(e:MouseEvent){
			if(this.mouseIsDown){
				//this.environmentMatrix.addToMatrix(new barrierEntity(e.stageX,e.stageY,0,0,2),e.stageX,e.stageY,false);
			}else{
				if((this.focalObj as tank)!=null){
					(this.focalObj as tank).rotateTurretToStagePt(e.stageX,e.stageY);
				}
				 this.mouseAura.x = e.stageX-(this.mouseAura.width/2);
				 this.mouseAura.y = e.stageY-(this.mouseAura.height/2);
			}
		}
		
		//Return a strength assesment number for a particular tank(HCE)
		public function strengthNumber(temp:HCE):int{
			return temp.health*(temp.ATdamage+temp.ATaccuracy+temp.ATstrength);
		}
		
		//Listen for a window closing, revert views after event handled.
		public function windowCloseListener(e:Event):void{
			this.revertView();
		}
		
		//For an update with the timer, update each unit's AI, and re-evaluate calcualtions and status.
		override public function viewTimerListener():void{
			
			//environmentMatrix.spreadEntity();
			if(this.statusCode==-1 ){
				trace("Status==0");
				this.parentPanel.halt(0);
			}else{
				this.enemyTanks=0;
				this.friendlyTanks=0;
				var fRat:int=0;
				var eRat:int=0;
				for(var count:int=0;count<this.focalCity.tArray.length;count++){
					     var tTank:HCE = (this.focalCity.tArray[count] as HCE);
						 if(tTank.ownerID == this.focalCity.ownerID){
							 friendlyTanks++;
							 fRat+=this.strengthNumber(tTank); 
						 }else{
							 enemyTanks++;
							 eRat+=this.strengthNumber(tTank);  
						 }
						 tTank.update(this.focalCity);
						
						 if(tTank.health <= 0){
							 this.removeEnt(this.focalCity.tArray[count],count);
							 trace("BOOM");
						 }
						  
				}//For
				var tVal:Number= fRat/(fRat+eRat);
				this.viewBar.update(enemyTanks,friendlyTanks,(tVal),this.focalCity.targetAnchor.health);
				if(tVal==0){
					this.statusCode=1;
					this.parentPanel.alert(300,300,"DEFEAT!",this.focalCity.labelStr+" Has fallen!",this.windowCloseListener);
					this.parentPanel.notifyCity(0);
					this.statusCode=-1;
					
				}else if(tVal==1){
					this.statusCode=-1;
					this.parentPanel.alert(300,300,"VICTORY",this.focalCity.labelStr+" Is safe.. for now...",this.windowCloseListener);
					this.parentPanel.notifyCity(1);
				}
			}
		}
		
	}
}