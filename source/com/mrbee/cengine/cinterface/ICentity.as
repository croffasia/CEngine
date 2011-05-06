/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.cinterface 
{
	import com.mrbee.cengine.core.PropertyReference;
	import com.mrbee.cengine.core.StateMachine;
	import com.mrbee.cengine.events.StateEvent;
	
	/**
	 * Интерфейс сущности.
	 * @author Poluosmak Andrew
	 */
	
	public interface ICentity 
	{
		
		/**
		 * Объект Стейт машины
		 */
		function get stateMachine():StateMachine;
		
		/**
		 * Активация Стейт машины (состояний). После активации свойство <code>stateMachine</code> будет содержать объект Стейт машины, посредством 
		 * которой можно управлять состояниями сущности. 
		 */
		function activateStateMachine():void;
		
		/**
		 * Деактивация Стейт машины. Во время деактивации буду удалены все ранее зарегистрированные состояния и связанные компоненты.
		 */
		function deactivateStateMachine():void;
		
		/**
		 * Регистрация сущности виртуальном мире. Данный метод используется в том случае, если сущность была создана как независимый класс 
		 * наследуемый от базового класса сущности. Вызов функции регистрации сущности должен происходить после назначения имени сущности.
		 */
		function registerEntity():void;
		
		/**
		 * Получение объекта компонента по его имени
		 * @param name имя компонента
		 * 
		 * @return IEntityComponent объект компонента
		 */
		function getComponentByName(name:String):IEntityComponent;
		
		/**
		 * Получение объекта компонента по его типу
		 * @param component Class компонента
		 * 
		 * @return IEntityComponent объект компонента
		 */
		function getComponentByType(component:Class):IEntityComponent;
		
		/**
		 * Добавление нового компонента
		 * 
		 * @param name имя компонента
		 * @param component IEntityComponent объект
		 * 
		 * @return Boolean флаг говорящий об успешном / не успешном добавлении компонента 
		 */
		function addComponent(name:String, component:IEntityComponent):Boolean;
		
		/**
		 * Удаление компонента по его имени
		 * @param name имя компонента
		 * 
		 * @return Boolean
		 */
		function removeComponentByName(name:String):Boolean;
		
		/**
		 * Удаление компонента по его типу. Удаляет все компоненты с указанным классом.
		 * @param component <code>Class</code> компонента
		 */
		function removeComponentByType(component:Class):void;
		
		/**
		 * Удаление всех компонентов сущности. Функция сначало удаляет состояния, если они были зарегитсрированны, после чего проводит очистку всех компонентов, 
		 * которые были добавлены в не состояний.
		 */	
		function removeAllComponents():Boolean;
		
		/**
		 * Получение ссылки на один из объектов приложения: сущность, компонент, свойство компонента, метод компонента
		 * @param property <code>PropertyReference</code> объект
		 * 
		 * @return объект
		 */
		function getProperty(property:PropertyReference):*;
		
		/**
		 * Внесение изменений в свойства компонента, которые были изменены с использованием PropertyReference
		 * 
		 * @param property <code>PropertyReference</code> объект
		 * @param value новое значение
		 * 
		 * @return Boolean
		 */
		function setProperty(property:PropertyReference, value:*):Boolean;
		
		/**
		 * Удаление сущности. Функция удалеят все компоненты принадлежащие ей, после чего удаляет себя.
		 * @return Boolean
		 */ 
		function remove():Boolean;
		
		/**
		 * Имя сущности
		 */
		function get name():String;
		
		/**
		 * Количество добавленных компонентов
		 */
		function get numComponents():int;
		
		/**
		 * @private
		 */
		function set name(value:String):void;		
	}
}