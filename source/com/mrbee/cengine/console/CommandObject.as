/******************************************************************
 * CEngine - AS3 component game framework
 * Copyright (C) 2011 Mr.Bee, LLC
 * For more information see http://www.mrbee.com.ua
 ****************************************************************/
package com.mrbee.cengine.console
{
	/**
	 * @private
	 * @author Poluosmak Andrew
	 */
	public class CommandObject
	{
		private var _alias:String;
		private var _external:Function;
		
		public function CommandObject()
		{
		}
		
		public function destruct():void
		{
			_external = null;
			_alias = "";
		}
		
		public function run():void
		{
			if(_external != null)
				_external();
		}

		public function get alias():String
		{
			return _alias;
		}

		public function set alias(value:String):void
		{
			_alias = value;
		}

		public function get external():Function
		{
			return _external;
		}

		public function set external(value:Function):void
		{
			_external = value;
		}


	}
}