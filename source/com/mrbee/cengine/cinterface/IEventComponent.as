package com.mrbee.cengine.cinterface 
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * Интерфейс событийного компонента
	 * @see com.mrbee.cengine.base.components.EventComponent
	 * @author Poluosmak Andrew
	 */
	
	public interface IEventComponent 
	{
		/**
		 * Добавление нового события
		 * 
		 * @param event тип события
		 * @param callback функция обработчик события
		 * @param isLocal идентификатор используемого диспетчера событий <ul><li>true: локальный</li><li>false: глобальный</li></ul>
		 * @param dispatcher новый диспетчер событий IEventDispatcher объект. В случае если передан новый диспетчер событий, то параметр isLocal игнорируется  
		 * @param autoRemove флаг говорящий об автоудалении события, после первого вызова (true/false) 
		 */
		function addEvent(event:String, callback:Function, isLocal:Boolean = true, dispatcher:IEventDispatcher = null, autoRemove:Boolean = false):void;
		
		/**
		 * Удаление события. Если функция вызывается без параметров, то удаляются все события созданные в компоненте.
		 * 
		 * @param event тип события
		 * @param callback функция обработчик
		 */
		function removeEvent(event:String = "", callback:Function = null):void;
				
		/**
		 * Отключение событий. Если функция вызывается без параметров, то отключаются все события созданные в компоненте.
		 * 
		 * @param event тип события
		 * @param callback функция обработчик
		 */
		function disableEvent(event:String = "", callback:Function = null):void;
					
		/**
		 * Включение событий. Если функция вызывается без параметров, то включаются все отключенные события созданные в компоненте.
		 * 
		 * @param event тип события
		 * @param callback функция обработчик
		 */
		function enableEvent(event:String = "", callback:Function = null):void;		
		
		/**
		 * Объект локального диспетчера событий
		 */
		function get localEventDispatcher():EventDispatcher;
	}
	
}