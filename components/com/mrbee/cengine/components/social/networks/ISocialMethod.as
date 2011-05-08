package com.mrbee.cengine.components.social.networks 
{
	
	/**
	 * Интерфейс объекта метода API социальной сети
	 */
	public interface ISocialMethod 
	{
		/**
		 * Вызов метода API
		 */
		function call():void;
		
		/**
		 * Обработчик успешного результата запроса к API социальной сети
		 */
		function onResultHandler(response:*):void;
		
		/**
		 * Обработчик не успешного результата запроса к API социальной сети
		 */
		function onFailHandler(response:*):void;
	}
	
}