package com.mrbee.cengine.console
{
	import com.mrbee.cengine.CEngine;
	import com.mrbee.cengine.console.logger.Logger;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	/**
	 * @private
	 */
	public class ConsoleController extends DrawConsole
	{
		public static const OPEN_KEY_KODE:int = 220;
		public static const SPEED:int = 15; 
		
		private static const EVENT_GROUP:String = "ConsoleController_EG";
		private static const PROCESS_NAME:String = "ConsoleController_Process";
		
		private var _isActive:Boolean = false;
		private var _isAnimate:Boolean = false;
		
		private var _maxY:int = 0;
		
		public function ConsoleController()
		{
			super();
						
			_maxY = Math.ceil(CEngine.mainStage.stage.stageHeight / 2);
			
			y = _maxY * -1;
			visible = false;
			
			draw();
						
			CEngine.eventManager.add(CEngine.mainStage.stage, KeyboardEvent.KEY_DOWN, toggleConsole, false, EVENT_GROUP);			
			CEngine.eventManager.add(_enterTf, KeyboardEvent.KEY_UP, enterConsole, false, EVENT_GROUP);				
		}				
		
		private function enterConsole(event:KeyboardEvent):void
		{			
			if(event.keyCode == Keyboard.ENTER)
			{
				ConsoleCommandManager.getInstance().runCommand(_enterTf.text);
			}
			
			var addedText:String = ConsoleCommandManager.getInstance().getAlias(_enterTf.text);
				
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
		
		private function fillLogHandler():void
		{
			addToLogTf(Logger.logsToString);
		}
		
		private function toggleConsole(event:KeyboardEvent):void
		{					
			if(_isAnimate == false && event.ctrlKey == true && event.keyCode == OPEN_KEY_KODE){
								
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
		
		
	}
}