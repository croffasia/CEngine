/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.utils.console.commands
{
	import com.mrbee.cengine.cinterface.ICentity;
	import com.mrbee.cengine.console.logger.Logger;
	import com.mrbee.cengine.managers.EntityManager;
	import com.mrbee.cengine.utils.ReferenceUtils;

	/**
	 * Консольная утилита для работы с PropertyReference. 
	 * Утилита для работы команды <code>execute.property</code>.
	 * <p>Пример вызова:
	 * <code>
	 * execute.property -p PropertyString param1 param2
	 * </code>
	 * где, PropertyString - это путь к конечному объекту, к которомы вы хотите получить доступ. param1, param2 передаются в случае если вызывается метод вашего компонента, который должен принять какое-то количество параметров.</p>
	 * 
	 * @author Poluosmak Andrew
	 */
	public class ExecuteProperty
	{
		/**
		 * Выполняет команду
		 * 
		 * @param propertyString PropertyReference пусть к объекту
		 * @param arg параметры, которые нужно передать в вызываемый объект, в случае если он является функцикцией и принимает такое же количество параметров 
		 */
		public static function exec(propertyString:String, ... arg):void
		{			
			var systemEntity:ICentity = EntityManager.getInstance().create("SystemExecutePropertyEntity");
			var result:* = systemEntity.getProperty(ReferenceUtils.getReference(propertyString));
			
			if(result is Function){
				var resFunction:*;
				if(arg != null){
					resFunction = result.apply(null, arg);
				} else {
					resFunction = result(); 
				}
				
				if(resFunction != undefined){
					Logger.info(ExecuteProperty, "Execute result: function "+ReferenceUtils.getReference(propertyString).property+" returned " + resFunction);
				} else {
					Logger.info(ExecuteProperty, "Execute result: function "+ReferenceUtils.getReference(propertyString).property+" running and nothing returned");
				}
			} else {
				Logger.info(ExecuteProperty, "Execute result: " + result);
			}
			
			systemEntity.remove();
			
		}
	}
}