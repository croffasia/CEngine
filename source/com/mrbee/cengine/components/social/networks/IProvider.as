package com.mrbee.cengine.components.social.networks 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	
	/**
	 * @private
	 */
	public interface IProvider 
	{		
		function request(method: String, options: Object = null):void;
		
		function onResult(e:Event, options:Object, loader:URLLoader):void;
		
		function onIOError(e:IOErrorEvent, options:Object, loader:URLLoader):void;
		
		function onSecurityError(e:SecurityErrorEvent, options:Object, loader:URLLoader):void;
	}
	
}