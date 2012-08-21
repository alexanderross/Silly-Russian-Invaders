/*
Class:CityStatus
Description:Window used in OpenView to reflect the status of the battle.
Alexander Ross
CS427-SPR2012-SWAG GAMES

Package declaration and imports:
*/
package classes.Views.windows {
	
	import flash.display.MovieClip;
	import classes.entity.dualEnvironment.City;
	import classes.entity.HCE;
	
	
	public class CityStatus extends MovieClip {
		
		
		public function CityStatus(nameI:String) {
			this.nameText.text=nameI;
		}
		public function update(eStrength:int,fStrength:int,outLk:Number,health:int){
			outLk=Math.round((outLk*100));
			this.friendliesText.text=fStrength+"";
			this.baddiesText.text=eStrength+"";
			this.hBar.width = 177*(health/100);
			this.outlookText.text=outLk+"% :";
			//After computing an outlook percentage, attach a certain range to a verbal representation.
			if(outLk > 90){
				this.outlookText.appendText("Safe");
			}else if(outLk >70 && outLk<=90){
				this.outlookText.appendText("Good");
			}else if(outLk >50 && outLk<=70){
				this.outlookText.appendText("Acceptable");
			}else if(outLk == 50){
				this.outlookText.appendText("Neutral");
			}else if(outLk >30 && outLk<50){
				this.outlookText.appendText("Bleak");
			}else if(outLk >10 && outLk<=30){
				this.outlookText.appendText("Dismal");
			}else{
				this.outlookText.appendText("Hopeless");
			}
		}
	}
	
}
