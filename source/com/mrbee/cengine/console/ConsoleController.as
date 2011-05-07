/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.console
{
	import com.mrbee.cengine.CEngine;
	import com.mrbee.cengine.console.logger.LogItem;
	import com.mrbee.cengine.console.logger.Logger;
	import com.mrbee.cengine.utils.DelegateFunction;
	
	import flash.events.ContextMenuEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.ui.Keyboard;

	/**
	 * @private
	 * @author Poluosmak Andrew
	 */
	public class ConsoleController extends DrawConsole
	{
		/**
		 * @private
		 */
		private var _openConsoleKeyCode:int = 220;
		
		/**
		 * @private
		 */
		private var _enableConsole:Boolean = true;
		
		/**
		 * @private
		 */
		public static const SPEED:int = 20; 
		
		/**
		 * @private
		 */
		private static const EVENT_GROUP:String = "ConsoleController_EG";
		
		/**
		 * @private
		 */
		private static const PROCESS_NAME:String = "ConsoleController_Process";
		
		/**
		 * @private
		 */
		private var _isActive:Boolean = false;
		
		/**
		 * @private
		 */
		private var _isAnimate:Boolean = false;
		
		/**
		 * @private
		 */
		private var _currentLogLevel:String = "";
		
		/**
		 * @private
		 */
		private var _maxY:int = 0;
		
		/**
		 * @private
		 */
		public function ConsoleController()
		{
			super();
						
			_maxY = Math.ceil(CEngine.mainStage.stage.stageHeight / 2);
			
			y = _maxY * -1;
			visible = false;
			
			draw();
						
			CEngine.eventManager.add(CEngine.mainStage.stage, KeyboardEvent.KEY_DOWN, toggleConsole, false, EVENT_GROUP);			
			CEngine.eventManager.add(_enterTf, KeyboardEvent.KEY_UP, enterConsole, false, EVENT_GROUP);
			
			createContextMenu();
		}	
		
		/**
		 * @private
		 */
		private function createContextMenu():void
		{
			var _contextMenu:ContextMenu = new ContextMenu();
			_contextMenu.hideBuiltInItems(); 			
			
			var clearMenuItem:ContextMenuItem = new ContextMenuItem("Clear");
			clearMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, clearConsole);			
			
			var errorItemFilterMenuItem:ContextMenuItem = new ContextMenuItem("Display ERROR");
			errorItemFilterMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, DelegateFunction.create(filterConsole, LogItem.ERROR));
			
			errorItemFilterMenuItem.separatorBefore = true;
			
			var noticeItemFilterMenuItem:ContextMenuItem = new ContextMenuItem("Display NOTICE");
			noticeItemFilterMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, DelegateFunction.create(filterConsole, LogItem.NOTICE));

			var infoItemFilterMenuItem:ContextMenuItem = new ContextMenuItem("Display INFO");
			infoItemFilterMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, DelegateFunction.create(filterConsole, LogItem.INFO));
			
			var allItemFilterMenuItem:ContextMenuItem = new ContextMenuItem("Display all");
			allItemFilterMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, DelegateFunction.create(filterConsole, ""));
						
			var copyrightItem:ContextMenuItem = new ContextMenuItem("Copyright (c) CEngine");
			
			copyrightItem.separatorBefore = true;
			_contextMenu.customItems.push(clearMenuItem, errorItemFilterMenuItem, noticeItemFilterMenuItem, infoItemFilterMenuItem, allItemFilterMenuItem, copyrightItem);
			
			this.contextMenu = _contextMenu;
		}
		
		/**
		 * @private
		 */
		protected function filterConsole(event:ContextMenuEvent, type:String):void
		{
			_currentLogLevel = type; 
		}
		
		/**
		 * @private
		 */
		protected function clearConsole(event:ContextMenuEvent):void
		{
			Logger.clear();
		}
		
		/**
		 * @private
		 */
		private function enterConsole(event:KeyboardEvent):void
		{		
			var addedText:String = "";
			
			if(event.keyCode == Keyboard.ENTER)
			{
				ConsoleCommandManager.getInstance().runCommand(_enterTf.text);
			}
			
			if(event.keyCode != Keyboard.BACKSPACE){
				addedText = ConsoleCommandManager.getInstance().getAlias(_enterTf.text);
			}
			
			if(addedText != "")
			{
				var startIndex:int = _enterTf.text.length; 
				//_enterTf.text = _enterTf.text.substr(0, _enterTf.text.length);
				_enterTf.text += addedText;
				_enterTf.setSelection(startIndex, _enterTf.text.length);				
			}
			
			if(event.keyCode == Keyboard.TAB)
			{
				_enterTf.text += " ";
				_enterTf.setSelection(_enterTf.text.length, _enterTf.text.length);
			}
		}
		
		/**
		 * @private
		 */
		private function fillLogHandler():void
		{
			addToLogTf(Logger.getLogItems(_currentLogLevel));
		}
		
		/**
		 * @private
		 */
		private function toggleConsole(event:KeyboardEvent):void
		{					
			if(_isAnimate == false && event.ctrlKey == true && event.keyCode == _openConsoleKeyCode && _enableConsole == true){
								
				_isAnimate = true;
				
				if(_isActive == false){						
					_isActive = true;
					CEngine.mainStage.addChild(this);
					CEngine.processManager.addTimerObject("_systemLogChecker", fillLogHandler, 1, 0);
					visible = true;							
					CEngine.processManager.addFrameObject(PROCESS_NAME, animateOpenConsole, 0);
				} else {
					//visible = false;
					CEngine.processManager.removeGroupTickedObjects("_systemLogChecker");
					CEngine.processManager.addFrameObject(PROCESS_NAME, animateCloseConsole, 0);
				}
			}
		}
		
		/**
		 * @private
		 */
		private function animateCloseConsole():void
		{
			if(y > _maxY * -1)
			{
				y = y - SPEED;
			} else {
				CEngine.processManager.removeGroupTickedObjects(PROCESS_NAME);
				_isAnimate = false;
				visible = false;
				_isActive = false;
				CEngine.mainStage.removeChild(this);
			}
		}
			
		/**
		 * @private
		 */
		private function animateOpenConsole():void
		{
			if(y < 0)
			{
				y = y + SPEED;
			} else {
				_enterTf.setSelection(0, 0);
				CEngine.processManager.removeGroupTickedObjects(PROCESS_NAME);
				_isAnimate = false;
			}
		}

		/**
		 * Код кнопки для коминации вызова консоли. 
		 * Используйте заготовленные константы в Keyboard классе.
		 */
		public function get openConsoleKeyCode():int
		{
			return _openConsoleKeyCode;
		}

		/**
		 * @private
		 */
		public function set openConsoleKeyCode(value:int):void
		{
			_openConsoleKeyCode = value;
		}

		/**
		 * Включение / Отключение вывода консоли
		 */
		public function get enableConsole():Boolean
		{
			return _enableConsole;
		}

		/**
		 * @private
		 */
		public function set enableConsole(value:Boolean):void
		{
			_enableConsole = value;
		}
		
		
	}
}