/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.console
{
	import com.adobe.utils.StringUtil;
	import com.mrbee.cengine.console.logger.Logger;
	
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
			var params:Array = [];
			var paramString:String = "";
			
			if(alias.indexOf("-p"))
			{
				var split:Array = alias.split("-p"); 
				alias = StringUtil.trim(split[0]).toLocaleLowerCase();	
				paramString = StringUtil.trim(split[1]);
				
				split = paramString.split(" ");
				
				if(params != null){
					var i:int;
					for(i = 0; i < split.length; i++){
						params.push(StringUtil.trim(split[i]));
					}
				}
			} else {
				alias.toLocaleLowerCase();
			}
			
			if(_commands[alias] != null)
			{
				CommandObject(_commands[alias]).run.apply(null, params);
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
			var params:String = "";
			
			if(alias.indexOf("-p"))
			{
				var split:Array = alias.split("-p"); 
				alias = split[0];				
			}
			
			var item:Object;
			var result:Array;

			for(item in _commands)
			{				
				result = String(CommandObject(_commands[item]).alias).match('^'+alias+'.*');
				if(result != null && result[0] != null){
					return CommandObject(_commands[item]).alias.replace(alias, "");
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