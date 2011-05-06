/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.managers.objects 
{
	import flash.net.URLLoader;
	
	/**
	 * @private
	 * @author Poluosmak Andrew
	 */
	
	public class LanguageLoader extends URLLoader
	{
		private var _languageID:String = "";
		
		public function LanguageLoader() 
		{
			super();
		}
		
		public function get languageID():String { return _languageID; }
		
		public function set languageID(value:String):void 
		{
			_languageID = value;
		}
		
	}

}