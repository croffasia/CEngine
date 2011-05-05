package com.mrbee.cengine.events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Poluosmak Andrew
	 */
	public class StateEvent extends Event 
	{
		public static const ACTIVATE:String = "StateEventActivate";
		public static const DEACTIVATE:String = "StateEventDeActivate";
		
		public var state:String = "";
		
		public function StateEvent(type:String, _state:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			state = _state;
		} 
		
		public override function clone():Event 
		{ 
			return new StateEvent(type, state, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("StateEvent", "type", "state", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}