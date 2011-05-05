package com.mrbee.cengine.cinterface 
{
	import com.mrbee.cengine.events.StateEvent;
	
	/**
	 * Интерфейс компонента состояния
	 * @author Poluosmak Andrew
	 */
	
	public interface IStateComponent 
	{
	
		/**
		 * Добавление нового компонента в текущее состояние
		 * 
		 * @param name имя компонента
		 * @param component IEntityComponent объект
		 */
		function addComponent(name:String, component:IEntityComponent):void;
		
		/**
		 * Удалание всех компонентов добавленных в текущем состоянии
		 */
		function removeAllComponents():void;		
		
		/**
		 * Удаление компонента по его имени
		 * @param name имя компонента
		 */
		function removeComponentByName(name:String):void;
		
		/**
		 * @private 
		 */
		function onDeactivateStateHandler(e:StateEvent = null):void;
		
		/**
		 * @private 
		 */
		function onActivateStateHandler(e:StateEvent = null):void;
		
		/**
		 * Запуск внутренней функции компонента. Используется при передаче дополнительных данных в событиях при смене состояний
		 */
		function runCommand(name:String = ""):void;
	}
	
}