package com.mrbee.cengine.components.social 
{
	import com.mrbee.cengine.components.social.networks.ISocialMethod;
	import com.mrbee.cengine.components.social.networks.ISocialResponder;
	
	/**
	 * ...
	 * @author Poluosmak Andrew
	 */
	public interface ISocialComponent 
	{		
		function caller(method:String):ISocialMethod;
		
		function onResultHandler(responce:ISocialResponder):void;
		
		function onErrorHandler(responce:ISocialResponder):void;
		
		function getCurrentUid():String;
	}
	
}