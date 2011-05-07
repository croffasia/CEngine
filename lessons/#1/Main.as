package 
{
	import app.entity.myfirstentity.MyFirstEntity;
	import com.mrbee.cengine.CEngine;
	import com.mrbee.cengine.console.logger.Logger;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * Урок №1. Создание сущностей и компонентов. 
	 * Результат работы урока будет виден в Ouput панели (для FlashDevelop) или Console панели (для Flash Builder).
	 * Не забудьте подключить к проекту классы фреймворка.
	 * 
	 * Дополнительная информация по этому уроку доступна здесь: https://github.com/PoluosmakAndrew/CEngine/wiki/Урок-1
	 * 
	 * @author Poluosmak Andrew
	 */
	
	public class Main extends Sprite 
	{		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// инициализация фреймворка
			CEngine.getInstance().initialize(this);	
			
			/**
			 * Метод логгера print замена стандартному trace(). 
			 * Если Logger.enabled выключен, информация не будет выведена. По умолчанию логер включен.
			 */
			Logger.print("Hello CEngine!");
			
			// создаем первую нашу сущность MyFirstEntity
			new MyFirstEntity();
									
		}
		
	}
	
}