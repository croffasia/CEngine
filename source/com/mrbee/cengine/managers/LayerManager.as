package com.mrbee.cengine.managers 
{
	import com.mrbee.cengine.CEngine;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	/**
	 * <p>Менеджер слоев. Менеджер слоев позволяет управлять графическими слоями приложения.</p> 
	 * <p>Слой представляет собой <code>Sprite</code> объект, который имеет заранее определенный уровень вложенности и свои координаты. Слои как и в любом Графическом редакторе 
	 * помогают заренее определить уровни вложенности графических элементов приложения.</p>
	 * 
	 * @author Poluosmak Andrew
	 */
	
	public class LayerManager
	{
		/**
		 * @private
		 */
		private static var _instance:LayerManager = null;
		
		/**
		 * @private
		 */
		public static const DEFAULT_LAYER:String = "DefaultLayerManagerScene";
		
		/**
		 * @private
		 */
		public function LayerManager(caller:Function = null) 
		{
			if( caller != LayerManager.getInstance )
                throw new Error ("LayerManager is a singleton class, use getInstance() instead");
            if ( LayerManager._instance != null )
                throw new Error( "Only one LayerManager instance should be instantiated" );
		}
		
		/**
		 * Возвращает объект менеджера слоев
		 * @return LayerManager
		 */
		public static function getInstance():LayerManager
		{
			if (_instance == null) 
				_instance = new LayerManager(arguments.callee);
			
			return _instance;			
		}
		
		/**
		 * Добавляет новый слой
		 * 
		 * @param name имя слоя, по которому он будет доступен как в менеджере, так и в DisplayObject контейнере
		 * @param index индекс воженнсоти (не обязательный) 
		 * @param params (не обязательный) объект настроек слоя: <ul><li>positionX: позиция по X</li><li>positionY: позиция по Y</li><li>width: ширина стейджа</li><li>height: высота стэйджа</li></ul> 
		 */
		public function add(name:String, index:Number = -1, params:Object = null):void
		{						
			var layer:Sprite = new Sprite();
				layer.name = name;
				layer.tabEnabled = false;
				layer.tabChildren = false;
				
			if(params != null){
				
				if(params.positionX != null)
					layer.x = params.positionX;
				
				if(params.positionY != null)
					layer.y = params.positionY;
			}
			
			if (index != -1) {
				
				var oldChild:Sprite = CEngine.mainStage.getChildAt(index) as Sprite;
				 
				if (oldChild != null)
				{
					CEngine.mainStage.addChild(layer);
					CEngine.mainStage.swapChildren(oldChild, layer);
				} else {
					CEngine.mainStage.addChildAt(layer, index);
				}
			} else {
				CEngine.mainStage.addChild(layer);
			}
			
			if(params != null){
				
				if(params.width != null)
					layer.stage.stageWidth = params.width;
				
				if(params.height != null)
					layer.stage.stageHeight = params.height;
			}
		}
		
		
		/**
		 * Задает новую конфигурацию созданному ранее слою
		 * 
		 * @param name имя слоя, по которому он доступен в менеджере
		 * @param params (не обязательный) объект настроек слоя: <ul><li>positionX: позиция по X</li><li>positionY: позиция по Y</li><li>width: ширина стейджа</li><li>height: высота стэйджа</li></ul> 
		 */
		public function configureLayer(name:String, params:Object = null):void
		{
			var layer:Sprite = getLayer(name);
			
			if(layer != null){
				if(params != null){
					
					if(params.positionX != null)
						layer.x = params.positionX;
					
					if(params.positionY != null)
						layer.y = params.positionY;
					
					if(params.width != null)
						layer.stage.stageWidth = params.width;
					
					if(params.height != null)
						layer.stage.stageHeight = params.height;
					
				}
			}
		}
		
		/**
		 * Удаление слоя из менеджера
		 * 
		 * @param name имя слоя
		 * @param alwaysRemove флаг указывающий на то, что слой будет удален если в нем будут содержаться другие графические элементы
		 */
		public function removeLayer(name:String, alwaysRemove:Boolean = false):void
		{
			var oldChild:Sprite = CEngine.mainStage.getChildByName(name) as Sprite;
			
			if (oldChild != null && (oldChild.numChildren > 0 && alwaysRemove == true))
				CEngine.mainStage.removeChild(oldChild);
				
		}		
		
		/**
		 * Возвращает объект слоя
		 * 
		 * @param name имя слоя в менеджере
		 * 
		 * @return Sprite
		 */
		public function getLayer(name:String):Sprite
		{
			return CEngine.mainStage.getChildByName(name) as Sprite;
		}
		
		/**
		 * Очистка всех пустых слоев
		 */
		public function clearEmptyLayers():void
		{
			var index:int;
			var countChildrens:int = CEngine.mainStage.numChildren;
			
			for (index = 0; index < countChildrens; index++ )
			{
				if (Sprite(CEngine.mainStage.getChildAt(index)).numChildren == 0)
					CEngine.mainStage.removeChildAt(index);
			}
		}
		
	}

}