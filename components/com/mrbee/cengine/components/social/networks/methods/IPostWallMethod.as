package com.mrbee.cengine.components.social.networks.methods 
{
	import com.mrbee.cengine.components.social.networks.ISocialMethod;
	
	/**
	 * @private
	 * @author Poluosmak Andrew
	 */
	
	public interface IPostWallMethod extends ISocialMethod
	{				
		function get wallID():String;
		
		function set wallID(value:String):void;
		
		function get photoID():String;
		
		function set photoID(value:String):void;
		
		function get postID():String;
		
		function set postID(value:String):void;
		
		function get message():String;
		
		function set message(value:String):void;
	}
	
}