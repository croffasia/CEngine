/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.core
{
	import com.mrbee.cengine.CEngine;
	import com.mrbee.cengine.cinterface.ICentity;
	import com.mrbee.cengine.cinterface.IEntityComponent;
	import com.mrbee.cengine.cinterface.IStateComponent;
	import com.mrbee.cengine.console.logger.Logger;
	import com.mrbee.cengine.events.StateEvent;
	
	import flash.utils.Dictionary;

	/**
	 * Стейт машина (состояния). Стейт машина позволяет организовать разбивку сущностей на состояния, в которых сущность может иметь разный набор 
	 * функциональности или же по разному отображаться. Объект стейт машины храниться в самой сущности, при условии ее активации.
	 * 
	 * @see com.mrbee.cengine.core.CEntity#activateStateMachine()
	 * @author Poluosmak Andrew
	 */
	public class StateMachine
	{
		/** 
		 * @private 
		 */
		private var _owner:ICentity;
		
		/** 
		 * @private 
		 */
		private var _states:Dictionary;		
		
		/** 
		 * @private 
		 */
		private var _currentStateComponent:IStateComponent = null;
		
		/** 
		 * @private 
		 */
		public function StateMachine(entity:ICentity)
		{
			_states = new Dictionary(true);
			_owner = entity;
			
			CEngine.eventManager.add(CEngine.eventDispatcher, StateEvent.ACTIVATE, onActivateStageHandler);
		}
		
		/**
		 * Регистрация нового состояния
		 * 
		 * @param name имя состояния
		 * @param stateCallback класс объекта состояния
		 */
		public function registerState(name:String, stateCallback:Class):void
		{
			if (_states[name] == null){
				_states[name] = stateCallback;
				Logger.info(this, "Register new state "+name+" (class: "+stateCallback+") for Entity "+name);
			}
		}
		
		/**
		 * Удаление ранее зарегистрированного состояния
		 * 
		 * @param name имя состояния
		 * @param deleteState флаг полного удаления состояния
		 * 
		 * @return Boolean флаг об успешном / не успешном удалении  
		 */
		final public function unregisterState(name:String = "", deleteState:Boolean = true):Boolean
		{
			if (_states[name] != null)
			{
				if (_currentStateComponent != null && IEntityComponent(_currentStateComponent).name == name){
					if(owner.removeComponentByName(name))
						_currentStateComponent = null;	
					else
						return false;
				} else {
					if(owner.removeComponentByName(name) == false)
						return false;
				}
				
				if(deleteState == true)
					delete _states[name];	
				
				return true;
			}
			
			return false;
		}
		
		/**
		 * Актицация зарегистрированного ранее состояния
		 * 
		 * @param _name имя состояния
		 * @param command дополнительные параметры, которые нужно передать в состояние
		 * 
		 * @return Boolean флаг об успешной / не успешной активации 
		 */
		public function activateState(_name:String, command:String = ""):Boolean
		{
			Logger.info(this, "Query for activate state "+owner.name+" in Entity "+owner.name);
			
			if (_currentStateComponent != null){				
				if(unregisterState(IEntityComponent(_currentStateComponent).name, false) == true)
					_currentStateComponent = null; 
			}			
			
			if (_states[_name] != null) {
				
				_currentStateComponent = new (_states[_name])() as IStateComponent;
				
				if(owner.addComponent(_name, _currentStateComponent as IEntityComponent) == false){
					return false;
				} else {
					_currentStateComponent.runCommand(command);
					return true;
				}
			}
			
			return false;
		}
		
		/**
		 * Удаление всех зарегистрированных состояний. При удалении всех состояний по цепочке будут удалены все компоненты добавленные в этом состоянии.
		 */
		public function unregisterAllStates():Boolean
		{
			if(_states != null)
			{
				var item:Object;
				
				for(item in _states){
					if(_states[item] != null)
						unregisterState(_states[item].name);
				}
			}
						
			return true;
		}
		
		/**
		 * @private
		 */
		public function destruct():void
		{
			CEngine.eventManager.removeCallbackEvent(onActivateStageHandler, StateEvent.ACTIVATE);
		}
		
		/**
		 * @private
		 * @param stage - State event
		 */ 
		private function onActivateStageHandler(e:StateEvent):void
		{ 
			if (_states[e.state] != null)
				activateState(e.state);
		}			

		/** 
		 * Объект сущности владельца 
		 */
		public function get owner():ICentity
		{
			return _owner;
		}

		/** 
		 * @private 
		 */
		public function set owner(value:ICentity):void
		{
			_owner = value;
		}

	}
}