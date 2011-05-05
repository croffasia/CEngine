package com.mrbee.cengine.components.social 
{
	import com.mrbee.cengine.components.social.networks.IProvider;
	import com.mrbee.cengine.components.social.networks.Networks;
	import com.mrbee.cengine.components.social.networks.vk.VKProvider;
	import com.mrbee.cengine.components.social.networks.vk.VKSetup;
	/**
	 * ...
	 * @author Poluosmak Andrew
	 */
	
	public class SocialFactory
	{
		private static var _instance:SocialFactory;		
		private var _provider:IProvider;
		
		private var _isSetup:Boolean = false;
		
		private var _apiUrl:String = "";
		private var _authKey:String = "";
		private var _sid:String = "";
		private var _applicationID:int = 0;
		private var _viewerID:int = 0;
		private var _isTestMode:Boolean = false;
		private var _applicationSecretKey:String = "";
		
		public function SocialFactory(caller:Function = null) 
		{
			if( caller != SocialFactory.getInstance )
                throw new Error ("SocialFactory is a singleton class, use getInstance() instead");
            if ( SocialFactory._instance != null )
                throw new Error( "Only one SocialFactory instance should be instantiated" );
		}
		
		public static function getInstance():SocialFactory
		{
			if (_instance == null)
				_instance = new SocialFactory(arguments.callee);
			
			return _instance;
		}
		
		/**
		 * Setup Social Engine
		 * @param	network - Specific social network ID (see Networks class)
		 * @return
		 */
		public function setup(network:String):Boolean
		{
			if (Networks.SocialEngines[network] != null && _isSetup == false){
				
				new VKSetup();
				
				_provider = new Networks.SocialEngines[network]["provider"]() as IProvider;
				
				_isSetup = true;
				
				return true;
			}
			
			return false;
		}
		
		public function get apiUrl():String { return _apiUrl; }
		
		public function set apiUrl(value:String):void 
		{
			_apiUrl = value;
		}
		
		public function get applicationID():int { return _applicationID; }
		
		public function set applicationID(value:int):void 
		{
			_applicationID = value;
		}
		
		public function get viewerID():int { return _viewerID; }
		
		public function set viewerID(value:int):void 
		{
			_viewerID = value;
		}
		
		public function get isTestMode():Boolean { return _isTestMode; }
		
		public function set isTestMode(value:Boolean):void 
		{
			_isTestMode = value;
		}
		
		public function get applicationSecretKey():String { return _applicationSecretKey; }
		
		public function set applicationSecretKey(value:String):void 
		{
			_applicationSecretKey = value;
		}
				 
		public function get provider():IProvider { return _provider; }
		
		public function get authKey():String { return _authKey; }
		
		public function set authKey(value:String):void 
		{
			_authKey = value;
		}
		
		public function get sid():String
		{
			return _sid;
		}
		
		public function set sid(value:String):void
		{
			_sid = value;
		}
	}

}