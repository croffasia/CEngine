package com.mrbee.cengine.cinterface 
{
	
	/**
	 * ...
	 * @author Poluosmak Andrew
	 */
	
	public interface ITickedComponent 
	{
		/**
		 * Add new ticked function
		 * @param	callback - Callback function. For create use DelegateFunction utils
		 * @param	delay - time delay
		 * @param	isRepeat - -1 without repeat, 0 - autorepeat, 1 - 1 repeat and etc...
		 */
		function registerForTick(callback:Function, delay:int = -1, isRepeat:Number = -1):void;
		
		/**
		 * Add new frame function
		 * @param	callback - Callback function. For create use DelegateFunction utils
		 * @param	isRepeat - -1 without repeat, 0 - autorepeat, 1 - 1 repeat and etc...
		 */
		function registerForFrame(callback:Function, isRepeat:Number = -1):void;
		
	}
	
}