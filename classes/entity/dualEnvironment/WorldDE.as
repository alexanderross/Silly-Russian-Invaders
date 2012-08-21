package classes.entity.dualEnvironment{
	
	public class WorldDE{
		public var decArray:Array;
		public var plCapitol:Capitol;
		public var playerDex:int;
		public var playerCurr:int;
		public var playerScr:int;
		
		public function WorldDE(capIn:Capitol):void{
			this.decArray=new Array(); 
			this.plCapitol=capIn;
			this.plCapitol.parentW = this;
			
		}
		
		public function addDEC(addition:DualEnvironmentContainer):void{
			this.decArray.push(addition); 
		}
	}
}