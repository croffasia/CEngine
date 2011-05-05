package com.mrbee.cengine.managers.objects
{
	import flash.display.Loader;

	/** 
	 * @private 
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