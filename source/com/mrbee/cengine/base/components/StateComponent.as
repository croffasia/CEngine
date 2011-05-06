/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.base.components 
{
	import com.mrbee.cengine.cinterface.IEntityComponent;
	import com.mrbee.cengine.cinterface.IStateComponent;
	import com.mrbee.cengine.events.StateEvent;
	import com.mrbee.cengine.utils.DelegateFunction;
	
	import flash.utils.Dictionary;
	
	/**
	 * <p>Компонент состояния сущности. Компоненты состояний помогут в разделении различного набора фукнциональности сущности имеющей несколько состояний. 
	 * Для работы с состояниями в сущности необходимо активировтаь <code>StateMachine</code>.</p>
	 * <p>При переходе в различные состояния, текущее активное состояние удаляется атвоматически, включая удаление всех связанных компонентов. 
	 * Удаление дополнительных данных произодится в <code>onRemoveHandler</code> методе.</p>
	 * 
	 * @author Poluosmak Andrew
	 */
	
	public class StateComponent extends EventComponent implements IStateComponent 
	{
		/**
		 * @private 
		 */
		private var _components:Dictionary;
		
		/**
		 * @private 
		 */
		public function StateComponent() 
		{
			super();
			_components = new Dictionary(true);
		}
		
		/**
		 * @inheritDoc 
		 */
		override public function onAddHandler():void
		{					
			super.onAddHandler();
			
			// add global event listeners for change status
			addEvent(StateEvent.ACTIVATE, DelegateFunction.create(onActivateStateHandler), false);
		}
		
		/**
		 * @inheritDoc 
		 */
		override public function onRemoveHandler():void
		{
			removeEvent();	
			removeAllComponents();
			super.onRemoveHandler();
		}
		
		/**
		 * Добавление нового компонента в текущее состояние
		 * 
		 * @param name имя компонента
		 * @param component IEntityComponent объект
		 */
		final public function addComponent(name:String, component:IEntityComponent):void
		{
			owner.addComponent(name, component);
			_components[name] = name;
		}
		
		/**
		 * Удалание всех компонентов добавленных в текущем состоянии
		 */
		final public function removeAllComponents():void
		{
			var name:Object;
			
			for (name in _components){
				removeComponentByName(name as String);
				delete _components[name];
			}
		}
		
		
		/**
		 * Удаление компонента по его имени
		 * @param name имя компонента
		 */
		final public function removeComponentByName(name:String):void
		{
			if(_components[name] != null){
				owner.removeComponentByName(name);
				delete _components[name];
			}
		}
		
		/**
		 * @private 
		 */
		public function onActivateStateHandler(e:StateEvent = null):void
		{
		}
		
		/**
		 * @private
		 */
		public function onDeactivateStateHandler(e:StateEvent = null):void
		{
		}
		
		/**
		 * Запуск внутренней функции компонента. Используется при передаче дополнительных данных в событиях при смене состояний
		 */
		public function runCommand(name:String = ""):void
		{
			if(name != "" && hasOwnProperty(name))
			{
				this[name]();
			}
		}
	
	}

}