package com.mrbee.cengine.components.list 
{
	import com.mrbee.cengine.base.components.EntityComponent;
	import com.mrbee.cengine.cinterface.IDataComponent;
	import com.mrbee.cengine.core.PropertyReference;
	
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Poluosmak Andrew
	 */
	
	public class ListComponent extends EntityComponent
	{
		/** Референс на дата компонент, который нужно листать **/
		public var dataComponentReference:PropertyReference = null;
		
		/** Имя компонента **/
		public static const NAME:String = "SystemComponent_dataComponent";
		
		public static const DIRECTION_RIGHT:String = "right";
		public static const DIRECTION_LEFT:String = "left";
		
		private var _filters:Array;
		
		/** Count items **/
		private var _countItems:int = 0;
		
		/** Count visible elements **/
		private var _visibleItems:int = 0;
		
		private var _listItems:int = 0;	
		
		/** Current listing position **/
		private var _currentPosition:int = 0;
		
		private var _finishItem:int = _visibleItems;
		private var _totalItems:int = 0;
		private var _dataArray:Array;
		 
		private var _dataComponent:IDataComponent;
		
		public function ListComponent() 
		{
			super();
		}
		
		/**
		 * Generate visible list
		 * @param	direction - list direction (right, left)
		 */
		public function generateList(direction:String = "", cacheData:Boolean = false):Dictionary
		{								
			var returnedDictionary:Dictionary = new Dictionary(true);
						
			// generate data
			generateDataArray(cacheData);
			
			if (direction == DIRECTION_RIGHT){
				rightList();
			} else if(direction == DIRECTION_LEFT){
				leftList();
			} else {
				_currentPosition = 0;
				_finishItem = _currentPosition + _visibleItems;
				
				if (_finishItem > _totalItems){
					_finishItem = _totalItems; 
				}							
			}
												
			var i:int = _currentPosition;
			var count:int = 0;
			
			returnedDictionary = null;
			returnedDictionary = new Dictionary(true);
			
			for (i; i < _finishItem; i++)
			{
				returnedDictionary[count] = _dataArray[i];
				count++;
			}
			
			return returnedDictionary;
		}
		
		protected function rightList():void
		{
			// add page counter
			_currentPosition += _listItems;
			
			// approve max page
			if (_currentPosition > _totalItems){
				_currentPosition -= _listItems;
			}
			
			// calculate start position				
			_finishItem = _currentPosition + _visibleItems;
				
			if (_finishItem > _totalItems){
				_finishItem = _totalItems;
				_currentPosition = _totalItems - _visibleItems; 
				
				if(_currentPosition < 0)
					_currentPosition = 0;
			}
		}
		
		protected function leftList():void
		{
			// add page counter
			_currentPosition -= _listItems;
			
			// approve max page
			if (_currentPosition <= 0){
				_currentPosition = 0;
			}
			
			// calculate start position				
			_finishItem = _currentPosition + _visibleItems;	
			
			if(_finishItem > _totalItems)
				_finishItem = _totalItems;
		}
		
		private function generateDataArray(cacheData:Boolean = false):void
		{
			if(_dataComponent == null || cacheData == false)
				_dataComponent = owner.getProperty(dataComponentReference) as IDataComponent;
			
			_dataArray = null;
			_dataArray = [];
			
			var dictionary:*;
			var objectItem:*
			
			if(_filters != null && _filters.length > 0)
			{
				dictionary = _dataComponent.search(_filters);
				_totalItems = dictionary.length;
			} else {
				dictionary = _dataComponent.getAll();
				_totalItems = _dataComponent.lenght;
			}
			
			
			for (objectItem in dictionary)
			{
				_dataArray.push(dictionary[objectItem]);
			}
						
		}
		
		public function get countItems():int { return _countItems; }
		
		public function set countItems(value:int):void 
		{
			_countItems = value;
		}
		
		public function get visibleItems():int { return _visibleItems; }
		
		public function set visibleItems(value:int):void 
		{
			_visibleItems = value;			
		}

		public function set listItems(value:int):void
		{
			_listItems = value;
		}

		/** Filters **/
		public function get filters():Array
		{
			return _filters;
		}

		/**
		 * @private
		 */
		public function set filters(value:Array):void
		{
			_filters = value;
		}

		
	}

}