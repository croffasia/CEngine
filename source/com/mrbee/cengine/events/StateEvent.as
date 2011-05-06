/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.events 
{
	import flash.events.Event;
	
	/**
	 * События для смены состояний сущностей. 
	 * Диспетчером является CEngine.eventDispatcher
	 * 
	 * @see com.mrbee.cengine.CEngine#eventDispatcher
	 * @author Poluosmak Andrew
	 */
	public class StateEvent extends Event 
	{
		/**
		 * Запрашивает смену состояния зарегистрированных сущностей (если таковое зарегистрированно в сущности)
		 */
		public static const ACTIVATE:String = "StateEventActivate";
		
		/**
		 * Имя состояние, в которое нужно перейти
		 */
		public var state:String = "";
		
		/**
		 * @private
		 */
		public function StateEvent(type:String, _state:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			state = _state;
		} 
		
		/**
		 * @private
		 */
		public override function clone():Event 
		{ 
			return new StateEvent(type, state, bubbles, cancelable);
		} 
		
		/**
		 * @private
		 */
		public override function toString():String 
		{ 
			return formatToString("StateEvent", "type", "state", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}