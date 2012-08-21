package classes.entityAttribute.AttributeSets{
	public class CityAttributes{
		
		public var HCEAttribs:Array, InternalAttribs:Array;
		public var HCEuint:uint,Internaluint:uint; 
		
		public function CityAttributes():void{
			this.HCEAttribs = new Array();
			this.InternalAttribs = new Array();
			this.HCEAttribs.push(new Array("Advanced Projectiles",new Array(5/4 , 1, 0, 5, 0, 0, 0, 0),0));
            this.HCEAttribs.push(new Array("AutoLoaders",new Array(0, 0 ,2,  0, 0, 0, 5, 0),0));
            this.HCEAttribs.push(new Array(" Engine Upgrades",new Array(0 , 0 , 0,  0, 0,1.5,5,10),0));
            this.HCEAttribs.push(new Array(" Reactive Armour",new Array(0, 0 , 0,  0, 1, 0 ,5,5),0));
		}
	}
}