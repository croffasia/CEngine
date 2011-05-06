/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.base.components 
{
	import com.adobe.crypto.MD5;
	import com.mrbee.cengine.CEngine;
	import com.mrbee.cengine.cinterface.ITickedComponent;
	
	/**
	 * Тикед компонент. Компонент предназначен для организации процессов 
	 * завязанных на TIMER и ENTER_FRAME. Используйте внутренние методы 
	 * для регистрации процессов.
	 * 
	 * @author Poluosmak Andrew
	 */
	
	public class TickedComponent extends EntityComponent implements ITickedComponent
	{
		/**
		 * Имя группы для добавляемых процессов 
		 */
		private var _processGroupName:String = "";
		
		/**
		 * @private
		 */
		public function TickedComponent() 
		{
			super();
			
			// generate new process manager group name
			var date:Date = new Date();
			_processGroupName = MD5.hash(date.toTimeString()+String(Math.floor(Math.random() * (10000000)) + 1));
		}
		
		/**
		 * @inheritDoc
		 */
		public override function onAddHandler():void
		{			
			super.onAddHandler();
		}
		
		/**
		 * @inheritDoc
		 */
		public override function onRemoveHandler():void
		{
			CEngine.processManager.removeGroupTickedObjects(_processGroupName);			
			super.onRemoveHandler();			
		}
		
		/**
		 * Регистрация процесса завязаного на TIMER
		 * 
		 * @param callback функция обработчик
		 * @param delay приодичность вызова в секундах
		 * @param isRepeat повторения вызовов: -1: один раз, 0: бесконечно, 1,2,3,*** указанное количество раз
		 */
		public function registerForTick(callback:Function, delay:int = -1, isRepeat:Number = -1):void
		{
			CEngine.processManager.addTimerObject(_processGroupName, callback, delay, isRepeat);
		}
		
		/**
		 * Регистрация процесса завязаного на ENTER_FRAME
		 * 
		 * @param callback функция обработчик
		 * @param isRepeat повторения вызовов: -1: один раз, 0: бесконечно, 1,2,3,*** указанное количество раз
		 */
		public function registerForFrame(callback:Function, isRepeat:Number = -1):void
		{
			CEngine.processManager.addFrameObject(_processGroupName, callback, isRepeat);
		}
		
	}

}