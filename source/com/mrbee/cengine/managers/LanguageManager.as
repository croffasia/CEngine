package com.mrbee.cengine.managers 
{
	import com.mrbee.cengine.CEngine;
	import com.mrbee.cengine.events.LanguageEvent;
	import com.mrbee.cengine.managers.objects.LanguageLoader;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.sampler.getSize;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	/**
	 * <p>Менеджер мультиязычности. Менеджер мультиязычности управляет языковыми переводами приложения.</p> 
	 * <p>Для работы с менеджером достаточно зарегистрировать TextField объект в менеджере с указанием языковой переменной и не обязательным параметром группы, к 
	 * которой принадлежит переменная. Работа менеджера устроена таким образом, что тексты переводятся на лету и в переводе учавствуют исключительно зарегистрированные 
	 * текстовые поля</p>
	 * 
	 * @author Poluosmak Andrew
	 */
	 
	public class LanguageManager
	{
		/** 
		 * @private 
		 */
		private static var _instance:LanguageManager = null;
		
		/** 
		 * @private 
		 */
		private static const EVENT_GROUP:String = "LanguageManagerEvents";
		
		/** 
		 * @private 
		 */
		private var _langs:Dictionary;
		
		/** 
		 * @private 
		 */
		private var _activeTextFields:Dictionary;
		
		/** 
		 * @private 
		 */
		private var _currentLanguageID:String = "ru";
		
		/** 
		 * @private 
		 */
		private var _loader:URLLoader;
		
		/** 
		 * @private 
		 */
		private var _urlRequest:URLRequest;
		
		/** 
		 * @private 
		 */
		public function LanguageManager(caller:Function = null) 
		{
			if( caller != LanguageManager.getInstance )
                throw new Error ("LanguageManager is a singleton class, use getInstance() instead");
            if ( LanguageManager._instance != null )
                throw new Error( "Only one LanguageManager instance should be instantiated" );
				
			_langs = new Dictionary(true);
			_activeTextFields = new Dictionary(true);
			
			// глобальное событие на смену языка 
			CEngine.eventManager.add(CEngine.eventDispatcher, LanguageEvent.SET_LANGUAGE, onChangeLanguage, false, EVENT_GROUP);			
		}		
		
		/**
		 * Возвращает объект менеджера мультиязычности
		 * @return LanguageManager
		 */
		public static function getInstance():LanguageManager
		{
			if (_instance == null) 
				_instance = new LanguageManager(arguments.callee);
			
			return _instance;			
		}
		
		/**
		 * Регистрация новой языковой версии
		 * 
		 * @param langName название языка языка
		 * @param langID идентификатор языка
		 */
		public function registerLang(langName:String, langID:String):void
		{
			_langs[langID] = langName;
		}
		
		/**
		 * Удаление языковой версии
		 * 
		 * @param langID идентификатор удаляемого языка языка 
		 */
		public function unregisterLang(langID:String):void
		{
			delete _langs[langID];
		}
		
		/**
		 * Удаление текстовго поля с активных полей ожидаемых перевод
		 * 
		 * @param textField TextField объект
		 */
		public function unregisterTextField(textField:TextField):void
		{
			if(_activeTextFields[textField] != null){
				_activeTextFields[textField].field = null;
				_activeTextFields[textField].callback = null;	
				delete _activeTextFields[textField];
			}
		}
		
		/**
		 * Регистрация текстового поля для перевода
		 * 
		 * @param textfield - TextField объект, в котором нужно отображить данные перевода
		 * @param languageVariable название переменной в языковом файле
		 * @param languageGroup название группы, которой принадлежит переменная. Если группа не указана, то переменная должна лежать в коре XML документа
		 * @param autoRemove флаг автоудаления его из активных после удаления со стэйджа (данная опция добавяет новое событие на каждый добавляемый TextField объект, что несет за собой увеличение объема потребляемой памяти)
		 */
		public function registerTextField(textField:TextField, languageVariable:String, languageGroup:String = "", autoRemove:Boolean = false, preTranslateCallback:Function = null):void
		{
			_activeTextFields[textField] = {field: textField, variable: languageVariable, group: languageGroup, callback: preTranslateCallback};
			
			if(autoRemove == true){
				CEngine.eventManager.add(textField, Event.REMOVED_FROM_STAGE, onAutoRemove, true);
			}
			
			if(preTranslateCallback == null)
				translateText(textField, getLanguageVariable(languageVariable, languageGroup));
			else
				translateText(textField, preTranslateCallback(getLanguageVariable(languageVariable, languageGroup)));
		}
		
		/**
		 * Ручное обновление переводов в указанном текстовм поле
		 * 
		 * @param textField ранее зарегистрированное текстовое поле для перевода
		 */
		public function updateTranslate(textField:TextField):void
		{
			if(_activeTextFields[textField] != null){
				if(_activeTextFields[textField].callback == null)
					translateText(textField, getLanguageVariable(_activeTextFields[textField].variable, _activeTextFields[textField].grou));
				else
					translateText(textField, _activeTextFields[textField].callback(getLanguageVariable(_activeTextFields[textField].variable, _activeTextFields[textField].group)));
			}
		}
				
		/**
		 * Удаление всех активных текстовых полей, ожидаемых перевода
		 */
		public function unRegisterAllActiveTextFields(event:Event = null):void
		{
			var obj:Object;
			
			for(obj in _activeTextFields){
				_activeTextFields[obj].field = null;
				_activeTextFields[obj].callback = null;				
				delete _activeTextFields[obj];
			}			
		}
		
		/**
		 * Возвращает текстовое значение перевода
		 * 
		 * @param languageVariable название переменной в языковом файле
		 * @param languageGroup название группы, которой принадлежит переменная. Если группа не указана, то переменная должна лежать в коре XML документа
		 * 
		 * @return текствое значение перевода
		 */
		public function getLanguageVariable(variable:String, groupVariable:String):String
		{
			if (_langs[_currentLanguageID] != null){
				if (groupVariable != "")
					return _langs[_currentLanguageID][groupVariable][variable];
				else
					return _langs[_currentLanguageID][variable];
			}
			
			return "";
		}
		
		/**
		 * Регистрирует XML переводов в менеджере
		 * 
		 * @param langID идентификатор языка
		 * @param languageXML XML языковых переводов
		 * 
		 * @return текствое значение перевода
		 */
		public function addXMLLanguage(langID:String, languageXML:XML):void
		{
			_langs[langID] = languageXML;
		}
						
		/**
		 * Загружает языковой файл переводов из-вне. 
		 * 
		 * @param url URL адрес, по которому доступен XML файл переводов
		 * @param langID идентификатор языка
		 */
		public function loadLanguage(url:String, langID:String):void
		{
			if (_langs[langID]) {
				
				var urlRequest:URLRequest = new URLRequest(url);
				
				var loader:LanguageLoader = new LanguageLoader();
					loader.languageID = langID;
					loader.addEventListener(Event.COMPLETE, onLoadXml, false, 0, true);
					loader.load(urlRequest);					
			}			
		}		
		
		/**
		 * @private
		 * @param	e
		 */
		private function onLoadXml(e:Event):void 
		{
			LanguageLoader(e.target).removeEventListener(Event.COMPLETE, onLoadXml);
			
			var xml:XML = new XML(LanguageLoader(e.target).data);		
			_langs[LanguageLoader(e.target).languageID] = xml;
			
			onChangeLanguage(null);
		}
		
		/**
		 * @private
		 */
		private function onAutoRemove(e:Event):void
		{
			unregisterTextField(TextField(e.currentTarget));
		}
		
		/**
		 * @private
		 */
		private function onChangeLanguage(e:LanguageEvent = null, langID:String = ""):void
		{
			var obj:Object;
			
			if(e != null)
				currentLanguageID = e.languageID;
			else if(langID != "") 
				_currentLanguageID = langID;
						
			for(obj in _activeTextFields){
				if(_activeTextFields[obj].callback == null)
					translateText(TextField(_activeTextFields[obj].field), getLanguageVariable(_activeTextFields[obj].variable, _activeTextFields[obj].group));
				else
					translateText(TextField(_activeTextFields[obj].field), _activeTextFields[obj].callback(getLanguageVariable(_activeTextFields[obj].variable, _activeTextFields[obj].group)));
			}
		}
		
		/**
		 * @private
		 */
		private function translateText(textField:TextField, text:String):void
		{
			var tf:TextFormat = textField.getTextFormat();
			textField.htmlText = text;
			textField.setTextFormat(tf);
		}
		
		/**
		 * Активный язык переводов 
		 */
		public function get currentLanguageID():String { return _currentLanguageID; }
		
		/**
		 * @private
		 */
		public function set currentLanguageID(value:String):void 
		{
			_currentLanguageID = value;
		}
		
	}

}