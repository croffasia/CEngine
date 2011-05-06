/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.console
{
	import flash.utils.Dictionary;

	/**
	 * Менеджер команд консоли. Менеджер позволяет добавлять кастомные команды для обработки их в консоли.
	 * 
	 * @author Poluosmak Andrew
	 */
	public class ConsoleCommandManager
	{
		/**
		 * @private
		 */
		private static var _instance:ConsoleCommandManager;
		
		/**
		 * @private
		 */
		private var _commands:Dictionary;
		
		/**
		 * @private
		 */
		public function ConsoleCommandManager(caller:Function = null)
		{
			if( caller != ConsoleCommandManager.getInstance )
				throw new Error ("ConsoleCommandManager is a singleton class, use getInstance() instead");
			if ( ConsoleCommandManager._instance != null )
				throw new Error( "Only one ConsoleCommandManager instance should be instantiated" );
			
			_commands = new Dictionary(true);
		}
		
		/**
		 * @private
		 */
		public static function getInstance():ConsoleCommandManager
		{
			if (_instance == null)
				_instance = new ConsoleCommandManager(arguments.callee);
			
			return _instance;
		}
		
		/**
		 * Добавление новой консольной команды
		 * 
		 * @param alias алиас команды
		 * @param externalCallback функция, которая будет выполнена при вызовае команды
		 */
		public function addCommand(alias:String, externalCallback:Function):void
		{
			var co:CommandObject;
			alias = alias.toLocaleLowerCase();
			
			if(_commands[alias] == null){
				co = new CommandObject();
				co.alias = alias;
				co.external = externalCallback;
							
				_commands[alias] = co;
			} else {
				CommandObject(_commands[alias]).external = externalCallback;
			}
		}
		
		/**
		 * @private
		 */
		public function runCommand(alias:String):void
		{
			alias = alias.toLocaleLowerCase();
			
			if(_commands[alias] != null)
			{
				CommandObject(_commands[alias]).run();
			}
		}
		
		/**
		 * Удаление консольной команды
		 * 
		 * @param alias алиас команды
		 */
		public function removeCommand(alias:String):void
		{
			alias = alias.toLocaleLowerCase();
			
			CommandObject(_commands[alias]).destruct();
			delete _commands[alias];
		}
		
		/**
		 * @private
		 */
		public function getAlias(alias:String):String
		{
			alias = alias.toLocaleLowerCase();
			
			var item:Object;
			var index:int;
			
			for(item in _commands)
			{
				index = CommandObject(_commands[item]).alias.lastIndexOf(alias);
				if(index != -1){					
					return CommandObject(_commands[item]).alias.substr(alias.length + index, CommandObject(_commands[item]).alias.length - (alias.length + index));
				}
			}
			
			return "";
		}
		
		/**
		 * @private
		 */
		public function listRegisteredCommands():void
		{
			var item:Object;
			
			for(item in _commands)
			{
				trace("Command "+CommandObject(_commands[item]).alias+" (External: "+CommandObject(_commands[item]).external+")");
			}
		}
		
	}
}