/*
Class:MCEntity
Description:
Parent class for all entities in the game

Alexander Ross
CS427-SPR2012-SWAG GAMES

Package declaration and imports:
*/

package classes{
	import flash.geom.Point;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.MouseEvent;
	import classes.spriteMC.SelectorBracket;
	import classes.entity.dualEnvironment.DualEnvironmentContainer;
	import classes.entity.dualEnvironment.Transport;

	public class MCEntity extends MovieClip{
		
		
		public var traceMovement:Boolean = true;
		
		public var isInventory:Boolean;
		public var labelStr:String, health:int=100,refX:Number,refY:Number;
		public var centerX:int, centerY:int,movementVectX:int=-100,movementVectY:int=0;
		public var ATagility:int=5;
		public var moved:Boolean;
		public var size:int=0,ownerID:int=0,traceNum:int=1,traceInit:int=1;
		public var selectionBracket:SelectorBracket = new SelectorBracket(); 
		public var focus:Boolean=false, globalFocus:Boolean=false;
		public var stgWidth:int=1400,stgHeight:int=900; //Dimension of backing image,used for bounds checking
		public var ownerString="";
		private var dotArray:Array = new Array();
		
		
		public function MCEntity(refXIn:int,refYIn:int):void{
			this.size = 0; 
			this.refX=refXIn;
			this.refY=refYIn;
			trace("RDI x:"+this.x+"y:"+this.y+"rX:"+this.refX+"rY:"+this.refY);
			this.addEventListener(MouseEvent.MOUSE_OVER,indicateSelector);
			this.addEventListener(MouseEvent.ROLL_OUT,removeSelector);
			this.addChild(selectionBracket); 
			this.selectionBracket.visible=false;
		}
		
		//Calculate distance to a particular point.
		public function calcDistance(target:Point):Number{
			var LTGtemp:Point=new Point(this.refX,this.refY);
			return Math.sqrt(Math.pow((target.y-LTGtemp.y),2)+Math.pow((target.x-LTGtemp.x),2));
		}

		//Draw a shape, used to trace movement of an entity
		public function drawEntity(newShape:Boolean,intX:int=-1,intY:int=-1):void{
			   if((this as DualEnvironmentContainer).ghost != null){
					(this as DualEnvironmentContainer).ghost.graphics.beginFill(0xFF0000);
					if(intY >=-1000){		
						(this as DualEnvironmentContainer).ghost.graphics.drawCircle(intX,intY,2);
					}else{
						this.graphics.drawCircle(this.x,this.y,2);
					}
					(this as DualEnvironmentContainer).ghost.graphics.endFill();
			   }
		}
		

		//Move entity with it's defined movement vector
		public function moveEnt(xVec:int,yVec:int):Boolean{
				var xChg:Number = (xVec/100)*this.ATagility/2; 
				var yChg:Number = (yVec/100)*this.ATagility/2;
				if((this.x+xChg > this.stgWidth || this.x+xChg < 0 || this.y+yChg >this.stgHeight || this.y+yChg < 0) && (this as DualEnvironmentContainer)==null){
					return false;
				}else{
					this.moved = true;
					this.refX+=xChg;
					this.refY+=yChg;
					
					if((this as DualEnvironmentContainer)!=null){
						if((this as DualEnvironmentContainer).ghost !=null){//It's a city, we only want it's ghost to draw the line.
							(this as DualEnvironmentContainer).drawEntity(false,this.refX-this.x,this.refY-this.y);
						}else{//It's a transport
							this.x=this.refX;
							this.y=this.refY;
						}
						
					}else{
						this.x=this.refX;
						this.y=this.refY;
					}
					
					return true
				}
		}
		
		//Indicate the entity being selected with a permanent selection bracket
		private function indicateSelector(e:MouseEvent):void{
			this.focus=true;
			this.selectionBracket.visible=true;
		}

		//Demote the entity's selection status
		private function removeSelector(e:MouseEvent):void{
			if(!this.globalFocus){
			this.selectionBracket.visible=false;
			}
			this.focus=false;
		}
		
		//Demote the entity's selection status
		public function demoteSelection():void{
			this.globalFocus=false;
			this.selectionBracket.visible=false;
		}
		
		//Partial marking of selection
		public function markSelected():void{
			this.globalFocus=true;
		}

		//Getter for selection
		public function isSelected():Boolean{
			return this.focus;
		}
		
		//Resolve the entites x-coordinate on the entire stage
		public function resolveAbsX():int{
			return this.localToGlobal(new Point()).x; 
		}
		
		//Resolve the entites y-coordinate on the entire stage
		public function resolveAbsY():int{
			return this.localToGlobal(new Point()).y; 
		}
	}
}