package classes.entity.dualEnvironment{
	import classes.Global;
	
	public class Transport extends DualEnvironmentContainer{
		
		public var ready:Boolean=true,returning:Boolean=false,destroyed=false;
		public var payload:Object;
		
		public function Transport(xIn:int,yIn:int,payloadI:Object=null):void{
			super(xIn,yIn,null);
			if(payload != null){
				this.payload = payloadI;
			}
			this.ghost = null;
			this.traceMovement=false;
		}
	}
}