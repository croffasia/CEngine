package com.mrbee.cengine.core 
{
	import com.mrbee.cengine.CEngine;
	import com.mrbee.cengine.cinterface.ICentity;
	import com.mrbee.cengine.cinterface.IEntityComponent;
	import com.mrbee.cengine.cinterface.IStateComponent;
	import com.mrbee.cengine.console.logger.Logger;
	import com.mrbee.cengine.events.StateEvent;
	import com.mrbee.cengine.managers.EntityManager;
	
	import flash.utils.Dictionary;
	
	/**
	 * <p>Базовый класс сущности. Сущность - это некий целый не зависимый объект в виртуальном мире, который может иметь свои состояния и свои компоненты.</p>
	 * <p>Если ваша сущность имеет несколько состояний, например разную функциональность или отображения для текущего пользователя и для гостя, используйте Стейт машину (состояния).
	 * Состояния помогут четко разделить функциональность сущности и даст возможность с любого места приложения быстрого и легко перевести сущность в нужное состояние. 
	 * Вы можете переводить как конкретную сущность в определенное состояние, так и одновременно все сущности в системе, которые имеют состояния с одинаковыми именами.</p>
	 * <p>Автоудаление компонентов и состояний. При удалении сущности срабатывает цепочка удалений: состояния, компоненты состояний, компоненты сущности. 
	 * Разработчику не нужно заботиться об удалении добавляемых компонентов, система сделает все это за вас.</p>
	 * 
	 * @author Poluosmak Andrew
	 */
	
	public class CEntity implements ICentity
	{
		/**
		 * @private 
		 */
		private var _name:String = "";
		
		
		/**
		 * словарь компонентов сущности
		 * @private 
		 */
		private var _components:Dictionary;		
		
		/**
		 * @private 
		 */
		private var _stateMachine:StateMachine = null;
		
		/**
		 * @private 
		 */
		public function CEntity() 
		{
			Logger.info(this, "Create base entity");
			init();						
		}
		
		/**
		 * Активация Стейт машины (состояний). После активации свойство <code>stateMachine</code> будет содержать объект Стейт машины, посредством 
		 * которой можно управлять состояниями сущности. 
		 */
		public function activateStateMachine():void
		{
			if(_stateMachine == null){
				_stateMachine = new StateMachine(this);
			}
		}
		
		/**
		 * Деактивация Стейт машины. Во время деактивации буду удалены все ранее зарегистрированные состояния и связанные компоненты.
		 */
		public function deactivateStateMachine():void
		{
			if(_stateMachine != null){
				if(_stateMachine.unregisterAllStates()){
					_stateMachine = null;
				}
			}
		}
		
		/**
		 * Добавление нового компонента
		 * 
		 * @param name имя компонента
		 * @param component IEntityComponent объект
		 * 
		 * @return Boolean флаг говорящий об успешном / не успешном добавлении компонента 
		 */
	    final public function addComponent(name:String, component:IEntityComponent):Boolean
		{			
			if (_components[name] == null){
				
				component.owner = this;
				component.name = name;				
				_components[name] = component;
				
				component.onAddHandler();
					
				return true;
			}

			return false;
		}
		
		/**
		 * Регистрация сущности виртуальном мире. Данный метод используется в том случае, если сущность была создана как независимый класс 
		 * наследуемый от базового класса сущности. Вызов функции регистрации сущности должен происходить после назначения имени сущности.
		 */
		final public function registerEntity():void
		{
			if(name != "")
				CEngine.entityManager.register(name, this);
			else
				throw new Error ("Set Entity name and register new Entity");
		}
		
		/**
		 * Получение объекта компонента по его имени
		 * @param name имя компонента
		 * 
		 * @return IEntityComponent объект компонента
		 */
		final public function getComponentByName(name:String):IEntityComponent
		{
			return _components[name];
		}
		
		/**
		 * Получение объекта компонента по его типу
		 * @param component Class компонента
		 * 
		 * @return IEntityComponent объект компонента
		 */
		final public function getComponentByType(component:Class):IEntityComponent
		{
			var name:String;
			
			for (name in _components) 
			{ 
				if (_components[name] is component) {
					return _components[name] as IEntityComponent;
				}
			}
			
			return null;
		}
		
		/**
		 * Получение ссылки на один из объектов приложения: сущность, компонент, свойство компонента, метод компонента
		 * @param property <code>PropertyReference</code> объект
		 * 
		 * @return объект
		 */
		final public function getProperty(property:PropertyReference):*
		{
			var currentEntity:ICentity;
			
			// find entity
			if (property.entity != null)
				currentEntity = EntityManager.getInstance().getEntityByName(property.entity);			
			else
				currentEntity = this;
				
			var currentComponent:IEntityComponent;
			
			// find component 
			if (property.component != null) {
					currentComponent = currentEntity.getComponentByName(property.component);
					
					if(currentComponent == null)
						return null;
			} else {
				return currentEntity;
			}
			
			var properties:Array = property.property;
			
			// find property			
			if(properties.length > 0)			
				return currentComponent[properties[0]];			
			else
				return currentComponent;
			
			return null;
		}
		
		/**
		 * Внесение изменений в свойства компонента, которые были изменены с использованием PropertyReference
		 * 
		 * @param property <code>PropertyReference</code> объект
		 * @param value новое значение
		 * 
		 * @return Boolean
		 */
		final public function setProperty(property:PropertyReference, value:*):Boolean
		{
			var currentEntity:ICentity;
			var currentComponentList:Array = [];
			
			// find entity
			if (property.entity != null)
				currentEntity = EntityManager.getInstance().getEntityByName(property.entity);			
			else
				currentEntity = this;
				
				
			var currentComponent:IEntityComponent;
			
			// find component
			if (property.component != null) {
					currentComponent = currentEntity.getComponentByName(property.component);
					if(currentComponent == null)
						return false;
			} else {
				return false;
			}
			
			var properties:Array = property.property;
			
			// find property			
			if(properties.length > 0){
				currentComponent[properties[0]] = value;
				return true;			
			}
			
			return false;
		}
		
		/**
		 * Удаление компонента по его имени
		 * @param name имя компонента
		 * 
		 * @return Boolean
		 */
		final public function removeComponentByName(name:String):Boolean
		{
			if (_components[name] != null) {
				IEntityComponent(_components[name]).onRemoveHandler();
				delete _components[name];

				return true;
			}
			
			return false;
		}
		
		/**
		 * Удаление компонента по его типу. Удаляет все компоненты с указанным классом.
		 * @param component <code>Class</code> компонента
		 */
		final public function removeComponentByType(component:Class):void
		{
			var name:String;
			
			for (name in _components) 
			{ 
				if (_components[name] is component) {
					IEntityComponent(_components[name]).onRemoveHandler();
					delete _components[name];
				}
			}
		}
		
		/**
		 * Удаление всех компонентов сущности. Функция сначало удаляет состояния, если они были зарегитсрированны, после чего проводит очистку всех компонентов, 
		 * которые были добавлены в не состояний.
		 */		
		final public function removeAllComponents():Boolean
		{
			var nameComponent:String;
			
			if(_stateMachine != null){
				if(_stateMachine.unregisterAllStates()){								
					for (nameComponent in _components){ 
						IEntityComponent(_components[nameComponent]).onRemoveHandler();
						delete _components[nameComponent];		
					}
				}
			}		
									
			for (nameComponent in _components){ 
				IEntityComponent(_components[nameComponent]).onRemoveHandler();
				delete _components[nameComponent];		
			}
			
			return true;
		}
		
		/**
		 * Удаление сущности. Функция удалеят все компоненты принадлежащие ей, после чего удаляет себя.
		 * @return Boolean
		 */ 
		public function remove():Boolean
		{
			if(removeAllComponents()){
				if(_stateMachine != null){
					_stateMachine.destruct();
					_stateMachine = null;
				}
				EntityManager.getInstance().remove(name);
			}
			
			return true;
		}
		
		/**
		 * Инициализация сущнсоти
		 * @private
		 */
		private function init():void
		{
			_components = new Dictionary(true);
		}
				
		/**
		 * Имя сущности
		 */
		public function get name():String { return _name; }
		
		/**
		 * @private
		 */
		public function set name(value:String):void 
		{
			_name = value;
		}

		/**
		 * Объект Стейт машины
		 */
		public function get stateMachine():StateMachine
		{
			return _stateMachine;
		}

	}
}