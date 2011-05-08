package com.mrbee.cengine.components.social.networks.vk.methods 
{
	import com.mrbee.cengine.components.social.SocialFactory;
	import com.mrbee.cengine.components.social.networks.methods.IPostNewsMethod;
	import com.mrbee.cengine.components.social.networks.responders.PostNewsSocialResponder;
	import com.mrbee.cengine.components.social.networks.responders.PostWallSocialResponder;
	
	import flash.external.ExternalInterface;
	
	/**
	 * 
	 * @author Poluosmak Andrew
	 */
	
	public class PostNews implements IPostNewsMethod
	{				
		private var _onResult:Function;
		private var _onFail:Function;
		
		private const PROFILE_FIELDS:String = "photo,photo_medium,photo_big,photo_rec,nickname,sex,bdate,city,country,timezone,domain,has_mobile,rate";
		
		private var _owner_id:String = "";
		private var _attachment:String = "";
		private var _message:String = "";
		
		public function PostNews(onResult:Function, onFail:Function) 
		{
			_onFail = onFail;
			_onResult = onResult;
		}
		
		public function call():void
		{
			if(ExternalInterface.available == true){
				ExternalInterface.addCallback("CEngine_PostNewsCallback", PostNewsCallback);
				ExternalInterface.call("CEngine_saveNewsPost", owner_id, message, attachment);
			} else {
				if (_onResult != null){
					var responderPost:PostNewsSocialResponder = new PostNewsSocialResponder();
					_onResult(responderPost);
				}
			}
		}
		
		/**
		 * Main result method callback
		 * @param	e
		 */
		public function onResultHandler(response:*):void
		{
			//
		}
		
		private function PostNewsCallback(post_id:String, error:int = 0):void
		{
			if (_onResult != null){
				var responderPost:PostNewsSocialResponder = new PostNewsSocialResponder();
				responderPost.post_id = post_id;
				responderPost.error = error;
				_onResult(responderPost);
			}			
		}
		
		/**
		 * Main fail method callback
		 * @param	e
		 */
		public function onFailHandler(e:*):void
		{
			var a:int;
		}

		public function get owner_id():String
		{
			return _owner_id;
		}

		public function set owner_id(value:String):void
		{
			_owner_id = value;
		}

		public function get attachment():String
		{
			return _attachment;
		}

		public function set attachment(value:String):void
		{
			_attachment = value;
		}

		public function get message():String
		{
			return _message;
		}

		public function set message(value:String):void
		{
			_message = value;
		}
		


	}

}