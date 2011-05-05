package com.mrbee.cengine.utils
{
	import flash.utils.ByteArray;

	/**
	 * @private
	 */
	public class ObjectUtils
	{
		
		/**
		 * Clone object
		 */
		static public function clone(object:Object):* {
			var byteArray:ByteArray = new ByteArray();
			
			byteArray.writeObject(object);
			byteArray.position = 0;
			
			return byteArray.readObject();
		}
	}
}