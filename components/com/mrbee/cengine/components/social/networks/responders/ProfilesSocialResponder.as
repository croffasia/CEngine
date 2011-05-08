package com.mrbee.cengine.components.social.networks.responders 
{
	import com.mrbee.cengine.components.social.networks.ISocialResponder;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Poluosmak Andrew
	 */
	
	public class ProfilesSocialResponder implements ISocialResponder
	{
		private var _profiles:Dictionary;
		private var _length:int = 0;
		
		public function ProfilesSocialResponder() 
		{
			_profiles = new Dictionary(true);
		}
		
		public function add(profile:ProfileSocialResponder):void
		{
			_profiles[profile.socialID] = profile;
			_length++;
		}
		
		public function remove(socialID:String):void
		{
			if (_profiles[socialID] != null)
				delete _profiles[socialID]; _length--;
		}
		
		public function getAll():Dictionary
		{
			return _profiles;
		}
		
		public function getUserUids():Array
		{
			var arrayResult:Array = [];
			
			for (var key:Object in _profiles)
			{
				arrayResult.push(ProfileSocialResponder(_profiles[key]).socialID);
			}
			
			return arrayResult;
		}
		
		public function lookup(socialID:String):ProfileSocialResponder
		{
			return _profiles[socialID];
		}
		
		public function get length():int { return _length; }
		
	}

}