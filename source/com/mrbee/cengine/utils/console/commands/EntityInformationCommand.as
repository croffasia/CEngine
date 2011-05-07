/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.utils.console.commands
{
	import com.mrbee.cengine.CEngine;
	import com.mrbee.cengine.cinterface.ICentity;
	import com.mrbee.cengine.console.logger.Logger;
	
	import flash.utils.Dictionary;
	
	/**
	 * Утилита для получения информации о заргеистрированных сущностях и их компонентов.
	 * 
	 * @author Poluosmak Andrew
	 */

	public class EntityInformationCommand
	{
		/**
		 * Список зерагистрированных сущностей в системе и количество 
		 * компонентов в каждой из них. 
		 * 
		 * @return String 
		 */
		static public function getEntityList():String
		{
			var allEntity:Dictionary = CEngine.entityManager.getAll();
			var entityName:String;
			var entityInfoArray:Array = [];
			var info:String = "";
			
			for(entityName in allEntity){
				
				info = " [";
				info += "Entity name: "+ICentity(allEntity[entityName]).name;
				info += "Count components: "+ICentity(allEntity[entityName]).numComponents;
				info += "] ";
				
				entityInfoArray.push(info);
			}
			
			var returnedString:String = entityInfoArray.join(", ");
			
			Logger.info(EntityInformationCommand, returnedString);
			
			return returnedString;
		}
	}
}