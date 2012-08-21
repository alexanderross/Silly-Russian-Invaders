/*
Class:RandomNameGen
Description:
Returns random city or military leader names, and tracks their use to avoid duplicate uses.

Alexander Ross
CS427-SPR2012-SWAG GAMES

Package declaration and imports:
*/

package classes.Controller{
	public class RandomNameGen{
		private var GeoNameArray:Array;
		private var PersonNameArray:Array;
		
		public function RandomNameGen():void{
			this.GeoNameArray = new Array();
			this.GeoNameArray.push(new Array("New York",false));
			this.GeoNameArray.push(new Array("Los Angeles",false));
			this.GeoNameArray.push(new Array("Chicago",false)); 
			this.GeoNameArray.push(new Array("Houston",false)); 
			this.GeoNameArray.push(new Array("Phoenix",false)); 
			this.GeoNameArray.push(new Array("Philadelphia",false)); 
			this.GeoNameArray.push(new Array("San Antonio",false)); 
			this.GeoNameArray.push(new Array("San Diego",false)); 
			this.GeoNameArray.push(new Array("Dallas",false)); 
			this.GeoNameArray.push(new Array("San Jose",false)); 
			this.GeoNameArray.push(new Array("Detroit",false)); 
			this.GeoNameArray.push(new Array("Jacksonville",false)); 
			this.GeoNameArray.push(new Array("Indianapolis",false));
			this.GeoNameArray.push(new Array("San Francisco",false)); 
			this.GeoNameArray.push(new Array("Columbus",false)); 
			this.GeoNameArray.push(new Array("Austin",false)); 
			this.GeoNameArray.push(new Array("Memphis",false)); 
			this.GeoNameArray.push(new Array("Fort Worth",false)); 
			this.GeoNameArray.push(new Array("Baltimore",false)); 
			this.GeoNameArray.push(new Array("Charlotte",false)); 
			this.GeoNameArray.push(new Array("El Paso",false)); 
			this.GeoNameArray.push(new Array("Boston",false)); 
			this.GeoNameArray.push(new Array("Seattle",false)); 
			this.GeoNameArray.push(new Array("Washington",false)); 
			this.GeoNameArray.push(new Array("Milwaukee",false)); 
			this.GeoNameArray.push(new Array("Denver",false)); 
			this.GeoNameArray.push(new Array("Louisville",false));
			this.GeoNameArray.push(new Array("Las Vegas",false)); 
			this.GeoNameArray.push(new Array("Nashville",false)); 
			this.GeoNameArray.push(new Array("Oklahoma City",false)); 
			this.GeoNameArray.push(new Array("Portland",false)); 
			this.GeoNameArray.push(new Array("Tucson",false)); 
			this.GeoNameArray.push(new Array("Albuquerque",false)); 
			this.GeoNameArray.push(new Array("Atlanta",false)); 
			this.GeoNameArray.push(new Array("Long Beach",false)); 
			this.GeoNameArray.push(new Array("Fresno",false)); 
			this.GeoNameArray.push(new Array("Sacramento",false)); 
			this.GeoNameArray.push(new Array("Mesa",false)); 
			this.GeoNameArray.push(new Array("Kansas City",false)); 
			this.GeoNameArray.push(new Array("Cleveland",false)); 
			this.GeoNameArray.push(new Array("Virginia Beach",false)); 
			this.GeoNameArray.push(new Array("Omaha",false)); 
			this.GeoNameArray.push(new Array("Miami",false)); 
			this.GeoNameArray.push(new Array("Oakland",false)); 
			this.GeoNameArray.push(new Array("Tulsa",false)); 
			this.GeoNameArray.push(new Array("Honolulu",false)); 
			this.GeoNameArray.push(new Array("Minneapolis",false)); 
			this.GeoNameArray.push(new Array("Colorado Springs",false)); 
			this.GeoNameArray.push(new Array("Arlington",false)); 
			this.GeoNameArray.push(new Array("Wichita",false)); 
			this.GeoNameArray.push(new Array("Raleigh",false)); 
			this.GeoNameArray.push(new Array("St. Louis",false)); 
			this.GeoNameArray.push(new Array("Santa Ana",false)); 
			this.GeoNameArray.push(new Array("Anaheim",false)); 
			this.GeoNameArray.push(new Array("Tampa",false)); 
			this.GeoNameArray.push(new Array("Cincinnati",false)); 
			this.GeoNameArray.push(new Array("Pittsburgh",false));
			this.GeoNameArray.push(new Array("Bakersfield",false)); 
			this.GeoNameArray.push(new Array("Aurora",false)); 
			this.GeoNameArray.push(new Array("Toledo",false)); 
			this.GeoNameArray.push(new Array("Riverside",false)); 
			this.GeoNameArray.push(new Array("Stockton",false)); 
			this.GeoNameArray.push(new Array("Corpus Christi",false)); 
			this.GeoNameArray.push(new Array("Newark",false)); 
			this.GeoNameArray.push(new Array("Anchorage",false));
			this.GeoNameArray.push(new Array("Buffalo",false));
			this.GeoNameArray.push(new Array("St. Paul",false)); 
			this.GeoNameArray.push(new Array("Lexington-Fayette",false));
			this.GeoNameArray.push(new Array("Plano",false));
			
			this.PersonNameArray = new Array();
			this.PersonNameArray.push(new Array("Peter The Great",false));
			this.PersonNameArray.push(new Array("Alexander Menshikov",false));
			this.PersonNameArray.push(new Array("Boris Sheremetev",false));
			this.PersonNameArray.push(new Array("Grigory Potemkin",false));
			this.PersonNameArray.push(new Array("Pyotr Rumyantsev",false));
			this.PersonNameArray.push(new Array("Pyotr Saltykov",false));
			this.PersonNameArray.push(new Array("Mikhail Kutuzov",false));
			this.PersonNameArray.push(new Array("Mikhail Miloradovich",false));
			this.PersonNameArray.push(new Array("Pavel Nakhimov",false));
			this.PersonNameArray.push(new Array("Ivan Paskevich",false));
			this.PersonNameArray.push(new Array("Mikhail Skobelev",false));
			this.PersonNameArray.push(new Array("Fyodor Ushakov",false));
		}
		
		public function getCityName():String{
			var choice:int = Math.random()*this.GeoNameArray.length;
			if(this.GeoNameArray[choice][1]){//taken already
				return this.getCityName();
			}else{
				this.GeoNameArray[choice][1]=true;
				return this.GeoNameArray[choice][0];
			}
			
		}
		
		public function getCharName():String{
			var choice:int = Math.random()*this.PersonNameArray.length;
			if(this.PersonNameArray[choice][1]){//taken already
				return this.getCharName();
			}else{
				this.PersonNameArray[choice][1]=true;
				return this.PersonNameArray[choice][0];
			}
			
		}
	}
}