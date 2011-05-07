/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.utils
{
	import com.mrbee.cengine.core.PropertyReference;	
	import flash.utils.Dictionary;	
	import mx.utils.ObjectUtil;

	/**
	 * Пул PropertyReference объектов. 
	 * Хранит ранее созданные объекты PropertyReference для предотвращения создания избыточного количества одинаковых объектов в системе.
	 * 
	 * @author Poluosmak Andrew
	 */
	public class ReferenceUtils
	{
		/**
		 * @private
		 */
		static private var _referencePool:Dictionary = new Dictionary(true);
		
		/**
		 * Получение PropertyReference объекта
		 * 
		 * @param type строка запроса PropertyReference
		 * @param clone клонировать или отдать существующий объект
		 * 
		 * @return PropertyReference обект
		 */
		static public function getReference(type:String, clone:Boolean = false):PropertyReference
		{
			if(_referencePool[type] == null)
				_referencePool[type] = new PropertyReference(type);
			
			if(clone == true)
				return ObjectUtil.clone(_referencePool[type]) as PropertyReference;
			else
				return _referencePool[type] as PropertyReference;
		} 
	}
}