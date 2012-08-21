package classes.entity.dualEnvironment{
	import classes.MCEntity;
	import classes.EnvironmentMatrix;
    import classes.Entity;
	import classes.EnvironmentMatrix;
	import classes.entity.*;
	import flash.geom.Point;
	import classes.entity.HCE;
	import classes.entity.HCE.tank.*;
	import classes.entity.HCE.artillery;
	import classes.entity.HCE.artillery.*;
	import classes.entity.HCE.tank;
	import classes.spriteMC.CraterExplosionSprite;	
	import classes.spriteMC.CityScape;
	import classes.entityAttribute.AttributeSets.CityAttributes;

	public class City extends MCEntity{
		public var tArray:Array = new Array();
		public var aArray:Array = new Array();
		public var myBackground:CityScape;
		public var myCityAttributes:CityAttributes = new CityAttributes();
		public var targetAnchor:HCE;
		public var ownerName:String;
		
		public function City(nameL:String,backgroundI:CityScape,owner:int):void{
			super(0,0);
			this.myBackground = backgroundI;
			this.labelStr = nameL;
			var mySelected:tank;
			this.targetAnchor = new HCE(600,300,owner);
			this.targetAnchor.ATstrength=20;
		}
		/*
		public function joinAttributes(newAttr:CityAttributes):Boolean{
			for(var cta:int=0;cta<this.myCityAttributes.HCEAttribs.length;cta++){
				for(var attrIndex:int=0;attrIndex<HCEAttribs[cta][1].length;attrIndex++){
					this.myCityAttributes.HCEAttribs[cta][1][0] |= newAttr.HCEAttribs[cta][1][attrIndex];
				}
			}//City Attrib loop
			this.applyHCEAttributes();
			return true;
		}
		*/
		
		public function applyHCEAttributes(onlyHealth:Boolean = false):void{
			for(var cto:int=0;cto<this.numChildren;cto++){
				try{
					var tempHCE:HCE = this.getChildAt(cto) as HCE;
					if(!onlyHealth){
						for(var cta:int=0;cta<this.myCityAttributes.HCEAttribs.length;cta++){
								if(!(tempHCE.ATTRIBint & Math.pow(2,cta))){ //HASNT BEEN APPLIED.
									tempHCE.ATTRIBint |=  Math.pow(2,cta);
									tempHCE.ATrange+=this.myCityAttributes.HCEAttribs[cta][1][0];
									tempHCE.ATaccuracy+=this.myCityAttributes.HCEAttribs[cta][1][1];
									tempHCE.ATfireInterval-=this.myCityAttributes.HCEAttribs[cta][1][2];
									tempHCE.ATdamage+=this.myCityAttributes.HCEAttribs[cta][1][3];
									tempHCE.ATstrength+=this.myCityAttributes.HCEAttribs[cta][1][4];
									tempHCE.ATagility+=this.myCityAttributes.HCEAttribs[cta][1][5];
									tempHCE.ATbuildTime+=this.myCityAttributes.HCEAttribs[cta][1][6];
									tempHCE.ATcost+=this.myCityAttributes.HCEAttribs[cta][1][7];
								
								}//IF
						}//for
					}//If only health
					else{
						tempHCE.health=100;
					}
				}catch(e:Error){
					
				}//catch
			}//for
		}//fnc
		
		public function getTankHealthPct():Number{
			var runHealth:int=0;
			var i:int=0;
			for(i=0;i<this.tArray.length;i++){
				runHealth+= (this.tArray[i] as tank).health;
			}
			return (runHealth as Number) / ((i));
		}
		
		public function joinTArrays(nextTArray:Array):void{
			for(var i:int=0;i<this.tArray.length;i++){
				(this.tArray[i] as HCE).refX = 630;
				(this.tArray[i] as HCE).refY = (i)*(600/this.tArray.length+3);
				(this.tArray[i] as HCE).movementVectX=-100;
				(this.tArray[i] as HCE).movementVectY=0;
			}
			for(i=0;i<nextTArray.length;i++){
				this.tArray.push(nextTArray[i] as HCE);
				(nextTArray[i] as HCE).refX = 70;
				(nextTArray[i] as HCE).refY = (i)*(600/nextTArray.length+3);
			}
			trace("Joined arrays");
		}
		
		public function removeTank(index:int):void{
			var tempArray:Array = new Array();
			for(var cto:int=0;cto<this.tArray.length;cto++){
				if(cto!=index){
					tempArray.push(this.tArray[cto]);
				}
			}
			this.tArray=tempArray;
		}
	}
}