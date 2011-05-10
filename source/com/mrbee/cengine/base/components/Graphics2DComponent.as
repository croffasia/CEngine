/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.base.components 
{
	import com.mrbee.cengine.CEngine;
	import com.mrbee.cengine.cinterface.IGraphics2DComponent;
	import com.mrbee.cengine.managers.LayerManager;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	/**
	 * Графический компонент. Компонент имеет набор функций для работы с графическим контейнером. Для каждого компонента создается новый контейнер Sprite, 
	 * который размещается на главной сцене приложения в указанном слое. Компонент наследуется от событийного компонента и имеет все его свойства и методы. 
	 * 
	 * @author Poluosmak Andrew
	 */
	
	public class Graphics2DComponent extends EventComponent implements IGraphics2DComponent
	{
		/**
		 * @private
		 */
		private var _displayObject:Sprite = null;
		
		/**
		 * @private
		 */
		private var _scene:String = "";
		
		/**
		 * @private
		 */
		public function Graphics2DComponent() {
			super();					
		}
		
		/**
		 * @inheritDoc
		 */
		override public function onAddHandler():void {					
			super.onAddHandler();
			
			_displayObject = new Sprite();
			
			if(_scene != "" && CEngine.layerManager.getLayer(_scene) != null){
				CEngine.layerManager.getLayer(_scene).addChild(_displayObject);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function onRemoveHandler():void {					
			super.onRemoveHandler();			
			clearContainer();
		}
	
		/**
		 * Добавление нового DisplayObject объекта в графический контейнер компонента
		 *  
		 * @param object DisplayObject объект
		 * @param index индекс вложенности
		 * 
		 * @return Boolean
		 */
		final public function addDisplayObject(object:DisplayObject, index:int = 0):Boolean {
			if (!_displayObject.contains(object)) {
				if(index == 0)
					_displayObject.addChild(object);
				else
					_displayObject.addChildAt(object, index);
					
				return true;
			}
			
			return false;
		}
		
		/**
		 * Изменение слоя, на котором распологается графический контейнер компонента
		 * @param newScene имя нового слоя
		 */
		final public function changeScene(newScene:String):void {
			if(_displayObject != null)
			{
				if(CEngine.layerManager.getLayer(_scene).contains(_displayObject))
				{
					CEngine.layerManager.getLayer(_scene).removeChild(_displayObject);
					
					if(CEngine.layerManager.getLayer(newScene)){
						CEngine.layerManager.getLayer(newScene).addChild(_displayObject);
						_scene = newScene;
					}
				}
			}
		}
		
		/**
		 * Получение DisplayObject объека с графичесокго контейнера компонента
		 * @param name имя DisplayObject объекта
		 * 
		 * @return DisplayObject
		 */
		final public function getDisplayObject(name:String):DisplayObject {
			return _displayObject.getChildByName(name);
		}
		
		/**
		 * Удаление DisplayObject объекта с контейнера
		 * @param object DisplayObject объект, который нужно удалить
		 */		
		final public function removeDisplayObject(object:DisplayObject):void {
			if(_displayObject.contains(object))
				_displayObject.removeChild(object);
		}
		
		/**
		 * Удаление DisplayObject объекта с контейнера по его имени
		 * @param name имя DisplayObject объекта в контейнере
		 */
		final public function removeDisplayObjectByName(name:String):void {
			var dso:DisplayObject = getDisplayObject(name);
			if(dso != null)
				removeDisplayObject(dso);
		}
		
		/**
		 * Объект контейнера
		 * @return Sprite
		 */
		final public function getContainer():Sprite {
			return _displayObject;
		}
		
		/**
		 * Очищает контейнер
		 */
		final public function clearContainer():void {
			if(_displayObject != null){
				while (_displayObject.numChildren > 0) 
				{ 
					_displayObject.removeChildAt(0);
				}
				
				if(_scene != "" && CEngine.layerManager.contains(_scene, _displayObject) == true)
				{
					CEngine.layerManager.getLayer(_scene).removeChild(_displayObject);
				}
			}			
		}
		
		/**
		 * Указатель слоя, на котором будет расположен контейнер
		 */
		final public function set scene(value:String):void {
			_scene = value;			
		}
		
		/** 
		 * Ширина контейнера 
		 */
		public function get width():Number { 
			return _displayObject.width; 
		}
		
		/**
		 * Высота контейнера
		 */
		public function get height():int { 
			return _displayObject.height; 
		}
		
		/** 
		 * Фильтры контейнера 
		 */		
		public function get filters():Array { 
			return _displayObject.filters; 
		}	
		
		/**
		 * @private
		 */
		public function set filters(value:Array):void {
			_displayObject.filters = value;
		}	
		
		/** 
		 * Alpha канал контейнера 
		 */		
		public function get alpha():Number { 
			return _displayObject.alpha; 
		}	
			
		/**
		 * @private
		 */
		public function set alpha(value:Number):void {
			_displayObject.alpha = value;
		}	
		
		/** 
		 * Отключение / влючение двойного клика контейнера 
		 */		
		public function get doubleClickEnabled():Boolean { 
			return _displayObject.doubleClickEnabled; 
		}	
			
		/**
		 * @private
		 */
		public function set doubleClickEnabled(value:Boolean):void {
			_displayObject.doubleClickEnabled = value;
		}	
		
		/**
		 * Включение / Отключение обработчика MOUSE событий  
		 */		
		public function get mouseChildren():Boolean { 
			return _displayObject.mouseChildren; 
		}	
			
		/**
		 * @private
		 */
		public function set mouseChildren(value:Boolean):void {
			_displayObject.mouseChildren = value;
		}
		
		/**
		 * Включение / Отключение Bitmap кеширования контейнера
		 */		
		public function get cacheAsBitmap():Boolean { 
			return _displayObject.cacheAsBitmap; 
		}	
			
		/**
		 * @private
		 */
		public function set cacheAsBitmap(value:Boolean):void {
			_displayObject.cacheAsBitmap = value;
		}
		
		/**
		 * Координаты по мыши над контейнером по X оси 
		 */		
		public function get mouseX():Number { 
			return _displayObject.mouseX; 
		}	
		
		/** 
		 * Координаты по мыши над контейнером по Y оси 
		 */		
		public function get mouseY():Number { 
			return _displayObject.mouseY; 
		}	
		
		/** 
		 * Количество вложенных DisplayObject объектов в контейнере
		 */		
		public function get numChildren():Number { 
			return _displayObject.numChildren; 
		}	
		
	}

}