/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.console.logger
{
	import flash.utils.Dictionary;

	/**
	 * Логгер для отладки приложения и добавления информации в консоль.
	 * 
	 * @author Poluosmak Andrew
	 */
	public class Logger
	{
		/**
		 * @private
		 */
		private static var _enabled:Boolean = true;
		
		/**
		 * @private
		 */
		private static var _logId:int = 0;
		
		/**
		 * @private
		 */
		private static var _totalRows:int = 20;
		
		/**
		 * @private
		 */
		private static var _length:int = 0;
		
		/**
		 * @private
		 */
		private static var _logs:Dictionary = new Dictionary(true);
		
		/**
		 * @private
		 */
		private static var _error_template:String = "";		
		
		/**
		 * Добавление сообщения об ошибке
		 * 
		 * @param object текущий класс
		 * @param message текст сообщения
		 */
		static public function error(object:Object, message:String):void
		{			
			if(_enabled)
				addToLog(object, message, LogItem.ERROR);
		}
		
		/**
		 * Добавление предупреждения
		 * 
		 * @param object текущий класс
		 * @param message текст сообщения
		 */
		static public function notice(object:Object, message:String):void
		{			
			if(_enabled)
				addToLog(object, message, LogItem.NOTICE);
		}
		
		/**
		 * Добавление информационного сообщения
		 * 
		 * @param object текущий класс
		 * @param message текст сообщения
		 */
		static public function info(object:Object, message:String):void
		{			
			if(_enabled)
				addToLog(object, message, LogItem.INFO);
		}
		
		/**
		 * Вывод информации в trace
		 * 
		 * @param message текст сообщения
		 */
		static public function print(message:String):void
		{
			if(_enabled){
				trace(LogItem.DEBUG+": "+message);
			}
		} 

		/**
		 * Количество хранимых сообщений
		 */
		public static function get totalRows():int
		{
			return _totalRows;
		}

		/**
		 * @private
		 */
		public static function set totalRows(value:int):void
		{
			_totalRows = value;
		}
		
		/**
		 * @private
		 */
		private static function addToLog(reporter:*, message:String, level:String):void
		{
			if(_length >= _totalRows)
				deleteFromLog();
			
			_length++;
			
			var item:LogItem = new LogItem();			
			item.messages = message;
			item.reporter = reporter;
			item.level = level;
			_logs[item] = item;
		}
		
		/**
		 * Очистка логов
		 */
		public static function clear():void
		{
			deleteFromLog(true);
		}
		
		/**
		 * @private
		 */
		private static function deleteFromLog(allDelete:Boolean = false):void
		{
			var item:Object;
			
			for(item in _logs)
			{
				delete _logs[item];
				_length--;
				
				if(allDelete == false)
					break;
			}
		}
		
		/**
		 * Формирует стилизированную строку вывода лога в консоль
		 * 
		 * @return String
		 */
		public static function getLogItems(level:String = ""):String
		{
			var item:Object;
			var returnedString:String = "";
			var itemArray:Array = [];
			
			for(item in _logs){
				if(level == "" || LogItem(_logs[item]).level == level){
					itemArray.push(LogItem(_logs[item]));
				}
			}
			
			itemArray.sortOn("id", Array.NUMERIC);
			var i:int;
			
			for(i = 0; i < itemArray.length; i++){
				returnedString += LogItem(itemArray[i]).template(LogItem(itemArray[i]).messages)+"\r";
			}
			
			return returnedString;
		}

		/**
		 * Включение / Отключение логера
		 */
		public static function get enabled():Boolean
		{
			return _enabled;
		}

		/**
		 * @private
		 */
		public static function set enabled(value:Boolean):void
		{
			_enabled = value;
		}

		/**
		 * Уникальный ID лог записи
		 */
		public static function get logId():int
		{
			_logId++
			return _logId;
		}

	}
}