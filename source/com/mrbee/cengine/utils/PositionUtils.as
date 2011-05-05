package com.mrbee.cengine.utils
{
	import com.mrbee.cengine.CEngine;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;

	/**
	 * Утилита для позиционирования графичесикх элементов. Данная утилита позиционирует DisplayObject объекты относительно слоев.  
	 */
	public class PositionUtils
	{	
		/**
		 * Позиционирование по центру
		 * 
		 * @param displayObject DisplayObject объект, который требуется спозиционировать
		 * @param layerName имя слоя, относительно которого позиционируем
		 */
		public static function center(displayObject:DisplayObject, layerName:String):void
		{
			var layer:Sprite = CEngine.layerManager.getLayer(layerName);
			  
			if(layer != null)
			{
				var _x:int = layer.stage.stageWidth / 2 - displayObject.width / 2;
				var _y:int = layer.stage.stageHeight / 2 - displayObject.height / 2;
				
				displayObject.x = _x;
				displayObject.y = _y;
			}
		}
		
		/**
		 * Установка отступа слева для DisplayObject объекта относительно указанного слоя  
		 * 
		 * @param displayObject DisplayObject объект, который требуется спозиционировать
		 * @param padding оступ в пикселях
		 * @param layerName имя слоя, относительно которого позиционируем
		 */
		public static function paddingLeft(displayObject:DisplayObject, padding:int, layerName:String):void
		{
			var layer:Sprite = CEngine.layerManager.getLayer(layerName);
			
			if(layer != null)
			{
				var _x:int = padding;
				
				displayObject.x = _x;
			}			
		}
		 
		/**
		 * Установка отступа справа для DisplayObject объекта относительно указанного слоя  
		 * 
		 * @param displayObject DisplayObject объект, который требуется спозиционировать
		 * @param padding оступ в пикселях
		 * @param layerName имя слоя, относительно которого позиционируем
		 */
		public static function paddingRight(displayObject:DisplayObject, padding:int, layerName:String):void
		{
			var layer:Sprite = CEngine.layerManager.getLayer(layerName);
			
			if(layer != null)
			{
				var _x:int = layer.stage.stageWidth - padding;
				
				displayObject.x = _x;
			}
		}
		
		/**
		 * Установка отступа сверху для DisplayObject объекта относительно указанного слоя  
		 * 
		 * @param displayObject DisplayObject объект, который требуется спозиционировать
		 * @param padding оступ в пикселях
		 * @param layerName имя слоя, относительно которого позиционируем
		 */
		public static function paddingTop(displayObject:DisplayObject, padding:int, layerName:String):void
		{
			var layer:Sprite = CEngine.layerManager.getLayer(layerName);
			
			if(layer != null)
			{
				displayObject.y = padding;				
			}			
		}
		
		/**
		 * Установка отступа снизу для DisplayObject объекта относительно указанного слоя  
		 * 
		 * @param displayObject DisplayObject объект, который требуется спозиционировать
		 * @param padding оступ в пикселях
		 * @param layerName имя слоя, относительно которого позиционируем
		 */
		public static function paddingBottom(displayObject:DisplayObject, padding:int, layerName:String):void
		{
			var layer:Sprite = CEngine.layerManager.getLayer(layerName);
			
			if(layer != null)
			{
				displayObject.y = layer.stage.stageHeight - padding;				
			}			
		}
	}
}