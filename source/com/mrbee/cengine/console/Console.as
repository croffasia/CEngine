/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.console
{
	import com.mrbee.cengine.utils.InformationUtils;
	import com.mrbee.cengine.utils.console.commands.EntityInformationCommand;
	import com.mrbee.cengine.utils.console.commands.ExecuteProperty;
	
	import flash.display.Sprite;
	
	/**
	 * Консоль для дебага. Консоль для дебага активируется автоматически. 
	 * Доступ к объекту консоли возможен посредством <code>CEngine</code>. 
	 * Вы можете установить статус - включена / выключена и горячую клавишу для 
	 * отображения консоли.
	 * 
	 * @see com.mrbee.cengine.CEngine#console
	 * @author Poluosmak Andrew
	 */
	public class Console extends ConsoleController
	{
		/**
		 * @private
		 */
		public function Console()
		{
			super();
			
			ConsoleCommandManager.getInstance().addCommand("ListEmbededFonts", InformationUtils.listEmbededFonts);
			ConsoleCommandManager.getInstance().addCommand("entity.info", EntityInformationCommand.getEntityList);
			ConsoleCommandManager.getInstance().addCommand("execute.property", ExecuteProperty.exec);
		}
		
		/**
		 * Код кнопки для коминации вызова консоли. 
		 * Используйте заготовленные константы в Keyboard классе. Вызов консоли происходит 
		 * при комбинации клавиши Ctrl + указанной вами или клавишей по умолчанию (обратный слеш) 
		 */
		override public function get openConsoleKeyCode():int
		{
			return super.openConsoleKeyCode;
		}
		
		/**
		 * Включение / Отключение вывода консоли
		 */
		override public function get enableConsole():Boolean
		{
			return super.enableConsole;
		}
		
		/**
		 * @private
		 */
		override public function set enableConsole(value:Boolean):void
		{
			super.enableConsole = value;
		}
		
		/**
		 * @private
		 */
		override public function set openConsoleKeyCode(value:int):void
		{
			super.openConsoleKeyCode = value;
		}
		
	}
}