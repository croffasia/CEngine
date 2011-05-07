/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.base.components 
{
	import com.mrbee.cengine.CEngine;
	import com.mrbee.cengine.cinterface.ICentity;
	import com.mrbee.cengine.cinterface.IEntityComponent;
	import com.mrbee.cengine.events.StateEvent;
	
	/**
	 * Базовый компонент фреймворка. От базового компонента наследуются все остальные предустановленные типы компонентов. 
	 * Каждый компонент знает о своем владельце и может напрямую обратиться к сущности, которая содержит этот компонент. 
	 * При разработке своих компонентов для удобной и стандратизированной передачи объектов, которые будут взаимодейтвовать с компонентом используету <code>PropertyReference</code>
	 *    
	 * @see com.mrbee.cengine.core.PropertyReference
	 * @author Poluosmak Andrew
	 */
	
	public class EntityComponent implements IEntityComponent
	{
		/** 
		 * @private 
		 */
		private var _name:String = "";
		
		/** 
		 * @private 
		 */
		private var _owner:ICentity;
		
		/**
		 * @private
		 */
		public function EntityComponent() 
		{
			
		}

		/**
		 * Обработчик вызываемый после успешного добавления компонента в систему. Если данный метод переопределяется в пользовтаельских компонентах, 
		 * то супер метод onAddHandler должен быть вызван перед любыми дополнительными действиями.
		 */
		public function onAddHandler():void
		{
			
		}
		
		/**
		 * Обработчик вызываемый перед удалением компонента из системы. Если данный метод переопределяется в пользовтаельских компонентах, 
		 * то супер метод onRemoveHandler должен быть вызван только после осуществления всех дополнительных действий.   
		 */
		public function onRemoveHandler():void
		{			
			owner = null;
		}
				
		/**
		 * Имя компонента в системе, по которому к неу можно обратиться
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
		 * Объект сущности владельца текущего компонента
		 */
		public function get owner():ICentity { return _owner; }
		
		/**
		 * @private
		 */
		public function set owner(value:ICentity):void 
		{
			_owner = value;
		}
		
		
	}

}