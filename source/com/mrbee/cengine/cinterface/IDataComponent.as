/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.cinterface 
{
	import flash.utils.Dictionary;
	
	/**
	 * Интерфейс компонента пользовательских данных
	 * @author Poluosmak Andrew
	 */
	
	public interface IDataComponent 
	{
		/**
		 * Добавление нового объекта
		 * 
		 * @param name имя, по которому он будет в дальнейшем доступен
		 * @param value объект заносимых данных
		 * @param replace указатель на автозамену в случае совпадения имен (true - перезаписать, false - пропустиить)
		 */
		function add(name:String, value:*, replace:Boolean = false):void;
		
		/**
		 * Удаление объекта по его имени
		 * @param name имя объекта
		 * 
		 * @return Boolean
		 */
		function remove(name:String):Boolean;
		
		/**
		 * Получение объекта по его имени.
		 * @param name имя объекта
		 * 
		 * @return объект
		 */
		function getItem(name:String):*;
		
		/**
		 * Поиск объектов по фильтру ключ = значение
		 * 
		 * @param filter массив объектов {key: "имя ключа", value: "значение"}
		 * 
		 * @return Array найденных объектов
		 */
		function search(filter:Array):Array;
		
		/**
		 * Очистка всех данных
		 */
		function clear():void;
		
		/**
		 * Получение словаря со всеми объектами. Ключи объектов - имена присваемые при добавлении объекта
		 * @return Dictionary
		 */
		function getAll():Dictionary;
		
		/**
		 * Количество объектов в компоненте
		 */
		function get lenght():int;
	}
	
}