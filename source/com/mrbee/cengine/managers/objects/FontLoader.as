/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.managers.objects
{
	import flash.display.Loader;

	/** 
	 * @private 
	 * @author Poluosmak Andrew
	 */
	public class FontLoader extends Loader
	{
		private var _fontName:String = "";
		
		public function FontLoader()
		{
			super();
		}

		public function get fontName():String
		{
			return _fontName;
		}

		public function set fontName(value:String):void
		{
			_fontName = value;
		}

	}
}