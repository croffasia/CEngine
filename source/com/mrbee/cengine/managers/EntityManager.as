/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.managers 
{
	import com.mrbee.cengine.cinterface.ICentity;
	import com.mrbee.cengine.core.CEntity;
	
	import flash.utils.Dictionary;
	
	/**
	 * <p>Менеджер сущностей. Управляет сущностями вашего виртуального мира.</p> 
	 * <p>Испольуется менеджер исключительно в базовых классах сущностей и не предназначен для публичного использования напрямую в вашем приложении.</p>
	 * 
	 * @author Poluosmak Andrew
	 */
	
	public class EntityManager
	{
		private static var _instance:EntityManager;		
		
		/** 
		 * Словарь зарегистрированных сущностей
		 * @private
		 */
		private var _entity:Dictionary;
		
		/** 
		 * @private 
		 */
		public function EntityManager(caller:Function = null) 
		{
			if( caller != EntityManager.getInstance )
                throw new Error ("EntityManager is a singleton class, use getInstance() instead");
            if ( EntityManager._instance != null )
                throw new Error( "Only one EntityManager instance should be instantiated" );
				
			_entity = new Dictionary(true);
		}
		
		/** 
		 * Возвращает экземпляр менеджера сущностей
		 */
		public static function getInstance():EntityManager
		{
			if (_instance == null)
				_instance = new EntityManager(arguments.callee);
			
			return _instance;
		}
		
		/** 
		 * Регистрирует сущнсоть в виртуальном мире
		 * 
		 * @param name уникальное имя сущнсоти. Сущности с одинаковыми именами не заменяются.
		 * @param entity <code>ICentity</code> объект
		 */
		public function register(name:String, entity:ICentity):void
		{
			if (getEntityByName(name) == null)
			{
				_entity[name] = entity;
			}
		}
		
		/** 
		 * Создание нового <code>ICentity</code> объекта
		 * 
		 * @param name уникальное имя сущнсоти. Сущности с одинаковыми именами не заменяются.
		 * @return <code>ICentity</code> объект
		 */	
		public function create(name:String):ICentity
		{
			if (getEntityByName(name) == null)
			{
				var cEntity:CEntity = new CEntity();
					cEntity.name = name;
					
					_entity[name] = cEntity;
					
					return _entity[name];
			}
			
			return null;
		}
		
		/** 
		 * Удалает зарегистрированную ранее сущность по указанному имени
		 * 
		 * @param name уникальное имя сущнсоти
		 * @return Boolean значение соотвествующее успешному удалению сущности
		 */
		public function remove(name:String):Boolean
		{
			var cEntity:ICentity = getEntityByName(name);
			
			if (cEntity != null)
			{
				//if(cEntity.remove()){
					delete _entity[name];
				//}
				
				return true;
			}
			
			return false;
		}
		
		/**
		 * @private
		 */		
		public function getEntityByName(name:String):ICentity
		{
			return _entity[name] as ICentity;

		}
		
		/**
		 * @private
		 */
		public function getAll():Dictionary
		{
			return _entity;
		}
	}

}