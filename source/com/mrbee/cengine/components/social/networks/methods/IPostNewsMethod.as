package com.mrbee.cengine.components.social.networks.methods 
{
	import com.mrbee.cengine.components.social.networks.ISocialMethod;
	
	/**
	 * @private
	 * @author Poluosmak Andrew
	 */
	
	public interface IPostNewsMethod extends ISocialMethod
	{				
		function get attachment():String;
		
		function set attachment(value:String):void;
		
		function get owner_id():String;
		
		function set owner_id(value:String):void;		
		
		function get message():String;
		
		function set message(value:String):void;
	}
	
}