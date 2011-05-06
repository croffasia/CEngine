/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.base.components 
{
	import com.adobe.crypto.MD5;
	import com.mrbee.cengine.CEngine;
	import com.mrbee.cengine.cinterface.IEventComponent;
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * Событийный компонент. Данный компонент имеет набор функций, позволяющих удобно работать с событиями. 
	 * Этот тип компонента удобно использовать в качестве контроллеров действий или реакции на события определенного объекта в системе.
	 * 
	 * @see com.mrbee.cengine.base.components.Graphics2DComponent
	 * @see com.mrbee.cengine.base.components.StateComponent
	 * @author Poluosmak Andrew
	 */
	
	public class EventComponent extends EntityComponent implements IEventComponent
	{	
		/** 
		 * @private 
		 */
		private var _eventGroupName:String = "";		
		
		/**
		 * Локальный диспетчер событий 
		 * @private 
		 */
		private var _localEventDispatcher:EventDispatcher = null;
		
		/**
		 * @private
		 */
		public function EventComponent() 
		{
			_localEventDispatcher = new EventDispatcher();
			
			// generate new event group name
			var date:Date = new Date();
			_eventGroupName = MD5.hash(date.toTimeString()+String(Math.floor(Math.random() * (10000000)) + 1));
		}
		
		/** 
		 * @inheritDoc 
		 */
		override public function onAddHandler():void
		{
			super.onAddHandler();
		}
		
		/** 
		 * @inheritDoc 
		 */
		override public function onRemoveHandler():void
		{
			this.removeEvent();
			super.onRemoveHandler();
		}
		
		/**
		 * Добавление нового события
		 * 
		 * @param event тип события
		 * @param callback функция обработчик события
		 * @param isLocal идентификатор используемого диспетчера событий <ul><li>true: локальный</li><li>false: глобальный</li></ul>
		 * @param dispatcher новый диспетчер событий IEventDispatcher объект. В случае если передан новый диспетчер событий, то параметр isLocal игнорируется  
		 * @param autoRemove флаг говорящий об автоудалении события, после первого вызова (true/false) 
		 */
		final public function addEvent(event:String, callback:Function, isLocal:Boolean = true, dispatcher:IEventDispatcher = null, autoRemove:Boolean = false):void
		{						
			if(isLocal == false && dispatcher == null){
				CEngine.eventManager.add(CEngine.eventDispatcher, event, callback, autoRemove, _eventGroupName);   
			} else if(isLocal == true && dispatcher == null) {
				CEngine.eventManager.add(_localEventDispatcher, event, callback, autoRemove, _eventGroupName);
			} else if(dispatcher != null){
				CEngine.eventManager.add(dispatcher, event, callback, autoRemove, _eventGroupName);
			}
		}
		
		/**
		 * Удаление события. Если функция вызывается без параметров, то удаляются все события созданные в компоненте.
		 * 
		 * @param event тип события
		 * @param callback функция обработчик
		 */
		final public function removeEvent(event:String = "", callback:Function = null):void
		{
			if (callback != null && event != "")				
				CEngine.eventManager.removeCallbackEvent(callback, event);
			else if(callback != null && event == "")
				CEngine.eventManager.removeCallback(callback);
			else if(callback == null && event != "")
				CEngine.eventManager.removeEvent(event);
			else
				CEngine.eventManager.removeGroup(_eventGroupName);
		}
		
		/**
		 * Отключение событий. Если функция вызывается без параметров, то отключаются все события созданные в компоненте.
		 * 
		 * @param event тип события
		 * @param callback функция обработчик
		 */
		final public function disableEvent(event:String = "", callback:Function = null):void
		{
			if (callback != null && event != "")
				CEngine.eventManager.disableCallbackEvent(callback, event); 
			else if(callback != null && event == "")
				CEngine.eventManager.disableCallback(callback); 
			else if(callback == null && event != "")
				CEngine.eventManager.disableEvent(event);
			else
				CEngine.eventManager.disableGroup(_eventGroupName);
		}
		
		/**
		 * Включение событий. Если функция вызывается без параметров, то включаются все отключенные события созданные в компоненте.
		 * 
		 * @param event тип события
		 * @param callback функция обработчик
		 */
		final public function enableEvent(event:String = "", callback:Function = null):void
		{
			if (callback != null && event != "")
				CEngine.eventManager.enableCallbackEvent(callback, event);
			else if(callback != null && event == "")
				CEngine.eventManager.enableCallback(callback); 
			else if(callback == null && event != "")
				CEngine.eventManager.enableEvent(event); 
			else
				CEngine.eventManager.enableGroup(_eventGroupName); 
		}
		
		/**
		 * Объект локального диспетчера событий
		 */
		public function get localEventDispatcher():EventDispatcher { return _localEventDispatcher; }
		
	}

}