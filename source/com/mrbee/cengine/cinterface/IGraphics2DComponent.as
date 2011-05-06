/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.cinterface 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	/**
	 * Интерфейс графического компонента
	 * @author Poluosmak Andrew
	 */
	
	public interface IGraphics2DComponent 
	{		 
		/**
		 * Указатель слоя, на котором будет расположен контейнер
		 */
		function set scene(value:String):void;
		
		/**
		 * Добавление нового DisplayObject объекта в графический контейнер компонента
		 *  
		 * @param object DisplayObject объект
		 * @param index индекс вложенности
		 * 
		 * @return Boolean
		 */
		function addDisplayObject(object:DisplayObject, index:int = 0):Boolean;
		
		/**
		 * Изменение слоя, на котором распологается графический контейнер компонента
		 * @param newScene имя нового слоя
		 */
		function changeScene(newScene:String):void;
		
		/**
		 * Получение DisplayObject объека с графичесокго контейнера компонента
		 * @param name имя DisplayObject объекта
		 * 
		 * @return DisplayObject
		 */
		function getDisplayObject(name:String):DisplayObject;		
		
		/**
		 * Объект контейнера
		 * @return Sprite
		 */
		function getContainer():Sprite;
		
		/**
		 * Удаление DisplayObject объекта с контейнера
		 * @param object DisplayObject объект, который нужно удалить
		 */	
		function removeDisplayObject(object:DisplayObject):void;
		
		/**
		 * Удаление DisplayObject объекта с контейнера по его имени
		 * @param name имя DisplayObject объекта в контейнере
		 */
		function removeDisplayObjectByName(name:String):void;
		
		/**
		 * Очищает контейнер
		 */
		function clearContainer():void;
		
		/** 
		 * Ширина контейнера 
		 */
		function get width():Number;
		
		/**
		 * Высота контейнера
		 */
		function get height():int;		
		
		/** 
		 * Фильтры контейнера 
		 */		
		function get filters():Array;
		
		/**
		 * @private
		 */
		function set filters(value:Array):void;
		
		/** 
		 * Alpha канал контейнера 
		 */			
		function get alpha():Number;
		
		/**
		 * @private
		 */
		function set alpha(value:Number):void;	
		
		/** 
		 * Отключение / влючение двойного клика контейнера 
		 */		
		function get doubleClickEnabled():Boolean;		
		
		/**
		 * @private
		 */
		function set doubleClickEnabled(value:Boolean):void;
		
		/**
		 * Включение / Отключение обработчика MOUSE событий  
		 */			
		function get mouseChildren():Boolean;	
		
		/**
		 * @private
		 */
		function set mouseChildren(value:Boolean):void;
		
		/**
		 * Включение / Отключение Bitmap кеширования контейнера
		 */	
		function get cacheAsBitmap():Boolean;
		
		/**
		 * @private
		 */
		function set cacheAsBitmap(value:Boolean):void;
		
		/**
		 * Координаты по мыши над контейнером по X оси 
		 */	
		function get mouseX():Number;
		
		/** 
		 * Координаты по мыши над контейнером по Y оси 
		 */	
		function get mouseY():Number;
		
		/** 
		 * Количество вложенных DisplayObject объектов в контейнере
		 */	
		function get numChildren():Number;
	}
	
}