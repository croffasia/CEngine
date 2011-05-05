package com.mrbee.cengine.components.social.networks.vk.methods 
{
	import com.mrbee.cengine.components.social.SocialFactory;
	import com.mrbee.cengine.components.social.networks.methods.IPostWallMethod;
	import com.mrbee.cengine.components.social.networks.responders.PostWallSocialResponder;
	
	import flash.external.ExternalInterface;
	
	/**
	 * 
	 * @author Poluosmak Andrew
	 */
	
	public class PostWall implements IPostWallMethod
	{				
		private var _onResult:Function;
		private var _onFail:Function;
		
		private const PROFILE_FIELDS:String = "photo,photo_medium,photo_big,photo_rec,nickname,sex,bdate,city,country,timezone,domain,has_mobile,rate";
		
		private var _wallID:String = "";
		private var _photoID:String = "";
		private var _postID:String = "";
		private var _message:String = "";
		
		public function PostWall(onResult:Function, onFail:Function) 
		{
			_onFail = onFail;
			_onResult = onResult;
		}
		
		public function call():void
		{
			var data:Object = new Object();									
			
			data.wall_id = _wallID;
			data.photo_id = _photoID;
			data.post_id = _postID;
			data.message = _message;
			
			SocialFactory.getInstance().provider.request("wall.savePost", { params: data, onComplete: onResultHandler, onError: onFailHandler});
		}
		
		/**
		 * Main result method callback
		 * @param	e
		 */
		public function onResultHandler(response:*):void
		{
			var responderPost:PostWallSocialResponder;
			
			if(response.post_hash != null && response.post_hash != ""){
				if(ExternalInterface.available == true){
					ExternalInterface.addCallback("PostWallCallback", PostWallCallback);
					ExternalInterface.call("saveWallPost", response.post_hash);
				} else {
					if (_onResult != null){
						responderPost = new PostWallSocialResponder();
						_onResult(responderPost);
					}
				}
			} else {
				if (_onResult != null){
					responderPost = new PostWallSocialResponder();
					_onResult(responderPost);
				}
			}
		}
		
		private function PostWallCallback(isPost:Boolean):void
		{
			if (_onResult != null){
				var responderPost:PostWallSocialResponder = new PostWallSocialResponder();
				responderPost.saved = isPost;
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
		
		public function get wallID():String { return _wallID; }
		
		public function set wallID(value:String):void 
		{
			_wallID = value;
		}
		
		public function get photoID():String { return _photoID; }
		
		public function set photoID(value:String):void 
		{
			_photoID = value;
		}
		
		public function get message():String { return _message; }
		
		public function set message(value:String):void 
		{
			_message = value;
		}

		public function get postID():String
		{
			return _postID;
		}

		public function set postID(value:String):void
		{
			_postID = value;
		}


	}

}