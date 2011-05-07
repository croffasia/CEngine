package com.mrbee.cengine.components.social.networks.responders 
{
	import com.mrbee.cengine.components.social.networks.ISocialResponder;
	
	/**
	 * ...
	 * @author Poluosmak Andrew
	 */
	
	public class PostNewsSocialResponder implements ISocialResponder
	{
		private var _post_id:String = "";
		private var _error:int = 0;
				
		public function PostNewsSocialResponder(){}
		

		public function get post_id():String
		{
			return _post_id;
		}

		public function set post_id(value:String):void
		{
			_post_id = value;
		}

		public function get error():int
		{
			return _error;
		}

		public function set error(value:int):void
		{
			_error = value;
		}


	}

}