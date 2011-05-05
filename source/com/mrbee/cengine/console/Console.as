package com.mrbee.cengine.console
{
	import com.mrbee.cengine.utils.InformationUtils;
	
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
		}
		
	}
}