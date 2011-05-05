package com.mrbee.cengine.components.social.networks.methods 
{
	import com.mrbee.cengine.components.social.networks.ISocialMethod;
	
	/**
	 * @private
	 * @author Poluosmak Andrew
	 */
	
	public interface IGetFriendsMethod extends ISocialMethod
	{
		function get uid():String;
		
		function set uid(value:String):void;
	}
	
}