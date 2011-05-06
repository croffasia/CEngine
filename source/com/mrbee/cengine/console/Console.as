/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.console
{
	import com.mrbee.cengine.utils.InformationUtils;
	import com.mrbee.cengine.utils.console.commands.EntityInformationCommand;
	
	import flash.display.Sprite;
	
	/**
	 * @private
	 * @author Poluosmak Andrew
	 */
	public class Console extends ConsoleController
	{
		public function Console()
		{
			super();
			
			ConsoleCommandManager.getInstance().addCommand("ListEmbededFonts", InformationUtils.listEmbededFonts);
			ConsoleCommandManager.getInstance().addCommand("Entity.info", EntityInformationCommand.getEntityList);			
		}
		
	}
}