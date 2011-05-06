/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.cinterface 
{
	
	/**
	 * Интерфейс тикед компонента.
	 * @author Poluosmak Andrew
	 */
	
	public interface ITickedComponent 
	{
		/**
		 * Регистрация процесса завязаного на TIMER
		 * 
		 * @param callback функция обработчик
		 * @param delay приодичность вызова в секундах
		 * @param isRepeat повторения вызовов: -1: один раз, 0: бесконечно, 1,2,3,*** указанное количество раз
		 */
		function registerForTick(callback:Function, delay:int = -1, isRepeat:Number = -1):void;
		
		/**
		 * Регистрация процесса завязаного на ENTER_FRAME
		 * 
		 * @param callback функция обработчик
		 * @param isRepeat повторения вызовов: -1: один раз, 0: бесконечно, 1,2,3,*** указанное количество раз
		 */
		function registerForFrame(callback:Function, isRepeat:Number = -1):void;
		
	}
	
}