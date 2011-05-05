package com.mrbee.cengine.base.components 
{
	import com.adobe.crypto.MD5;
	import com.mrbee.cengine.CEngine;
	import com.mrbee.cengine.cinterface.ITickedComponent;
	
	/**
	 * 
	 * @author Poluosmak Andrew
	 */
	
	public class TickedComponent extends EntityComponent implements ITickedComponent
	{
		/** Specific group name for process manager **/
		private var _processGroupName:String = "";
		
		public function TickedComponent() 
		{
			super();
			
			// generate new process manager group name
			var date:Date = new Date();
			_processGroupName = MD5.hash(date.toTimeString()+String(Math.floor(Math.random() * (10000000)) + 1));
		}
		
		public override function onAddHandler():void
		{			
			super.onAddHandler();
		}
		
		public override function onRemoveHandler():void
		{
			CEngine.processManager.removeGroupTickedObjects(_processGroupName);			
			super.onRemoveHandler();			
		}
		
		/**
		 * Add new ticked function
		 * @param	callback - Callback function. For create use DelegateFunction utils
		 * @param	delay - time delay
		 * @param	isRepeat - -1 without repeat, 0 - autorepeat, 1 - 1 repeat and etc...
		 */
		public function registerForTick(callback:Function, delay:int = -1, isRepeat:Number = -1):void
		{
			CEngine.processManager.addTimerObject(_processGroupName, callback, delay, isRepeat);
		}
		
		/**
		 * Add new frame function
		 * @param	callback - Callback function. For create use DelegateFunction utils
		 * @param	isRepeat - -1 without repeat, 0 - autorepeat, 1 - 1 repeat and etc...
		 */
		public function registerForFrame(callback:Function, isRepeat:Number = -1):void
		{
			CEngine.processManager.addFrameObject(_processGroupName, callback, isRepeat);
		}
		
	}

}