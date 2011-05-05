package com.mrbee.cengine.components.amfserver 
{
	import com.mrbee.cengine.base.components.EntityComponent;
	
	/**
	 * ...
	 * @author Poluosmak Andrew
	 */
	
	public class AMFServerComponent extends EntityComponent implements IAMFServerComponent
	{
		protected var _target:String = "";
		protected var _responder:BaseResponder = null;
		
		public function AMFServerComponent() 
		{
			super();
		}
		
		protected function call(functionName:String, ...arg):void
		{
			if(_responder != null){
				
				var argument:Array = [];
					argument.push(_target + "." + functionName);
					argument.push(_responder);
					argument.push.apply(null, arg);
				
				AMFServer.getInstance().call.apply(this, argument);
			}
		}
		
		public function onResultHandler(response:BaseResponder):void
		{
			//
		}
		
		public function onStatusHandler(response:BaseResponder):void
		{
			//
		}
		
		public function get target():String { return _target; }
		
		public function set target(value:String):void 
		{
			_target = value;
		}
		
		public function get responder():BaseResponder { return _responder; }
		
		public function setResponder(value:Class):void 
		{
			_responder = new value(onResultHandler, onStatusHandler);
		}
		
	}

}