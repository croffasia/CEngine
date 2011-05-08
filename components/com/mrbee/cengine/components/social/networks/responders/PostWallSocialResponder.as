package com.mrbee.cengine.components.social.networks.responders 
{
	import com.mrbee.cengine.components.social.networks.ISocialResponder;
	
	/**
	 * ...
	 * @author Poluosmak Andrew
	 */
	
	public class PostWallSocialResponder implements ISocialResponder
	{
		private var _saved:Boolean = false;		
				
		public function PostWallSocialResponder(){}
		
		/** MD5 hash for current post **/
		public function get saved():Boolean
		{
			return _saved;
		}

		/**
		 * @private
		 */
		public function set saved(value:Boolean):void
		{
			_saved = value;
		}

	}

}