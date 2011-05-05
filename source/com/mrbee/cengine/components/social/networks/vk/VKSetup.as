package com.mrbee.cengine.components.social.networks.vk 
{
	import com.mrbee.cengine.components.social.networks.SocialMethod;
	import com.mrbee.cengine.components.social.networks.vk.methods.*;
	
	import flash.net.registerClassAlias;
	
	/**
	 * @private
	 * @author Poluosmak Andrew
	 */
	
	public class VKSetup
	{
		public function VKSetup() 
		{
			registerClassAlias(SocialMethod.GET_PROFILES, GetProfiles);
			registerClassAlias(SocialMethod.GET_FRIENDS, GetFriends);
			registerClassAlias(SocialMethod.GET_APP_FRIENDS, GetAppFriends);
			registerClassAlias(SocialMethod.GET_BALANCE, GetBalance);
			registerClassAlias(SocialMethod.POST_WALL, PostWall);
			registerClassAlias(SocialMethod.SHOW_INVITE_BOX, ShowInviteBox);
			
		}
		
	}

}