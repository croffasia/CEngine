package com.mrbee.cengine.managers.objects
{
	import flash.display.Sprite;
	
	/** 
	 * @private 
	 */
	public class LayerObject extends Sprite
	{		
		public static const ALIGN_TOP:String = "top";
		public static const ALIGN_BOTTOM:String = "bottom";
		public static const ALIGN_LEFT:String = "left";
		public static const ALIGN_RIGHT:String = "right"; 
		
		public function LayerObject()
		{
			super();			
		}
				
		public function setAlign(align:String, removePrevious:Boolean = false):void
		{
			//
		}
		
	}
}