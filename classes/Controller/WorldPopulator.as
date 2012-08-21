/*
Class:WorldPopulator
Description:
Creates data objects from scratch to populate the game.
Alexander Ross
CS427-SPR2012-SWAG GAMES

Package declaration and imports:
*/

package classes.Controller{
	
	import classes.Views.*;

	import classes.entity.dualEnvironment.City;
	import classes.spriteMC.CitySkin.GrassSkin;
	import classes.entity.AI.AIHCE;
	import classes.entity.HCE.tank.Abrams;
	import classes.entity.HCE.tank.Challenger;
	import classes.entity.HCE;
	import classes.entity.HCE.tank.BlackEagle;
	
	import classes.entity.dualEnvironment.WorldDE;
	import classes.entity.dualEnvironment.DualEnvironmentContainer;
	
	import classes.MCEntity;
	import classes.entity.dualEnvironment.Capitol;
	import classes.spriteMC.CitySkin.DesertSkin;
	import fl.motion.AdjustColor;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import fl.motion.Color;
	import classes.Global;

	public class WorldPopulator{
		public var enemyName:String="";
		private var generator:RandomNameGen;
		
		public function WorldPopulator():void{
			this.generator=new RandomNameGen();
			this.enemyName= generator.getCharName();
		}
		
		public function returnInitialEnvironment():WorldDE{
			var myCap = new Capitol(1300,Math.random()*900);
			var myWorld:WorldDE = new WorldDE(myCap);
			// an id of 1 is the enemy. 
			for(var k:int=0;k<Global.Difficulty;k++){
				myWorld.addDEC(this.returnCityDEC(0,Global.PlrName,10-(Global.Difficulty/2)));
			}
			myWorld.addDEC(this.returnCityDEC(1,this.enemyName,Global.Difficulty));
						   
			return myWorld;

		}//FNC
		
		public function getNewHCEArrayEnemy(){
			var tintColour:Color = new Color();
				tintColour.setTint(0xFF0000,.1);
			var returnArray= new Array();
			for (var t:int=0;t<Global.Difficulty;t++){
						var rn:int = 10-Math.round(Math.random()*Global.Difficulty);
							if(rn<3){
							returnArray.push(new Abrams((Math.random()*600)+100,(Math.random()*500)+100,this.enemyName,1));
							}
							if(rn>=3 && rn<=8){
							returnArray.push(new Challenger((Math.random()*600)+100,(Math.random()*500)+100,this.enemyName,1));
							}
							if(rn > 8){
							returnArray.push(new BlackEagle((Math.random()*600)+100,(Math.random()*500)+100,this.enemyName,1));
							}
						(returnArray[t] as HCE).transform.colorTransform = tintColour;
						
				}
				return returnArray;
		}
											 
		
		public function getNewHCEArray(owner:int,ownerName:String,numberTanks:int,tint:Color):Array{
			var returnArray= new Array();
			for (var t:int=0;t<numberTanks;t++){
						var rn:int = 10-Math.round(Math.random()*Global.Difficulty);
						if(owner == 0){
							if(rn>8){
							returnArray.push(new Abrams((Math.random()*600)+100,(Math.random()*500)+100,ownerName,owner));
							}
							if(rn>=3 && rn<=8){
							returnArray.push(new Challenger((Math.random()*600)+100,(Math.random()*500)+100,ownerName,owner));
							}
							if(rn < 3){
							returnArray.push(new BlackEagle((Math.random()*600)+100,(Math.random()*500)+100,ownerName,owner));
							}
						}else{
							if(rn<3){
							returnArray.push(new Abrams((Math.random()*600)+100,(Math.random()*500)+100,ownerName,owner));
							}
							if(rn>=3 && rn<=8){
							returnArray.push(new Challenger((Math.random()*600)+100,(Math.random()*500)+100,ownerName,owner));
							}
							if(rn > 8){
							returnArray.push(new BlackEagle((Math.random()*600)+100,(Math.random()*500)+100,ownerName,owner));
							}
						}
						
						(returnArray[t] as HCE).initializeAI(owner);
						if(owner == 1){
							(returnArray[t] as HCE).transform.colorTransform = tint;
						}
				}
				return returnArray;
		}
		
		public function returnCityDEC(owner:int,ownerName:String,numTanks:int,xIN:int=-1,yIN:int=-1):DualEnvironmentContainer{
				var myCity1:City;
				//Make a filter to make enemy things red-ish.
				var tintColour:Color = new Color();
				tintColour.setTint(0xFF0000,.1);

					trace("Making city for "+ownerName+", "+numTanks+" Tanks requested.");
					if(Math.random()*4 <=2){
						myCity1 = new City(this.generator.getCityName(),new DesertSkin(),owner);
					}else{
						myCity1 = new City(this.generator.getCityName(),new GrassSkin(),owner);
					}
					myCity1.ownerName = ownerName;
					myCity1.tArray = this.getNewHCEArray(owner,ownerName,numTanks,tintColour);
					
					var testDEC:DualEnvironmentContainer;
					
					if(owner ==0){
						if(xIN > 0){
							testDEC = new DualEnvironmentContainer(xIN,yIN,myCity1);
						}else{	
							testDEC = new DualEnvironmentContainer(Math.random()*800+400,Math.random()*700+100,myCity1);
						}
					}else{
						testDEC = new DualEnvironmentContainer(Math.random()*100 + 50,Math.random()*700,myCity1);
						testDEC.initializeAI(1);
						testDEC.transform.colorTransform = tintColour;
					}
					testDEC.ownerID = owner;
					testDEC.ownerString= ownerName;
					
					return testDEC;
		    }
	    }
	}
