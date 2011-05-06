/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.base.components 
{
	import com.adobe.utils.DictionaryUtil;
	import com.mrbee.cengine.cinterface.IDataComponent;
	
	import flash.utils.Dictionary;
	
	import mx.utils.ObjectUtil;
	
	/**
	 * <p>Компонент пользовательских данных. Советуем использовать этот компонент для храненнния данных пользователей в приложени.</p>
	 * <p>Компонент реализует простой менеджер данных, который позволяет добавлять / удалять / получать / искать нужные вам данные а так же 
	 * четко разделяет типы данных в приложении. В разрабатываемых персональных компонентах данных возможно переопределять стандартные 
	 * методы, а так же удобно реализовывать предустановленные фильтры, которые будут часто использоваться в приложении.</p>
	 * 
	 * @author Poluosmak Andrew
	 */
	
	public class DataComponent extends EntityComponent implements IDataComponent
	{
		/**
		 * @private
		 */
		private var _dataDictionary:Dictionary;
		
		/**
		 * @private
		 */
		private var _lenght:int = 0;
		
		/**
		 * @private
		 */
		public function DataComponent() 
		{
			super();
			_dataDictionary = new Dictionary();
		}
		
		/**
		 * Добавление нового объекта
		 * 
		 * @param name имя, по которому он будет в дальнейшем доступен
		 * @param value объект заносимых данных
		 * @param replace указатель на автозамену в случае совпадения имен (true - перезаписать, false - пропустиить)
		 */
		public function add(name:String, value:*, replace:Boolean = false):void
		{
			if (replace == false) {
				if (_dataDictionary[name] == null){
					_dataDictionary[name] = value;
					_lenght++;
				}
			} else {
				_dataDictionary[name] = value; 
				_lenght++;
			}
		}
		
		/**
		 * Удаление объекта по его имени
		 * @param name имя объекта
		 * 
		 * @return Boolean
		 */
		public function remove(name:String):Boolean
		{
			if (_dataDictionary[name] != null){
				delete _dataDictionary[name]; 
				_lenght--; 
				return true;
			}
				
			return false;
		}		
		
		/**
		 * Получение словаря со всеми объектами. Ключи объектов - имена присваемые при добавлении объекта
		 * @return Dictionary
		 */
		public function getAll():Dictionary
		{
			return _dataDictionary;
		}
		
		/**
		 * Получение объекта по его имени.
		 * @param name имя объекта
		 * 
		 * @return объект
		 */
		public function getItem(name:String):*
		{
			return _dataDictionary[name];
		}
		
		/**
		 * Поиск объектов по фильтру ключ = значение
		 * 
		 * @param filter массив объектов {key: "имя ключа", value: "значение"}
		 * 
		 * @return Array найденных объектов
		 */
		public function search(filter:Array):Array
		{
			var result:Array = [];
			var i:int;
			var item:Object;
			
			if (filter.length > 0)
			{
				for (item in _dataDictionary)
				{		
					for(i = 0; i < filter.length; i++){
						if(_dataDictionary[item].hasOwnProperty(filter[i].name) && _dataDictionary[item][filter[i].name] == filter[i].value)
							result.push(_dataDictionary[item]);
					}
				}
			}
			
			return result;
		}
		
		/**
		 * Очистка всех данных
		 */
		public function clear():void
		{
			var obj:Object;
			
			for (obj in _dataDictionary)
			{					
				delete _dataDictionary[obj];
			}
			
			_dataDictionary = null;
			_lenght = 0;
		}
		
		/**
		 * Количество объектов в компоненте
		 */
		public function get lenght():int { return _lenght; }	
	}

}