/*
Class:Player
Description:
Data object that tracks players progress and checks/processes cash transactions

Alexander Ross
CS427-SPR2012-SWAG GAMES

Package declaration and imports:
*/

package classes.Controller{
	import classes.Global;
	public class Player{
		
		public var cash:int=0, amtSpent:int=0, cashSpentOnCities:int=0, cashSpentOnUnits:int=0;
		public var survivalTime:int=1, unitsDestroyed:int=0, unitsBought:int=0, citiesBought:int=0;
		public var citiesLost:int=0, unitsLost:int=0;
		public var battlesWon:int=0;
		
		public function Player(){
			this.cash=(11-Global.Difficulty)*1500;
		}
		
		public function addSurvivalTime():void{
			this.survivalTime+=1;
			this.cash+=Global.Difficulty;
		}
		
		public function addUnitDestroyed(unitCost:int):void{
			this.unitsDestroyed++;
			this.cash+=unitCost+ (10*Global.Difficulty);
		}
		
		public function addCityLost():void{
			this.citiesLost++;
			this.cash-=10*Global.Difficulty;
		}
		
		public function addCityDefended():void{
			this.battlesWon++;
			this.cash+=10*Global.Difficulty;
		}
		
		public function addUnitLost():void{
			this.unitsLost++;
			this.cash-=Global.Difficulty;
		}
		
		public function canBuyObject(cost:int):Boolean{
			if(cost > this.cash){
				return false;
			}
			return true;
		}
		
		public function buyObject(cost:int, type:String):Boolean{
			if(cost < this.cash){
				if(type=="CITY"){
					this.cashSpentOnCities+=cost;
					this.citiesBought++;
				}else if(type=="UNIT"){
					this.cashSpentOnUnits+=cost;
					this.unitsBought++;
				}else{
					this.amtSpent+= cost;
				}
				this.amtSpent+=cost;
				this.cash-=cost;
				return true;
			}else{ 
				return false;
			}
		}
	}
}