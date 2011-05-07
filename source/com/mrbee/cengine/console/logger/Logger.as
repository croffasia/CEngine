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
	public class Logger extends LoggerTemplates
	{
		/**
		 * @private
		 */
		private static var _enabled:Boolean = true;
		
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
				addToLog(setError(message));
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
				addToLog(setNotice(message));
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
				addToLog(setInfo(message));
		}
		
		/**
		 * Вывод информации в trace
		 * 
		 * @param object текущий класс
		 * @param message текст сообщения
		 */
		static public function print(object:Object, message:String):void
		{
			if(_enabled)
				trace("INFO: "+message);
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
		private static function addToLog(message:String):void
		{
			if(_length >= _totalRows)
				deleteFromLog();
			
			_length++;
			
			_logs[_length] = message; 
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
		 * @private
		 */
		public static function get logsToString():String
		{ 
			var item:Object;
			var returnedString:String = "";
			
			for(item in _logs)
			{
				returnedString += _logs[item]+"\r";
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


	}
}