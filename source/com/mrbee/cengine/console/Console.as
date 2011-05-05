package com.mrbee.cengine.console
{
	import com.mrbee.cengine.utils.InformationUtils;
	import com.mrbee.cengine.utils.console.commands.EntityInformationCommand;
	
	import flash.display.Sprite;
	
	/**
	 * @private
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