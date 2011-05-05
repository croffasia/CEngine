package com.mrbee.cengine.utils
{
	import com.mrbee.cengine.console.logger.Logger;	
	import flash.text.Font;

	/**
	 * Информационные утилиты. Вспомогательные информационные утилиты
	 * 
	 * @author Poluosmak Andrew
	 */
	public class InformationUtils
	{		
		/**
		 * Вывод в консоль списка шрифтов подключенных к приложению
		 */
		static public function listEmbededFonts():void
		{ 
			Logger.info(InformationUtils, '[' + Font.enumerateFonts().map(function(e:*, i:int, arr:Array):String { return e.fontName  }) + ']');
		}
	}
}