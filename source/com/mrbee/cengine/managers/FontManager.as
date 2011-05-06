/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.managers
{
	import com.mrbee.cengine.managers.objects.FontLoader;
	
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	/**
	 * <p>Менеджер шрифтов. Управляет ембедом шрифтов в вашем приложении.</p> 
	 * <p>Менеджер шрифтов позволяет добавлять в ваше приложение шрифты из внешнего SFW файла или же включенного в проект класса шрифта, а так же 
	 * менять шрифты в указанных TextField объектах.</p>
	 * 
	 * @author Poluosmak Andrew
	 */

	public class FontManager
	{
		/** 
		 * @private 
		 */
		private static var _instance:FontManager = null;
		
		/** 
		 * @private 
		 */
		private var _registeredFonts:Dictionary = null;
		
		/** 
		 * @private 
		 */
		private var _usedTextFields:Dictionary = null;
		
		/** 
		 * @private 
		 */
		public function FontManager(caller:Function = null) 
		{
			if( caller != FontManager.getInstance )
				throw new Error ("FontManager is a singleton class, use getInstance() instead");
			if ( FontManager._instance != null )
				throw new Error( "Only one FontManager instance should be instantiated" );
			
			_registeredFonts = new Dictionary();
			_usedTextFields = new Dictionary();
		}
		
		/**
		 * Возвращает объект менеджера шрифтов
		 * @return FontManager
		 */
		public static function getInstance():FontManager
		{
			if (_instance == null) 
				_instance = new FontManager(arguments.callee);
			
			return _instance;			
		}		
		
		/**
		 * Добавление шрифта с внешнего URL адреса.
		 * 
		 * @param name имя шрифта, по которому он будет доступен в менеджере
		 * @param url URL адрес SWF файла, в котором Export name шрифта соотвествует его имени в менеджере 
		 */
		public function addFont(name:String, url:String):void
		{
			var urlRequest:URLRequest = new URLRequest(url);
			
			var loader:FontLoader = new FontLoader();

			loader.fontName = name;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadFont, false, 0, true);
			loader.load(urlRequest);
		}
		
		/**
		 * Добавление шрифта включенным в проект классом шрифта.
		 * 
		 * @param name имя шрифта, по которому он будет доступен в менеджере
		 * @param fontClass <code>Class</code> добавляемого шрифта
		 */
		public function addFontClass(name:String, fontClass:Class):void
		{
			_registeredFonts[name] = new fontClass();
		}
		
		/**
		 * Удаление шрифта из менеджера
		 * 
		 * @param name имя удаляемого шрифта в менеджере
		 */
		public function removeFont(name:String):void
		{
			delete _registeredFonts[name];
		}
		
		/**
		 * Получение оригинального названия зарегитсрированного в менеджере шрифта шрифта
		 * 
		 * @param name имя шрифта в менеджере
		 * @return оригинальное название шрифта, которое можно использовать в CSS классах
		 */
		public function getOriginalFontName(systemName:String):String
		{
			if(_registeredFonts[systemName] != null)
				return Font(_registeredFonts[systemName]).fontName;
			
			return "";
		}
		
		/**
		 * Применяет указанный шрифт к текстовому полю типа TextField
		 * 
		 * @param name имя шрифта в менеджере
		 * @param textField <code>TextField</code> объект
		 */
		public function useFont(name:String, textField:TextField):void
		{			
			if(_registeredFonts[name]){
				var tf:TextFormat = textField.getTextFormat();
					tf.font = Font(_registeredFonts[name]).fontName;
					
				textField.setTextFormat(tf);
			}
		}
		
		/** 
		 * @private 
		 */
		private function onLoadFont(event:Event):void
		{			
			var floader:FontLoader = (event.target.loader as FontLoader);
			floader.removeEventListener(Event.COMPLETE, onLoadFont);
						
			_registeredFonts[floader.fontName] = new (floader.contentLoaderInfo.applicationDomain.getDefinition(floader.fontName) as Class);			
		}
		
	}
}