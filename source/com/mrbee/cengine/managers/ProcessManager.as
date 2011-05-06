/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.managers 
{
	import com.mrbee.cengine.CEngine;
	import com.mrbee.cengine.managers.objects.TickObject;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	/**
	 * <p>Менеджер процессов. Менеджер процессов предназначен для контроля над процессами выполняемыми по событию <code>ENTER_FRAME</code> и <code>TIMER</code>.</p>
	 * <p>Настоятельно рекомендуем пользоваться менеджером процессов, т.к. он позволяет экономить ресурсы потребляемые приложением за счет того, что любые события 
	 * типа <code>ENTER_FRAME</code> и <code>TIMER</code> будут существовать в приложение в одном экземпляре.</p> 
	 *  
	 * @author Poluosmak Andrew
	 */
	
	public class ProcessManager 
	{		
		/**
		 * @private
		 */
		private static var _instance:ProcessManager;
		
		/**
		 * @private
		 */
		public static const TIMER_RATIO:int = 1;
		
		/**
		 * @private
		 */
		private const TIMER_DELAY:int = 1000;
		
		/**
		 * @private
		 */
		private const TIMER_MS:int = Math.ceil(TIMER_DELAY / TIMER_RATIO);
		
		/**
		 * @private
		 */
		private var _maxTikedObjectsPerTick:int = 5;
		
		/**
		 * @private
		 */
		private var _maxTikedObjectsPerFrame:int = 20;
		
		/**
		 * @private
		 */
		private var _timers:Dictionary;
		
		/**
		 * @private
		 */
		private var _timerStarted:int = 0;
		
		/**
		 * @private
		 */
		private var _timerCounter:int = 0;
		
		/**
		 * @private
		 */
		private var _systemTimer:Timer = null;
		
		/**
		 * @private
		 */
		public function ProcessManager(caller:Function = null) 
		{
			if( caller != ProcessManager.getInstance )
                throw new Error ("ProcessManager is a singleton class, use getInstance() instead");
            if ( ProcessManager._instance != null )
                throw new Error( "Only one ProcessManager instance should be instantiated" );
				
			initialize();			
		}
		
		/**
		 * @private
		 */
		private function initialize():void
		{
			// create timers dictionary
			_timers = new Dictionary(true);			
			
			// fix start time
			_timerStarted = new Date().time / 1000;
			_timerCounter = _timerStarted;
			
			_systemTimer = new Timer(TIMER_MS);
			_systemTimer.addEventListener(TimerEvent.TIMER, onTimerCallback, false, 0, true);
			_systemTimer.start();
			
			CEngine.mainStage.addEventListener(Event.ENTER_FRAME, onEnterFrameHandler, false, 0, true);
		}
		
		/**
		 * Возвращает объект менеджера процессов 
		 * 
		 * @return ProcessManager
		 */
		public static function getInstance():ProcessManager
		{
			if (_instance == null) 
				_instance = new ProcessManager(arguments.callee);
			
			return _instance;			
		}
		
		/**
		 * Удаляет группу процессов
		 * @param group название группы
		 */
		public function removeGroupTickedObjects(group:String):void
		{
			if (_timers[group] != null)
			{
				var tickObj:Object;

				for (tickObj in _timers[group])
				{				
					if(TickObject(_timers[group][tickObj]).isRunning == false){
						delete _timers[group][tickObj];
					} else {
						TickObject(_timers[group][tickObj]).hasDelete = true;
					}
				}
			}
		}		
		
		/**
		 * Добавляет новый процесс базирующийся на таймере
		 * 
		 * @param group название группы, к которой принадлежит процесс
		 * @param callback функция обработчик (используйте <code>DelegateFunction</code>)
		 * @param delay время, через которое будет срабатывать повтор
		 * @param isRepeat количество повторов <ul><li>-1 без повтора</li><li>0 неограниченное количество</li><li>1 и более указывают соотвествующее количество повторов</li></ul>
		 * 
		 *  @example Пример использования: 
		 * <listing version="3.0">
		 * CEngine.processManager.addTimerObject("TestTimer", onTimer, 1, 0); // Добавляем процесс в группу TestTimer, который будет каждую 1 секунду вызывать функцию onTimer
		 * CEngine.processManager.addTimerObject("TestTimer", onTimer, 1); // Добавляем процесс в группу TestTimer, который через 1 секунду вызовет функцию onTimer и удалит себя  
		 * </listing> 
		 */
		public function addTimerObject(group:String, callback:Function, delay:int= -1, isRepeat:Number = -1):void 
		{
			addTickedObject(group, callback, delay, isRepeat, false);
		}
		
		/**
		 * Добавляет новый процесс базирующийся на таймере
		 * 
		 * @param group название группы, к которой принадлежит процесс
		 * @param callback функция обработчик (используйте <code>DelegateFunction</code>)
		 * @param isRepeat количество повторов <ul><li>-1 без повтора</li><li>0 неограниченное количество</li><li>1 и более указывают соотвествующее количество повторов</li></ul>
		 * 
		 * @example Пример использования: 
		 * <listing version="3.0">
		 * CEngine.processManager.addFrameObject("TestFrame", onEnterFrame, 0); // Добавляем процесс в группу TestFrame, который будет вызывать функцию onEnterFrame при каждом вхождении ENTER_FRAME
		 * CEngine.processManager.addFrameObject("TestFrame", onEnterFrame, -1); // Добавляем процесс в группу TestFrame, который при вхождении ENTER_FRAME вызовет функцию onEnterFrame и удалит себя  
		 * </listing> 
		 */
		public function addFrameObject(group:String, callback:Function, isRepeat:Number = -1):void 
		{
			addTickedObject(group, callback, -1, isRepeat, true);
		}
		
		/**
		 * @private
		 */
		private function addTickedObject(group:String, callback:Function, delay:int = -1, isRepeat:Number = -1, isFrame:Boolean = false):void
		{
			var timckObj:TickObject = new TickObject();
				timckObj.started = _timerCounter;
				timckObj.delay = delay;
				timckObj.repeat = isRepeat;
				timckObj.isFrame = isFrame;
				timckObj.callbackDelegate = callback;
			
			if (_timers[group] == null)
				_timers[group] = new Dictionary();
			
			_timers[group][timckObj] = timckObj;
		}
		
		/**
		 * @private
		 */
		private function onTimerCallback(e:TimerEvent):void
		{
			_timerCounter++;
			
			var currentTicked:int = 0;
			
			if (maxTikedObjectsPerTick >= currentTicked)
			{
				var tickGroup:Object;
				var tickObj:Object;
				
				for (tickGroup in _timers)
				{
					for (tickObj in _timers[tickGroup])
					{
						if (TickObject(_timers[tickGroup][tickObj]).isFrame == false && TickObject(_timers[tickGroup][tickObj]).finished <= _timerCounter && TickObject(_timers[tickGroup][tickObj]).hasDelete == false){
							
							TickObject(_timers[tickGroup][tickObj]).isRunning = true;
							
							//set counter for tick
							currentTicked++;
							
							//Call caclback function
							if(TickObject(_timers[tickGroup][tickObj]).hasDelete == false && (TickObject(_timers[tickGroup][tickObj]).callbackDelegate) != null){
								(TickObject(_timers[tickGroup][tickObj]).callbackDelegate)();
							}
							
							// if ticked object has been deleted after first execute
							if (TickObject(_timers[tickGroup][tickObj]).repeat == -1){
								
								TickObject(_timers[tickGroup][tickObj]).destruct();
								delete _timers[tickGroup][tickObj];
								break;
							}
							
							// if ticked object have max repeated
							if (TickObject(_timers[tickGroup][tickObj]).repeat > 0){
								
								TickObject(_timers[tickGroup][tickObj]).alreadyRepeat++;
								
								// if max repeated, delete tick object
								if (TickObject(_timers[tickGroup][tickObj]).alreadyRepeat >= TickObject(_timers[tickGroup][tickObj]).repeat)
								{
									TickObject(_timers[tickGroup][tickObj]).destruct();
									delete _timers[tickGroup][tickObj];
									break;
								}
							}
							
							TickObject(_timers[tickGroup][tickObj]).started = _timerCounter;
							TickObject(_timers[tickGroup][tickObj]).isRunning = false;
							
							if (TickObject(_timers[tickGroup][tickObj]).hasDelete == true)
								delete _timers[tickGroup][tickObj];
						} else if(TickObject(_timers[tickGroup][tickObj]).hasDelete == true){
							TickObject(_timers[tickGroup][tickObj]).destruct();
							delete _timers[tickGroup][tickObj];
						}
					}
				}
			}
		}
		
		
		/**
		 * @private
		 */
		private function onEnterFrameHandler(e:Event):void
		{
			var currentTicked:int = 0;
			
			if (maxTikedObjectsPerFrame >= currentTicked)
			{
				var tickGroup:Object;
				var tickObj:Object;
				
				for (tickGroup in _timers)
				{
					for (tickObj in _timers[tickGroup])
					{
						if (TickObject(_timers[tickGroup][tickObj]).isFrame == true && TickObject(_timers[tickGroup][tickObj]).hasDelete == false){
									
							TickObject(_timers[tickGroup][tickObj]).isRunning = true;
							
							// if ticked object has been deleted after first execute
							if (TickObject(_timers[tickGroup][tickObj]).repeat == -1 && TickObject(_timers[tickGroup][tickObj]).alreadyRepeat > 0){
								
								TickObject(_timers[tickGroup][tickObj]).destruct();
								delete _timers[tickGroup][tickObj];
								break;
							}
													
							//set counter for tick
							currentTicked++;
							
							//Call caclback function
							if(TickObject(_timers[tickGroup][tickObj]).hasDelete == false && (TickObject(_timers[tickGroup][tickObj]).callbackDelegate) != null)
								(TickObject(_timers[tickGroup][tickObj]).callbackDelegate)();
							
							
							// if ticked object have max repeated
							if (TickObject(_timers[tickGroup][tickObj]).repeat > 0){
								
								TickObject(_timers[tickGroup][tickObj]).alreadyRepeat++;
								
								// if max repeated, delete tick object
								if (TickObject(_timers[tickGroup][tickObj]).alreadyRepeat >= TickObject(_timers[tickGroup][tickObj]).repeat)
								{
									TickObject(_timers[tickGroup][tickObj]).destruct();
									delete _timers[tickGroup][tickObj];
									break;
								}
							} else {
								TickObject(_timers[tickGroup][tickObj]).alreadyRepeat = 1;
							}						
							
							TickObject(_timers[tickGroup][tickObj]).isRunning = false;
							
							if (TickObject(_timers[tickGroup][tickObj]).hasDelete == true)
								delete _timers[tickGroup][tickObj];
						} else if(TickObject(_timers[tickGroup][tickObj]).hasDelete == true){
							TickObject(_timers[tickGroup][tickObj]).destruct();
							delete _timers[tickGroup][tickObj];
						}
					}
				}
			}
		}
		
		/**
		 * Максимальное количество одновременно обрабатываемых действий во время работы с таймером
		 */
		public function get maxTikedObjectsPerTick():int { return _maxTikedObjectsPerTick; }
		
		/**
		 * @private
		 */
		public function set maxTikedObjectsPerTick(value:int):void 
		{
			_maxTikedObjectsPerTick = value;
		}
		
		/**
		 * Максимальное количество одновременно обрабатываемых действий во время работы с фреймом
		 */
		public function get maxTikedObjectsPerFrame():int { return _maxTikedObjectsPerFrame; }
		
		/**
		 * @private
		 */
		public function set maxTikedObjectsPerFrame(value:int):void 
		{
			_maxTikedObjectsPerFrame = value;
		}
	}

}