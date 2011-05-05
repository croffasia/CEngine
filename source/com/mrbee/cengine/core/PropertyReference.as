package com.mrbee.cengine.core 
{
	/**
	 * Референс на объект. Референсы используются для передачи сущностей, компонентов, свойств или методов компонентов другим компонентам.
	 * 
	 * @example Пример использования: 
	 * <listing version="3.0">
	 * new PropertyReference("#MyEntity_Name"); // создаст ссылку на полный объект сущности.
	 * new PropertyReference("#MyEntityName.[at]MyComponentName"); // создаст ссылку на полный объект компонента MyComponentName добавленного в сущность MyEntityName
	 * new PropertyReference("[at]MyComponentName"); // создаст ссылку на полный объект компонента в текущей сущности
	 * new PropertyReference("[at]MyComponentName.propertyValue"); // создаст ссылку на свойство propertyValue компонента MyComponentName находящегося в текущей сущности
	 * new PropertyReference("[at]MyComponentName.myfunction"); // создаст ссылку на метод myfunction() компонента MyComponentName находящегося в текущей сущности 
	 * </listing> 
	 * @author Poluosmak Andrew
	 */
	public class PropertyReference
	{
		/**
		 * @private
		 */
		private var _string:String = "";
		
		/**
		 * @private
		 */
		private var _explode:Array = new Array();
		
		/**
		 * @private
		 */
		private var _entity:String = "";
		
		/**
		 * @private
		 */
		private var _component:String = "";
		
		/**
		 * @private
		 */
		private var _property:Array = [];
		
		/**
		 * Создание нового референса на объект
		 * 
		 * @param value запрос, по которому идет поиск нужного референса. Строка запроса состоит из имен сущностей, компонентов под  
		 * которыми они зарегистрированны в приложении. Идентификаторы сущностей помечаются знаком # перед название, идентификаторы компонентов помечаются
		 * знаком [at] (собачка) перед название, название свойств и методов соотвествует их реальным названиям. Вся цепочка запроса разделяется между собой точками 
		 */
		public function PropertyReference(value:String) 
		{
			_string = value;
			_explode = _string.split(".");
			
			// get entity name
			if (_explode != null && _explode[0] != null && _explode[0].charAt(0) == "#")
				_entity = (_explode[0]).substr(1, (_explode[0]).length - 1);
			else
				_entity = null;
			
			// get component name
			if (_explode != null) {
				if(_explode[0] != null && _explode[0].charAt(0) == "@")
					_component = (_explode[0]).substr(1, (_explode[0]).length - 1);
				else if (_explode[1] != null && _explode[1].charAt(0) == "@")				
					_component = (_explode[1]).substr(1, (_explode[1]).length - 1);
				else
					_component = null;
			} else {
				_component = null;
			}
			
			// get property
			var i:int;
			for (i = 0; i < _explode.length; i++ ) 
			{			
				if ((_explode[i]).charAt(0) != "@" && (_explode[i]).charAt(0) != "#")
					_property.push(_explode[i]);
			}
		}
		
		/**
		 * Возвращает строковый запрос референса
		 * 
		 * @return строка запроса
		 */
		public function get string():String
		{
			return _string;
		}
		
		/**
		 * Возвращает имя сущности, в которой будет произведен поиск.
		 * 
		 * @return Имя сущности. В случае, если сущность не была указана, возвращает пустоту
		 */
		public function get entity():String
		{
			return _entity
		}
		
		/**
		 * Возвращает имя компонента, в котором будет произведен поиск.
		 * 
		 * @return Имя компонента
		 */
		public function get component():String
		{
			return _component;			
		}
		
		/**
		 * Возвращает имя свойства / метода, который требуется найти
		 * 
		 * @return Имя свойства / метода
		 */
		public function get property():Array
		{
			return _property;
		}
	}

}