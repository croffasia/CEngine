/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.cinterface 
{
	
	/**
	 * Интерфейс базового компонента
	 * @see com.mrbee.cengine.base.components.EntityComponent
	 * @author Poluosmak Andrew
	 */
	
	public interface IEntityComponent 
	{
		/**
		 * Обработчик вызываемый после успешного добавления компонента в систему. Если данный метод оверайдится в пользовтаельских компонентах, 
		 * то супер метод onAddHandler должен быть вызван перед любыми дополнительными действиями.
		 */
		function onAddHandler():void;
		
		/**
		 * Обработчик вызываемый перед удалением компонента из системы. Если данный метод оверайдится в пользовтаельских компонентах, 
		 * то супер метод onRemoveHandler должен быть вызван только после осуществления всех дополнительных действий.   
		 */
		function onRemoveHandler():void;		
				
		/**
		 * Объект сущности владельца текущего компонента
		 */
		function get owner():ICentity;
		
		/**
		 * @private
		 */
		function set owner(value:ICentity):void;
		
		/**
		 * Имя компонента в системе, по которому к неу можно обратиться
		 */
		function get name():String;
		
		/**
		 * @private
		 */
		function set name(value:String):void;
	}
	
}