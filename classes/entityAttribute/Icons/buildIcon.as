/*
Class:Icon
Description:
Parent class for all icons

Alexander Ross
CS427-SPR2012-SWAG GAMES

Package declaration and imports:
*/
package classes.entityAttribute.Icons{
	import classes.entityAttribute.Icon;
	import flash.display.MovieClip;
	import flash.display.BitmapData;
	import flash.text.TextField;
	import classes.entity.HCE.tank.Abrams;
	import classes.entity.HCE.tank.BlackEagle;
	import classes.entity.HCE.tank.Challenger;
	import classes.entity.dualEnvironment.Transport;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	public class buildIcon extends Icon{
		
		public var cost:int=0;
		public var  objectStr:String="";
		private var myText:TextField;
		private var myTextBG:TextField;
		public var arrayIndex=0;
		
		public function buildIcon(callBackIN:Function,iconIn:BitmapData,objName:String,indexI:int,shortDesc:String,longDesc:String):void{
				super(iconIn);
				this.arrayIndex = indexI;
				this.callBackFunction = callBackIN;
				
				var txForm:TextFormat = new TextFormat();
				txForm.size=9;
				this.myTextBG = new TextField();
				this.myText = new TextField();
				this.myTextBG.x++;
				this.myTextBG.y++;
				
				this.myText.text=shortDesc;
				this.myTextBG.text=shortDesc;
				this.myText.setTextFormat(txForm);
				txForm.color=0xFFFFFF;
				this.myTextBG.setTextFormat(txForm);
				this.addChild(this.myTextBG);
				this.addChild(myText);
				this.myText.selectable=false;
				this.objectStr= objName;
				this.shortName=shortDesc;
				this.description = longDesc;
		}//FncCons
		
		public function retrieveItem(ownerName:String):Object{
			if(this.objectStr == "ABR"){
				return new Abrams(10,10,ownerName,0);
			}else if(this.objectStr == "CHAL"){
				return new Challenger(10,10,ownerName,0);
			}else if(this.objectStr == "BE"){
				return new BlackEagle(10,10,ownerName,0);
			}
		}
		
		public function setActive(newState:Boolean):void{
			if(newState){
				this.alpha = 1;
			}else{
				this.alpha = .7;
			}
		}
		
		public function setText(newText:String):void{
			this.myText.text=newText;
		}
		
		public function getQueueIconInstance(thresholdIN:int,destination:String):queueIcon{
			return new queueIcon(this.callBackFunction,this.containedImage,this.objectStr,this.shortName,destination,thresholdIN);
		}
	}//Class
}//Pack
				