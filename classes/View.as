/*
Class:View 
Description:
Parent for OpenView and WorldView
Alexander Ross
CS427-SPR2012-SWAG GAMES

Package declaration and imports:
*/

package classes{
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import classes.Views.OpenView;
	import classes.Views.ContainerPane;

	public class View extends MovieClip{
		public var pressedKeys:Array = new Array();//Track pressed keys
		public var mouseIsDown:Boolean = false;//Boolean if mouse is down, important to WorldView
		public var mouseAura:selectorAura;// Selection Aura
		public var focalObj:MCEntity;//Object currently selected
		//Hacks
		private var MVI:int=10;
		public var prevView:View;//View preceeding this one, important for transition
		public var parentPanel:ContainerPane;//Tracker to call the container pane directly
		
		
		public function View(interval:int){
			this.mouseAura=new selectorAura();
			for(var i=0;i<222;i++){//Initialize the pressed button array
				this.pressedKeys.push([i,false]);
				this.pressedKeys[i]=false;
			}	
			this.addEventListener(Event.ADDED_TO_STAGE,this.addListeners);
			this.addEventListener(Event.REMOVED_FROM_STAGE,this.destroyListeners);
		}
		//Add key listeners
		public function addListeners(e:Event):void{			
			stage.addEventListener(KeyboardEvent.KEY_DOWN,this.myBoardListener);
			stage.addEventListener(KeyboardEvent.KEY_UP,this.myBoardListenerRelease);
			
		}
		//Destroy listeners, important to avoid scope problems
		public function destroyListeners(e:Event):void{
			stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.myBoardListener);
			stage.removeEventListener(KeyboardEvent.KEY_UP,this.myBoardListenerRelease);
		}
		
		public function setObjectMVI(input:int):void{
			this.MVI = input;
		}
		//Inset an object into the view, and make sure it's actual x and y match it's simulated.
		public function insertObject(insert:DisplayObject):void{
			var tempPt:MCEntity = insert as MCEntity; 
			this.addChild(tempPt);
			tempPt.x=tempPt.refX;
			tempPt.y=tempPt.refY;
		}
		//Switch back the the view in the prevView attribute
		public function revertView():void{
			this.switchViews(this.prevView);
		}
		
		//Switch to a provided view
		public function switchViews(newView:View):void{
				var tempView:View= newView;// Set to be able to return back
				tempView.parentPanel = this.parentPanel;
				tempView.parentPanel.contained=tempView;//Update the pane's contained view
				tempView.prevView=this;
				this.parentPanel.notifyViewChange();//Notify the container of a view change
				this.parentPanel.viewHolder.removeChild(this);//Remove this instance from the stage
				this.parentPanel.viewHolder.addChild(tempView);//Add the new instance to the stage
				this.parentPanel.primaryTimer.start();//re-start the timer on the container pane
		}
	
		
		//Board listener, on release switch the entry for that key in the dictionary to false
		public function myBoardListenerRelease(e:KeyboardEvent){
			this.pressedKeys[e.keyCode]=false;
		}
		
		//Use the keys, or combinations of the keys to move a focal object, if that object exists.
		public function myBoardListener(e:KeyboardEvent){
			this.pressedKeys[e.keyCode]=true;
			if(e.keyCode > 36 && e.keyCode < 41){
				if(this.focalObj!=null){
					if(pressedKeys[37] && pressedKeys[38])focalObj.moveEnt(-50,-50);	
					else if(pressedKeys[38] && pressedKeys[39])  focalObj.moveEnt(50,-50);
					else if(pressedKeys[39] && pressedKeys[40])  focalObj.moveEnt(50,50);
					else if(pressedKeys[37] && pressedKeys[40])  focalObj.moveEnt(-50,50);
					else {
						if(e.keyCode==37) focalObj.moveEnt(-100,0);
						if(e.keyCode==38) focalObj.moveEnt(0,-100);
						if(e.keyCode==39) focalObj.moveEnt(100,0);
						if(e.keyCode==40) focalObj.moveEnt(0,100);
					}//Keycode is R1 Vector (ELSE of R2 vector)
				}//A focalobject is non null
			}
			//-----------------------------------------
		}
		
		//Empty, overrided in used children classes
		public function myMouseListenerDN(e:MouseEvent){
		   
		}
		
		//While never used, important to have if a low-scoped message must be thrown
		public function alert(xIn:int,yIn:int,pT:String,sT:String,targetFn:Function):void{
			this.parentPanel.alert(xIn,yIn,pT,sT,targetFn);
		}
	}
}