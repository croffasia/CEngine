package com.mrbee.cengine.components.social.networks.vk.methods 
{
	import com.mrbee.cengine.components.social.networks.methods.IGetProfilesMethod;
	import com.mrbee.cengine.components.social.networks.responders.ProfileSocialResponder;
	import com.mrbee.cengine.components.social.networks.responders.ProfilesSocialResponder;
	import com.mrbee.cengine.components.social.SocialFactory;
	
	/**
	 * ...
	 * @author Poluosmak Andrew
	 */
	
	public class GetProfiles implements IGetProfilesMethod
	{				
		private var _onResult:Function;
		private var _onFail:Function;
		
		private const PROFILE_FIELDS:String = "photo,photo_medium,photo_big,photo_rec,nickname,sex,bdate,city,country,timezone,domain,has_mobile,rate";
		
		private var _uids:Array = [];
		
		public function GetProfiles(onResult:Function, onFail:Function) 
		{
			_onFail = onFail;
			_onResult = onResult;
		}
		
		public function call():void
		{
			var data:Object = new Object();

			_uids.push(String(SocialFactory.getInstance().viewerID));
			
			data.uids = _uids.join(",");
			data.fields = PROFILE_FIELDS;
			
			SocialFactory.getInstance().provider.request("getProfiles", { params: data, onComplete: onResultHandler, onError: onFailHandler});
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
				
				responderProfile.socialID = response[key].uid;
				responderProfile.firstName = response[key].first_name;
				responderProfile.lastName  = response[key].last_name;
				responderProfile.bDate     = response[key].bdate;
				responderProfile.city      = response[key].city;
				responderProfile.country   = response[key].country;
				responderProfile.isOnline  = response[key].online;
				responderProfile.hasMobile = response[key].has_mobile;
				responderProfile.photoBig  = response[key].photo_big;
				responderProfile.photoMedium = response[key].photo_medium;
				responderProfile.photoSmall  = response[key].photo_rec;
				responderProfile.rate = response[key].rate;
				responderProfile.sex  = response[key].sex;
				
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
		
		public function get uids():Array { return _uids; }
		
		public function set uids(value:Array):void 
		{
			_uids = value;
		}
	}

}