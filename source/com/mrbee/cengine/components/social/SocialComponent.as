package com.mrbee.cengine.components.social 
{
	import com.mrbee.cengine.base.components.EventComponent;
	import com.mrbee.cengine.components.social.networks.IProvider;
	import com.mrbee.cengine.components.social.networks.ISocialMethod;
	import com.mrbee.cengine.components.social.networks.ISocialResponder;
	import com.mrbee.cengine.components.social.networks.Networks;
	import com.mrbee.cengine.components.social.SocialFactory;
	
	import flash.net.getClassByAlias;
	
	/**
	 * ...
	 * @author Poluosmak Andrew
	 */

	public class SocialComponent extends EventComponent implements ISocialComponent
	{
		public function SocialComponent() 
		{
			super();					
		}
		
		final public function caller(method:String):ISocialMethod
		{
			var methodClass:Class = getClassByAlias(method);
			var methodObject:ISocialMethod;
			
			if (methodClass != null){
				methodObject = new methodClass(onResultHandler, onErrorHandler);
				return methodObject;
			}
			
			return null;
		}
		
		public function getCurrentUid():String
		{
			return SocialFactory.getInstance().viewerID as String;
		}
		
		public function onResultHandler(responce:ISocialResponder):void { }
		
		public function onErrorHandler(responce:ISocialResponder):void{}
		
	}

}