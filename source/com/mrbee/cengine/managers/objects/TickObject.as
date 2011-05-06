/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.managers.objects 
{
	/** 
	 * @private 
	 * @author Poluosmak Andrew
	 */
	
	public class TickObject
	{
		/** Start time **/
		private var _started:int = 0;
		
		/** Delay time **/
		private var _delay:int = 0;
		
		/** Finish time (autocalculate) **/
		private var _finished:int = 0;
		
		/** Number of Repeat: -1 without repeat, 0 - autorepeat, etc. **/
		private var _repeat:Number = -1;
		
		/** Number of  alreade repeated **/
		private var _alreadyRepeat:int = 0;
		
		/** Is EnterFrame or Ticked **/
		private var _isFrame:Boolean = false;
		
		private var _hasDelete:Boolean = false;
		private var _isRunning:Boolean = false;
		
		/** 
		 * Callback function. Use DelegateFunction utils for create 
		 * Function reference with aditional arguments 
		 * **/
		private var _callbackDelegate:Function = null;		
		
		/**
		 * Calculate finish value
		 */
		private function calculate():void
		{
			_finished = _started + _delay;
		}
		
		public function destruct():void
		{
			callbackDelegate = null;
		}
		
		/********************** Getters & Setters **********************/
		
		/**
		 * Start time
		 */
		public function get started():int { return _started; }
		
		public function set started(value:int):void 
		{
			_started = value;			
			calculate();
		}
			
		public function get finished():int { return _finished; }
		
		public function get callbackDelegate():Function { return _callbackDelegate; }
		
		public function set callbackDelegate(value:Function):void 
		{
			_callbackDelegate = value;
		}
		
		public function get delay():int { return _delay; }
		
		public function set delay(value:int):void 
		{
			_delay = value;
			calculate();
		}
		
		public function get repeat():Number { return _repeat; }
		
		public function set repeat(value:Number):void 
		{
			_repeat = value;
		}
		
		public function get alreadyRepeat():int { return _alreadyRepeat; }
		
		public function set alreadyRepeat(value:int):void 
		{
			_alreadyRepeat = value;
		}
		
		public function get isFrame():Boolean { return _isFrame; }
		
		public function set isFrame(value:Boolean):void 
		{
			_isFrame = value;
		}
		
		public function get hasDelete():Boolean { return _hasDelete; }
		
		public function set hasDelete(value:Boolean):void 
		{
			_hasDelete = value;
		}
		
		public function get isRunning():Boolean { return _isRunning; }
		
		public function set isRunning(value:Boolean):void 
		{
			_isRunning = value;
		}
		
	}

}