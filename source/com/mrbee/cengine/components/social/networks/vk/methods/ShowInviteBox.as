package com.mrbee.cengine.components.social.networks.vk.methods
{
	import com.mrbee.cengine.components.social.networks.methods.IShowInviteBoxMethod;
	
	import flash.external.ExternalInterface;
	
	public class ShowInviteBox implements IShowInviteBoxMethod
	{		
		public function ShowInviteBox(onResult:Function, onFail:Function)
		{
		}
		
		public function call():void
		{
			if(ExternalInterface.available == true){
				ExternalInterface.call("showInviteBox");
			}
		}
		
		public function onResultHandler(response:*):void
		{
		}
		
		public function onFailHandler(response:*):void
		{
		}
	}
}