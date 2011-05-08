package com.mrbee.cengine.components.social.networks.vk.methods 
{
	import com.mrbee.cengine.components.social.networks.methods.IGetAppFriendsMethod;
	import com.mrbee.cengine.components.social.networks.responders.ProfileSocialResponder;
	import com.mrbee.cengine.components.social.networks.responders.ProfilesSocialResponder;
	import com.mrbee.cengine.components.social.SocialFactory;
	
	/**
	 * ...
	 * @author Poluosmak Andrew
	 */
	
	public class GetAppFriends implements IGetAppFriendsMethod
	{				
		private var _onResult:Function;
		private var _onFail:Function;
		
		public function GetAppFriends(onResult:Function, onFail:Function) 
		{
			_onFail = onFail;
			_onResult = onResult;
		}
		
		public function call():void
		{
			SocialFactory.getInstance().provider.request("friends.getAppUsers", { onComplete: onResultHandler, onError: onFailHandler});
		}
		
		/**
		 * Main result method callback
		 * @param	e
		 */
		public function onResultHandler(response:*):void
		{
			var responderProfile:ProfileSocialResponder;
			var responderProfiles:ProfilesSocialResponder = new ProfilesSocialResponder();
			
			for (var key:String in response) {
				
				responderProfile = new ProfileSocialResponder();
				
				responderProfile.socialID = String(response[key]);
				
				responderProfiles.add(responderProfile);
			}
					
			if (_onResult != null)
				_onResult(responderProfiles);	
		}
		
		/**
		 * Main fail method callback
		 * @param	e
		 */
		public function onFailHandler(e:*):void
		{
			var a:int;
		}
		
	}

}