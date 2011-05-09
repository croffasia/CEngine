/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.base.resources
{
	import com.adobe.crypto.MD5;
	import com.mrbee.cengine.CEngine;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	
	/**
	 * Базовый мувиклип ресурс. Расширяет стандартный класс MovieClip для более удобной работы с ресурсами CEngine.
	 * @author Poluosmak Andrew
	 */
	public class BaseSpriteResource extends Sprite
	{
		/**
		 * @private
		 */
		private var _translatedTextFields:Dictionary; 
		
		/**
		 * @private
		 */
		private var _eventGroupName:String = "";
		
		/**
		 * @private
		 */
		public function BaseSpriteResource()
		{
			super();
			
			_translatedTextFields = new Dictionary(true);
			
			var date:Date = new Date();
			_eventGroupName = MD5.hash(date.toTimeString()+String(Math.floor(Math.random() * (10000000)) + 1));
		}
		
		/**
		 * Функция добавления события. Рекомендуем использовать ее лишь при необходимости визуальных изменений, которые зависят от определенных событий.
		 * 
		 * @param type Тип события
		 * @param callbackFunction функция обработчик
		 * @param autoRemove флаг автоудаления, после первого срабатывания события
		 */
		protected function addEvent(type:String, callbackFunction:Function, autoRemove:Boolean = false):void
		{
			CEngine.eventManager.add(this, type, callbackFunction, autoRemove, _eventGroupName);    
		}
		
		/**
		 * Регистрация текстового поля для переводов.
		 * 
		 * @param tfField TextField объект
		 * @param languageVar название переменной в переводах
		 * @param languageVarGroup название группы, которой принадлежит переменная для перевода 
		 * @param autoRemove флаг автоудаления поля из активных переводов. Поле будет удалено автоматически, при удалении его со сцены
		 * @param callbackCommit функция для обработки перевода. Принимает один текстовый параметр, возвращать долна обработанный текст 
		 */
		protected function registerTranslate(tfField:TextField, languageVar:String, languageVarGroup:String, autoRemove:Boolean = true, callbackCommit:Function = null):void
		{
			CEngine.languageManager.registerTextField(tfField, languageVar, languageVarGroup, autoRemove, callbackCommit);
			
			if(autoRemove == false)
				_translatedTextFields[tfField] = tfField;
		}
		
		/**
		 * Очистка данных реусра перед удалением. При переопределении фукнции, обязательно вызывайте супер метод, 
		 * для полного удаления не нужных объектов.
		 */
		public function destruct():void
		{
			CEngine.eventManager.removeGroup(_eventGroupName);
			
			var item:Object;
			
			for(item in _translatedTextFields){
				CEngine.languageManager.unregisterTextField(_translatedTextFields[item]);
				delete _translatedTextFields[item];
			}
			
			_translatedTextFields = null;
		}
	}
}