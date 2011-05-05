package com.mrbee.cengine 
{
	import com.mrbee.cengine.console.Console;
	import com.mrbee.cengine.managers.EntityManager;
	import com.mrbee.cengine.managers.EventManager;
	import com.mrbee.cengine.managers.FontManager;
	import com.mrbee.cengine.managers.LanguageManager;
	import com.mrbee.cengine.managers.LayerManager;
	import com.mrbee.cengine.managers.ProcessManager;
	
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	

	/**
	 * Базовый класс фреймворка. Базовый класс содержит все необходимые для работы менеджеры и доступ к Flash vars объектам.
	 * 
	 * @author Poluosmak Andrew
	 */
	
	public class CEngine
	{
		/**
		 * @private
		 */ 
		private static var _instance:CEngine = null;
		
		/**
		 * @private
		 */ 
		private static var _eventDispatcher:EventDispatcher = null;
		
		/**
		 * @private
		 */
		private static var _mainStage:Sprite;	
		
		/**
		 * @private
		 */
		private static var _console:Console;
		
		/**
		 * Contructor
		 * @private
		 */
		public function CEngine(caller:Function = null) 
		{
			if( caller != CEngine.getInstance )
                throw new Error ("LayerManager is a singleton class, use getInstance() instead");
            if ( CEngine._instance != null )
                throw new Error( "Only one LayerManager instance should be instantiated" );
				
			init();
		}
		
		/**
		 * @private
		 */
		private function init():void
		{
			_eventDispatcher = new EventDispatcher();					
		}
		
		/**
		 * Возвращает объект CEngine
		 * @return CEngine
		 */
		public static function getInstance():CEngine
		{
			if (_instance == null) 
				_instance = new CEngine(arguments.callee);
			
			return _instance;			
		}
		
		/**
		 * Инициализирует фреймворк
		 * @param stage спрайт, от которого базируется приложение  
		 */ 
		public function initialize(stage:Sprite):void
		{
			_mainStage = stage;			
			layerManager.add(LayerManager.DEFAULT_LAYER);
			ProcessManager.getInstance();
			
			_console = new Console();
		}		
		
		/**
		 * Получение FlashVars переменых
		 * 
		 * @return Object
		 */
		public function getFlashVars():Object
		{
			/*var _flashVars:Object = { };
			_flashVars.referrer = "wall_view_inline";
			_flashVars.post_id = 100;
			_flashVars.viewer_type = 2;*/
			return _mainStage.loaderInfo.parameters;
			
			//return _flashVars;
		}
		
		/** 
		 * @private
		 */
		static public function get console():Console { return _console; }
		
		/** 
		 * Объект менеджера событий
		 */
		static public function get eventManager():EventManager { return EventManager.getInstance(); }
		
		/** 
		 * Объект менеджера сущностей
		 */
		static public function get entityManager():EntityManager { return EntityManager.getInstance(); }
		
		/** 
		 * Объект менеджера слоев
		 */
		static public function get layerManager():LayerManager { return LayerManager.getInstance(); }
		
		/** 
		 * Объект менеджера процессов
		 */
		static public function get processManager():ProcessManager { return ProcessManager.getInstance(); }
		
		/** 
		 * Объект менеджера языков
		 */
		static public function get languageManager():LanguageManager { return LanguageManager.getInstance(); }
		
		/** 
		 * Объект менеджера шрифтов
		 */
		static public function get fontManager():FontManager { return FontManager.getInstance(); }
		
		/**
		 * Базовый спрайм приложения
		 */
		static public function get mainStage():Sprite { return _mainStage; }
		
		/** 
		 * Глобальный дипетчер событий
		 */
		static public function get eventDispatcher():EventDispatcher { return _eventDispatcher; }		
		
	}

}