/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.console.logger
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	/**
	 * Объект записи в логе
	 * @author Poluosmak Andrew
	 */
	public class LogItem
	{
		/**
		 * Уровень логирования Debug
		 */
		public static const DEBUG:String = "DEBUG";
		
		/**
		 * Уровень логирования INFO
		 */
		public static const INFO:String = "INFO";
		
		/**
		 * Уровень логирования NOTICE
		 */
		public static const NOTICE:String = "NOTICE";
		
		/**
		 * Уровень логирования ERROR
		 */
		public static const ERROR:String = "ERROR";
		
		/**
		 * @private
		 */		
		private var _reporter:* = null;
		
		/**
		 * @private
		 */		
		private var _messages:String = "";
		
		/**
		 * @private
		 */		
		private var _level:String = "";
		
		/**
		 * @private
		 */		
		private var _time:int = 0;
		
		/**
		 * @private
		 */		
		private var _id:int = 0;
		
		/**
		 * @private
		 */		
		private var _template:Function;
		
		/**
		 * @private
		 */		
		public function LogItem()
		{
			_time = new Date().getTime() / 1000;
			_id = Logger.logId;
		}

		/**
		 * Объект инициатор записи
		 */		
		public function get reporter():*
		{
			return _reporter;
		}

		/**
		 * @private
		 */		
		public function set reporter(value:Object):void
		{
			_reporter = getClass(value);
		}

		/**
		 * Сообщение записанное в лог
		 */		
		public function get messages():String
		{
			return _messages;
		}

		/**
		 * @private
		 */		
		public function set messages(value:String):void
		{
			_messages = value;
		}

		/**
		 * Время записи в лог - Unix time (секунды)
		 */		
		public function get time():int
		{
			return _time;
		}

		/**
		 * Уровень логирования
		 */		
		public function get level():String
		{
			return _level;
		}

		/**
		 * @private
		 */		
		public function set level(value:String):void
		{
			_level = value;
			
			switch(_level){
				case INFO:
					_template = LoggerTemplates.INFO;
					break;
				case ERROR:
					_template = LoggerTemplates.ERROR;
					break;
				case NOTICE:
					_template = LoggerTemplates.NOTICE;
					break;
				default:
					_template = LoggerTemplates.INFO;
					break;
			}
		}
		
		/**
		 * @private
		 */		
		private function getClass (obj:Object):Class 
		{
			return Class(getDefinitionByName(getQualifiedClassName(obj)));
		}

		/**
		 * @private
		 */		
		public function get template():Function
		{
			return _template;
		}
		
		/**
		 * Уникальный ID записи
		 */		
		public function get id():int
		{
			return _id;
		}

	}
}