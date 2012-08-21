/*
Class:entityDisplay
Description:
Display the characteristics of an HCE(Tank)
Alexander Ross
CS427-SPR2012-SWAG GAMES

Package declaration and imports:
*/
package classes.Views.windows {
	
	import flash.display.MovieClip;
	import classes.entity.HCE;
	import flash.events.MouseEvent;
	import classes.Views.OpenView;
	import classes.entityAttribute.AttributeSets.CityAttributes;
	import classes.entityAttribute.AttributeSets.upgradeElement;
	import flash.display.DisplayObject;
	
	
	public class entityDisplay extends MovieClip {
		
		//Update the window with the instance's attributes and the upgrades applicable for the city.
		public function entityDisplay(instance:HCE,attrs:CityAttributes) {
			
			this.nameText.text=instance.selectionBracket.nameBox.text;
			this.ownerText.text=instance.selectionBracket.ownerBox.text
			this.healthBar.width=(instance.health/100)*700;
			this.agilityText.text=""+instance.ATagility;
			this.accuracyText.text=""+instance.ATaccuracy;
			this.reloadText.text=""+instance.ATfireInterval+ " Cycles";
			this.strengthText.text=""+instance.ATstrength;
			this.damageText.text=""+instance.ATdamage;
			this.rangeText.text=instance.ATrange+" Meters"; 
			this.hitText.text=instance.tHits+"";
			this.missText.text=(instance.fired-instance.tHits)+"";
			this.exitBtn.addEventListener(MouseEvent.CLICK,this.exitListener);
			(this.reactiveArmourICO as upgradeElement).currLevel=1;
			//(this.reactiveArmourICO as upgradeElement).activate();
			
		}
		
		//Upon exit, re-start the container pane's timer and hide the window.
		public function exitListener(event:MouseEvent):void{
			((this.parent) as OpenView).parentPanel.primaryTimer.start();
			this.gotoAndPlay(2);
		}
	}
	
}
